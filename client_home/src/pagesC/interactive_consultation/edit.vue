<template>
  <view class="page_diy_edit page_interactive_consultation_edit" :style="{ paddingTop: vuex_custom_bar_height + 'px' }">
    <tn-nav-bar>互动咨询</tn-nav-bar>
    <view class="page-custom " id="page_diy_edit">
      <view class="custom-from">
          <view v-if="$check_field('set', 'consultation_number') || $check_field('add', 'consultation_number') ||  $check_field('get', 'consultation_number')" class="custom-from-item">
          <view class="label">
            <text>
              咨询编号
            </text>
          </view>
              <!-- 文本 -->
                  <view class="content">
            <input type="text" id="form_consultation_number" v-model="form['consultation_number']" placeholder="请输入咨询编号" v-if="(form['consultation_number'] && $check_field('set','consultation_number')) || (!form['consultation_number'] && $check_field('add','consultation_number'))" :disabled="true" />
            <text v-else-if="$check_field('get','consultation_number')">{{ form['consultation_number'] }}</text>
          </view>
                    </view>
            <view v-if="$check_field('set', 'farmers_merchants') || $check_field('add', 'farmers_merchants') ||  $check_field('get', 'farmers_merchants')" class="custom-from-item">
          <view class="label">
            <text>农户商家</text>
          </view>
          <view class="content">
            <uni-data-select
                    id="form_farmers_merchants" v-model="form['farmers_merchants']"
                    :localdata="list_user_farmers_merchants"
                    :clear="!disabledObj['farmers_merchants_isDisabled']"
                    :disabled="disabledObj['farmers_merchants_isDisabled']"
                    v-if="(form['farmers_merchants'] && $check_field('set', 'farmers_merchants')) || (!form['farmers_merchants'] && $check_field('add', 'farmers_merchants'))" style="width: 100%;">
            </uni-data-select>
            <text v-else-if="$check_field('get', 'farmers_merchants')">
              {{form['farmers_merchants']}}
            </text>
          </view>
        </view>
            <view v-if="$check_field('set', 'business_name') || $check_field('add', 'business_name') ||  $check_field('get', 'business_name')" class="custom-from-item">
          <view class="label">
            <text>
              商家名称
            </text>
          </view>
              <!-- 文本 -->
                  <view class="content">
            <input type="text" id="form_business_name" v-model="form['business_name']" placeholder="请输入商家名称" v-if="(form['business_name'] && $check_field('set','business_name')) || (!form['business_name'] && $check_field('add','business_name'))" :disabled="disabledObj['business_name_isDisabled']" />
            <text v-else-if="$check_field('get','business_name')">{{ form['business_name'] }}</text>
          </view>
                    </view>
            <view v-if="$check_field('set', 'contact_number') || $check_field('add', 'contact_number') ||  $check_field('get', 'contact_number')" class="custom-from-item">
          <view class="label">
            <text>
              联系号码
            </text>
          </view>
              <!-- 手机 -->
          <view class="content">
            <input type="text" id="form_contact_number" v-model="form['contact_number']" placeholder="请输入联系号码" v-if="(form['contact_number'] && $check_field('set','contact_number')) || (!form['contact_number'] && $check_field('add','contact_number'))"  :disabled="disabledObj['contact_number_isDisabled']" />
            <text v-else-if="$check_field('get','contact_number')">{{ form['contact_number'] }}</text>
          </view>
            </view>
            <view v-if="$check_field('set', 'business_address') || $check_field('add', 'business_address') ||  $check_field('get', 'business_address')" class="custom-from-item">
          <view class="label">
            <text>
              商家地址
            </text>
          </view>
              <!-- 文本 -->
                  <view class="content">
            <input type="text" id="form_business_address" v-model="form['business_address']" placeholder="请输入商家地址" v-if="(form['business_address'] && $check_field('set','business_address')) || (!form['business_address'] && $check_field('add','business_address'))" :disabled="disabledObj['business_address_isDisabled']" />
            <text v-else-if="$check_field('get','business_address')">{{ form['business_address'] }}</text>
          </view>
                    </view>
            <view v-if="$check_field('set', 'date_of_consultation') || $check_field('add', 'date_of_consultation') ||  $check_field('get', 'date_of_consultation')" class="custom-from-item">
          <view class="label">
            <text>
              咨询日期
            </text>
          </view>
              <!-- 日期 -->
          <view class="content">
            <uni-datetime-picker :disabled="disabledObj['date_of_consultation_isDisabled']" type="date"
                     id="form_date_of_consultation" v-model="form['date_of_consultation']" placeholder="请输入咨询日期"
                     v-if="(form['date_of_consultation'] && $check_field('set', 'date_of_consultation')) || (!form['date_of_consultation'] && $check_field('add', 'date_of_consultation'))" />
            <text v-else-if="$check_field('get', 'date_of_consultation')">
              {{form['date_of_consultation']}}
            </text>
          </view>
	        </view>
            <view v-if="$check_field('set', 'consulting_users') || $check_field('add', 'consulting_users') ||  $check_field('get', 'consulting_users')" class="custom-from-item">
          <view class="label">
            <text>咨询用户</text>
          </view>
          <view class="content">
            <uni-data-select
                    id="form_consulting_users" v-model="form['consulting_users']"
                    :localdata="list_user_consulting_users"
                    :clear="!disabledObj['consulting_users_isDisabled']"
                    :disabled="disabledObj['consulting_users_isDisabled']"
                    v-if="(form['consulting_users'] && $check_field('set', 'consulting_users')) || (!form['consulting_users'] && $check_field('add', 'consulting_users'))" style="width: 100%;">
            </uni-data-select>
            <text v-else-if="$check_field('get', 'consulting_users')">
              {{form['consulting_users']}}
            </text>
          </view>
        </view>
            <view v-if="$check_field('set', 'consulting_content') || $check_field('add', 'consulting_content') ||  $check_field('get', 'consulting_content')" class="custom-from-item">
          <view class="label">
            <text>
              咨询内容
            </text>
          </view>
              <!-- 多文本 -->
          <view class="content">
            <textarea id="form_consulting_content" v-model="form['consulting_content']" v-if="(form['consulting_content'] && $check_field('set','consulting_content')) || (!form['consulting_content'] && $check_field('add','consulting_content'))" :disabled="disabledObj['consulting_content_isDisabled']"/>
            <text v-else-if="$check_field('get','consulting_content')">{{ form['consulting_content'] }}</text>
          </view>
            </view>
          <view class="form-footer">
          <view class="me-btn" @click="submit()">提交</view>
        </view>
      </view>
    </view>
  </view>
</template>

<script>
import mixin from '@/libs/mixins/page.js';
export default {
  mixins: [mixin],
  data() {
    return {
      url_get_obj: '~/api/interactive_consultation/get_obj?',
      url_add: '~/api/interactive_consultation/add?',
      url_set: '~/api/interactive_consultation/set?',
	  today: new Date().toISOString().split('T')[0],
      // 查询条件
      query: {
        interactive_consultation_id: 0,
          consultation_number: "",
            farmers_merchants: 0,
            business_name: "",
            contact_number: "",
            business_address: "",
            date_of_consultation: "",
            consulting_users: 0,
            consulting_content: "",
        },
      obj: {
        interactive_consultation_id: 0,
          consultation_number: this.$get_stamp(), // 咨询编号
            farmers_merchants: 0, // 农户商家
            business_name:  '', // 商家名称
            contact_number:  '', // 联系号码
            business_address:  '', // 商家地址
            date_of_consultation: this.$toTime(new Date().getTime(), "yyyy-MM-dd"),
            consulting_users: 0, // 咨询用户
            consulting_content:  '', // 咨询内容
        },

      // 表单字段
      form: {
        interactive_consultation_id: 0,
          consultation_number: this.$get_stamp(), // 咨询编号
            farmers_merchants: 0, // 农户商家
            business_name: null, // 商家名称
            contact_number: null, // 联系号码
            business_address: null, // 商家地址
            date_of_consultation: this.$toTime(new Date().getTime(), "yyyy-MM-dd"),
            consulting_users: 0, // 咨询用户
            consulting_content:  '', // 咨询内容
        },
      disabledObj: {
          consultation_number_isDisabled: false,
            farmers_merchants_isDisabled: false,
            business_name_isDisabled: false,
            contact_number_isDisabled: false,
            business_address_isDisabled: false,
            date_of_consultation_isDisabled: false,
            consulting_users_isDisabled: false,
            consulting_content_isDisabled: false,
        },
                      // 用户列表
      list_user_farmers_merchants: [],
                                                  // 用户列表
      list_user_consulting_users: [],
                  field: 'interactive_consultation_id',
      table_key: 'interactive_consultation',

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
                                                      return null;
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
            async get_user_session_consulting_users(){
        var _this = this;
        var json = await this.$get("~/api/user_group/get_obj?name=消费者");
        if(json.result && json.result.obj){
          var source_table = json.result.obj.source_table;
          var user_id = _this.userInfo.user_id;
          if (user_id){
            var url = "~/api/"+source_table+"/get_obj"
            this.$get(url, { user_id: _this.userInfo.user_id }, function (res) {
              if (res.result && res.result.obj) {
                var arr = []
                for (let key in res.result.obj) {
                  arr.push(key)
                }
                var arrForm = []
                for (let key in _this.form) {
                  arrForm.push(key)
                }
                _this.form["consulting_users"] = user_id
                _this.disabledObj['consulting_users' + '_isDisabled'] = true
                for (var i=0;i<arr.length;i++){
                  if (arr[i]!=='examine_state' && arr[i]!=='examine_reply') {
                    for (var j = 0; j < arrForm.length; j++) {
                      if (arr[i] === arrForm[j]) {
                        if (arr[i] !== "consulting_users") {
                          _this.form[arrForm[j]] = res.result.obj[arr[i]]
                          _this.disabledObj[arrForm[j] + '_isDisabled'] = true
                          break;
                        }
                      }
                    }
                  }
                }
              }
            });
          }
        }
        else if(json.error){
          console.error(json.error);
        }
    },
            
                change_img(key_name) {
      var _self = this;
      _self.upload_img_flag = false;
      // 选择图像方法
      uni.chooseImage({
        count: 1,
        sizeType: ['original', 'compressed'], //可以指定是原图还是压缩图，默认二者都有
        sourceType: ['album'], //从相册选择
        success: function (res) {
          const tempFilePaths = res.tempFilePaths;
          const uploadTask = uni.uploadFile({
            url: _self.$fullUrl('~/api/interactive_consultation/upload?'),
            filePath: tempFilePaths[0],
            name: 'file',
            formData: {
              interactive_consultation: 'test',
            },
            header: {
              'x-auth-token': _self.$store.state.app.userInfo.token,
            },
            success: function (uploadFileRes) {
              var filename = JSON.parse(uploadFileRes.data).result.url;
              var img_url = filename;
              _self.form[key_name] = img_url;
            },
          });

          uploadTask.onProgressUpdate(function (res) {
            _self.percent = res.progress;
            console.log('上传进度' + res.progress);
            console.log('已经上传的数据长度' + res.totalBytesSent);
            console.log('预期需要上传的数据总长度' + res.totalBytesExpectedToSend);
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
     * 获取对象后获取缓存表单
     * @param {Object} json
     * @param {Object} func
     */
    get_obj_after(json, func) {
      var form = uni.db.get('form');
      var obj = Object.assign({}, form, this.obj);
      if (form) {
        this.obj = uni.push(this.obj, obj);
      }
      if (form) {
        this.form = uni.push(this.form, form);
      }
      if (func) {
        func(json);
      }
    },

  },
  onLoad() {
                this.get_list_user_farmers_merchants();
                                  this.get_user_session_consulting_users();
        this.get_list_user_consulting_users();
          },
};
</script>

