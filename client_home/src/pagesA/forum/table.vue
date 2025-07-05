<template>
  <view
    class="page_forum_table"
    id="forum_table"
    :style="{ paddingTop: vuex_custom_bar_height + 'px' }"
  >
    <tn-nav-bar>交流论坛列表</tn-nav-bar>
    <view class="popup_overlay" :hidden="userFeedbackHidden" @click="hideDiv()"></view>
    <template v-if="$check_action('/forum/table', 'get')">
      <uni-search-bar
        placeholder="搜索标题"
        @confirm="search_"
        @cancel="cancel"
        cancelText="取消"
        @input="input($event, 'title')"
      >
        <uni-icons slot="searchIcon" color="#999999" size="18" type="home" />
      </uni-search-bar>

      <view class="change">
        <uni-data-select
          :localdata="type_list"
          v-model="obj.type"
          @change="push_search_query($event, 'type')"
        >
        </uni-data-select>
        <view @click="$navTo('/pagesA/forum/add')" class="me-btn" style="margin-left: 10rpx">
          <span style="font-size: 14px">添加</span>
        </view>
      </view>
      <uni-table ref="table" border emptyText="暂无更多数据">
        <uni-tr>
          <uni-th align="center">标题</uni-th>
          <uni-th align="center">封面图</uni-th>
          <uni-th align="center">分类</uni-th>
          <uni-th align="center">标签</uni-th>
          <uni-th align="center">置顶状态</uni-th>
          <uni-th align="center">创建时间</uni-th>
          <uni-th align="center">更新时间</uni-th>
          <uni-th align="center">操作</uni-th>
        </uni-tr>
        <uni-tr v-for="(o, i) in list" :key="i">
          <uni-td align="center">{{ o.title }}</uni-td>
          <uni-td align="center">
            <image style="width: 3rem; height: 3rem" :src="$fullImgUrl(o.img)" mode="scaleToFill" />
          </uni-td>
          <uni-td align="center">{{ o.type }}</uni-td>
          <uni-td align="center">{{ o.tag }}</uni-td>
          <uni-td align="center">{{ o.istop == 1 ? '是' : '否' }}</uni-td>
          <uni-td align="center">{{ $toTime(o['create_time'], 'yyyy-MM-dd hh:mm:ss') }}</uni-td>
          <uni-td align="center">{{ $toTime(o['update_time'], 'yyyy-MM-dd hh:mm:ss') }}</uni-td>
          <uni-td align="center">
            <view @click="$navTo('/pagesA/forum/edit?forum_id=' + o.forum_id)" class="answer_link">
              <button type="default" size="mini">详情</button>
            </view>
			<view @click="delInfo(i)" v-show="user_group == '管理员' || $check_action('/forum/table', 'del')" class="answer_link delete_a_btn">
				<button type="default" size="mini">删除</button>
			</view>
            <view
              @click="
                $navTo(
                  '/pagesB/comment/table?source_table=forum&source_field=' +
                    field +
                    '&source_id=' +
                    o.forum_id
                )
              "
              class="answer_link"
            >
              <button type="default" size="mini">评论</button>
            </view>
          </uni-td>
        </uni-tr>
      </uni-table>

      <uni-pagination
        style="padding: 10px"
        show-icon="true"
        :total="count"
        :pageSize="query.size"
        :current="query.page"
        @change="page_change"
      ></uni-pagination>
    </template>
  </view>
</template>

<script>
import mixin from '@/libs/mixins/page.js';

export default {
  mixins: [mixin],
  data() {
    return {
      // 获取数据地址
      url_get_list: '/forum/get_list?like=0',
      url_get_type_list: '/forum_type/get_list',
      url_set: '/forum/set?',
      url_del: '/forum/del',
      // 字段ID
      field: 'forum_id',
      // 查询
      query: {
        size: 10,
        page: 1,
        title: '',
        type: '',
        orderby: 'istop desc,create_time desc',
        user_id: '',
      },

      userFeedbackHidden: true, // 默认隐藏
      feedbackContent: '',
      forum_id: 0,
      type_list: [],
    };
  },
  methods: {
    get_forum_type() {
      let _slef = this;
      this.$get(this.url_get_type_list, {}, function (json, status) {
        _slef.type_list = json.result.list.map((item) => {
          return {
            value: item.name,
            text: item.name,
          };
        });
      });
    },
    delInfo(v) {
      let _this = this;
      uni.showModal({
        title: '删除',
        content: '此操作将永久删除该文件, 是否继续?',
        success: function (res) {
          if (res.confirm) {
            let list = [v];
            _this.delAll(list);
          } else if (res.cancel) {
            console.log('用户点击取消');
          }
        },
      });
    },
    //搜索相关方法
    push_search_query(query, key) {
      this.query[key] = query;
      this.search_();
    },
    input(e, key) {
      this.query[key] = e;
    },
    search_() {
      this.query.page = 1;
      this.get_list();
    },
    showDiv(forum_id, reply) {
      // 显示输入弹出框
      this.userFeedbackHidden = false;
      this.forum_id = forum_id;
      this.feedbackContent = reply;
    },
    hideDiv() {
      // 隐藏输入弹出框
      this.userFeedbackHidden = true;
      this.forum_id = '';
      this.feedbackContent = '';
    },
    //回复内容提交
    submitFeedback() {
      let _self = this;
      if (this.feedbackContent) {
        let form = {
          reply: this.feedbackContent,
        };

        this.$post(this.url_set + 'forum_id=' + this.forum_id, form, function (json, status) {
          //修改列表中的对象属性
          for (var i = 0; i < _self.list.length; i++) {
            let msgObj = _self.list[i];
            if (msgObj.forum_id == _self.forum_id) {
              msgObj.reply = _self.feedbackContent;
            }
          }

          _self.hideDiv();
        });
      }
    },
    get_forum_list() {
      let _self = this;
	  this.query.user_id = this.userGroup == '管理员' ? '' : this.userInfo.user_id;
      this.$get(this.url_get_list, this.query, function (json, status) {
        _self.list = json.result.list;
      });
    },
  },
  created() {
    this.get_forum_list();
    this.get_forum_type();
  },
};
</script>
<style lang="scss" scoped>
@import 'styles/pagesA/index.scss';
</style>
