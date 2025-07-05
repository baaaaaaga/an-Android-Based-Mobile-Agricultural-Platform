<template>
  <view :style="{ paddingTop: vuex_custom_bar_height + 'px' }">
    <tn-nav-bar>在线留言管理</tn-nav-bar>
    <view class="diy_table diy_table_tml" id="message_table">
      <view :hidden="userFeedbackHidden" class="popup_content">
        <view class="popup_title">回复</view>
        <view class="popup_textarea_item">
          <input
            type="text"
            class="popup_textarea"
            value=""
            v-model="feedbackContent"
            placeholder="请输入回复内容"
            id="reply_input"
          />
          <view @click="submitFeedback" class="buttons">
            <!-- <text class="popup_button">确定</text> -->
            <button class="me-btn" type="primary">确定</button>
          </view>
        </view>
      </view>
      <view class="popup_overlay" :hidden="userFeedbackHidden" @click="hideDiv()"></view>
      <template v-if="$check_action('/message/table', 'get')">
        <uni-search-bar
          placeholder="搜索标题"
          @confirm="search_"
          @cancel="cancel"
          cancelText="取消"
          @input="input($event, 'title')"
        >
          <uni-icons slot="searchIcon" color="#999999" size="18" type="home" />
        </uni-search-bar>
        <uni-table ref="table" border emptyText="暂无更多数据">
          <uni-tr>
            <uni-th align="center">头像</uni-th>
            <uni-th align="center">标题</uni-th>
            <uni-th align="center">昵称</uni-th>
            <!--						<uni-th align="center">留言手机号</uni-th>-->
            <!--						<uni-th align="center">留言邮箱</uni-th>-->
            <uni-th align="center">创建时间</uni-th>
            <uni-th align="center">更新时间</uni-th>
            <uni-th align="center">操作</uni-th>
          </uni-tr>
          <uni-tr v-for="(o, i) in list" :key="i">
            <uni-td align="center">
              <image
                style="width: 3rem; height: 3rem"
                :src="$fullImgUrl(o.avatar)"
                mode="scaleToFill"
              />
            </uni-td>
            <uni-td align="center">{{ o.title }}</uni-td>
            <uni-td align="center">{{ o.nickname }}</uni-td>
            <!--						<uni-td align="center">{{ o.phone }}</uni-td>-->
            <!--						<uni-td align="center">{{ o.email }}</uni-td>-->
            <uni-td align="center">{{ $toTime(o['create_time'], 'yyyy-MM-dd hh:mm:ss') }}</uni-td>
            <uni-td align="center">{{ $toTime(o['update_time'], 'yyyy-MM-dd hh:mm:ss') }}</uni-td>
            <uni-td align="center" class="operate">
              <view
                @click="$navTo('/pagesB/message/view?message_id=' + o.message_id)">
                <button class="answer_link" type="default" size="mini">详情</button>
              </view>

              <button
			    type="default" 
			    size="mini"
                class="delete_a_btn answer_link"
                @click="delInfo(i)"
                v-show="user_group == '管理员' || $check_action('/message/table', 'del')"
              >
                删除
              </button>

              <button
                v-if="user_group === '管理员' && (o.reply == '' || o.reply == null)"
                type="default"
                size="mini"
                @click="showDiv($event, o.message_id, '')"
                class="answer_link"
              >
                回复
              </button>
              <button
                v-if="o.reply != '' && o.reply != null"
                type="default"
                size="mini"
                @click="showDiv($event, o.message_id, o.reply)"
                class="answer_link"
              >
                查看回复
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
      url_get_list: '~/api/message/get_list?like=0',
      url_set: '~/api/message/set?',
      url_del: '~/api/message/del',
      // 字段ID
      field: 'message_id',
      // 查询
      query: {
        size: 10,
        page: 1,
        title: '',
        user_id: '',
      },

      userFeedbackHidden: true, // 默认隐藏
      feedbackContent: '',
      canReply: true,
      message_id: 0,
    };
  },
  created() {
    this.query.user_id = this.userGroup == '管理员' ? '' : this.userInfo.user_id;
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
    input(e, key) {
      this.query[key] = e;
    },
    search_() {
      this.query.page = 1;
      this.get_list();
    },
    showDiv(e, message_id, reply) {
      // 显示输入弹出框
      this.userFeedbackHidden = false;
      this.message_id = message_id;
      this.feedbackContent = reply;
    },
    hideDiv() {
      // 隐藏输入弹出框
      this.userFeedbackHidden = true;
      this.message_id = '';
      this.feedbackContent = '';
    },
    //回复内容提交
    submitFeedback() {
      let _self = this;
      if (this.feedbackContent) {
        let form = {
          reply: this.feedbackContent,
        };

        this.$post(this.url_set + 'message_id=' + this.message_id, form, function (json, status) {
          //修改列表中的对象属性
          for (var i = 0; i < _self.list.length; i++) {
            let msgObj = _self.list[i];
            if (msgObj.message_id == _self.message_id) {
              msgObj.reply = _self.feedbackContent;
            }
          }

          _self.hideDiv();
        });
      }
    },
  },
};
</script>
<style lang="scss" scoped>
@import 'styles/pagesB/index.scss';
</style>
