<template>
  <view class="page_diy_view page_origin_display_view" :style="{ paddingTop: vuex_custom_bar_height + 'px' }">
    <tn-nav-bar>产地展示详情</tn-nav-bar>
    <view id="page_diy_view" class="page-from">
      <uni-forms :modelValue="form" v-if="is_view()" labelWidth="70px">

        <uni-forms-item v-if="$check_field('get','name_of_place_of_origin') || ($check_field('add','name_of_place_of_origin') || $check_field('set','name_of_place_of_origin'))" label="产地名称" name="name_of_place_of_origin">
                      <uni-easyinput type="text" v-model="form['name_of_place_of_origin']" v-if="(form['origin_display_id'] && $check_field('set','name_of_place_of_origin')) || (!form['origin_display_id'] && $check_field('add','name_of_place_of_origin'))" :disabled="disabledObj['name_of_place_of_origin_isDisabled']" />
          <!-- 仅查看 -->
          <text v-else-if="$check_field('get','name_of_place_of_origin')">
            {{ form['name_of_place_of_origin'] }}
          </text>
                    </uni-forms-item>
        <uni-forms-item v-if="$check_field('get','cover_chart') || ($check_field('add','cover_chart') || $check_field('set','cover_chart'))" label="封面图" name="cover_chart">
              <!-- 修改权限 -->
          <view class="from-img" v-if="form['cover_chart'] && $check_field('set', 'cover_chart')">
            <image v-if="disabledObj['cover_chart_isDisabled']" :src="$fullImgUrl(form['cover_chart'])" />
            <image v-if="!disabledObj['cover_chart_isDisabled']" :src="$fullImgUrl(form['cover_chart'])" @click="change_img('cover_chart')" />
          </view>
          <!-- 添加权限 -->
          <view class="from-img" v-else-if="!form['cover_chart'] && ($check_field('add','cover_chart') || $check_field('set','cover_chart'))">
            <view v-if="disabledObj['cover_chart_isDisabled']" class="add-img">
              <text>+</text>
            </view>
            <view v-if="!disabledObj['cover_chart_isDisabled']" class="add-img" @click="change_img('cover_chart')">
              <text>+</text>
            </view>
          </view>
          <!-- 查询权限 -->
          <view class="from-img" v-else-if="$check_field('get', 'cover_chart')">
            <image :src="$fullImgUrl(form['cover_chart'])" />
          </view>
            </uni-forms-item>
        <uni-forms-item v-if="$check_field('get','place_of_origin_address') || ($check_field('add','place_of_origin_address') || $check_field('set','place_of_origin_address'))" label="产地地址" name="place_of_origin_address">
                      <uni-easyinput type="text" v-model="form['place_of_origin_address']" v-if="(form['origin_display_id'] && $check_field('set','place_of_origin_address')) || (!form['origin_display_id'] && $check_field('add','place_of_origin_address'))" :disabled="disabledObj['place_of_origin_address_isDisabled']" />
          <!-- 仅查看 -->
          <text v-else-if="$check_field('get','place_of_origin_address')">
            {{ form['place_of_origin_address'] }}
          </text>
                    </uni-forms-item>
        <uni-forms-item v-if="$check_field('get','type_of_place_of_origin') || ($check_field('add','type_of_place_of_origin') || $check_field('set','type_of_place_of_origin'))" label="产地类型" name="type_of_place_of_origin">
              <uni-data-select
              v-model="form.type_of_place_of_origin"
              :localdata="list_type_of_place_of_origin"
              :clear="!disabledObj['type_of_place_of_origin_isDisabled']"
              :disabled="disabledObj['type_of_place_of_origin_isDisabled']"
              v-if="(form['origin_display_id'] && $check_field('set','type_of_place_of_origin')) || (!form['origin_display_id'] && $check_field('add','type_of_place_of_origin'))"
			  style="width: 100%;"
                        ></uni-data-select>
          <!-- 仅查看 -->
          <text v-else-if="$check_field('get','type_of_place_of_origin')">
            {{ form['type_of_place_of_origin'] }}
          </text>
            </uni-forms-item>
        <uni-forms-item v-if="$check_field('get','scale_of_origin') || ($check_field('add','scale_of_origin') || $check_field('set','scale_of_origin'))" label="产地规模" name="scale_of_origin">
                      <uni-easyinput type="text" v-model="form['scale_of_origin']" v-if="(form['origin_display_id'] && $check_field('set','scale_of_origin')) || (!form['origin_display_id'] && $check_field('add','scale_of_origin'))" :disabled="disabledObj['scale_of_origin_isDisabled']" />
          <!-- 仅查看 -->
          <text v-else-if="$check_field('get','scale_of_origin')">
            {{ form['scale_of_origin'] }}
          </text>
                    </uni-forms-item>
        <uni-forms-item v-if="$check_field('get','introduction_of_origin') || ($check_field('add','introduction_of_origin') || $check_field('set','introduction_of_origin'))" label="产地介绍" name="introduction_of_origin">
              <uni-easyinput type="textarea" v-model="form['introduction_of_origin']" v-if="(form['origin_display_id'] && $check_field('set', 'introduction_of_origin')) || (!form['origin_display_id'] && $check_field('add', 'introduction_of_origin'))" :disabled="disabledObj['introduction_of_origin_isDisabled']"/>
          <!-- 仅查看 -->
          <text v-else-if="$check_field('get', 'introduction_of_origin')">
            {{ form['introduction_of_origin'] }}
          </text>
            </uni-forms-item>
        <uni-forms-item v-if="$check_field('get','farmers_merchants') || ($check_field('add','farmers_merchants') || $check_field('set','farmers_merchants'))" label="农户商家" name="farmers_merchants">
              <uni-data-select
              id="form_farmers_merchants"
              v-model="form['farmers_merchants']"
              :localdata="list_user_farmers_merchants"
              :clear="!disabledObj['farmers_merchants_isDisabled']"
              :disabled="disabledObj['farmers_merchants_isDisabled']"
              v-if="(form['origin_display_id'] && $check_field('set', 'farmers_merchants')) || (!form['origin_display_id'] && $check_field('add', 'farmers_merchants'))"
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
                      <uni-easyinput type="text" v-model="form['business_name']" v-if="(form['origin_display_id'] && $check_field('set','business_name')) || (!form['origin_display_id'] && $check_field('add','business_name'))" :disabled="disabledObj['business_name_isDisabled']" />
          <!-- 仅查看 -->
          <text v-else-if="$check_field('get','business_name')">
            {{ form['business_name'] }}
          </text>
                    </uni-forms-item>
        <uni-forms-item v-if="$check_field('get','contact_number') || ($check_field('add','contact_number') || $check_field('set','contact_number'))" label="联系号码" name="contact_number">
              <uni-easyinput type="number" v-model="form['contact_number']" v-if="(form['origin_display_id'] && $check_field('set','contact_number')) || (!form['origin_display_id'] && $check_field('add','contact_number'))" :disabled="disabledObj['contact_number_isDisabled']" />
          <!-- 仅查看 -->
          <text v-else-if="$check_field('get','contact_number')">
            {{ form['contact_number'] }}
          </text>
            </uni-forms-item>
        <uni-forms-item v-if="$check_field('get','business_address') || ($check_field('add','business_address') || $check_field('set','business_address'))" label="商家地址" name="business_address">
                      <uni-easyinput type="text" v-model="form['business_address']" v-if="(form['origin_display_id'] && $check_field('set','business_address')) || (!form['origin_display_id'] && $check_field('add','business_address'))" :disabled="disabledObj['business_address_isDisabled']" />
          <!-- 仅查看 -->
          <text v-else-if="$check_field('get','business_address')">
            {{ form['business_address'] }}
          </text>
                    </uni-forms-item>
      </uni-forms>
      <view class="form-footer" v-if="$check_action('/origin_display/view','set') || ($check_action('/origin_display/view','add') || $check_option('/origin_display/table','examine'))">
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
      field: "origin_display_id",
      url_add: "~/api/origin_display/add?",
      url_set: "~/api/origin_display/set?",
      url_get_obj: "~/api/origin_display/get_obj?",
      url_upload: "~/api/origin_display/upload?",
      name_of_place_of_origin: null,
      cover_chart: null,
      place_of_origin_address: null,
      type_of_place_of_origin: null,
      scale_of_origin: null,
      introduction_of_origin: null,
      farmers_merchants: null,
      business_name: null,
      contact_number: null,
      business_address: null,
      query: {
        "origin_display_id": 0,
      },
      form: {
          "name_of_place_of_origin":  '', // 产地名称
            "cover_chart":  '', // 封面图
            "place_of_origin_address":  '', // 产地地址
            "type_of_place_of_origin":  '', // 产地类型
            "scale_of_origin":  '', // 产地规模
            "introduction_of_origin":  '', // 产地介绍
            "farmers_merchants": 0, // 农户商家
            "business_name": null, // 商家名称
            "contact_number": null, // 联系号码
            "business_address": null, // 商家地址
          "origin_display_id": 0, // ID
      },
      disabledObj:{
          "name_of_place_of_origin_isDisabled": false,
            "cover_chart_isDisabled": false,
            "place_of_origin_address_isDisabled": false,
            "type_of_place_of_origin_isDisabled": false,
            "scale_of_origin_isDisabled": false,
            "introduction_of_origin_isDisabled": false,
            "farmers_merchants_isDisabled": false,
            "business_name_isDisabled": false,
            "contact_number_isDisabled": false,
            "business_address_isDisabled": false,
        },
                                          // 产地类型选项列表
      list_type_of_place_of_origin: [],
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
        url: this.$fullUrl('~/api/origin_display/upload?'), //仅为示例，非真实的接口地址
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
      if (type == 'name_of_place_of_origin') this['name_of_place_of_origin'] = this.form['name_of_place_of_origin'] = "";
      if (type == 'cover_chart') this['cover_chart'] = this.form['cover_chart'] = "";
      if (type == 'place_of_origin_address') this['place_of_origin_address'] = this.form['place_of_origin_address'] = "";
      if (type == 'type_of_place_of_origin') this['type_of_place_of_origin'] = this.form['type_of_place_of_origin'] = "";
      if (type == 'scale_of_origin') this['scale_of_origin'] = this.form['scale_of_origin'] = "";
      if (type == 'introduction_of_origin') this['introduction_of_origin'] = this.form['introduction_of_origin'] = "";
      if (type == 'farmers_merchants') this['farmers_merchants'] = this.form['farmers_merchants'] = "";
      if (type == 'business_name') this['business_name'] = this.form['business_name'] = "";
      if (type == 'contact_number') this['contact_number'] = this.form['contact_number'] = "";
      if (type == 'business_address') this['business_address'] = this.form['business_address'] = "";
    },
    submit_() {
      if (this['name_of_place_of_origin'] !== null) this.form['name_of_place_of_origin'] = this['name_of_place_of_origin']
      if (this['cover_chart'] !== null) this.form['cover_chart'] = this['cover_chart']
      if (this['place_of_origin_address'] !== null) this.form['place_of_origin_address'] = this['place_of_origin_address']
      if (this['type_of_place_of_origin'] !== null) this.form['type_of_place_of_origin'] = this['type_of_place_of_origin']
      if (this['scale_of_origin'] !== null) this.form['scale_of_origin'] = this['scale_of_origin']
      if (this['introduction_of_origin'] !== null) this.form['introduction_of_origin'] = this['introduction_of_origin']
      if (this['farmers_merchants'] !== null) this.form['farmers_merchants'] = this['farmers_merchants']
      if (this['business_name'] !== null) this.form['business_name'] = this['business_name']
      if (this['contact_number'] !== null) this.form['contact_number'] = this['contact_number']
      if (this['business_address'] !== null) this.form['business_address'] = this['business_address']
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
            '/origin_display/upload',
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
          uploadFilePathApi('/origin_display/upload',filePath,undefined,undefined,
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
        	if(/^\d{10}$|^\d{13}$/.test(this.form["name_of_place_of_origin"])){
    		this.form["name_of_place_of_origin"] = this.$toTime(parseInt(this.form["name_of_place_of_origin"]),"yyyy-MM-dd hh:mm:ss")
    	}
                	if(/^\d{10}$|^\d{13}$/.test(this.form["place_of_origin_address"])){
    		this.form["place_of_origin_address"] = this.$toTime(parseInt(this.form["place_of_origin_address"]),"yyyy-MM-dd hh:mm:ss")
    	}
                	if(/^\d{10}$|^\d{13}$/.test(this.form["scale_of_origin"])){
    		this.form["scale_of_origin"] = this.$toTime(parseInt(this.form["scale_of_origin"]),"yyyy-MM-dd hh:mm:ss")
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
     * 获取产地类型列表
     */
    async get_list_type_of_place_of_origin() {
              var json = await this.$get("~/api/type_of_place_of_origin/get_list?");
      if(json.result && json.result.list){
        json.result.list.map((o) => this.list_type_of_place_of_origin.push({value:o.type_of_place_of_origin,text:o.type_of_place_of_origin}));
      }
      else if(json.error){
        console.error(json.error);
      }
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
                                                                                                                            },

    is_view() {
      var bl = this.user_group == '管理员';

      if (!bl) {
        bl = this.$check_action('/origin_display/table', 'add');
        console.log(bl ? '你有表格添加权限视作有添加权限' : '你没有表格添加权限');
      }
      if (!bl) {
        bl = this.$check_action('/origin_display/table', 'set');
        console.log(bl ? '你有表格添加权限视作有修改权限' : '你没有表格修改权限');
      }
      if (!bl) {
        bl = this.$check_action('/origin_display/view', 'add');
        console.log(bl ? '你有视图添加权限视作有添加权限' : '你没有视图添加权限');
      }
      if (!bl) {
        bl = this.$check_action('/origin_display/view', 'set');
        console.log(bl ? '你有视图修改权限视作有修改权限' : '你没有视图修改权限');
      }
      if (!bl) {
        bl = this.$check_action('/origin_display/view', 'get');
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
                  this.get_list_type_of_place_of_origin();
                    this.get_list_user_farmers_merchants();
          this.get_group_user_farmers_merchants();
                      },
};
</script>

<style lang="scss" scoped>
  @import 'styles/pagesC/index.scss';
</style>