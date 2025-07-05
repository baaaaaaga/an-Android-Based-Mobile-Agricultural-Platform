<template>
  <el-main class="bg edit_wrap comtable_e">
    <el-form ref="form" :model="form" status-icon label-width="120px" v-if="is_view()">
      <el-row class="row_ce">
        <el-col :xs="24" :sm="12" :lg="8" class="el_form_item_warp">
          <el-form-item label="订单号" prop="order_number">
            <el-input id="order_number" v-model="form['order_number']" placeholder="请输入订单号"
            ></el-input>
          </el-form-item>
        </el-col>
        <el-col :xs="24" :sm="12" :lg="8" class="el_form_item_warp">
          <el-form-item label="商品名称" prop="product_name">
            <el-input id="product_name" v-model="form['product_name']" placeholder="请输入商品名称"
            ></el-input>
          </el-form-item>
        </el-col>
        <el-col :xs="24" :sm="12" :lg="8" class="el_form_item_warp">
          <el-form-item label="购买数量" prop="purchase_quantity">
            <el-input id="purchase_quantity" v-model="form['purchase_quantity']" placeholder="请输入购买数量"
            ></el-input>
          </el-form-item>
        </el-col>
        <el-col :xs="24" :sm="12" :lg="8" class="el_form_item_warp">
          <el-form-item label="交易总额" prop="total_transaction_amount">
            <el-input-number id="total_transaction_amount" v-model.number="form['total_transaction_amount']"
            ></el-input-number>
          </el-form-item>
        </el-col>
        <el-col :xs="24" :sm="12" :lg="8" class="el_form_item_warp">
          <el-form-item label="发货日期" prop="the_date_of_issuance">
            <el-date-picker id="the_date_of_issuance"
                            v-model="form['the_date_of_issuance']" type="date" placeholder="选择日期">
            </el-date-picker>
          </el-form-item>
        </el-col>
        <el-col :xs="24" :sm="12" :lg="8" class="el_form_item_warp">
          <el-form-item label="配送单号" prop="delivery_number">
            <el-input id="delivery_number" v-model="form['delivery_number']" placeholder="请输入配送单号"
            ></el-input>
          </el-form-item>
        </el-col>
        <el-col :xs="24" :sm="12" :lg="8" class="el_form_item_warp">
          <el-form-item label="联系人" prop="contact_name">
            <el-input id="contact_name" v-model="form['contact_name']" placeholder=""></el-input>
          </el-form-item>
        </el-col>
        <el-col :xs="24" :sm="12" :lg="8" class="el_form_item_warp">
          <el-form-item label="买家" prop="ordinary_users">
            <el-select v-model="form.ordinary_users" placeholder="请选择" :disabled="true">
              <el-option :key="-1" label="未选择" :value="0">
              </el-option>
              <el-option v-for="(o,i) in list_user" :key="i" :label="o.nickname" :value="o.user_id">
              </el-option>
            </el-select>
          </el-form-item>
        </el-col>
        <el-col :xs="24" :sm="12" :lg="8" class="el_form_item_warp">
          <el-form-item label="收货地址" prop="shipping_address">
            <el-input id="shipping_address" v-model="form['shipping_address']" placeholder="请输入收货地址"
            ></el-input>
          </el-form-item>
        </el-col>
        <el-col :xs="24" :sm="12" :lg="8" class="el_form_item_warp">
          <el-form-item label="配送状态" prop="delivery_status">
            <el-select id="delivery_status" v-model="form['delivery_status']"
            >
              <el-option v-for="o in list_delivery_status" :key="o" :label="o" :value="o">
              </el-option>
            </el-select>
          </el-form-item>
        </el-col>
        <el-col :xs="24" :sm="12" :lg="8" class="el_form_item_warp">
          <el-form-item label="签收状态" prop="signing_status">
            <el-select id="signing_status" v-model="form['signing_status']"
                       :disabled="true"
            >
              <el-option v-for="o in list_signing_status" :key="o" :label="o" :value="o">
              </el-option>
            </el-select>
          </el-form-item>
        </el-col>


      </el-row>
      <el-col :xs="24" :sm="12" :lg="8" class="el_form_btn_warp">
        <el-form-item v-if="$check_action('/logistics_delivery/view','set') || $check_action('/logistics_delivery/view','add')">
          <el-button type="primary" @click="submit()">提交</el-button>
          <el-button @click="cancel()">取消</el-button>
        </el-form-item>
        <el-form-item v-else>
          <el-button @click="cancel()">返回</el-button>
        </el-form-item>
      </el-col>

    </el-form>
  </el-main>
</template>

<script>
import mixin from "@/mixins/page.js";

export default {
  mixins: [mixin],
  data() {
    return {
      field: "logistics_delivery_id",
      url_add: "~/api/logistics_delivery/add?",
      url_set: "~/api/logistics_delivery/set?",
      url_get_obj: "~/api/logistics_delivery/get_obj?",
      url_upload: "~/api/logistics_delivery/upload?",

      query: {
        "logistics_delivery_id": 0,
      },

      form: {
        "order_number": '', // 订单号
        "product_name": '', // 商品名称
        "purchase_quantity": '', // 购买数量
        "total_transaction_amount": 0, // 交易总额
        "the_date_of_issuance": '', // 发货日期
        "delivery_number": '', // 配送单号
        "ordinary_users": 0, // 普通用户
        "shipping_address": '', // 收货地址
        "delivery_status": '', // 配送状态
        "signing_status": '', // 签收状态
        "logistics_delivery_id": 0, // ID
        "contact_name": "", // ID

      },
      disabledObj: {
        "order_number_isDisabled": false,
        "product_name_isDisabled": false,
        "purchase_quantity_isDisabled": false,
        "total_transaction_amount_isDisabled": false,
        "the_date_of_issuance_isDisabled": false,
        "delivery_number_isDisabled": false,
        "ordinary_users_isDisabled": false,
        "shipping_address_isDisabled": false,
        "delivery_status_isDisabled": false,
        "signing_status_isDisabled": false,
      },


      // 配送状态选项列表
      list_delivery_status: ['待取货', '配送中', '已完成'],

      // 签收状态选项列表
      list_signing_status: ['待签收', '已签收'],
      list_user: []

    }
  },
  methods: {

    /**
     * 获取对象之前
     * @param {Object} param
     */
    get_obj_before(param) {
      if (this.form["the_date_of_issuance"].indexOf("-") === -1) {
        this.form["the_date_of_issuance"] = this.$toTime(parseInt(this.form["the_date_of_issuance"]), "yyyy-MM-dd")
      }
      return param;
    },

    /**
     * 获取对象之后
     * @param {Object} json
     * @param {Object} func
     */
    get_obj_after(json, func) {

      if (this.form["the_date_of_issuance"] == "0000-00-00") {
        this.form["the_date_of_issuance"] = null;
      }
      if (parseInt(this.form["the_date_of_issuance"]) > 9999) {
        this.form["the_date_of_issuance"] = this.$toTime(parseInt(this.form["the_date_of_issuance"]), "yyyy-MM-dd")
      }

    },

    /**
     * 提交前验证事件
     * @param {Object} 请求参数
     * @return {String} 验证成功返回null, 失败返回错误提示
     */
    submit_check(param) {
      let msg = null
      return msg;
    },

    is_view() {
      // var bl = this.user_group == "管理员";
      var bl = false;

      if (!bl) {
        bl = this.$check_action('/logistics_delivery/table', 'add');
        console.log(bl ? "你有表格添加权限视作有添加权限" : "你没有表格添加权限");
      }
      if (!bl) {
        bl = this.$check_action('/logistics_delivery/table', 'set');
        console.log(bl ? "你有表格添加权限视作有修改权限" : "你没有表格修改权限");
      }
      if (!bl) {
        bl = this.$check_action('/logistics_delivery/view', 'add');
        console.log(bl ? "你有视图添加权限视作有添加权限" : "你没有视图添加权限");
      }
      if (!bl) {
        bl = this.$check_action('/logistics_delivery/view', 'set');
        console.log(bl ? "你有视图修改权限视作有修改权限" : "你没有视图修改权限");
      }
      if (!bl) {
        bl = this.$check_action('/logistics_delivery/view', 'get');
        console.log(bl ? "你有视图查询权限视作有查询权限" : "你没有视图查询权限");
      }

      console.log(bl ? "具有当前页面的查看权，请注意这不代表你有字段的查看权" : "无权查看当前页，请注意即便有字段查询权限没有页面查询权限也不行");

      return bl;
    },
    /**
     * 上传文件
     * @param {Object} param
     */
    uploadimg(param) {
      this.uploadFile(param.file, "avatar");
    },
    /**
     * 获取用户
     */
    async get_list_user() {
      var json = await this.$get("~/api/user/get_list?");
      if (json.result) {
        this.list_user = json.result.list;
      } else if (json.error) {
        console.error(json.error);
      }
    }

  },
  created() {
    this.get_list_user()
  },
}
</script>

