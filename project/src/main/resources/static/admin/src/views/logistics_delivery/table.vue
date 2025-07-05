<template>
  <el-main class="bg table_wrap comtabel_t">
    <el-form label-position="right" :model="query" class="form p_4" label-width="120">
      <el-row class="rows row1">

        <el-col :xs="24" :sm="24" :lg="8" class="el_form_search_wrap">
          <el-form-item label="配送状态">
            <el-select v-model="query.delivery_status">
              <el-option v-for="o in list_delivery_status" :key="o" :label="o"
                         :value="o">
              </el-option>
            </el-select>
          </el-form-item>
        </el-col>
        <el-col :xs="24" :sm="24" :lg="8" class="el_form_search_wrap">
          <el-form-item label="签收状态">
            <el-select v-model="query.signing_status">
              <el-option v-for="o in list_signing_status" :key="o" :label="o"
                         :value="o">
              </el-option>
            </el-select>
          </el-form-item>
        </el-col>
      </el-row>
      <el-row class="rows row2">

        <el-col :xs="24" :sm="24" :lg="24" class="search_btn_wrap search_btns">

          <el-col :xs="24" :sm="10" :lg="8" class="search_btn_1 search_btn_wrap_1 btns">

            <el-button type="primary" @click="search()" class="search_btn_find">查询</el-button>
            <el-button @click="reset()" style="margin-right: 74px;" class="search_btn_reset">重置</el-button>


            <el-button v-if="$check_action('/logistics_delivery/view', 'del')" class="search_btn_del" type="danger" @click="delInfo()">删除</el-button>

          </el-col>
        </el-col>
      </el-row>

    </el-form>
    <el-table :data="list" @selection-change="selectionChange" @sort-change="$sortChange" style="width: 100%"
              id="dataTable" :key="renderTable">
      <el-table-column fixed type="selection" tooltip-effect="dark" width="55">
      </el-table-column>
      <el-table-column prop="order_number" @sort-change="$sortChange" label="订单号"
                       min-width="200">
      </el-table-column>
      <el-table-column prop="product_name" @sort-change="$sortChange" label="商品名称"
                       min-width="200">
      </el-table-column>
      <el-table-column prop="purchase_quantity" @sort-change="$sortChange" label="购买数量"
                       min-width="200">
      </el-table-column>
      <el-table-column prop="total_transaction_amount" @sort-change="$sortChange" label="交易总额"
                       min-width="200">
      </el-table-column>
      <el-table-column prop="the_date_of_issuance" @sort-change="$sortChange" label="发货日期"
                       min-width="200">
        <template slot-scope="scope">
          {{ $toTime(scope.row["the_date_of_issuance"], "yyyy-MM-dd") }}
        </template>
      </el-table-column>
      <el-table-column prop="delivery_number" @sort-change="$sortChange" label="配送单号"
                       min-width="200">
      </el-table-column>
      <el-table-column prop="contact_name" @sort-change="$sortChange" label="联系人"
                       min-width="200">

      </el-table-column>
      <el-table-column prop="user_id" label="买家" sortable min-width="100">
        <template slot-scope="scope">
          <div>
            {{ list_user.getVal("nickname", {"user_id": scope.row.ordinary_users}) }}
          </div>
        </template>
      </el-table-column>
      <el-table-column prop="shipping_address" @sort-change="$sortChange" label="收货地址"
                       min-width="200">
      </el-table-column>
      <el-table-column prop="delivery_status" @sort-change="$sortChange" label="配送状态"
                       min-width="200">
      </el-table-column>
      <el-table-column prop="signing_status" @sort-change="$sortChange" label="签收状态"
                       min-width="200">
      </el-table-column>


      <el-table-column sortable prop="create_time" label="创建时间" min-width="200">
        <template slot-scope="scope">
          {{ $toTime(scope.row["create_time"], "yyyy-MM-dd hh:mm:ss") }}
        </template>
      </el-table-column>

      <el-table-column sortable prop="update_time" label="更新时间" min-width="200">
        <template slot-scope="scope">
          {{ $toTime(scope.row["update_time"], "yyyy-MM-dd hh:mm:ss") }}
        </template>
      </el-table-column>


      <el-table-column fixed="right" label="操作" min-width="200">


        <template slot-scope="scope">
          <div class="view_a">
            <button class="e-button el-button--small is-plain el-button--success" style="margin: 5px !important;"
                    @click="goTo_('./view?' + field + '=' + scope.row[field])"
                    size="small" v-if="$check_action('/logistics_delivery/view', 'get') || $check_action('/logistics_delivery/view', 'set')">
              <span>详情</span>
            </button>
            <button v-if="scope.row['signing_status'] == '待签收' && ($check_option('/logistics_delivery/table','sign_for'))"
                    class="e-button el-button--small is-plain el-button--success" size="small"
                    style="margin: 5px !important;"
                    @click="changeSigning('logistics_delivery_id=' + scope.row['logistics_delivery_id'], scope.row['signing_status'], scope.$index)">
              签收
            </button>
          </div>
        </template>
      </el-table-column>

    </el-table>

    <!-- 分页器 -->
    <div class="mt text_center">
      <el-pagination @size-change="handleSizeChange" @current-change="handleCurrentChange"
                     :current-page="query.page" :page-sizes="[7, 10, 30, 100]" :page-size="query.size"
                     layout="total, sizes, prev, pager, next, jumper" :total="count">
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
      // 获取数据地址
      url_get_list: "~/api/logistics_delivery/get_list?like=0",
      url_del: "~/api/logistics_delivery/del?",

      // 字段ID
      field: "logistics_delivery_id",

      // 查询
      query: {
        "size": 7,
        "page": 1,
        "delivery_status": "",
        "signing_status": "",
        "login_time": "",
        "create_time": "",
        "orderby": `create_time desc`
      },

      // 数据
      list: [],
      // 配送状态列表
      list_delivery_status: ['待取货', '配送中', '已完成'],
      // 签收状态列表
      list_signing_status: ['待签收', '已签收'],
      list_user: [],
      renderTable: Number(Math.random().toString().substr(3, 12) + Date.now()).toString(36)
    }
  },
  methods: {
    goTo_(url) {
      this.$router.push(url)
    },

    get_list_before(param) {
      var user_group = this.user.user_group;
      if (user_group != "管理员") {
        if (this.$check_option('/goods/table', 'seller')){
          param["merchant_id"] = this.user.user_id;
        }else {
          param["ordinary_users"] = this.user.user_id
        }
      }
      return param;
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
    changeSigning(query, status, index) {
      var url = "~/api/logistics_delivery/set?" + query
      this.list[index]['signing_status'] = status = status == "待签收" ? '已签收' : "待签收"
      this.$post(url, {'signing_status': status}, (json, status) => {
        if (json.result) {
          this.renderTable = Number(Math.random().toString().substr(3, 12) + Date.now()).toString(36)
        } else if (json.error) {
          this.$toast(json.error.message, 'danger');
        } else {
          this.$toast("服务器连接失败！", "danger");
        }
      });
    }
  },
  created() {
    this.get_list_user();
  }
}
</script>

<style type="text/css">
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

.text_center {
  text-align: center;
}
</style>
