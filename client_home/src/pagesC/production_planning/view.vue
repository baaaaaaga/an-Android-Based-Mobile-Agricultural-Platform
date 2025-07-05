<template>
  <view class="page_diy_view page_production_planning_view" :style="{ paddingTop: vuex_custom_bar_height + 'px' }">
    <tn-nav-bar>生产计划详情</tn-nav-bar>
    <view id="page_diy_view" class="page-from">
      <uni-forms :modelValue="form" v-if="is_view()" labelWidth="70px">

        <uni-forms-item v-if="$check_field('get','plan_no') || ($check_field('add','plan_no') || $check_field('set','plan_no'))" label="计划编号" name="plan_no">
                      <uni-easyinput type="text" v-model="form['plan_no']" v-if="(form['production_planning_id'] && $check_field('set','plan_no')) || (!form['production_planning_id'] && $check_field('add','plan_no'))" :disabled="disabledObj['plan_no_isDisabled']" />
          <!-- 仅查看 -->
          <text v-else-if="$check_field('get','plan_no')">
            {{ form['plan_no'] }}
          </text>
                    </uni-forms-item>
        <uni-forms-item v-if="$check_field('get','schedule_title') || ($check_field('add','schedule_title') || $check_field('set','schedule_title'))" label="计划标题" name="schedule_title">
                      <uni-easyinput type="text" v-model="form['schedule_title']" v-if="(form['production_planning_id'] && $check_field('set','schedule_title')) || (!form['production_planning_id'] && $check_field('add','schedule_title'))" :disabled="disabledObj['schedule_title_isDisabled']" />
          <!-- 仅查看 -->
          <text v-else-if="$check_field('get','schedule_title')">
            {{ form['schedule_title'] }}
          </text>
                    </uni-forms-item>
        <uni-forms-item v-if="$check_field('get','planned_date') || ($check_field('add','planned_date') || $check_field('set','planned_date'))" label="计划日期" name="planned_date">
              <uni-datetime-picker v-if="(form['production_planning_id'] && $check_field('set', 'planned_date')) || (!form['production_planning_id'] && $check_field('add', 'planned_date'))" v-model="form['planned_date']" type="date" :disabled="disabledObj['planned_date_isDisabled']"/>
          <!-- 仅查看 -->
          <text v-else-if="$check_field('get', 'planned_date')">
            {{ form['planned_date'] }}
          </text>
	        </uni-forms-item>
        <uni-forms-item v-if="$check_field('get','plan_content') || ($check_field('add','plan_content') || $check_field('set','plan_content'))" label="计划内容" name="plan_content">
              <uni-easyinput type="textarea" v-model="form['plan_content']" v-if="(form['production_planning_id'] && $check_field('set', 'plan_content')) || (!form['production_planning_id'] && $check_field('add', 'plan_content'))" :disabled="disabledObj['plan_content_isDisabled']"/>
          <!-- 仅查看 -->
          <text v-else-if="$check_field('get', 'plan_content')">
            {{ form['plan_content'] }}
          </text>
            </uni-forms-item>
        <uni-forms-item v-if="$check_field('get','farmers_merchants') || ($check_field('add','farmers_merchants') || $check_field('set','farmers_merchants'))" label="农户商家" name="farmers_merchants">
              <uni-data-select
              id="form_farmers_merchants"
              v-model="form['farmers_merchants']"
              :localdata="list_user_farmers_merchants"
              :clear="!disabledObj['farmers_merchants_isDisabled']"
              :disabled="disabledObj['farmers_merchants_isDisabled']"
              v-if="(form['production_planning_id'] && $check_field('set', 'farmers_merchants')) || (!form['production_planning_id'] && $check_field('add', 'farmers_merchants'))"
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
      </uni-forms>
      <view class="form-footer" v-if="$check_action('/production_planning/view','set') || ($check_action('/production_planning/view','add') || $check_option('/production_planning/table','examine'))">
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
      field: "production_planning_id",
      url_add: "~/api/production_planning/add?",
      url_set: "~/api/production_planning/set?",
      url_get_obj: "~/api/production_planning/get_obj?",
      url_upload: "~/api/production_planning/upload?",
      plan_no: null,
      schedule_title: null,
      planned_date: null,
      plan_content: null,
      farmers_merchants: null,
      query: {
        "production_planning_id": 0,
      },
      form: {
          "plan_no":  '', // 计划编号
            "schedule_title":  '', // 计划标题
            "planned_date": this.$toTime(new Date().getTime(), "yyyy-MM-dd"),
            "plan_content":  '', // 计划内容
            "farmers_merchants": 0, // 农户商家
          "production_planning_id": 0, // ID
      },
      disabledObj:{
          "plan_no_isDisabled": false,
            "schedule_title_isDisabled": false,
            "planned_date_isDisabled": false,
            "plan_content_isDisabled": false,
            "farmers_merchants_isDisabled": false,
        },
                                              // 用户列表
      list_user_farmers_merchants: [],
                  // 用户组
      group_user_farmers_merchants: "",
                };
  },
  methods: {
    /**
     * 提交前验证事件
     * @param {Object} 请求参数
     * @return {String} 验证成功返回null, 失败返回错误提示
     */
    async submit_check(param) {
                                          if (!param.planned_date){
        return "计划日期不能为空";
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
        url: this.$fullUrl('~/api/production_planning/upload?'), //仅为示例，非真实的接口地址
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
      if (type == 'plan_no') this['plan_no'] = this.form['plan_no'] = "";
      if (type == 'schedule_title') this['schedule_title'] = this.form['schedule_title'] = "";
      if (type == 'planned_date') this['planned_date'] = this.form['planned_date'] = "";
      if (type == 'plan_content') this['plan_content'] = this.form['plan_content'] = "";
      if (type == 'farmers_merchants') this['farmers_merchants'] = this.form['farmers_merchants'] = "";
    },
    submit_() {
      if (this['plan_no'] !== null) this.form['plan_no'] = this['plan_no']
      if (this['schedule_title'] !== null) this.form['schedule_title'] = this['schedule_title']
      if (this['planned_date'] !== null) this.form['planned_date'] = this['planned_date']
      if (this['plan_content'] !== null) this.form['plan_content'] = this['plan_content']
      if (this['farmers_merchants'] !== null) this.form['farmers_merchants'] = this['farmers_merchants']
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
            '/production_planning/upload',
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
          uploadFilePathApi('/production_planning/upload',filePath,undefined,undefined,
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
        	if(/^\d{10}$|^\d{13}$/.test(this.form["plan_no"])){
    		this.form["plan_no"] = this.$toTime(parseInt(this.form["plan_no"]),"yyyy-MM-dd hh:mm:ss")
    	}
            	if(/^\d{10}$|^\d{13}$/.test(this.form["schedule_title"])){
    		this.form["schedule_title"] = this.$toTime(parseInt(this.form["schedule_title"]),"yyyy-MM-dd hh:mm:ss")
    	}
              if (this.form["planned_date"] && JSON.stringify(this.form["planned_date"]).indexOf("-")===-1) {
        this.form["planned_date"] = this.$toTime(parseInt(this.form["planned_date"]), "yyyy-MM-dd")
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
     * 获取农户商家用户组
     */
    async get_group_user_farmers_merchants() {
      this.form["farmers_merchants"] = this.user.user_id;
      var json = await this.$get("~/api/user_group/get_obj?name=农户商家");
      if(json.result && json.result.obj){
        this.group_user_farmers_merchants = json.result.obj;
        this.get_user_session_farmers_merchants(this.form['farmers_merchants'])
      }
      else if(json.error){
        console.error(json.error);
      }
    },
    get_user_session_farmers_merchants(id){
      var _this = this;
      var user_id = {"user_id":_this.user.user_id}
      var url = "~/api/"+_this.group_user_farmers_merchants.source_table+"/get_obj"
      this.$get(url, user_id, function(res) {
        if (res.result && res.result.obj) {
          var arr = []
          for (let key in res.result.obj) {
            arr.push(key)
          }
          var arrForm = []
          for (let key in _this.form) {
            arrForm.push(key)
          }
          _this.form["farmers_merchants"] = _this.user.user_id
          _this.disabledObj['farmers_merchants' + '_isDisabled'] = true
          for (var i=0;i<arr.length;i++){
            if (arr[i]!=='examine_state' && arr[i]!=='examine_reply') {
              for (var j = 0; j < arrForm.length; j++) {
                if (arr[i] === arrForm[j]) {
                  if (arr[i] !== "farmers_merchants") {
                    _this.form[arrForm[j]] = res.result.obj[arr[i]]
                    _this.disabledObj[arrForm[j] + '_isDisabled'] = true
                    break;
                  } else {
                    _this.disabledObj[arrForm[j] + '_isDisabled'] = true
                  }
                }
              }
            }
          }
        }
      });
    },
      
      /**
     * 获取对象之后
     * @param {Object} json
     * @param {Object} func
     */
    get_obj_after(json, func) {
                                      if (this.form["planned_date"] && JSON.stringify(this.form["planned_date"]).indexOf("-")===-1) {
        this.form["planned_date"] = this.$toTime(parseInt(this.form["planned_date"]),"yyyy-MM-dd")
      }
                                    },

    is_view() {
      var bl = this.user_group == '管理员';

      if (!bl) {
        bl = this.$check_action('/production_planning/table', 'add');
        console.log(bl ? '你有表格添加权限视作有添加权限' : '你没有表格添加权限');
      }
      if (!bl) {
        bl = this.$check_action('/production_planning/table', 'set');
        console.log(bl ? '你有表格添加权限视作有修改权限' : '你没有表格修改权限');
      }
      if (!bl) {
        bl = this.$check_action('/production_planning/view', 'add');
        console.log(bl ? '你有视图添加权限视作有添加权限' : '你没有视图添加权限');
      }
      if (!bl) {
        bl = this.$check_action('/production_planning/view', 'set');
        console.log(bl ? '你有视图修改权限视作有修改权限' : '你没有视图修改权限');
      }
      if (!bl) {
        bl = this.$check_action('/production_planning/view', 'get');
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
          this.get_group_user_farmers_merchants();
          },
};
</script>

<style lang="scss" scoped>
  @import 'styles/pagesC/index.scss';
</style>