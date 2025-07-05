<template>
  <article class="sign_in forgot_wrap">
    <div class="warp">
      <el-row>
        <el-col>
          <el-form :model="form" ref="form" label-width="80px" class="form">
            <h1>忘记密码</h1>

            <el-form-item label="用户名" prop="username">
              <el-input v-model="form.username" placeholder="请输入用户名"></el-input>
            </el-form-item>

            <el-form-item label="邮箱" prop="email">
              <el-input v-model="form.email" placeholder="请输入邮箱">
              </el-input>
            </el-form-item>

            <el-form-item label="验证码" prop="code">
              <el-input v-model="form.code" placeholder="请输入验证码">
                <el-button @click="send()" slot="append">发送验证码</el-button>
              </el-input>
            </el-form-item>

            <el-form-item label="新密码" prop="password">
              <el-input v-model="form.password" placeholder="请输入新密码" show-password>
              </el-input>
            </el-form-item>

            <el-form-item label="确认密码" prop="confirm_password">
              <el-input v-model="confirm_password" placeholder="请再次输入新密码" show-password>
              </el-input>
            </el-form-item>

            <div class="btns">
              <el-button class="float-right  fg_submit" type="primary" @click="submit()">提交</el-button>
              <!-- <router-link to="./login">取消</router-link> -->
              <el-button class="float-right  fg_cancle" @click="$router.push('./login')">取消</el-button>
            </div>

          </el-form>
        </el-col>
      </el-row>
    </div>
  </article>
</template>

<script>
  import mixin from "@/mixins/page.js";

  export default {
    mixins: [mixin],
    data: function () {
      return {
        url_submit: "~/api/user/forget_password?",
        token: "",
        confirm_password: "",

        oauth: {
          signIn: false
        },

        form: {
          username: "",
          phone: "",
          email: "",
          password: "",
          code: ""
        }
      }
    },
    methods: {
      send() {
        if (!this.form.username) {
          this.$toast("用户名不能为空!", "error");
          return
        }
        if (!this.form.email) {
          this.$toast("邮箱不能为空!", "error");
          return
        }
        let email_regular = /^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
        if (this.form.email && !email_regular.test(this.form.email)) {
          this.$toast("邮箱格式不正确 例：test@test.com", "error");
          return
        }
        let _this = this;
        _this.$get('~/api/user/get_obj', {"username": _this.form.username}, function (user_json, status) {
          if (user_json.result && user_json.result.obj) {
            if (user_json.result.obj.email === _this.form.email) {
              // 获取用户状态
              _this.$get('~/api/code_token/send_email', {"email": _this.form.email}, function (json, status) {
                if (json.result) {
                  _this.token = json.token;
                  _this.$toast('发送成功！', 'success');
                } else if (json.error) {
                  _this.$toast(json.error.message, "error");
                } else {
                  _this.$toast('服务器连接失败！');
                }
              });
            } else {
              _this.$toast('用户邮箱不正确！', 'error');
            }
          } else {
            _this.$toast('未找到用户！', 'error');
          }
        });
      },

      /**
       *  提交前校验
       *  @param {Object} param
       */
      async submit_check(param) {

        var msg = "";

        var email_regular = /^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;

        var {username, email, password, code} = param;

        if (!username) {
          msg = "用户名不能为空!";
        } else if (!email) {
          msg = "邮箱不能为空!"
        } else if (email && !email_regular.test(email)) {
          msg = "邮箱格式不正确 例：test@test.com";
        } else if (password !== this.confirm_password) {
          msg = "密码和确认密码不一致。";
        } else if (!code) {
          msg = "验证码不能为空！";
        }
        if (msg === '') {
          let result = await this.$get("~/api/code_token/verify_email_code", {"token": this.token, "code": code});
          if (result.result) {
          } else if (result.error) {
            msg = result.error.message
          } else {
            msg = '服务器连接失败！'
          }
        }
        return msg;
      },

      submit_before(param) {
        var p = Object.assign({}, param);
        console.log("提交前信息：", p);
        return p;
      },
      submit_after() {
        this.$toast('提交成功！', 'success');
        this.$router.push("/login");
      },
      /**
       * 提交事件
       * @param {Object} param 表单
       * @param {Object} func 返回函数
       */
      async submit(param, func) {
        // console.log('提交事件', param);
        if (!param) {
          param = this.form;
        }
        // 提交前事件
        var pm = this.events("submit_before", Object.assign({}, param)) || param;
        // 提交前验证事件
        var msg = await this.events("submit_check", pm);
        var ret;

        console.log("提交前错误信息msg：", msg);
        // 判断错误
        if (msg) {
          this.$toast(msg, 'danger');
        } else {
          // 提交表单
          ret = this.events("submit_main", pm, func);
        }
        // 返回结果
        return ret;
      }
    },
    created() {

    }
  }
</script>

<style>
  .sign_in {
    box-sizing: border-box;
    height: 100vh;
    padding: .5rem;
    width: 100%;
    background: url("../../public/img/bg.jpg") no-repeat;
    background-size: 100% 100%;
    color: #fff;
  }

  .sign_in h1,
  .sign_in .btns {
    text-align: center;
  }

  .sign_in .btns .el-button {
    width: 40%;
  }

  .sign_in .el-form-item__label {
    color: #fff;
  }

  .sign_in .form {
    box-sizing: border-box;
    padding: 1rem 3rem;
    margin: auto;
    margin-top: 15rem;
    width: 100%;
    max-width: 25rem;
    box-shadow: 0 0 0 1px hsla(240, 0%, 100%, .3) inset,
    0 .5em 1em rgba(50, 50, 50, 0.6);
    text-shadow: 0 1px 1px hsla(240, 0%, 100%, .5);
    overflow: hidden;
    /* background-color: rgba(255, 255, 255, .5); */
    border-radius: 0.5rem;
  }

  .sign_in .form:after {
    content: '';
    position: absolute;
    top: 0;
    left: 0;
    right: 0;
    bottom: 0;
    background-color: rgba(255, 255, 255, 0.8);
    z-index: -1;

    background-image: url("../../public/img/bg.jpg");
    background-position: center top;
    background-size: cover;
    background-attachment: fixed;
    -webkit-filter: blur(20px);
    -moz-filter: blur(20px);
    -ms-filter: blur(20px);
    -o-filter: blur(20px);
    filter: blur(20px);
  }
</style>
