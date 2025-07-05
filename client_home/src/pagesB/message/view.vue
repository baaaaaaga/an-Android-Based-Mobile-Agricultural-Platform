<template>
  <view class="message_view" :style="{ paddingTop: vuex_custom_bar_height + 'px' }">
    <tn-nav-bar>在线留言详情</tn-nav-bar>
    <view class="container diy_view" id="forum_edit">
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
                      style="width: 5rem; height: 5rem"
                      :src="$fullImgUrl(obj.avatar)"
                      mode="scaleToFill"
                      @click="change_avatar(obj.message_id)"
                    />
                  </span>
                </view>
              </view>
            </view>
            <view class="col-12 col-6">
              <view class="view">
                <view class="diy_title">
                  <span>标题</span>
                </view>
                <view class="diy_field diy_text">
                  <span>
                    <input class="uni-input" v-model="obj.title" />
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
                    {{ obj.nickname }}
                  </span>
                </view>
              </view>
            </view>
            <!--					<view class="col-12 col-6">-->
            <!--						<view class="view">-->
            <!--							<view class="diy_title">-->
            <!--								<span>留言手机号</span>-->
            <!--							</view>-->
            <!--							<view class="diy_field diy_text">-->
            <!--								<span>-->
            <!--									<input class="uni-input" v-model="obj.phone" />-->
            <!--								</span>-->
            <!--							</view>-->
            <!--						</view>-->
            <!--					</view>-->
            <!--					<view class="col-12 col-6">-->
            <!--						<view class="view">-->
            <!--							<view class="diy_title">-->
            <!--								<span>留言邮箱</span>-->
            <!--							</view>-->
            <!--							<view class="diy_field diy_text">-->
            <!--								<span>-->
            <!--									<input class="uni-input" v-model="obj.email" />-->
            <!--								</span>-->
            <!--							</view>-->
            <!--						</view>-->
            <!--					</view>-->
            <view class="col-12 col-6">
              <view class="view">
                <view class="diy_title">
                  <span>提交时间</span>
                </view>
                <view class="diy_field diy_datetime">
                  <span>
                    {{ $toTime(obj.create_time, 'yyyy-MM-dd hh:mm:ss') }}
                  </span>
                </view>
              </view>
            </view>
            <view class="col-12 col-6">
              <view class="view">
				<view class="diy_title">
				  <span>内容</span>
				</view>
                <view class="diy_field diy_text">
                  <span>
                    <textarea v-model="obj.content"></textarea>
                  </span>
                </view>
              </view>
            </view>

            <view class="col-12 col-6">
              <view class="col-12">
                <view class="answer_btn_box">
                  <button class="answer_btn_submit me-btn" @click="submit()">提交</button>
                  <view class="clear"> </view>
                </view>
              </view>
            </view>
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
      url_get_obj: '~/api/message/get_obj?',
      url_add: '~/api/message/add',
      url_set: '~/api/message/set',
      field: 'message_id',
      query: {
        message_id: 0,
      },
      // 商品详情初始化
      obj: {
        message_id: 0,
        title: '',
        content: '',
        create_time: '',
        update_time: '',
        // "email": "",
        // "phone": "",
        avatar: '',
        nickname: '',
      },
      placeholder: '开始输入...',
      params: 0,
    };
  },
  methods: {
    change_avatar(message_id) {
      var _self = this;
      // 选择图像方法
      uni.chooseImage({
        count: 1,
        sizeType: ['original', 'compressed'], //可以指定是原图还是压缩图，默认二者都有
        sourceType: ['album'], //从相册选择
        success: function (res) {
          const tempFilePaths = res.tempFilePaths;
          const uploadTask = uni.uploadFile({
            url: _self.$fullUrl('~/api/message/upload?'),
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
                '~/api/message/set?message_id=' + message_id,
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
      _slef.$post(_slef.url_set + '?message_id=' + form.message_id, form, function (json, status) {
        uni.showToast({
          title: '提交成功',
          //将值设置为 success 或者直接不用写icon这个参数
          icon: 'success',
          //显示持续时间为 2秒
          duration: 2000,
        });
      });
    },
  },
};
</script>
<style lang="scss" scoped>
@import 'styles/pagesB/index.scss';
</style>
