<template>
  <el-main class="bg table_wrap order">
    <el-form :model="query" class="form p_4" label-position="right" label-width="120">
      <el-row class="rows row1">
        <el-col :lg="6" :sm="12" :xs="24" class="el_form_search_wrap">
          <el-form-item label="优惠券名称">
            <el-input v-model="query.coupon_name"></el-input>
          </el-form-item>
        </el-col>
      </el-row>
      <el-row class="rows row2">
        <el-col :lg="24" :sm="24" :xs="24" class="search_btn_wrap">
          <el-col :lg="12" :sm="12" :xs="24" class="search_btn_1 btns">

            <el-button class="search_btn_find" type="primary" @click="search()">查询</el-button>
            <el-button class="search_btn_reset" @click="reset()">重置</el-button>
            <el-button v-if="$check_option('/goods/table', 'seller')" @click="$router.push('./view?')">添加</el-button>
            <el-button v-if="$check_action('/order/table','del')"
                       class="float-right search_btn_del" type="danger"
                       @click="delInfo()">删除
            </el-button>

          </el-col>

        </el-col>

      </el-row>
    </el-form>
    <el-table :data="list" border stripe style="width: 100%" @selection-change="selectionChange"
              @sort-change="$sortChange">

      <el-table-column fixed tooltip-effect="dark" type="selection" width="55">
      </el-table-column>

      <el-table-column fixed label="优惠券名称" prop="coupon_name" width="120">
      </el-table-column>

      <el-table-column fixed label="所属卖家" prop="coupon_user_id" width="120">
        <template slot-scope="scope">
          {{list_user.getVal('nickname', {"user_id":scope.row.coupon_user_id})}}
        </template>
      </el-table-column>

      <el-table-column label="优惠券金额" min-width="200" prop="coupon_price">
        <template slot-scope="scope">
          满
          {{ scope.row["coupon_price"] }}
          减
          {{ scope.row["coupon_price1"] }}
        </template>
      </el-table-column>

      <el-table-column label="优惠券类型" min-width="120" prop="coupon_type">
      </el-table-column>

      <el-table-column label="有效期" min-width="300" prop="coupon_time">
        <template slot-scope="scope">
          {{ $toTime(scope.row["coupon_time"].split(",")[0], "yyyy-MM-dd hh:mm:ss") }}
          到
          {{ $toTime(scope.row["coupon_time"].split(",")[1], "yyyy-MM-dd hh:mm:ss") }}
        </template>
      </el-table-column>

      <el-table-column label="创建时间" min-width="200" prop="create_time" sortable>
        <template slot-scope="scope">
          {{ $toTime(scope.row["create_time"], "yyyy-MM-dd hh:mm:ss") }}
        </template>
      </el-table-column>

      <el-table-column label="更新时间" min-width="200" prop="update_time" sortable>
        <template slot-scope="scope">
          {{ $toTime(scope.row["update_time"], "yyyy-MM-dd hh:mm:ss") }}
        </template>
      </el-table-column>

    </el-table>

    <!-- 分页器 -->
    <div class="mt text_center">
      <el-pagination :current-page="query.page" :page-size="query.size"
                     :page-sizes="[7, 10, 30, 100]" :total="count" layout="total, sizes, prev, pager, next, jumper"
                     @size-change="handleSizeChange" @current-change="handleCurrentChange">
      </el-pagination>
    </div>
    <!-- /分页器 -->
  </el-main>
</template>

<script>
import mixin from "@/mixins/page.js";

export default {
  mixins: [mixin],
  data() {
    return {
      url_get_list: "~/api/coupon/get_list?like=0",
      url_set: "~/api/coupon/set?",
      url_del: "~/api/coupon/del?",

      // 字段ID
      field: "coupon_id",

      refund_view: false,

      form: {
        state: ""
      },

      query: {
        size: 10,
        page: 1,
        coupon_name:"",
        coupon_user_id: ""
      },

      // 数据
      list: [],
      //用户列表
      list_user: []
    }
  },
  methods: {
    async get_list_user(){
      var json = await this.$get("~/api/user/get_list?");
      if(json.result){
        this.list_user = json.result.list;
      }
      else if(json.error){
        console.error(json.error);
      }
    },
    /**
     * 请求列表前
     * @param {Object} param
     */
    get_list_before(param) {
      let user_group = this.user.user_group;
      if (user_group !== "管理员" && this.$check_option('/goods/table', 'seller')){
        param["coupon_user_id"] = this.user.user_id;
      }
      return param;
    },
    /**
     * @description 删除
     * @param {Object} index
     * @param {Object} rows
     */
    deleteRow(index, rows) {
      rows.splice(index, 1);
    },
    /**
     * @description 表格样式
     */
    table_class({
                  row,
                  column,
                  rowIndex,
                  columnIndex
                }) {
      return "table_class";
    },
  },
  created() {
    this.get_list_user();
    if (this.user_group != "管理员") {
      if (this.$check_option('/goods/table', 'seller')){
        this.query.coupon_user_id = this.$store.user.user_id
      }
    }
  }
}
</script>

<style type="text/css">
.refund_view {
  top: 0;
}

.bg {
  background: white;
}

.form.p_4 {
  padding: 1rem;
}

.form .el-input {
  width: initial;
}

.mt {
  margin-top: 1rem;
}

.float-right {
  float: right;
}

.mr-1 {
  margin-right: 1rem;
}

.el-table .table_class {
  background: rgba(150, 150, 150, 0.1);
  text-align: center;
}

.text_center {
  text-align: center;
}

.float-right {
  float: right;
}
</style>
