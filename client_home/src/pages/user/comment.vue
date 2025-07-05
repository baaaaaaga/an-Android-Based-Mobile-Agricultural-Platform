<template>
  <view id="page_user_comment" class="page_user_comment" :style="{ paddingTop: vuex_custom_bar_height + 'px' }">
    <tn-nav-bar>我的评论</tn-nav-bar>
    <view class="comment_list">
      <view class="comment_item" v-for="(o, i) in list" :key="i">
        <view class="comment_card">
          <view class="comment_card_header">
            <view class="text">{{ o.reply_to_id > 0 ? '回复' : '评论' }}</view>
            <view class="reply_name" v-if="o.reply_to_id > 0">@{{ o.reply_name }}</view>
            <view class="source_title text-ellipsis-1" @click="navHandle(o)">{{
              o.source_obj ? o.source_obj.title : ''
            }}</view>
          </view>
          <view class="comment_card_body">
            {{ o.content }}
          </view>
          <view class="comment_card_footer">
            <view class="datetime">{{ o.create_time }}</view>

            <view class="operate_group">
              <view class="me-btn btn_delete" @click="delete_comment(o)" v-if="$check_action('/comment/table', 'del')">删除</view>
            </view>
          </view>
        </view>
      </view>
    </view>
  </view>
</template>

<script>
import { getRouteBasePath } from '@/utils/index.js';
export default {
  data() {
    return {
      list: [],
      vm: {},
      loading: false, // 是否正在加载状态
      isMore: true, // 是否有更多
      page: 1, // 当前请求的页码
      size: 10, // 每次请求的数据量
    };
  },
  onShow() {
    this.reload_comment_list();
  },
  methods: {
    reload_comment_list() {
      this.page = 1;
      this.loading = false;
      this.isMore = true;
      this.get_comment_list();
    },
    async get_comment_list() {
      this.loading = true;
      const params = {
        user_id: this.userInfo.user_id,
        page: this.page,
        size: this.size,
      };

      let res = await this.$get('~/api/comment/get_list', params);

      if (res.result.list.length > 0) {
        for (let item of res.result.list) {
          if (item.reply_to_id > 0) {
            let resJson = await this.$get('~/api/comment/get_obj', {
              comment_id: item.reply_to_id,
            });
            if (resJson.result.obj) {
              item['reply_name'] = resJson.result.obj.nickname;
            }
          }

          // 查询文章信息
          let query = {
            [item.source_field]: item.source_id,
          };
          let url = `~/api/${item.source_table}/get_obj`;
          let rest = await this.$get(url, query);
          if (rest.result.obj) {
			item['source_obj'] = rest.result.obj;
			for(let obj in rest.result.obj){
				if(obj.includes("_name") || obj.includes("_title")){
					item['source_obj']['title'] = rest.result.obj[obj];
					break;
				}
			}
          } else {
            item['source_obj'] = {};
          }
        }
        // 数据合并，假设返回的数据结构包含list属性
        if (this.page == 1) {
          this.list = [...res.result.list];
        } else {
          this.list.push(...res.result.list);
        }
        this.page++;
      } else {
        // 没有更多数据
        this.isMore = false;
      }
      this.loading = false;
    },

    // 删除
    async delete_comment(o, index) {
      const query = {
        page: 1,
        size: 9999,
        reply_to_id: o.comment_id,
      };
      // 查询是否有回复
      let res = await this.$get('~/api/comment/get_list', query);
      let del_list = res.result.list;
      del_list.push(o);

      uni.showModal({
        title: '删除',
        content: '是否要删除评论?',
        success: async (res) => {
          if (res.confirm) {
            for (var i = 0; i < del_list.length; i++) {
              let res = await this.$get('~/api/comment/del', {
                comment_id: del_list[i].comment_id,
              });
              if (res.error) {
                this.$toast('删除失败' + o.error.message, 'danger');
                break;
              }
            }

            this.reload_comment_list();
          } else if (res.cancel) {
            console.log('用户点击取消');
          }
        },
      });
    },
    // 更多展示
    more_show(o, i) {
      o.display_btn = !o.display_btn;
      this.$set(this.list, i, o);
    },
    navHandle(o) {
      const basePath = getRouteBasePath(o.source_table);
      this.$navTo(basePath + o.source_table + '/details?' + o.source_field + '=' + o.source_id);
    },
  },
  async onReachBottom() {
    if (this.isMore && !this.loading) {
      this.get_comment_list();
    }
  },
};
</script>

<style lang="scss" scoped>
@import 'styles/pages/index.scss';
</style>
