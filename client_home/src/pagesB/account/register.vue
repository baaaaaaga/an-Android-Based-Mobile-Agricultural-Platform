<template>
  <view class="account_register" id="account_register">
	<view class="container">
		<view class="custom-1"></view>
		<view class="back-btn" @click="navBack"></view>
		<view class="custom-3"></view>
		<view class="wrapper">
			<view class="left-top-sign">REGISTER</view>
			<view class="welcome">注册</view>
		</view>
		<uni-forms
	      class="form_register"
	      :rules="rules"
	      :value="form"
	      ref="form"
	      validate-trigger="bind"
	      err-show-type="undertext"
	      labelWidth="90px"
	    >
	      <uni-forms-item class="username" name="username" required label="账号">
	        <uni-easyinput
	          type="text"
	          :inputBorder="true"
	          v-model="form.username"
	          placeholder="请输入账号"
	        ></uni-easyinput>
	      </uni-forms-item>
	
	      <uni-forms-item class="password" name="password" required label="密码">
	        <uni-easyinput
	          type="password"
	          :inputBorder="true"
	          v-model="form.password"
	          placeholder="请输入密码"
	        ></uni-easyinput>
	      </uni-forms-item>
	
	      <uni-forms-item class="confirm_password" name="confirm_password" required label="确认密码">
	        <uni-easyinput
	          type="password"
	          :inputBorder="true"
	          v-model="confirm_password"
	          placeholder="请再次输入密码"
	        ></uni-easyinput>
	      </uni-forms-item>
	
	      <uni-forms-item class="nickname" name="nickname" required label="昵称">
	        <uni-easyinput type="text" v-model="form.nickname" placeholder="请输入昵称">
	        </uni-easyinput>
	      </uni-forms-item>
	
	      <uni-forms-item name="email" label="邮箱">
	        <uni-easyinput type="email" v-model="form.email" placeholder="请输入邮箱"> </uni-easyinput>
	      </uni-forms-item>
	
		
	      <uni-forms-item class="user_group" name="user_group" label="身份">
	        <view class="group_selector">
	          <picker mode="selector" :range="list_user_group" range-key="name" @change="select_group">
	            {{ form.user_group ? form.user_group : '选择身份' }}
	            <uni-icons style="padding-left: 0.5rem" type="arrowdown" size="16"> </uni-icons>
	          </picker>
	        </view>
	      </uni-forms-item>
	
	  	    	  	    	      <!-- 消费者 -->
	      <form_consumer v-if="form.user_group === '消费者'" @change="handleSubFormChange" :form="form_sub" ></form_consumer>
	    	  	    	  	    	  	    	  	    	  	    	  	    	  	    	  	    	  	
	      <view class="btn_register" @click="submit()">立即注册</view>
	      <view class="btn_all">
			<view class="login-section">
			  已经有账号?<view @click="$navTo('/pagesB/account/login')" class="text">立即登录</view>
			</view>
	        <view class="forgot-section" @click="$navTo('/pagesB/account/forgot')">忘记密码</view>
	      </view>
	    </uni-forms>
	</view>
    
  </view>
</template>

<script>
import mixin from '@/libs/mixins/page.js';
      /* 消费者 */
  import form_consumer from "@/pagesB/components/form_consumer";
                  
import { uploadFilePathApi, uploadFileApi } from '@/api/common.js';
export default {
  components: {
        /* 消费者 */
    form_consumer,
                    },
  mixins: [mixin],
  data() {
    return {
      url_submit: '~/api/user/register?',
      form: {
        nickname: '',
        username: '',
        password: '',
        email: '',
        // phone: '',
        user_group: '',
      },

      form_sub: {},

      // 确认密码
      confirm_password: '',

      // 校验
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
        nickname: {
          rules: [
            {
              minLength: 2,
              maxLength: 12,
              errorMessage: '昵称长度为{maxLength} 个字符',
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
        user_group: {
          rules: [
            {
              required: true,
              errorMessage: '请选择用户组',
            },
          ],
        },
      },

      // 用户组列表
      list_user_group: [],
    };
  },
  methods: {
    as(obj, query, all) {
      if (obj) {
        var bl = true;
        var type = typeof obj;
        if (type !== typeof query) {
          // 如果类型不一致 则两个无相似
          bl = false;
        } else if (type === 'string' || type === 'bool' || type === 'number') {
          bl = obj === query;
        } else if (obj.constructor == Array) {
          // 如果都是数组
          var lh = obj.length;
          if (all && lh !== query.length) {
            // 要求完全一致 而长度不一致 说明不相似
            bl = false;
          } else {
            // 否则判断数组里的每个成员是否相似
            for (var i = 0; i < lh; i++) {
              if (!this.as(obj[i], query[i])) {
                bl = false;
                break;
              }
            }
          }
        } else {
          // 如果类型为对象
          if (
            all &&
            Object.getOwnPropertyNames(obj).length !== Object.getOwnPropertyNames(query).length
          ) {
            // 如果要求完全一致, 而属性长度不一致，则不相似
            bl = false;
          } else {
            // 否则都为对象则判断其值是否一致
            for (var k in query) {
              if (!this.as(obj[k], query[k], all)) {
                bl = false;
                break;
              }
            }
          }
        }
        return bl;
      } else {
        return false;
      }
    },
    getObj(data, query) {
      var obj;
      if (query) {
        for (var i = 0; i < data.length; i++) {
          var o = data[i];
          if (this.as(o, query)) {
            obj = o;
            break;
          }
        }
      }
      return obj;
    },
    getVal(data, key, query) {
      var obj = this.getObj(data, query);
      if (obj) {
        return obj[key];
      } else {
        return null;
      }
    },
    handleSubFormChange(data) {
      this.form_sub[data.type] = data.value;
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
      var pm = this.events('submit_before', Object.assign({}, param)) || param;
      // 提交前验证事件
      var msg = await this.events('submit_check', pm);
      var ret;
      console.log('提交前错误信息：', msg);
      // 判断错误
      if (msg) {
        this.$toast(msg, 'danger');
      } else {
        // 提交表单
        ret = this.events('submit_main', pm, func);
      }
      // 返回结果
      return ret;
    },
    /**
     * 提交前事件
     * @param {Object} param
     */
    submit_before(param) {
      var user_group = param.user_group;
        if(user_group === "消费者"){
                            }
                      },

    /**
     * 提交前校验
     * @param {Object} param
     */
    async submit_check(param) {
      var ret = null;

      var email_regular = /^[a-zA-Z0-9_-]+@[a-zA-Z0-9_-]+(\.[a-zA-Z0-9_-]+)+$/;
      // var phone_regular = /^(13[0-9]|14[01456879]|15[0-35-9]|16[2567]|17[0-8]|18[0-9]|19[0-35-9])\d{8}$/;

      // var {username ,password ,nickname ,user_group ,email ,phone} = param;
      var { username, password, nickname, user_group, email } = param;

      var confirm_password = this.confirm_password;

      console.log(
        '表单校验username ,password ,email ,nickname ,user_group',
        username,
        password,
        email,
        nickname,
        user_group
      );

      if (!username) {
        ret = '账号不能为空';
      } else if (username.length > 16 || username.length < 5) {
        ret = '账号长度应为5到16个字符之间！';
      } else if (!password) {
        ret = '密码不能为空!';
      } else if (password.length > 16 || password.length < 5) {
        ret = '密码长度应为5到16个字符之间！';
      } else if ((nickname && nickname.length > 12) || nickname.length < 2) {
        ret = '昵称长度应为2个字符到12个字符之间';
      } else if (email && !email_regular.test(email)) {
        ret = '请输入正确的邮箱地址 例：test@test.com!';
      }
      // else if(phone && !phone_regular.test(phone)){
      // 	ret = "请输入正确的手机号码 例：18955552312!";
      // }
      else if (password != confirm_password) {
        ret = '确认密码与密码不一致！';
      } else if (!user_group) {
        ret = '请选择用户组!';
      }
      console.log(user_group);
      if (!ret && user_group) {
            if(user_group === "消费者"){
          var form_sub = Object.assign({} ,this.form_sub);
                                                      let mobile_phone_number_phone_regular = /^(13[0-9]|14[01456879]|15[0-35-9]|16[2567]|17[0-8]|18[0-9]|19[0-35-9])\d{8}$/;
          if(form_sub.mobile_phone_number && !mobile_phone_number_phone_regular.test(form_sub.mobile_phone_number)){
            return "手机号格式错误"
          }
                            }
                        }

      var p = { username: param.username };

      if (!ret) {
        var res = await this.$get('~/api/user/count', p);

        if (res.result) {
          ret = '用户已存在!';
        }
      }

      return ret;
    },

    /**
     * 提交成功后
     * @param {Object} json
     * @param {Object} func
     */
    submit_after(json, func) {
      var form = Object.assign({}, this.form);
      delete form.password;
      console.log('查询表单form', form);
      var table = this.getVal(this.list_user_group, 'source_table', { name: form.user_group });
      console.log('关联表:', table);
      if (table) {
        this.get_register(form, table);
      } else {
        console.log('用户组没有关联表');
      }
    },

    /**
     * 获取注册表信息
     * @param {Object} form
     * @param {Object} table
     */
    get_register(form, table) {
      var form_sub = this.form_sub;
      this.$get('~/api/user/get_obj', form, (res) => {
        console.log('注册表信息res', res);
        if (res.result && res.result.obj) {
          form_sub.user_id = res.result.obj.user_id;
          this.submit_sub(form_sub, table);
        } else if (res.error) {
          console.error(res.error);
          this.$toast(res.error.message, 'error');
        }
      });
    },

    /**
     *  提交附加信息
     */
    submit_sub(form, table) {
	  for (let index in form) {
	  	if(Array.isArray(form[index])){
	  	  form[index] = form[index].join(',')
	  	}
	  }
	  setTimeout(() => {
	  	this.$post('~/api/' + table + '/add?', form, (res) => {
	  	  console.log('提交结果res：', res);
	  	  if (res.result) {
	  	    this.$toast('注册成功!');
	  	    setTimeout(() => {
	  	      this.$Router.pushTab('/pages/index/index');
	  	    }, 1000);
	  	  } else if (res.error) {
	  	    this.$toast(res.error.message);
	  	  }
	  	});
	  }, 1000);
    },

    // 选择学校时触发
    select_group(e) {
      // 选中后会触发这个回调函数 e.target.value是你选中的下拉菜单数组的索引
      const i = e.target.value; // 将根据索引将你选中的学校名称在数组中找出来
      var list = this.list_user_group;
      this.form.user_group = list[i].name;
    },

    // 获取用户组
    get_list_user_group() {
      this.$get('~/api/user_group/get_list?register_min=2&register_max=3', {}, (res) => {
        if (res.result && res.result.list) {
          this.list_user_group = res.result.list;
        } else if (res.error) {
          console.error(res.error);
          this.$toast(res.error.message);
        }
      });
    },
    handleBlur(value, type) {
      this.$emit('change', { value, type });
    },
  },
  onLoad() {
    this.get_list_user_group();
  },
  onReady() {},
};
</script>

<style lang="scss" scoped>
@import 'styles/pagesB/index.scss';
</style>
