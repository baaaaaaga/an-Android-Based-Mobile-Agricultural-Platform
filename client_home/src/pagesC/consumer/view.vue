<template>
  <view class="page_diy_view page_consumer_view" :style="{ paddingTop: vuex_custom_bar_height + 'px' }">
    <tn-nav-bar>消费者详情</tn-nav-bar>
    <view id="page_diy_view" class="page-from">
      <uni-forms :modelValue="form" v-if="is_view()" labelWidth="70px">
        <uni-forms-item label="头像" name="avatar">
          <view class="from-img" v-if="form_user['avatar']">
            <image :src="$fullImgUrl(form_user['avatar'])" @click="change_avatar()" />
          </view>
          <view class="from-img" v-else-if="!form_user['avatar']">
            <view class="add-img" @click="change_avatar()">
              <text>+</text>
            </view>
          </view>
          <uni-icons style="display: none" class="forward" type="forward" id="form_user_img_avatar"></uni-icons>
        </uni-forms-item>

        <uni-forms-item label="账号" name="username">
          <span v-if="obj_user.username">{{ obj_user.username }}</span>
          <uni-easyinput v-else type="text" v-model="form_user.username" placeholder="请输入账号" />
        </uni-forms-item>

        <uni-forms-item v-if="!obj_user.password" label="密码" name="password">
          <uni-easyinput type="password" v-model="form_user.password" placeholder="请输入密码" />
        </uni-forms-item>

        <uni-forms-item label="昵称" name="nickname">
          <uni-easyinput type="text" v-model="form_user.nickname" placeholder="请输入昵称" />
        </uni-forms-item>

        <uni-forms-item label="邮箱" name="email">
          <uni-easyinput type="text" v-model="form_user.email" placeholder="请输入邮箱" />
        </uni-forms-item>

        <uni-forms-item label="状态" name="state">
          <uni-data-select
            v-model="form_user.state"
            :localdata="list_user_state"
            :disabled="user_group !== '管理员'" 
			:clear="user_group=='管理员'"
			 style="width: 100%;"
          ></uni-data-select>
        </uni-forms-item>

  
        <uni-forms-item v-if="$check_field('get','user_name') || ($check_field('add','user_name') || $check_field('set','user_name'))" label="用户姓名" name="user_name">
                      <uni-easyinput type="text" v-model="form['user_name']" v-if="(form['consumer_id'] && $check_field('set','user_name')) || (!form['consumer_id'] && $check_field('add','user_name'))" :disabled="disabledObj['user_name_isDisabled']" />
          <!-- 仅查看 -->
          <text v-else-if="$check_field('get','user_name')">
            {{ form['user_name'] }}
          </text>
                    </uni-forms-item>
        <uni-forms-item v-if="$check_field('get','mobile_phone_number') || ($check_field('add','mobile_phone_number') || $check_field('set','mobile_phone_number'))" label="手机号码" name="mobile_phone_number">
              <uni-easyinput type="number" v-model="form['mobile_phone_number']" v-if="(form['consumer_id'] && $check_field('set','mobile_phone_number')) || (!form['consumer_id'] && $check_field('add','mobile_phone_number'))" :disabled="disabledObj['mobile_phone_number_isDisabled']" />
          <!-- 仅查看 -->
          <text v-else-if="$check_field('get','mobile_phone_number')">
            {{ form['mobile_phone_number'] }}
          </text>
            </uni-forms-item>
      </uni-forms>
      <view class="form-footer" v-if="$check_action('/consumer/view','set') || ($check_action('/consumer/view','add') || $check_option('/consumer/table','examine'))">
        <view class="me-btn btn-submit" @click="submit_()"> 提交 </view>
        <view class="me-btn btn-cancel" @click="cancel()">取消</view>
      </view>
      <view class="form_button" v-else>
        <view class="me-btn btn-cancel" @click="cancel()">返回</view>
      </view>
    </view>
  </view>
</template>

<script>
import mixin from '@/libs/mixins/page.js';
        import { uploadFilePathApi, uploadFileApi } from '@/api/common.js';
export default {
  mixins: [mixin],
  data() {
    return {
	  today: new Date().toISOString().split('T')[0],
      field_user: "user_id",
      url_add_user: "~/api/user/register?",
      url_set_user: "~/api/user/set?",
      url_get_obj_user: "~/api/user/get_obj?",
      url_upload_user: "~/api/user/upload?",
      form_user:{
        user_id: 0,
        username: '',
        nickname: '',
        password: '',
        avatar: '',
        // phone: '',
        email: '',
        user_group: "消费者",
        // phone_state: 0,
        // email_state: 0,
        state: 1,
        },
      obj_user: {
        user_id: 0,
        username: '',
        nickname: '',
        password: '',
        avatar: '',
        // phone: '',
        email: '',
        user_group: "消费者",
        // phone_state: 0,
        // email_state: 0,
        state: 1,
        },
      query_user: {
        "user_id": 0,
      },
      list_state: [{value:0,text:"未认证"},{value:1,text:"审核中"},{value:2,text:"已认证"}],
      list_user_state: [{value: 1,text: "可用"},{value: 2,text: "异常"},{value: 3,text: "已冻结"},{value: 4,text: "已注销"}],
      group_table: "consumer",
      is_password: true,
        field: "consumer_id",
      url_add: "~/api/consumer/add?",
      url_set: "~/api/consumer/set?",
      url_get_obj: "~/api/consumer/get_obj?",
      url_upload: "~/api/consumer/upload?",
      user_name: null,
      mobile_phone_number: null,
      query: {
        "consumer_id": 0,
      },
      form: {
          "user_name":  '', // 用户姓名
            "mobile_phone_number":  '', // 手机号码
          "user_id": 0,
        "consumer_id": 0, // ID
      },
      disabledObj:{
          "user_name_isDisabled": false,
            "mobile_phone_number_isDisabled": false,
        },
                    };
  },
  methods: {
    /**
     * 提交前验证事件
     * @param {Object} 请求参数
     * @return {String} 验证成功返回null, 失败返回错误提示
     */
    async submit_check(param) {
                              let mobile_phone_number_phone_regular = /^(13[0-9]|14[01456879]|15[0-35-9]|16[2567]|17[0-8]|18[0-9]|19[0-35-9])\d{8}$/;
      if(param.mobile_phone_number && !mobile_phone_number_phone_regular.test(param.mobile_phone_number)){
        return "手机号格式错误"
      }
                  return null;
    },
    changeLog(v, value) {
      this.form[value] = v;
    },
    uploadFile_(type) {
      // #ifdef APP-VUE
      uni.chooseFile({
        count: 1,
        success: (chooseImageRes) => {
          const tempFilePaths = chooseImageRes.tempFilePaths;
          this.successChoose(tempFilePaths[0], type);
        },
      });
      // #endif
      // #ifdef !APP-VUE
      if (
        uni.getSystemInfoSync().uniPlatform != 'mp-weixin' ||
        uni.getSystemInfoSync().platform == 'devtools'
      ) {
        uni.chooseImage({
          count: 1,
          success: (chooseImageRes) => {
            const tempFilePaths = chooseImageRes.tempFilePaths;
            this.successChoose(tempFilePaths[0], type);
          },
        });
      } else {
        wx.chooseMessageFile({
          count: 1,
          success: (chooseImageRes) => {
            const tempFilePaths = chooseImageRes.tempFiles;
            this.successChoose(tempFilePaths[0].path, type);
          },
        });
      }
      // #endif
    },
    successChoose(filePath, type) {
      uni.uploadFile({
        url: this.$fullUrl('~/api/consumer/upload?'), //仅为示例，非真实的接口地址
        filePath,
        name: 'file',
        success: (uploadFileRes) => {
          if (uploadFileRes.data.error) {
            uni.showToast({ title: uploadFileRes.data.error.message, icon: 'none' });
          } else {
            this[type] = JSON.parse(uploadFileRes.data).result.url;
          }
        },
      });
    },
    close_(type) {
      if (type == 'user_name') this['user_name'] = this.form['user_name'] = "";
      if (type == 'mobile_phone_number') this['mobile_phone_number'] = this.form['mobile_phone_number'] = "";
    },
    submit_() {
      if (this['user_name'] !== null) this.form['user_name'] = this['user_name']
      if (this['mobile_phone_number'] !== null) this.form['mobile_phone_number'] = this['mobile_phone_number']
      console.log(this.form)
      this.submit();
    },
    /**
     * 上传文件
     * @param {Object} param文件参数
     */
    change_file(key_name) {
      var _self = this;
      // 选择图像方法
      uni.chooseFile({
        count: 1,
        sizeType: ['original', 'compressed'], //可以指定是原图还是压缩图，默认二者都有
        sourceType: ['album'], //从相册选择
        success: (file) => {
          const tempFilePaths = file.tempFilePaths;
          const filePath = tempFilePaths[0];
          uploadFilePathApi(
            '/consumer/upload',
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
            this.form[key_name] = filename;
          });
        },
        error: function (e) {
          console.log(e);
        },
      });
    },
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
        success: (file) => {
          const tempFilePaths = file.tempFilePaths;
          const filePath = tempFilePaths[0];
          uploadFilePathApi('/consumer/upload',filePath,undefined,undefined,
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
            this.form[key_name] = filename;
          });
        },
        error: function (e) {
          console.log(e);
        },
      });
    },
    /**
     * 获取对象后获取缓存表单
     * @param {Object} json
     * @param {Object} func
     */
    get_obj_before(param) {
      var form = uni.db.get('form');
      if (form) {
        delete form.examine_state;
        delete form.examine_reply;
        this.obj = uni.push(this.obj, form);
        this.form = uni.push(this.form, form);
      }
      var arr = [];
      for (let key in form) {
        arr.push(key);
      }
      for (var i = 0; i < arr.length; i++) {
        this.disabledObj[arr[i] + '_isDisabled'] = true;
      }
        	if(/^\d{10}$|^\d{13}$/.test(this.form["user_name"])){
    		this.form["user_name"] = this.$toTime(parseInt(this.form["user_name"]),"yyyy-MM-dd hh:mm:ss")
    	}
              uni.db.del('form');

      return param;
    },
    
      
      /**
     * 获取对象之后
     * @param {Object} json
     * @param {Object} func
     */
    get_obj_after(json, func) {
      let user_id = this.form.user_id;
      this.$get('~/api/user/get_obj', { user_id }, (res) => {
        if (res.result && res.result.obj) {
          let o = res.result.obj;
          delete o['create_time'];
          delete o['login_time'];
          this.form_user = o;
          this.obj_user = o;
          this.is_password = this.obj_user.password ? false : true;
          this.query_user.user_id = user_id;
        } else if (res.error) {
          console.log(res.error);
          console.log('获取不到相关信息');
        }
      });
                            },
    /**
     * 修改头像
     * @param {Object} param文件参数
     */
    change_avatar() {
      var _self = this;
      _self.upload_img_flag = false;
      // 选择图像方法
      uni.chooseImage({
        count: 1,
        sizeType: ['original', 'compressed'], //可以指定是原图还是压缩图，默认二者都有
        sourceType: ['album'], //从相册选择

        success: (file) => {
          const tempFilePaths = file.tempFilePaths;
          const filePath = tempFilePaths[0];
          uploadFilePathApi(
            undefined,
            filePath,
            undefined,
            undefined,
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
            this.form_user.avatar = filename;
          });
        },
        error: function (e) {
          console.log(e);
        },
      });
    },
    async submit(param, func) {
      if (!param) {
        param = this.form_user;
      }
      var pm = this.events('submit_before', Object.assign({}, param)) || param;
      var msg = await this.events('submit_check', pm);
      var ret;
      if (msg) {
        this.$toast(msg, 'danger');
      } else {
        ret = this.events('submit_main', pm, func);
      }
      return ret;
    },

    // 提交前校验
    async submit_check(param) {
      var ret = null;

      var email_regular = /^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;

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
      } else if (this.is_password && (password.length > 16 || password.length < 5)) {
        ret = '密码长度应为5到16个字符之间！';
      } else if ((nickname && nickname.length > 12) || nickname.length < 2) {
        ret = '昵称长度应为2个字符到12个字符之间';
      } else if (email && !email_regular.test(email)) {
        ret = '请输入正确的邮箱地址 例：test@test.com!';
      }
      else if (!user_group) {
        ret = '请选择用户组!';
      }

      var p = { username: param.username };

      let form_sub = Object.assign({}, this.form);
                              let mobile_phone_number_phone_regular = /^(13[0-9]|14[01456879]|15[0-35-9]|16[2567]|17[0-8]|18[0-9]|19[0-35-9])\d{8}$/;
      if(form_sub.mobile_phone_number && !mobile_phone_number_phone_regular.test(form_sub.mobile_phone_number)){
        return "手机号格式错误"
      }
                  return ret;
    },

    submit_main(param, func) {
      var url = this.url;
      if (url) {
        if (this.field_user) {
          var id = param[this.field_user];
          if (id) {
            var q = {
              method: 'set',
            };
            q[this.field_user] = id;
            url = this.toUrl(q, url);
          } else {
            url += 'method=add';
          }
        } else {
          url += 'method=submit';
        }
      } else if (this.url_submit) {
        url = this.url_submit;
      } else if (this.field_user) {
        var id = param[this.field_user];
        if (id) {
          url = this.url_set_user;
        } else {
          url = this.url_add_user;
        }
      }

      // console.log('提交', url);
      if (url) {
        var _this = this;
        this.$post(this.$toUrl(this.query_user, url), param, function (json, status) {
          if (json.result === 0 || json.result) {
            _this.events('submit_after', json, func);
          } else if (json.error) {
            _this.$toast(json.error.message, 'danger');
          } else {
            _this.$toast('服务器连接失败！', 'danger');
          }
        });
      }
    },

    // 提交成功后
    submit_after(json, func) {
      var form = Object.assign({}, this.form_user);
      console.log('查询表单form', form);
      this.get_register(form);
    },

    /**
     * 获取注册表信息
     * @param {Object} form
     * @param {Object} table
     */
    get_register(form) {
      var form = this.form;
      var form_user = this.form_user;
      delete form_user.password;
      if (!form['consumer_id']) {
        delete form_user.user_id;
      }
      this.$get('~/api/user/get_obj', form_user, (res) => {
        console.log('注册表信息res', res);
        if (res.result && res.result.obj) {
          form.user_id = res.result.obj.user_id;
          this.submit_sub(form);
        } else if (res.error) {
          console.error(res.error);
          this.$toast(res.error.message, 'error');
        }
      });
    },

    submit_sub(form_sub) {
      if (form_sub['consumer_id']) {
        // 提交事件
        this.$post('~/api/' + this.group_table + '/set?consumer_id=' + form_sub['consumer_id'], form_sub, (res) => {
            console.log('提交结果：', res);
            if (res.result) {
              this.$toast('修改成功!', 'success');
              uni.navigateBack({
                delta: 1,
              });
            } else if (res.error) {
              console.error(res.error);
              this.$toast(res.error.message, 'error');
            }
          }
        );
      } else {
        // 提交事件
        this.$post('~/api/' + this.group_table + '/add?', form_sub, (res) => {
          console.log('提交结果：', res);
          if (res.result) {
            this.$toast('添加成功!', 'success');
            uni.navigateBack({
              delta: 1,
            });
          } else if (res.error) {
            var user_id = form_sub['user_id'];
            this.$get('~/api/user/del', { user_id });
            console.error(res.error);
            this.$toast(res.error.message, 'error');
          }
        });
      }
    },
    
    is_view() {
      var bl = this.user_group == '管理员';

      if (!bl) {
        bl = this.$check_action('/consumer/table', 'add');
        console.log(bl ? '你有表格添加权限视作有添加权限' : '你没有表格添加权限');
      }
      if (!bl) {
        bl = this.$check_action('/consumer/table', 'set');
        console.log(bl ? '你有表格添加权限视作有修改权限' : '你没有表格修改权限');
      }
      if (!bl) {
        bl = this.$check_action('/consumer/view', 'add');
        console.log(bl ? '你有视图添加权限视作有添加权限' : '你没有视图添加权限');
      }
      if (!bl) {
        bl = this.$check_action('/consumer/view', 'set');
        console.log(bl ? '你有视图修改权限视作有修改权限' : '你没有视图修改权限');
      }
      if (!bl) {
        bl = this.$check_action('/consumer/view', 'get');
        console.log(bl ? '你有视图查询权限视作有查询权限' : '你没有视图查询权限');
      }

      console.log(
        bl
          ? '具有当前页面的查看权，请注意这不代表你有字段的查看权'
          : '无权查看当前页，请注意即便有字段查询权限没有页面查询权限也不行'
      );

      return bl;
    },
  },
  created() {
          },
};
</script>

<style lang="scss" scoped>
  @import 'styles/pagesC/index.scss';
</style>