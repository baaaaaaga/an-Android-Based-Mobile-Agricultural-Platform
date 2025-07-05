<template>
  <view class="comment_table" :style="{ paddingTop: vuex_custom_bar_height + 'px' }">
    <tn-nav-bar>评论管理</tn-nav-bar>
    <view class="page_comment" id="comment_list">
      <view class="popup_overlay" :hidden="userFeedbackHidden" @click="hideDiv()"></view>
      <template v-if="$check_action('/forum/table', 'get')">
        <uni-search-bar
          placeholder="搜索昵称"
          @confirm="search_"
          @cancel="cancel"
          cancelText="取消"
          @input="input($event, 'nickname')"
        >
          <uni-icons slot="searchIcon" color="#999999" size="18" type="home" />
        </uni-search-bar>
        <uni-search-bar
          placeholder="搜索内容"
          @confirm="search_"
          @cancel="cancel"
          cancelText="取消"
          @input="input($event, 'content')"
        >
          <uni-icons slot="searchIcon" color="#999999" size="18" type="home" />
        </uni-search-bar>
        <uni-table ref="table" border emptyText="暂无更多数据">
          <uni-tr>
            <uni-th align="center">昵称</uni-th>
            <uni-th align="center">头像</uni-th>
            <uni-th align="center">评论人</uni-th>
            <uni-th align="center">创建时间</uni-th>
            <uni-th align="center">更新时间</uni-th>
            <uni-th align="center">操作</uni-th>
          </uni-tr>
          <uni-tr v-for="(o, i) in list" :key="i">
            <uni-td align="center">{{ o.nickname }}</uni-td>
            <uni-td align="center">
              <image
                style="width: 3rem; height: 3rem"
                :src="$fullImgUrl(o.avatar)"
                mode="scaleToFill"
              />
            </uni-td>
            <uni-td align="center">{{ o.nickname }}</uni-td>
            <uni-td align="center">{{ $toTime(o['create_time'], 'yyyy-MM-dd hh:mm:ss') }}</uni-td>
            <uni-td align="center">{{ $toTime(o['update_time'], 'yyyy-MM-dd hh:mm:ss') }}</uni-td>
            <uni-td align="center">
              <view
                @click="$navTo('/pagesB/comment/view?comment_id=' + o.comment_id)"
              >
                <button class="answer_link" type="default" size="mini">详情</button>
              </view>

              <button
                class="delete_a_btn answer_link" 
			    size="mini"
                @click="delInfo(i)"
                v-show="user_group == '管理员' || $check_action('/comment/table', 'del')"
              >
                删除
              </button>

              <button
                type="default"
                size="mini"
                v-if="!o.reply_to_id"
                @click="
                  query.reply_to_id = o.comment_id;
                  search_();
                "
                class="answer_link"
              >
                查看被回复
              </button>
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
  </view>
</template>

<script>
import mixin from '@/libs/mixins/page.js';

export default {
  mixins: [mixin],
  data() {
    return {
      // 获取数据地址
      url_get_list: '~/api/comment/get_list?like=0',
      url_set: '~/api/comment/set?',
      url_del: '~/api/comment/del',
      // 字段ID
      field: 'comment_id',
      // 查询
      query: {
        size: 10,
        page: 1,
        title: '',
        type: '',
        orderby: 'create_time desc',
        source_table: '',
        source_field: '',
        source_id: 0,
        reply_to_id: 0,
      },
      list: [],
      userFeedbackHidden: true, // 默认隐藏
      feedbackContent: '',
      comment_id: 0,
    };
  },
  methods: {
    //删除相关
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
      console.log(this.query);
      this.query.page = 1;
      this.get_list();
    },
  },
};
</script>
<style lang="scss" scoped>
@import 'styles/pagesB/index.scss';
</style>
