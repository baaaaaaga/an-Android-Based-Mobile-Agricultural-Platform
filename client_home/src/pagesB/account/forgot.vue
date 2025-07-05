<template>
  <view id="account_forgot" class="user_account account_forgot">
	<view class="container">
		<view class="custom-1"></view>
		<view class="back-btn" @click="navBack"></view>
		<view class="custom-3"></view>
		<view class="wrapper">
		  <view class="left-top-sign">FORGOT</view>
		  <view class="welcome">找回密码</view>
		  <view class="input-content">
		    <view class="input-item">
		      <text class="tit">用户名</text>
		      <input
		        type="text"
		        v-model="form.username"
		        placeholder="请输入用户名"
		        maxlength="11"
		        data-key="username"
		      />
		    </view>
		    <view class="input-item">
		      <text class="tit">密码</text>
		      <input
		        type="password"
		        v-model="form.password"
		        placeholder="6-18位不含特殊字符的数字、字母组合"
		        placeholder-class="input-empty"
		        maxlength="20"
		        password
		        data-key="password"
		      />
		    </view>
		    <view class="input-item">
		      <text class="tit">确认密码</text>
		      <input
		        type="password"
		        v-model="confirm_password"
		        placeholder="6-18位不含特殊字符的数字、字母组合"
		        placeholder-class="input-empty"
		        maxlength="20"
		        password
		        data-key="password"
		      />
		    </view>
		    <view class="input-item">
		      <text class="tit">邮箱</text>
		      <input type="text" v-model="form.email" placeholder="请输入邮箱" />
		    </view>
		    <view class="input-item">
		      <text class="tit">验证码</text>
		      <input
		        style="width: 50%"
		        type="text"
		        v-model="form.code"
		        placeholder="请输入验证码"
		        maxlength="10"
		      />
		      <button
		        class="btn_send"
		        type="primary"
		        style="width: 40%; margin: 0 10px"
		        size="mini"
		        @click="get_code()"
		      >
		        发送
		      </button>
		    </view>
		  </view>
		  <button class="confirm-btn" @click="forgot">找回密码</button>
		  <view class="register-section">
		    还没有账号?<view @click="$navTo('/pagesB/account/register')" class="text">立即注册</view>
		  </view>
		</view>
	</view>
  </view>
</template>

<script>
export default {
  data() {
    return {
      form: {
        username: '',
        password: '',
        email: '',
        code: '',
      },
      confirm_password: '',
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
        confirm_password: {
          rules: [
            {
              required: true,
              errorMessage: '请输入确认密码',
            },
            {
              minLength: 5,
              maxLength: 16,
              errorMessage: '确认密码长度在 {minLength} 到 {maxLength} 个字符',
            },
          ],
        },
        code: {
          rules: [
            {
              required: true,
              errorMessage: '请输入验证码',
            },
            {
              minLength: 1,
              maxLength: 4,
              errorMessage: '验证码长度为{maxLength} 个字符',
            },
          ],
        },
        email: {
          rules: [
            {
              format: 'email',
              errorMessage: '请输入正确的邮箱地址',
            },
          ],
        },
      },
      token: "",
    };
  },
  onLoad() {},
  onReady() {},
  methods: {
    get_code() {
      if (!this.form.username){
        this.$toast("用户名不能为空!","error");
        return
      }
      if (!this.form.email){
        this.$toast("邮箱不能为空!","error");
        return
      }
      let email_regular = /^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
      if(this.form.email && !email_regular.test(this.form.email) ){
        this.$toast("邮箱格式不正确 例：test@test.com","error");
        return
      }
      let _this = this;
      _this.$get('~/api/user/get_obj', {"username": _this.form.username}, function(user_json, status) {
        if (user_json.result && user_json.result.obj) {
          if (user_json.result.obj.email===_this.form.email) {
            // 获取用户状态
            _this.$get('~/api/code_token/send_email', {"email":_this.form.email}, function(json, status) {
              if (json.result) {
                _this.token = json.token;
                _this.$toast('发送成功！', 'success');
              } else if (json.error) {
                _this.$toast(json.error.message,"error");
              } else {
                _this.$toast('服务器连接失败！');
              }
            });
          }else {
            _this.$toast('用户邮箱不正确！', 'error');
          }
        }else {
          _this.$toast('未找到用户！', 'error');
        }
      });
    },
    /**
     * 忘记密码
     * @param {Object} form
     */
    async forgot() {
      var form = Object.assign({}, this.form);
      let msg = await this.submit_check(form);
      if (msg) {
        this.$toast(msg, "error");
        return
      }
      let result = await this.$get("~/api/code_token/verify_email_code", {"token": this.token, "code": form.code});
      if (result.result) {
        this.$post("~/api/user/forget_password?", form, (res) => {
          if (res.result) {
            this.$toast("修改成功", "success");
            var url = this.$redirect();
            this.$nav(url);
          } else if (res.error) {
            this.$toast(res.error.message, "error");
          }
        });
      } else if (result.error) {
        this.$toast(result.error.message, "error");
      } else {
        this.$toast('服务器连接失败！', "error");
      }
    },
    async submit_check(param){

      var msg = "";

      var email_regular = /^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;

      var {username ,email ,password ,code} = param;

      if(!username){
        msg = "用户名不能为空!";
      }
      else if (!email){
        msg = "邮箱不能为空!"
      }
      else if(email && !email_regular.test(email) ){
        msg = "邮箱格式不正确 例：test@test.com";
      }
      else if(password !== this.confirm_password){
        msg = "密码和确认密码不一致。";
      }
      else if(!code){
        msg = "验证码不能为空！";
      }
      if (msg === ''){
        let result = await this.$get("~/api/code_token/verify_email_code",{"token":this.token,"code":code});
        if (result.result) {
        } else if (result.error) {
          msg = result.error.message
        } else {
          msg = '服务器连接失败！'
        }
      }
      return msg;
    },
    /**
     * 手动重置表单
     */
    resetForm() {
      this.$refs.form.resetFields();
    },
    navBack() {
      uni.navigateBack();
    },
  },
};
</script>

<style lang="scss" scoped>
@import 'styles/pagesB/index.scss';
</style>
