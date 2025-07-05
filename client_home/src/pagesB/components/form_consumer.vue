<template>
  <view class="diy_register">
      <view v-if="$check_register_field('add', 'user_name', '/consumer/view')" class="diy_register_field col-md-6">
      <view class="diy_title">
        <text> 用户姓名 </text>
      </view>
                  <!-- 文本 -->
        <view class="diy_field diy_text">
          <input type="text" id="form_user_name" v-model="form['user_name']" @blur="handleBlur($event.target.value,'user_name')"  placeholder="请输入用户姓名" />
        </view>
              </view>
        <view v-if="$check_register_field('add', 'mobile_phone_number', '/consumer/view')" class="diy_register_field col-md-6">
      <view class="diy_title">
        <text> 手机号码 </text>
      </view>
          <!-- 手机 -->
      <view class="diy_field diy_phone">
        <input type="text" id="form_mobile_phone_number" v-model="form['mobile_phone_number']" @blur="handleBlur($event.target.value, 'mobile_phone_number')" placeholder="请输入手机号码"/>
      </view>
        </view>
    </view>
</template>

<script>
    import { uploadFilePathApi, uploadFileApi } from '@/api/common.js';
export default {
  model: {
    prop: 'form',
    event: 'change',
  },
  props: {
    form: {
      type: Object,
      default: () => {
        return {
          url_upload: '~/api/consumer/upload?',
        };
      },
    },
  },
  data() {
    return {
        };
  },
  methods: {
        /**
     * 上传图片
     * @param {Object} param文件参数
     */
    change_img(key_name) {
      var _self = this;
      _self.upload_img_flag = false;
      // 选择图像方法
      uni.chooseImage({
        count: 1,
        sizeType: ['original', 'compressed'], //可以指定是原图还是压缩图，默认二者都有
        sourceType: ['album'], //从相册选择
        success: (res) => {
          console.log('开始上传图片');
          console.log(tempFilePaths);
          const tempFilePaths = res.tempFilePaths;
          const filePath = tempFilePaths[0];
          uploadFilePathApi(
                  undefined,
                  filePath,
                  undefined,
                  {
                    i_want_to_customize: 'test',
                  },
                  (task) => {
                    task.onProgressUpdate((res) => {
                      this.percent = res.progress;
                      console.log('上传进度' + res.progress);
                      console.log('已经上传的数据长度' + res.totalBytesSent);
                      console.log('预期需要上传的数据总长度' + res.totalBytesExpectedToSend);
                    });
                  }
          ).then((res) => {
            const filename = res.result.url;
            _self.$delete(this.form, key_name);
            _self.$set(this.form, key_name, filename);
            _self.handleBlur(filename, key_name);
          });
        },
        error: function (e) {
          console.log(e);
        },
      });
    },
    handleBlur(value, type) {
      this.$emit('change', { value, type });
    },
  },
  mounted() {
          },
};
</script>
