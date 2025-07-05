<template>
  <view class="page_diy_view page_experience_sharing_view" :style="{ paddingTop: vuex_custom_bar_height + 'px' }">
    <tn-nav-bar>经验分享详情</tn-nav-bar>
    <view id="page_diy_view" class="page-from">
      <uni-forms :modelValue="form" v-if="is_view()" labelWidth="70px">

        <uni-forms-item v-if="$check_field('get','title') || ($check_field('add','title') || $check_field('set','title'))" label="标题" name="title">
                      <uni-easyinput type="text" v-model="form['title']" v-if="(form['experience_sharing_id'] && $check_field('set','title')) || (!form['experience_sharing_id'] && $check_field('add','title'))" :disabled="disabledObj['title_isDisabled']" />
          <!-- 仅查看 -->
          <text v-else-if="$check_field('get','title')">
            {{ form['title'] }}
          </text>
                    </uni-forms-item>
        <uni-forms-item v-if="$check_field('get','share_type') || ($check_field('add','share_type') || $check_field('set','share_type'))" label="分享类型" name="share_type">
              <uni-data-select
              v-model="form.share_type"
              :localdata="list_share_type"
              :clear="!disabledObj['share_type_isDisabled']"
              :disabled="disabledObj['share_type_isDisabled']"
              v-if="(form['experience_sharing_id'] && $check_field('set','share_type')) || (!form['experience_sharing_id'] && $check_field('add','share_type'))"
			  style="width: 100%;"
                        ></uni-data-select>
          <!-- 仅查看 -->
          <text v-else-if="$check_field('get','share_type')">
            {{ form['share_type'] }}
          </text>
            </uni-forms-item>
        <uni-forms-item v-if="$check_field('get','experience_content') || ($check_field('add','experience_content') || $check_field('set','experience_content'))" label="经验内容" name="experience_content">
              <uni-easyinput type="textarea" v-model="form['experience_content']" v-if="(form['experience_sharing_id'] && $check_field('set', 'experience_content')) || (!form['experience_sharing_id'] && $check_field('add', 'experience_content'))" :disabled="disabledObj['experience_content_isDisabled']"/>
          <!-- 仅查看 -->
          <text v-else-if="$check_field('get', 'experience_content')">
            {{ form['experience_content'] }}
          </text>
            </uni-forms-item>
      </uni-forms>
      <view class="form-footer" v-if="$check_action('/experience_sharing/view','set') || ($check_action('/experience_sharing/view','add') || $check_option('/experience_sharing/table','examine'))">
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
      field: "experience_sharing_id",
      url_add: "~/api/experience_sharing/add?",
      url_set: "~/api/experience_sharing/set?",
      url_get_obj: "~/api/experience_sharing/get_obj?",
      url_upload: "~/api/experience_sharing/upload?",
      title: null,
      share_type: null,
      experience_content: null,
      query: {
        "experience_sharing_id": 0,
      },
      form: {
          "title": null, // 标题
            "share_type": null, // 分享类型
            "experience_content": null, // 经验内容
          "experience_sharing_id": 0, // ID
      },
      disabledObj:{
          "title_isDisabled": false,
            "share_type_isDisabled": false,
            "experience_content_isDisabled": false,
        },
                          // 分享类型选项列表
      list_share_type: [],
                    };
  },
  methods: {
    /**
     * 提交前验证事件
     * @param {Object} 请求参数
     * @return {String} 验证成功返回null, 失败返回错误提示
     */
    async submit_check(param) {
          if (!param.title){
        return "标题不能为空";
      }
                          if (!param.share_type){
        return "分享类型不能为空";
      }
                          if (!param.experience_content){
        return "经验内容不能为空";
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
        url: this.$fullUrl('~/api/experience_sharing/upload?'), //仅为示例，非真实的接口地址
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
      if (type == 'title') this['title'] = this.form['title'] = "";
      if (type == 'share_type') this['share_type'] = this.form['share_type'] = "";
      if (type == 'experience_content') this['experience_content'] = this.form['experience_content'] = "";
    },
    submit_() {
      if (this['title'] !== null) this.form['title'] = this['title']
      if (this['share_type'] !== null) this.form['share_type'] = this['share_type']
      if (this['experience_content'] !== null) this.form['experience_content'] = this['experience_content']
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
            '/experience_sharing/upload',
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
          uploadFilePathApi('/experience_sharing/upload',filePath,undefined,undefined,
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
        	if(/^\d{10}$|^\d{13}$/.test(this.form["title"])){
    		this.form["title"] = this.$toTime(parseInt(this.form["title"]),"yyyy-MM-dd hh:mm:ss")
    	}
                  uni.db.del('form');

      return param;
    },
    
        /**
     * 获取分享类型列表
     */
    async get_list_share_type() {
              var json = await this.$get("~/api/share_type/get_list?");
      if(json.result && json.result.list){
        json.result.list.map((o) => this.list_share_type.push({value:o.share_type,text:o.share_type}));
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
                                        },

    is_view() {
      var bl = this.user_group == '管理员';

      if (!bl) {
        bl = this.$check_action('/experience_sharing/table', 'add');
        console.log(bl ? '你有表格添加权限视作有添加权限' : '你没有表格添加权限');
      }
      if (!bl) {
        bl = this.$check_action('/experience_sharing/table', 'set');
        console.log(bl ? '你有表格添加权限视作有修改权限' : '你没有表格修改权限');
      }
      if (!bl) {
        bl = this.$check_action('/experience_sharing/view', 'add');
        console.log(bl ? '你有视图添加权限视作有添加权限' : '你没有视图添加权限');
      }
      if (!bl) {
        bl = this.$check_action('/experience_sharing/view', 'set');
        console.log(bl ? '你有视图修改权限视作有修改权限' : '你没有视图修改权限');
      }
      if (!bl) {
        bl = this.$check_action('/experience_sharing/view', 'get');
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
          this.get_list_share_type();
          },
};
</script>

<style lang="scss" scoped>
  @import 'styles/pagesC/index.scss';
</style>