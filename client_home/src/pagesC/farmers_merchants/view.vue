<template>
  <view class="page_diy_view page_farmers_merchants_view" :style="{ paddingTop: vuex_custom_bar_height + 'px' }">
    <tn-nav-bar>农户商家详情</tn-nav-bar>
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

  
        <uni-forms-item v-if="$check_field('get','business_name') || ($check_field('add','business_name') || $check_field('set','business_name'))" label="商家名称" name="business_name">
                      <uni-easyinput type="text" v-model="form['business_name']" v-if="(form['farmers_merchants_id'] && $check_field('set','business_name')) || (!form['farmers_merchants_id'] && $check_field('add','business_name'))" :disabled="disabledObj['business_name_isDisabled']" />
          <!-- 仅查看 -->
          <text v-else-if="$check_field('get','business_name')">
            {{ form['business_name'] }}
          </text>
                    </uni-forms-item>
        <uni-forms-item v-if="$check_field('get','contact_number') || ($check_field('add','contact_number') || $check_field('set','contact_number'))" label="联系号码" name="contact_number">
              <uni-easyinput type="number" v-model="form['contact_number']" v-if="(form['farmers_merchants_id'] && $check_field('set','contact_number')) || (!form['farmers_merchants_id'] && $check_field('add','contact_number'))" :disabled="disabledObj['contact_number_isDisabled']" />
          <!-- 仅查看 -->
          <text v-else-if="$check_field('get','contact_number')">
            {{ form['contact_number'] }}
          </text>
            </uni-forms-item>
        <uni-forms-item v-if="$check_field('get','business_address') || ($check_field('add','business_address') || $check_field('set','business_address'))" label="商家地址" name="business_address">
                      <uni-easyinput type="text" v-model="form['business_address']" v-if="(form['farmers_merchants_id'] && $check_field('set','business_address')) || (!form['farmers_merchants_id'] && $check_field('add','business_address'))" :disabled="disabledObj['business_address_isDisabled']" />
          <!-- 仅查看 -->
          <text v-else-if="$check_field('get','business_address')">
            {{ form['business_address'] }}
          </text>
                    </uni-forms-item>
        <uni-forms-item v-if="$check_field('get','business_license') || ($check_field('add','business_license') || $check_field('set','business_license'))" label="营业执照" name="business_license">
              <!-- 修改权限 -->
          <view class="from-img" v-if="form['business_license'] && $check_field('set', 'business_license')">
            <image v-if="disabledObj['business_license_isDisabled']" :src="$fullImgUrl(form['business_license'])" />
            <image v-if="!disabledObj['business_license_isDisabled']" :src="$fullImgUrl(form['business_license'])" @click="change_img('business_license')" />
          </view>
          <!-- 添加权限 -->
          <view class="from-img" v-else-if="!form['business_license'] && ($check_field('add','business_license') || $check_field('set','business_license'))">
            <view v-if="disabledObj['business_license_isDisabled']" class="add-img">
              <text>+</text>
            </view>
            <view v-if="!disabledObj['business_license_isDisabled']" class="add-img" @click="change_img('business_license')">
              <text>+</text>
            </view>
          </view>
          <!-- 查询权限 -->
          <view class="from-img" v-else-if="$check_field('get', 'business_license')">
            <image :src="$fullImgUrl(form['business_license'])" />
          </view>
            </uni-forms-item>
        <uni-forms-item v-if="$check_field('get','certification_application') || ($check_field('add','certification_application') || $check_field('set','certification_application'))" label="认证申请" name="certification_application">
              <!-- 修改权限 -->
          <view class="from-img" v-if="form['certification_application'] && $check_field('set', 'certification_application')">
            <image v-if="disabledObj['certification_application_isDisabled']" :src="$fullImgUrl(form['certification_application'])" />
            <image v-if="!disabledObj['certification_application_isDisabled']" :src="$fullImgUrl(form['certification_application'])" @click="change_img('certification_application')" />
          </view>
          <!-- 添加权限 -->
          <view class="from-img" v-else-if="!form['certification_application'] && ($check_field('add','certification_application') || $check_field('set','certification_application'))">
            <view v-if="disabledObj['certification_application_isDisabled']" class="add-img">
              <text>+</text>
            </view>
            <view v-if="!disabledObj['certification_application_isDisabled']" class="add-img" @click="change_img('certification_application')">
              <text>+</text>
            </view>
          </view>
          <!-- 查询权限 -->
          <view class="from-img" v-else-if="$check_field('get', 'certification_application')">
            <image :src="$fullImgUrl(form['certification_application'])" />
          </view>
            </uni-forms-item>
        <uni-forms-item label="审核状态" name="examine_state">
          <uni-data-select
              v-model="form['examine_state']"
              :localdata="list_examine_state"
              v-if="(form['examine_state'] && $check_examine()) || (!form['examine_state'] && $check_examine())"
			  style="width: 100%;"
          ></uni-data-select>
          <text v-else>{{form["examine_state"]}}</text>
        </uni-forms-item>
      </uni-forms>
      <view class="form-footer" v-if="$check_action('/farmers_merchants/view','set') || ($check_action('/farmers_merchants/view','add') || $check_option('/farmers_merchants/table','examine'))">
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
        user_group: "农户商家",
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
        user_group: "农户商家",
        // phone_state: 0,
        // email_state: 0,
        state: 1,
        },
      query_user: {
        "user_id": 0,
      },
      list_state: [{value:0,text:"未认证"},{value:1,text:"审核中"},{value:2,text:"已认证"}],
      list_user_state: [{value: 1,text: "可用"},{value: 2,text: "异常"},{value: 3,text: "已冻结"},{value: 4,text: "已注销"}],
      group_table: "farmers_merchants",
      is_password: true,
        field: "farmers_merchants_id",
      url_add: "~/api/farmers_merchants/add?",
      url_set: "~/api/farmers_merchants/set?",
      url_get_obj: "~/api/farmers_merchants/get_obj?",
      url_upload: "~/api/farmers_merchants/upload?",
      business_name: null,
      contact_number: null,
      business_address: null,
      business_license: null,
      certification_application: null,
      query: {
        "farmers_merchants_id": 0,
      },
      form: {
          "business_name": null, // 商家名称
            "contact_number": null, // 联系号码
            "business_address": null, // 商家地址
            "business_license": null, // 营业执照
            "certification_application":  '', // 认证申请
          "examine_state": "未审核",
        "user_id": 0,
        "farmers_merchants_id": 0, // ID
      },
      disabledObj:{
          "business_name_isDisabled": false,
            "contact_number_isDisabled": false,
            "business_address_isDisabled": false,
            "business_license_isDisabled": false,
            "certification_application_isDisabled": false,
        },
                                              list_examine_state:[{value:"未审核",text:"未审核"},{value:"已通过",text:"已通过"},{value:"未通过",text:"未通过"}],
    };
  },
  methods: {
    /**
     * 提交前验证事件
     * @param {Object} 请求参数
     * @return {String} 验证成功返回null, 失败返回错误提示
     */
    async submit_check(param) {
          if (!param.business_name){
        return "商家名称不能为空";
      }
                          if (!param.contact_number){
        return "联系号码不能为空";
      }
              let contact_number_phone_regular = /^(13[0-9]|14[01456879]|15[0-35-9]|16[2567]|17[0-8]|18[0-9]|19[0-35-9])\d{8}$/;
      if(param.contact_number && !contact_number_phone_regular.test(param.contact_number)){
        return "手机号格式错误"
      }
                      if (!param.business_address){
        return "商家地址不能为空";
      }
                          if (!param.business_license){
        return "营业执照不能为空";
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
        url: this.$fullUrl('~/api/farmers_merchants/upload?'), //仅为示例，非真实的接口地址
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
      if (type == 'business_name') this['business_name'] = this.form['business_name'] = "";
      if (type == 'contact_number') this['contact_number'] = this.form['contact_number'] = "";
      if (type == 'business_address') this['business_address'] = this.form['business_address'] = "";
      if (type == 'business_license') this['business_license'] = this.form['business_license'] = "";
      if (type == 'certification_application') this['certification_application'] = this.form['certification_application'] = "";
    },
    submit_() {
      if (this['business_name'] !== null) this.form['business_name'] = this['business_name']
      if (this['contact_number'] !== null) this.form['contact_number'] = this['contact_number']
      if (this['business_address'] !== null) this.form['business_address'] = this['business_address']
      if (this['business_license'] !== null) this.form['business_license'] = this['business_license']
      if (this['certification_application'] !== null) this.form['certification_application'] = this['certification_application']
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
            '/farmers_merchants/upload',
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
          uploadFilePathApi('/farmers_merchants/upload',filePath,undefined,undefined,
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
        	if(/^\d{10}$|^\d{13}$/.test(this.form["business_name"])){
    		this.form["business_name"] = this.$toTime(parseInt(this.form["business_name"]),"yyyy-MM-dd hh:mm:ss")
    	}
                	if(/^\d{10}$|^\d{13}$/.test(this.form["business_address"])){
    		this.form["business_address"] = this.$toTime(parseInt(this.form["business_address"]),"yyyy-MM-dd hh:mm:ss")
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
          if(!ret && !form_sub["business_name"]){
        ret = "商家名称不能为空!";
      }
                          if(!ret && !form_sub["contact_number"]){
        ret = "联系号码不能为空!";
      }
              let contact_number_phone_regular = /^(13[0-9]|14[01456879]|15[0-35-9]|16[2567]|17[0-8]|18[0-9]|19[0-35-9])\d{8}$/;
      if(form_sub.contact_number && !contact_number_phone_regular.test(form_sub.contact_number)){
        return "手机号格式错误"
      }
                      if(!ret && !form_sub["business_address"]){
        ret = "商家地址不能为空!";
      }
                          if(!ret && !form_sub["business_license"]){
        ret = "营业执照不能为空!";
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
      if (!form['farmers_merchants_id']) {
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
      if (form_sub['farmers_merchants_id']) {
        // 提交事件
        this.$post('~/api/' + this.group_table + '/set?farmers_merchants_id=' + form_sub['farmers_merchants_id'], form_sub, (res) => {
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
        bl = this.$check_action('/farmers_merchants/table', 'add');
        console.log(bl ? '你有表格添加权限视作有添加权限' : '你没有表格添加权限');
      }
      if (!bl) {
        bl = this.$check_action('/farmers_merchants/table', 'set');
        console.log(bl ? '你有表格添加权限视作有修改权限' : '你没有表格修改权限');
      }
      if (!bl) {
        bl = this.$check_action('/farmers_merchants/view', 'add');
        console.log(bl ? '你有视图添加权限视作有添加权限' : '你没有视图添加权限');
      }
      if (!bl) {
        bl = this.$check_action('/farmers_merchants/view', 'set');
        console.log(bl ? '你有视图修改权限视作有修改权限' : '你没有视图修改权限');
      }
      if (!bl) {
        bl = this.$check_action('/farmers_merchants/view', 'get');
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