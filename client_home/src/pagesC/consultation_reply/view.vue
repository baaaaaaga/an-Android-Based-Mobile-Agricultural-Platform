<template>
  <view class="page_diy_view page_consultation_reply_view" :style="{ paddingTop: vuex_custom_bar_height + 'px' }">
    <tn-nav-bar>咨询回复详情</tn-nav-bar>
    <view id="page_diy_view" class="page-from">
      <uni-forms :modelValue="form" v-if="is_view()" labelWidth="70px">

        <uni-forms-item v-if="$check_field('get','consultation_number') || ($check_field('add','consultation_number') || $check_field('set','consultation_number'))" label="咨询编号" name="consultation_number">
                      <uni-easyinput type="text" v-model="form['consultation_number']" v-if="(form['consultation_reply_id'] && $check_field('set','consultation_number')) || (!form['consultation_reply_id'] && $check_field('add','consultation_number'))" :disabled="disabledObj['consultation_number_isDisabled']" />
          <!-- 仅查看 -->
          <text v-else-if="$check_field('get','consultation_number')">
            {{ form['consultation_number'] }}
          </text>
                    </uni-forms-item>
        <uni-forms-item v-if="$check_field('get','farmers_merchants') || ($check_field('add','farmers_merchants') || $check_field('set','farmers_merchants'))" label="农户商家" name="farmers_merchants">
              <uni-data-select
              id="form_farmers_merchants"
              v-model="form['farmers_merchants']"
              :localdata="list_user_farmers_merchants"
              :clear="!disabledObj['farmers_merchants_isDisabled']"
              :disabled="disabledObj['farmers_merchants_isDisabled']"
              v-if="(form['consultation_reply_id'] && $check_field('set', 'farmers_merchants')) || (!form['consultation_reply_id'] && $check_field('add', 'farmers_merchants'))"
			   style="width: 100%;"
          ></uni-data-select>
          <uni-data-select
              v-model="form['farmers_merchants']"
              :localdata="list_user_farmers_merchants"
              :clear="false"
              :disabled="true"
              v-else-if="$check_field('get', 'farmers_merchants')"
              id="farmers_merchants"
			  style="width: 100%;"
          ></uni-data-select>
            </uni-forms-item>
        <uni-forms-item v-if="$check_field('get','business_name') || ($check_field('add','business_name') || $check_field('set','business_name'))" label="商家名称" name="business_name">
                      <uni-easyinput type="text" v-model="form['business_name']" v-if="(form['consultation_reply_id'] && $check_field('set','business_name')) || (!form['consultation_reply_id'] && $check_field('add','business_name'))" :disabled="disabledObj['business_name_isDisabled']" />
          <!-- 仅查看 -->
          <text v-else-if="$check_field('get','business_name')">
            {{ form['business_name'] }}
          </text>
                    </uni-forms-item>
        <uni-forms-item v-if="$check_field('get','contact_number') || ($check_field('add','contact_number') || $check_field('set','contact_number'))" label="联系号码" name="contact_number">
              <uni-easyinput type="number" v-model="form['contact_number']" v-if="(form['consultation_reply_id'] && $check_field('set','contact_number')) || (!form['consultation_reply_id'] && $check_field('add','contact_number'))" :disabled="disabledObj['contact_number_isDisabled']" />
          <!-- 仅查看 -->
          <text v-else-if="$check_field('get','contact_number')">
            {{ form['contact_number'] }}
          </text>
            </uni-forms-item>
        <uni-forms-item v-if="$check_field('get','business_address') || ($check_field('add','business_address') || $check_field('set','business_address'))" label="商家地址" name="business_address">
                      <uni-easyinput type="text" v-model="form['business_address']" v-if="(form['consultation_reply_id'] && $check_field('set','business_address')) || (!form['consultation_reply_id'] && $check_field('add','business_address'))" :disabled="disabledObj['business_address_isDisabled']" />
          <!-- 仅查看 -->
          <text v-else-if="$check_field('get','business_address')">
            {{ form['business_address'] }}
          </text>
                    </uni-forms-item>
        <uni-forms-item v-if="$check_field('get','date_of_consultation') || ($check_field('add','date_of_consultation') || $check_field('set','date_of_consultation'))" label="咨询日期" name="date_of_consultation">
              <uni-datetime-picker v-if="(form['consultation_reply_id'] && $check_field('set', 'date_of_consultation')) || (!form['consultation_reply_id'] && $check_field('add', 'date_of_consultation'))" v-model="form['date_of_consultation']" type="date" :disabled="disabledObj['date_of_consultation_isDisabled']"/>
          <!-- 仅查看 -->
          <text v-else-if="$check_field('get', 'date_of_consultation')">
            {{ form['date_of_consultation'] }}
          </text>
	        </uni-forms-item>
        <uni-forms-item v-if="$check_field('get','consulting_users') || ($check_field('add','consulting_users') || $check_field('set','consulting_users'))" label="咨询用户" name="consulting_users">
              <uni-data-select
              id="form_consulting_users"
              v-model="form['consulting_users']"
              :localdata="list_user_consulting_users"
              :clear="!disabledObj['consulting_users_isDisabled']"
              :disabled="disabledObj['consulting_users_isDisabled']"
              v-if="(form['consultation_reply_id'] && $check_field('set', 'consulting_users')) || (!form['consultation_reply_id'] && $check_field('add', 'consulting_users'))"
			   style="width: 100%;"
          ></uni-data-select>
          <uni-data-select
              v-model="form['consulting_users']"
              :localdata="list_user_consulting_users"
              :clear="false"
              :disabled="true"
              v-else-if="$check_field('get', 'consulting_users')"
              id="consulting_users"
			  style="width: 100%;"
          ></uni-data-select>
            </uni-forms-item>
        <uni-forms-item v-if="$check_field('get','consulting_content') || ($check_field('add','consulting_content') || $check_field('set','consulting_content'))" label="咨询内容" name="consulting_content">
              <uni-easyinput type="textarea" v-model="form['consulting_content']" v-if="(form['consultation_reply_id'] && $check_field('set', 'consulting_content')) || (!form['consultation_reply_id'] && $check_field('add', 'consulting_content'))" :disabled="disabledObj['consulting_content_isDisabled']"/>
          <!-- 仅查看 -->
          <text v-else-if="$check_field('get', 'consulting_content')">
            {{ form['consulting_content'] }}
          </text>
            </uni-forms-item>
        <uni-forms-item v-if="$check_field('get','reply_content') || ($check_field('add','reply_content') || $check_field('set','reply_content'))" label="回复内容" name="reply_content">
              <uni-easyinput type="textarea" v-model="form['reply_content']" v-if="(form['consultation_reply_id'] && $check_field('set', 'reply_content')) || (!form['consultation_reply_id'] && $check_field('add', 'reply_content'))" :disabled="disabledObj['reply_content_isDisabled']"/>
          <!-- 仅查看 -->
          <text v-else-if="$check_field('get', 'reply_content')">
            {{ form['reply_content'] }}
          </text>
            </uni-forms-item>
      </uni-forms>
      <view class="form-footer" v-if="$check_action('/consultation_reply/view','set') || ($check_action('/consultation_reply/view','add') || $check_option('/consultation_reply/table','examine'))">
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
      field: "consultation_reply_id",
      url_add: "~/api/consultation_reply/add?",
      url_set: "~/api/consultation_reply/set?",
      url_get_obj: "~/api/consultation_reply/get_obj?",
      url_upload: "~/api/consultation_reply/upload?",
      consultation_number: null,
      farmers_merchants: null,
      business_name: null,
      contact_number: null,
      business_address: null,
      date_of_consultation: null,
      consulting_users: null,
      consulting_content: null,
      reply_content: null,
      query: {
        "consultation_reply_id": 0,
      },
      form: {
          "consultation_number":  '', // 咨询编号
            "farmers_merchants": 0, // 农户商家
            "business_name": null, // 商家名称
            "contact_number": null, // 联系号码
            "business_address": null, // 商家地址
            "date_of_consultation": this.$toTime(new Date().getTime(), "yyyy-MM-dd"),
            "consulting_users": 0, // 咨询用户
            "consulting_content":  '', // 咨询内容
            "reply_content":  '', // 回复内容
          "consultation_reply_id": 0, // ID
      },
      disabledObj:{
          "consultation_number_isDisabled": false,
            "farmers_merchants_isDisabled": false,
            "business_name_isDisabled": false,
            "contact_number_isDisabled": false,
            "business_address_isDisabled": false,
            "date_of_consultation_isDisabled": false,
            "consulting_users_isDisabled": false,
            "consulting_content_isDisabled": false,
            "reply_content_isDisabled": false,
        },
                      // 用户列表
      list_user_farmers_merchants: [],
                                                          // 用户列表
      list_user_consulting_users: [],
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
                          if (!param.date_of_consultation){
        return "咨询日期不能为空";
      }
                                                                	  let field = {
				  consultation_number: param.consultation_number,
			  };
	  let res = await this.$get("~/api/consultation_reply/get_list", field);
	  if (res && res.result.count > 0) {
		for(var i = 0;i < res.result.list.length;i ++){
		  if(res.result.list[i].consultation_reply_id != param.consultation_reply_id){
						  return "已操作回复！";
					  }
		}
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
        url: this.$fullUrl('~/api/consultation_reply/upload?'), //仅为示例，非真实的接口地址
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
      if (type == 'consultation_number') this['consultation_number'] = this.form['consultation_number'] = "";
      if (type == 'farmers_merchants') this['farmers_merchants'] = this.form['farmers_merchants'] = "";
      if (type == 'business_name') this['business_name'] = this.form['business_name'] = "";
      if (type == 'contact_number') this['contact_number'] = this.form['contact_number'] = "";
      if (type == 'business_address') this['business_address'] = this.form['business_address'] = "";
      if (type == 'date_of_consultation') this['date_of_consultation'] = this.form['date_of_consultation'] = "";
      if (type == 'consulting_users') this['consulting_users'] = this.form['consulting_users'] = "";
      if (type == 'consulting_content') this['consulting_content'] = this.form['consulting_content'] = "";
      if (type == 'reply_content') this['reply_content'] = this.form['reply_content'] = "";
    },
    submit_() {
      if (this['consultation_number'] !== null) this.form['consultation_number'] = this['consultation_number']
      if (this['farmers_merchants'] !== null) this.form['farmers_merchants'] = this['farmers_merchants']
      if (this['business_name'] !== null) this.form['business_name'] = this['business_name']
      if (this['contact_number'] !== null) this.form['contact_number'] = this['contact_number']
      if (this['business_address'] !== null) this.form['business_address'] = this['business_address']
      if (this['date_of_consultation'] !== null) this.form['date_of_consultation'] = this['date_of_consultation']
      if (this['consulting_users'] !== null) this.form['consulting_users'] = this['consulting_users']
      if (this['consulting_content'] !== null) this.form['consulting_content'] = this['consulting_content']
      if (this['reply_content'] !== null) this.form['reply_content'] = this['reply_content']
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
            '/consultation_reply/upload',
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
          uploadFilePathApi('/consultation_reply/upload',filePath,undefined,undefined,
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
        	if(/^\d{10}$|^\d{13}$/.test(this.form["consultation_number"])){
    		this.form["consultation_number"] = this.$toTime(parseInt(this.form["consultation_number"]),"yyyy-MM-dd hh:mm:ss")
    	}
                	if(/^\d{10}$|^\d{13}$/.test(this.form["business_name"])){
    		this.form["business_name"] = this.$toTime(parseInt(this.form["business_name"]),"yyyy-MM-dd hh:mm:ss")
    	}
                	if(/^\d{10}$|^\d{13}$/.test(this.form["business_address"])){
    		this.form["business_address"] = this.$toTime(parseInt(this.form["business_address"]),"yyyy-MM-dd hh:mm:ss")
    	}
              if (this.form["date_of_consultation"] && JSON.stringify(this.form["date_of_consultation"]).indexOf("-")===-1) {
        this.form["date_of_consultation"] = this.$toTime(parseInt(this.form["date_of_consultation"]), "yyyy-MM-dd")
      }
                      uni.db.del('form');

      return param;
    },
    
          /**
     * 获取农户商家用户列表
     */
    async get_list_user_farmers_merchants() {
      var json = await this.$get("~/api/user/get_list?user_group=农户商家");
      if(json.result && json.result.list){
        json.result.list.map((o) => this.list_user_farmers_merchants.push({value:o.user_id,text:o.nickname + '-' + o.username}));
      }
      else if(json.error){
        console.error(json.error);
      }
    },
      
      
      
      
      
          /**
     * 获取消费者用户列表
     */
    async get_list_user_consulting_users() {
      var json = await this.$get("~/api/user/get_list?user_group=消费者");
      if(json.result && json.result.list){
        json.result.list.map((o) => this.list_user_consulting_users.push({value:o.user_id,text:o.nickname + '-' + o.username}));
      }
      else if(json.error){
        console.error(json.error);
      }
    },
      
      
      
      /**
     * 获取对象之后
     * @param {Object} json
     * @param {Object} func
     */
    get_obj_after(json, func) {
                                                                          if (this.form["date_of_consultation"] && JSON.stringify(this.form["date_of_consultation"]).indexOf("-")===-1) {
        this.form["date_of_consultation"] = this.$toTime(parseInt(this.form["date_of_consultation"]),"yyyy-MM-dd")
      }
                                                },

    is_view() {
      var bl = this.user_group == '管理员';

      if (!bl) {
        bl = this.$check_action('/consultation_reply/table', 'add');
        console.log(bl ? '你有表格添加权限视作有添加权限' : '你没有表格添加权限');
      }
      if (!bl) {
        bl = this.$check_action('/consultation_reply/table', 'set');
        console.log(bl ? '你有表格添加权限视作有修改权限' : '你没有表格修改权限');
      }
      if (!bl) {
        bl = this.$check_action('/consultation_reply/view', 'add');
        console.log(bl ? '你有视图添加权限视作有添加权限' : '你没有视图添加权限');
      }
      if (!bl) {
        bl = this.$check_action('/consultation_reply/view', 'set');
        console.log(bl ? '你有视图修改权限视作有修改权限' : '你没有视图修改权限');
      }
      if (!bl) {
        bl = this.$check_action('/consultation_reply/view', 'get');
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
            this.get_list_user_farmers_merchants();
                                this.get_list_user_consulting_users();
                  },
};
</script>

<style lang="scss" scoped>
  @import 'styles/pagesC/index.scss';
</style>