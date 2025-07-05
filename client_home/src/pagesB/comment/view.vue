<template>
  <view class="comment_view" :style="{ paddingTop: vuex_custom_bar_height + 'px' }">
    <tn-nav-bar>查看评论</tn-nav-bar>
    <view
      class="page_website_announcement diy_detail diy_detail--new"
      id="forum_edit"
    >
      <view class="warp">
        <view class="container-fluid">
          <view class="row">
            <view class="col-12 col-6">
              <view class="view">
                <view class="diy_title">
                  <span>头像</span>
                </view>
                <view class="diy_field diy_text">
                  <span>
                    <image
                      style="width: 5rem; height: 5rem; border: 1px #d1d1d1 solid"
                      :src="$fullImgUrl(obj.avatar)"
                      mode="scaleToFill"
                      @click="change_avatar(obj.comment_id)"
                    />
                  </span>
                </view>
              </view>
            </view>
            <view class="col-12 col-6">
              <view class="view">
                <view class="diy_title">
                  <span>昵称</span>
                </view>
                <view class="diy_field diy_text">
                  <span>
                    <input class="uni-input" v-model="obj.nickname" />
                  </span>
                </view>
              </view>
            </view>
            <view class="col-12 col-6">
              <view class="view">
                <view class="diy_title">
                  <span>正文</span>
                </view>
                <view class="diy_field diy_text">
                  <span>
                    <textarea v-model="obj.content"></textarea>
                  </span>
                </view>
              </view>
            </view>

            <!--					<view class="col-12 col-6">-->
            <!--						<view class="col-12">-->
            <!--							<view class="answer_btn_box">-->
            <!--								<button class="answer_btn_submit" @click="submit()">-->
            <!--									提交-->
            <!--								</button>-->
            <!--								<view class="clear"> </view>-->
            <!--							</view>-->
            <!--						</view>-->
            <!--					</view>-->
          </view>
        </view>
      </view>
    </view>
  </view>
</template>

<script>
import bar_title from '@/components/diy/bar_title.vue';

import mixin from '@/libs/mixins/page.js';
export default {
  mixins: [mixin],
  components: {
    bar_title,
  },
  data() {
    return {
      url_get_obj: '~/api/comment/get_obj?',
      url_add: '~/api/comment/add',
      url_set: '~/api/comment/set',
      field: 'comment_id',
      query: {
        comment_id: 0,
      },
      // 商品详情初始化
      obj: {
        comment_id: 0,
        title: '',
        content: '',
        avatar: '',
        nickname: '',
      },
      type_list: [],
    };
  },
  methods: {
    change_avatar(comment_id) {
      var _self = this;
      // 选择图像方法
      uni.chooseImage({
        count: 1,
        sizeType: ['original', 'compressed'], //可以指定是原图还是压缩图，默认二者都有
        sourceType: ['album'], //从相册选择
        success: function (res) {
          const tempFilePaths = res.tempFilePaths;
          const uploadTask = uni.uploadFile({
            url: _self.$fullUrl('~/api/comment/upload?'),
            filePath: tempFilePaths[0],
            name: 'file',
            header: {
              'x-auth-token': _self.$store.state.app.userInfo.token,
            },
            success: function (uploadFileRes) {
              var filename = JSON.parse(uploadFileRes.data).result.url;
              console.log(filename);
              var avatar = JSON.parse(uploadFileRes.data).result.url;
              _self.$post(
                '~/api/comment/set?comment_id=' + comment_id,
                {
                  avatar,
                },
                (res) => {
                  _self.obj.avatar = filename;
                }
              );
            },
          });

          uploadTask.onProgressUpdate(function (res) {
            _self.percent = res.progress;
            console.log('上传进度' + res.progress);
            console.log('已经上传的数据长度' + res.totalBytesSent);
            console.log('预期需要上传的数据总长度' + res.totalBytesExpectedToSend);
          });
        },
        error: function (e) {
          console.log(e);
        },
      });
    },
    submit_main() {
      let _slef = this;
      let form = _slef.obj;
      delete form.update_time;
      delete form.create_time;
      _slef.$post(_slef.url_set + '?comment_id=' + form.comment_id, form, function (json, status) {
        uni.showToast({
          icon: 'success',
          title: '保存成功',
        });
        setTimeout(() => {
          uni.hideToast();

          //关闭提示后跳转
          uni.navigateTo({
            url: '/pagesB/comment/table',
          });
        }, 1500);
      });
    },
  },
};
</script>
<style lang="scss" scoped>
@import 'styles/pagesB/index.scss';
</style>
