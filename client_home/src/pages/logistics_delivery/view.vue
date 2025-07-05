<template>
  <view class="page_logistics_delivery_view" :style="{ paddingTop: vuex_custom_bar_height + 'px' }">
    <tn-nav-bar>订单配送详情</tn-nav-bar>
    <view id="page_diy_view" class="page-from">
      <uni-forms :modelValue="form" labelWidth="70px">
        <uni-forms-item label="订单号" name="order_number">
          <uni-easyinput type="text" v-model="form['order_number']" />
        </uni-forms-item>
        <uni-forms-item label="商品名称" name="product_name">
          <uni-easyinput type="text" v-model="form['product_name']" />
        </uni-forms-item>
        <uni-forms-item label="购买数量" name="purchase_quantity">
          <uni-easyinput type="text" v-model="form['purchase_quantity']" />
        </uni-forms-item>
        <uni-forms-item label="交易总额" name="total_transaction_amount">
          <uni-easyinput type="text" v-model="form['total_transaction_amount']" />
        </uni-forms-item>
        <uni-forms-item label="发货日期" name="the_date_of_issuance">
          <uni-datetime-picker v-model="form['the_date_of_issuance']" type="date" />
        </uni-forms-item>
        <uni-forms-item label="配送单号" name="delivery_number">
          <uni-easyinput type="text" v-model="form['delivery_number']" />
        </uni-forms-item>

        <uni-forms-item label="买家" name="delivery_number">
          <uni-data-select
            v-model="form['ordinary_users']"
            :localdata="list_user_ordinary_users"
            :disabled="true"
          ></uni-data-select>
        </uni-forms-item>

        <uni-forms-item label="联系人" name="ordinary_users">
          <uni-easyinput type="text" v-model="form['contact_name']" />
        </uni-forms-item>
        <uni-forms-item label="收货地址" name="shipping_address">
          <uni-easyinput type="text" v-model="form['shipping_address']" />
        </uni-forms-item>
        <uni-forms-item label="配送状态" name="delivery_status">
          <uni-data-select
            v-model="form.delivery_status"
            :localdata="list_delivery_status"
          ></uni-data-select>
        </uni-forms-item>
        <uni-forms-item label="签收状态" name="signing_status">
          <uni-data-select
            v-if="!form['signing_status']"
            v-model="form.signing_status"
            :localdata="[
              { value: '待签收', text: '待签收' },
              { value: '已签收', text: '已签收' },
            ]"
          ></uni-data-select>
          <text v-else> {{ form['signing_status'] }} </text>
        </uni-forms-item>
      </uni-forms>
      <view class="form-footer">
        <view
          class="me-btn btn-submit"
          v-if="userGroup == '管理员' || $check_action('/logistics_delivery/view', 'set')"
          @click="submitData"
        >
          提交
        </view>
        <view class="me-btn btn-cancel" @click="cancel">取消</view>
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
      field: 'logistics_delivery_id',
      url_add: '~/api/logistics_delivery/add?',
      url_set: '~/api/logistics_delivery/set?',
      url_get_obj: '~/api/logistics_delivery/get_obj?',
      url_upload: '~/api/logistics_delivery/upload?',
      order_number: null,
      product_name: null,
      purchase_quantity: null,
      total_transaction_amount: null,
      the_date_of_issuance: null,
      store_name: null,
      delivery_number: null,
      ordinary_users: null,
      shipping_address: null,
      delivery_status: null,
      signing_status: null,
      query: {
        logistics_delivery_id: 0,
      },

      form: {
        order_number: '', // 订单号
        product_name: '', // 商品名称
        purchase_quantity: '', // 购买数量
        total_transaction_amount: 0, // 交易总额
        the_date_of_issuance: this.$toTime(new Date().getTime(), 'yyyy-MM-dd'),
        store_name: '', // 店铺名称
        delivery_number: '', // 店铺地址
        ordinary_users: 0, // 普通用户
        shipping_address: '', // 收货地址
        delivery_status: '', // 配送状态
        signing_status: '', // 签收状态
        logistics_delivery_id: 0, // ID
        contact_name: '', // ID
      },
      disabledObj: {
        order_number_isDisabled: false,
        product_name_isDisabled: false,
        purchase_quantity_isDisabled: false,
        the_date_of_issuance_isDisabled: false,
        store_name_isDisabled: false,
        store_address_isDisabled: false,
        ordinary_users_isDisabled: false,
        shipping_address_isDisabled: false,
        delivery_status_isDisabled: false,
        signing_status_isDisabled: false,
      },
      // 用户列表
      list_user_ordinary_users: [],
      // 配送状态选项列表
      list_delivery_status: [],
      // 签收状态选项列表
      list_signing_status: [],
    };
  },
  methods: {
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
        url: '/api/logistics_delivery/upload', //仅为示例，非真实的接口地址
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
      if (type == 'order_number') this['order_number'] = this.form['order_number'] = '';
      if (type == 'product_name') this['product_name'] = this.form['product_name'] = '';
      if (type == 'purchase_quantity')
        this['purchase_quantity'] = this.form['purchase_quantity'] = '';
      if (type == 'total_transaction_amount')
        this['total_transaction_amount'] = this.form['total_transaction_amount'] = '';
      if (type == 'the_date_of_issuance')
        this['the_date_of_issuance'] = this.form['the_date_of_issuance'] = '';
      if (type == 'store_name') this['store_name'] = this.form['store_name'] = '';
      if (type == 'store_address') this['store_address'] = this.form['store_address'] = '';
      if (type == 'ordinary_users') this['ordinary_users'] = this.form['ordinary_users'] = '';
      if (type == 'shipping_address') this['shipping_address'] = this.form['shipping_address'] = '';
      if (type == 'delivery_status') this['delivery_status'] = this.form['delivery_status'] = '';
      if (type == 'signing_status') this['signing_status'] = this.form['signing_status'] = '';
    },
    submitData() {
      if (this['order_number'] !== null) this.form['order_number'] = this['order_number'];
      if (this['product_name'] !== null) this.form['product_name'] = this['product_name'];
      if (this['purchase_quantity'] !== null)
        this.form['purchase_quantity'] = this['purchase_quantity'];
      if (this['total_transaction_amount'] !== null)
        this.form['total_transaction_amount'] = this['total_transaction_amount'];
      if (this['the_date_of_issuance'] !== null)
        this.form['the_date_of_issuance'] = this['the_date_of_issuance'];
      if (this['store_name'] !== null) this.form['store_name'] = this['store_name'];
      if (this['store_address'] !== null) this.form['store_address'] = this['store_address'];
      if (this['ordinary_users'] !== null) this.form['ordinary_users'] = this['ordinary_users'];
      if (this['shipping_address'] !== null)
        this.form['shipping_address'] = this['shipping_address'];
      if (this['delivery_status'] !== null) this.form['delivery_status'] = this['delivery_status'];
      if (this['signing_status'] !== null) this.form['signing_status'] = this['signing_status'];
      console.log(this.form);
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
        success: function (res) {
          const tempFilePaths = res.tempFilePaths;
          const uploadTask = uni.uploadFile({
            url: _self.$fullUrl('~/api/logistics_delivery/upload?'),
            filePath: tempFilePaths[0],
            name: 'file',
            formData: {
              i_want_to_customize: 'test',
            },
            header: {
              'x-auth-token': _self.$store.state.app.userInfo.token,
            },
            success: function (uploadFileRes) {
              var filename = JSON.parse(uploadFileRes.data).result.url;
              _self.form[key_name] = filename;
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
        success: function (res) {
          const tempFilePaths = res.tempFilePaths;
          const uploadTask = uni.uploadFile({
            url: _self.$fullUrl('~/api/logistics_delivery/upload?'),
            filePath: tempFilePaths[0],
            name: 'file',
            formData: {
              i_want_to_customize: 'test',
            },
            header: {
              'x-auth-token': _self.$store.state.app.userInfo.token,
            },
            success: function (uploadFileRes) {
              var filename = JSON.parse(uploadFileRes.data).result.url;
              _self.form[key_name] = filename;
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
      if (
        this.form['the_date_of_issuance'] &&
        JSON.stringify(this.form['the_date_of_issuance']).indexOf('-') === -1
      ) {
        this.form['the_date_of_issuance'] = this.$toTime(
          parseInt(this.form['the_date_of_issuance']),
          'yyyy-MM-dd'
        );
      }
      uni.db.del('form');
      return param;
    },

    /**
     * 获取普通用户用户列表
     */
    async get_list_user_ordinary_users() {
      var json = await this.$get('~/api/user/get_list');
      if (json.result && json.result.list) {
        json.result.list.map((o) =>
          this.list_user_ordinary_users.push({
            value: o.user_id,
            text: o.nickname + '-' + o.username,
          })
        );
      } else if (json.error) {
        console.error(json.error);
      }
    },

    /**
     * 获取配送状态列表
     */
    async get_list_delivery_status() {
      ['待取货', '派送中', '已完成'].map((o) =>
        this.list_delivery_status.push({ value: o, text: o })
      );
    },

    /**
     * 获取签收状态列表
     */
    async get_list_signing_status() {
      ['待签收', '已签收'].map((o) => this.list_signing_status.push({ value: o, text: o }));
    },

    /**
     * 获取对象之后
     * @param {Object} json
     * @param {Object} func
     */
    get_obj_after(json, func) {
      if (
        this.form['the_date_of_issuance'] &&
        JSON.stringify(this.form['the_date_of_issuance']).indexOf('-') === -1
      ) {
        this.form['the_date_of_issuance'] = this.$toTime(
          parseInt(this.form['the_date_of_issuance']),
          'yyyy-MM-dd'
        );
      }
    },

    is_view() {
      var bl = this.user_group == '管理员';

      if (!bl) {
        bl = this.$check_action('/logistics_delivery/table', 'add');
        console.log(bl ? '你有表格添加权限视作有添加权限' : '你没有表格添加权限');
      }
      if (!bl) {
        bl = this.$check_action('/logistics_delivery/table', 'set');
        console.log(bl ? '你有表格添加权限视作有修改权限' : '你没有表格修改权限');
      }
      if (!bl) {
        bl = this.$check_action('/logistics_delivery/view', 'add');
        console.log(bl ? '你有视图添加权限视作有添加权限' : '你没有视图添加权限');
      }
      if (!bl) {
        bl = this.$check_action('/logistics_delivery/view', 'set');
        console.log(bl ? '你有视图修改权限视作有修改权限' : '你没有视图修改权限');
      }
      if (!bl) {
        bl = this.$check_action('/logistics_delivery/view', 'get');
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
    this.get_list_user_ordinary_users();
    this.get_list_delivery_status();
    this.get_list_signing_status();
  },
};
</script>
<style lang="scss" scoped>
@import 'styles/pages/index.scss';
</style>
