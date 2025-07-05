<template>
  <el-main class="bg edit_wrap order">
    <el-form ref="form" :model="form" label-width="120px" status-icon>
      <el-row class="row_e">
        <el-col :lg="8" :sm="12" :xs="24" class="el_form_item_warp">
          <el-form-item label="优惠券名称" prop="contact_name">
            <el-input v-model="form.coupon_name" placeholder="请输入优惠券名称"></el-input>
          </el-form-item>
        </el-col>

        <el-col :lg="8" :sm="12" :xs="24" class="el_form_item_warp">
          <el-form-item label="优惠券金额" prop="contact_phone">
            满
            <el-input style="width: 50px!important;" v-model="form.coupon_price"  type="number"></el-input>
            减
            <el-input style="width: 50px!important;" v-model="form.coupon_price1" type="number"></el-input>
          </el-form-item>
        </el-col>

        <el-col :lg="8" :sm="12" :xs="24" class="el_form_item_warp">
          <el-form-item label="有效期" prop="contact_address">
            <el-date-picker
                style="border: 1px solid #cccccc!important;border-radius: 0"
                v-model="form.coupon_time"
                type="datetimerange"
                value-format="yyyy-MM-dd HH:mm:ss"
                range-separator="至"
                start-placeholder="开始日期"
                end-placeholder="结束日期">
            </el-date-picker>
          </el-form-item>
        </el-col>


        <el-col :lg="8" :sm="12" :xs="24" class="el_form_item_warp">
          <el-form-item label="优惠券类型" prop="description">
            <el-select v-model="form.coupon_type" placeholder="请选择类型">
              <el-option
                  v-for="item in list_type"
                  :key="item.value"
                  :label="item.label"
                  :value="item.value">
              </el-option>
            </el-select>
          </el-form-item>
        </el-col>
        <el-col :lg="8" :sm="12" :xs="24" class="el_form_item_warp">
          <el-form-item label="卖家" prop="description">
            <el-select v-model="form.coupon_user_id" placeholder="请选择卖家" :disabled="coupon_user_disabled">
              <el-option
                  v-for="item in list_user"
                  :key="item.user_id"
                  :label="item.nickname"
                  :value="item.user_id">
              </el-option>
            </el-select>
          </el-form-item>
        </el-col>
      </el-row>


      <el-col :lg="24" :sm="24" :xs="24" class="el_form_btn_warp">
        <el-form-item>
          <el-col :lg="12" :sm="24" :xs="24" class="el_form_btn el_form_btn_1">
            <el-button style="width: 100%; float: left;" type="primary" @click="submit()">提交</el-button>
          </el-col>
          <el-col :lg="12" :sm="24" :xs="24" class="el_form_btn el_form_btn_2">
            <el-button style="width: 100%; float: right;" @click="cancel()">取消</el-button>
          </el-col>
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
      field: "coupon_id",
      url_add: "~/api/coupon/add?",
      url_set: "~/api/coupon/set?",
      url_get_obj: "~/api/coupon/get_obj?",

      query: {
        order_id: 0
      },

      form: {
        coupon_name: "",
        coupon_price:"",
        coupon_price1:"",
        coupon_time:"",
        coupon_type:"满减",
        coupon_user_id:"",
        coupon_user_auth:""
      },

      coupon_user_disabled:false,
      list_user: [],

      list_type:[{
        value:"满减",
        label:"满减"
      }]
    }
  },
  methods: {
    submit_before(params){
      const query = JSON.parse(JSON.stringify(params))
      query.coupon_time = query.coupon_time.join(",")
      this.list_user.forEach(value => {
        if(value.user_id == query.coupon_user_id){
          query.coupon_user_auth = value.user_group
        }
      })
      return query
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
    },
  },
  created() {
    this.get_list_user();
    if (this.user_group != "管理员") {
      if (this.$check_option('/goods/table', 'seller')){
        this.form.coupon_user_id = this.$store.state.user.user_id
        this.coupon_user_disabled = true;
      }
    }
    this.form.coupon_user_auth = this.$store.state.user.user_group
  }
}
</script>

<style>
.avatar-uploader .el-upload {
  border: 1px dashed #d9d9d9;
  border-radius: 6px;
  cursor: pointer;
  position: relative;
  overflow: hidden;
}

.avatar-uploader .el-upload:hover {
  border-color: #409EFF;
}

.avatar-uploader-icon {
  font-size: 28px;
  color: #8c939d;
  width: 178px;
  height: 178px;
  line-height: 178px;
  text-align: center;
}

.avatar {
  width: 178px;
  height: 178px;
  display: block;
}
</style>
