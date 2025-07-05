<template>
  <view id="account_login" class="user_account account_login">
    <view class="container">
      <view class="custom-1"></view>
      <view class="custom-2"></view>
      <view class="custom-3"></view>
      <view class="custom-4"><text>农产品市场平台</text></view>
      <view class="custom-5"></view>

      <view class="login-wrapper">
        <view class="input-content">
          <view class="input-item">
            <view class="input-item-icon">
              <view class="tn-icon-my-lack"></view>
            </view>
            <input
                type="text"
                v-model="form.username"
                placeholder="请输入用户名"
                maxlength="16"
                data-key="username"
            />
          </view>
          <view class="input-item">
            <view class="input-item-icon">
              <view class="tn-icon-lock"></view>
            </view>
            <input
                v-model="form.password"
                placeholder="请输入密码"
                placeholder-class="input-empty"
                maxlength="20"
                :password="!showPassword"
                data-key="password"
                @confirm="login"
            />
            <view class="input-item-icon">
              <view
                  @click="showPassword = !showPassword"
                  :class="[showPassword ? 'tn-icon-eye' : 'tn-icon-eye-hide']"
              >
              </view>
            </view>
          </view>
        </view>
        <button class="confirm-btn" @click="login" :disabled="logining">登录</button>
        <view class="forget-section">
          <view @click="$navTo('/pagesB/account/forgot')">忘记密码?</view>
        </view>
                      		<view class="register-section">
			还没有账号?
			<view @click="$navTo('/pagesB/account/register')" class="text">马上注册</view>
		</view>
      </view>
    </view>

  </view>
</template>

<script>
  import mixin from '@/libs/mixins/page.js';
  import {loginApi} from '@/api/login.js';
  import jsencrypt from '@/components/jsencrypt/jsencrypt.vue';

  export default {
    mixins: [mixin],
    data() {
      return {
        logining: false,
		allow_user: [
			'管理员'
					,"消费者"
											],
        form: {
          username: '',
          password: '',
        },
        rules: {
          username: {
            rules: [
              {
                required: true,
                errorMessage: '请输入用户名',
              },
              {
                minLength: 5,
                maxLength: 16,
                errorMessage: '用户名长度在 {minLength} 到 {maxLength} 个字符',
              },
            ],
          },
          password: {
            rules: [
              {
                required: true,
                errorMessage: '请输入密码',
              },
              {
                minLength: 5,
                maxLength: 16,
                errorMessage: '密码长度在 {minLength} 到 {maxLength} 个字符',
              },
            ],
          },
        },
        showPassword: false,
      };
    },
    onLoad() {
      console.log(this.$u.route);
    },
    methods: {
      closePopup() {
        this.logining = false;
      },
      login() {
        this.logining = true;
        let form = Object.assign({}, this.form);
          const publicKey = "MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQC+mEDzYLbKNB9rbOuvGgwdBUpPaHryRGarxBQppkOzlj+ouep8MMq1Xg7NBkjLOV2vnn4E5AVvX0XVOmBg8W5eNQ1uS1HCG2fie8BpXGgl1pWj/HYIrA2d/U7xxvMO8UMhAGfMdaGrPrGdZTr95pzL/q+VJZOcqSAgux/YEdu11wIDAQAB";
        form.password = jsencrypt.setEncrypt(publicKey,form.password);
          loginApi(form)
          .then((res) => {
            if (res.result && res.result.obj) {
              let user = res.result.obj;
			  if(this.allow_user.includes(user.user_group)){
				  				  // 缓存token
				  this.$u.vuex('token', user.token);
				  // 存储用户信息
				  this.$u.vuex('userInfo', user);
				  // 设置权限集
				  this.$u.vuex('userGroup', user.user_group);
				  // 前往首页
				  uni.switchTab({
				    url: '/pages/index/index',
				  });
				  console.log('---登录成功---');
			  }else{
				  this.$toast("您的账号不支持在用户端登录！", 'error');
			  }
              
            } else if (res.error) {
              this.$toast(res.error.message, 'error');
            }
          })
          .finally(() => {
            this.logining = false;
          });
      },
      /**
       * 手动重置表单
       */
      resetForm() {
        this.$refs.form.resetFields();
      },
    },
    onBackPress() {
      var bl = false;
      var user_id = this.user.user_id;
      if (user_id == null || user_id < 1) {
        // this.$nav('/pages/index/index');
        bl = true;
      }
      return false;
    },
  };
</script>

<style lang="scss" scoped>
  @import 'styles/pagesB/index.scss';
</style>
