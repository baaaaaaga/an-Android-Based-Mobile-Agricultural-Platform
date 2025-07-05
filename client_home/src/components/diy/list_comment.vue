<template>
  <view class="list_comment" v-if="list.length > 0">
    <view
      class="item_comment"
      v-for="(o, i) in list"
      :key="i"
      :to="'/pages/article/details?' + vm.comment_id + '=' + o[vm.comment_id]"
    >
      <view class="comment_box">
        <view class="left_block">
          <image
            class="image"
            :src="$fullImgUrl(o[vm.avatar]) || '/static/img/default.png'"
          ></image>
        </view>
        <view class="right_block">
          <view class="top_comment">
            <view class="nickname">
              {{ o[vm.nickname] }}
            </view>
            <view class="right">
              <view class="del" @click="delete_comment(o)" v-if="userInfo.user_id === o[vm.user_id] && $check_action('/comment/list', 'del')"> 删除</view>
              <view class="link" @click="$navTo(goto_edit(o))"> 回复</view>
            </view>
          </view>
          <rich-text class="content" :nodes="$setRichTextImage(o[vm.content])"></rich-text>
          <view class="time">
            {{ $toTime(o[vm.create_time], 'yyyy-MM-dd hh:mm:ss') }}
          </view>
        </view>
      </view>

      <!-- 回复内容 -->
      <view class="list_reply_block" v-if="o.list_reply">
        <view class="list_reply_box" v-for="(obj, idx) in o.list_reply" :key="idx">
          <view class="list_reply">
            <view class="reply_left">
              <image
                class="hf-image"
                :src="$fullImgUrl(obj[vm.avatar]) || '@/static/img/avatar.jpg'"
              ></image>
              <text class="nickname">{{ obj[vm.nickname] }}</text>
            </view>
            <view class="reply_right" v-if="userInfo.user_id === o[vm.user_id] && $check_action('/comment/list', 'del')">
              <view class="del" @click="delete_comment(obj)"> 删除</view></view
            >
          </view>
          <rich-text class="content" :nodes="$setRichTextImage(obj[vm.content])"></rich-text>

          <text class="reply_time">{{ $toTime(obj[vm.create_time], 'yyyy-MM-dd hh:mm:ss') }}</text>
        </view>
      </view>
      <!-- /回复内容 -->
      <view class="line"></view>
    </view>
  </view>
  <view class="list_comment empty" v-else>还没有评论哦</view>
</template>

<script scoped>
export default {
  props: {
    list: {
      type: Array,
      default: function () {
        return [];
      },
    },
    obj: {
      type: Object,
      default: function () {
        return {};
      },
    },
    vm: {
      type: Object,
      default: function () {
        return {
          avatar: 'avatar',
          nickname: 'nickname',
          comment_id: 'comment_id',
          create_time: 'create_time',
          content: 'content',
		  user_id: 'user_id',
        };
      },
    },
  },
  data() {
    return {
      active_index: -1,
      reply_comment: '',
    };
  },
  methods: {
    goto_edit(o) {
      var vm = this.vm;
      return (
        '/pagesB/comment/edit?source_table=' +
        o.source_table +
        '&source_field=' +
        o.source_field +
        '&source_id=' +
        o.source_id +
        '&reply_to_id=' +
        o[vm.comment_id] +
        '&nickname=' +
        o[vm.nickname]
      );
    },
    async delete_comment(o) {
      let del_list = [o];
	  let del_num = 1;
      if (o.reply_to_id == 0) {
        const query = {
          page: 1,
          size: 9999,
          reply_to_id: o.comment_id,
        };
        // 查询是否有回复
        let res = await this.$get('~/api/comment/get_list', query);
        if (res.result.list.length > 0) {
		  del_num += res.result.list.length;
          del_list.push(...res.result.list);
        }
      }

      uni.showModal({
        title: '删除',
        content: '是否要删除评论?',
        success: async (res) => {
          if (res.confirm) {
            let flag = true;
            for (var i = 0; i < del_list.length; i++) {
              let res = await this.$get('~/api/comment/del', {
                comment_id: del_list[i].comment_id,
              });
              if (res.error) {
                flag = false;
                this.$toast('删除失败' + o.error.message, 'danger');
                break;
              }
            }
            if (flag) {
              this.$toast('删除成功', 'success');
			  // 更新模块评论数
			  let source_table = del_list[0].source_table
			  let source_field = del_list[0].source_field
			  let source_id = del_list[0].source_id
			  if (del_list[0].source_table != 'article' && del_list[0].source_table !=
			  	'forum' && del_list[0].source_table != 'goods') {
			  	this.$get("~/api" + source_table + "/get_obj", {
			  		[source_field]: source_id
			  	}, (json) => {
			  		if(json.result && json.result.obj){
			  			let comment_len = json.result.obj.comment_len - del_num
			  			this.$post('~/api/' + source_table + '/set?' + source_field + '=' + source_id,
			  			    {comment_len},(res) => {
			  			      if (res.result) {
			  			        console.log('添加评论数状态：', res.result);
			  			      } else if (res.error) {
			  			        console.error(res.error);
			  			      }
			  			    }
			  			);
			  		}
			  		console.log(json)
			  	});
			  }
              this.$emit('refresh');
            }
          } else if (res.cancel) {
            console.log('用户点击取消');
          }
        },
      });
    },
  },
};
</script>

<style lang="scss" scoped>
@import 'styles/components/index.scss';
</style>
