<template>
  <view class="page_logistics_delivery_table" :style="{ paddingTop: vuex_custom_bar_height + 'px' }">
    <tn-nav-bar>订单配送列表</tn-nav-bar>
    <view class="logistics_delivery_wrapper" id="page_diy_table">
      <!-- 筛选模块(开始) -->
      <view class="search-wrap">
        <!-- 搜索栏 -->
        <uni-forms :modelValue="query" labelWidth="70px">
          <uni-forms-item label="配送状态" name="delivery_status">
            <uni-data-select
              placeholder="请选择"
              v-model="query['delivery_status']"
              :localdata="list_delivery_status"
            ></uni-data-select>
          </uni-forms-item>
          <uni-forms-item label="签收状态" name="signing_status">
            <uni-data-select
              placeholder="请选择"
              v-model="query['signing_status']"
              :localdata="list_signing_status"
            ></uni-data-select>
          </uni-forms-item>
        </uni-forms>
        <!-- /搜索栏 -->
        <view class="search-btn-wrap">
          <view class="me-btn btn-reset" @click="reset()"> 重置 </view>
          <view class="me-btn btn-search" @click="search_()"> 查询 </view>

          <view class="clear"></view>
        </view>
		<view class="toolbar">
		  <view
		    class="me-btn btn-add"
		    @click="$navTo('/pages/logistics_delivery/view?')"
		    v-if="user_group == '管理员' || $check_option('/goods/table', 'seller')"
		    >添加
		  </view>
		</view>
      </view>
      
      <!-- 列表 -->
      <view class="list-wrap">
        <view class="list">
          <view v-for="(o, i) in list" :key="i" class="list-item">
            <view class="item-row">
              <view class="label" v-if="true">
                <span>商品名称</span>
              </view>
              <view class="value">
                <text>
                  {{ o['product_name'] }}
                </text>
              </view>
            </view>
            <view class="item-row">
              <view class="label" v-if="true">
                <span>配送状态</span>
              </view>
              <view class="value">
                <text>
                  {{ o['delivery_status'] }}
                </text>
              </view>
            </view>

            <view class="item-row">
              <view class="label" v-if="true">
                <span>签收状态</span>
              </view>
              <view class="value">
                <text>
                  {{ o['signing_status'] }}
                </text>
              </view>
            </view>
            <view class="item-row">
              <text class="value">
                {{ $toTime(o['create_time'], 'yyyy-MM-dd hh:mm:ss') }}
              </text>
            </view>

            <view class="operate-bar">
              <view
                width="100%"
                class="me-btn btn-info"
                v-if="
                  userGroup == '管理员' ||
                  $check_action('/logistics_delivery/view', 'set') ||
                  $check_action('/logistics_delivery/view', 'get')
                "
                @click="$navTo('/pages/logistics_delivery/view?' + field + '=' + o[field])"
              >
                详情
              </view>
              <view
                class="me-btn btn-delete"
                v-if="
                  userGroup == '管理员' ||
                  $check_action('/logistics_delivery/table', 'del') ||
                  $check_action('/logistics_delivery/view', 'del')
                "
                @click="delInfo(i)"
              >
                删除
              </view>
              <view
                width="100%"
                class="me-btn btn-sign"
                @click="
                  changeSigning(
                    'logistics_delivery_id=' + o['logistics_delivery_id'],
                    o['signing_status'],
                    i
                  )
                "
                v-if="
                  userGroup == '管理员' ||
                  (o['signing_status'] == '待签收' &&
                    $check_option('/logistics_delivery/table', 'sign_for'))
                "
              >
                签收
              </view>
            </view>
          </view>
        </view>
      </view>
      <!-- /列表 -->
      <!-- 分页器 -->
      <uni-pagination
        class="pager"
        show-icon="true"
        :total="count"
        :pageSize="query.size"
        :current="query.page"
        @change="page_change"
      ></uni-pagination>
      <!-- /分页器 -->
    </view>
  </view>
</template>
<script>
import mixin from '@/libs/mixins/page.js';

export default {
  mixins: [mixin],
  data() {
    return {
      // 获取数据地址
      url_get_list: '~/api/logistics_delivery/get_list?like=0',
      url_del: '~/api/logistics_delivery/del?',

      // 字段ID
      field: 'logistics_delivery_id',

      // 查询
      query: {
        size: 7,
        page: 1,
        store_name: '',
        delivery_status: '',
        signing_status: '',
        login_time: '',
        create_time: '',
      },

      // 数据
      list: [],
      // 配送状态列表
      list_delivery_status: [{ value: '', text: '全部' }],
      // 签收状态列表
      list_signing_status: [{ value: '', text: '全部' }],
    };
  },
  methods: {
    search_() {
      this.query.page = 1;
      this.get_list();
    },
    /**
     * 重置
     */
    reset: function reset() {
      uni.clear(this.query);
      uni.push(this.query, this.config);
      this.get_list();
    },
    get_list_before(param) {
      var user_group = this.userInfo.user_group;
      if (user_group != '管理员') {
        // if (this.$check_option('/goods/table', 'seller')){
        //   param["merchant_id"] = this.user.user_id;
        // }else {
        param['ordinary_users'] = this.user.user_id;
        // }
      }
      return param;
    },
    delInfo(v) {
      let _this = this;
      uni.showModal({
        title: '删除',
        content: '此操作将永久删除该文件, 是否继续?',
        success: function (res) {
          if (res.confirm) {
            let list = [v];
            _this.delAll(list);
          } else if (res.cancel) {
            console.log('用户点击取消');
          }
        },
      });
    },
    /**
     * 获取配送状态列表
     */
    async get_list_delivery_status() {
      ['待取货', '配送中', '已完成'].map((o) =>
        this.list_delivery_status.push({ value: o, text: o })
      );
    },
    /**
     * 获取签收状态列表
     */
    async get_list_signing_status() {
      ['待签收', '已签收'].map((o) => this.list_signing_status.push({ value: o, text: o }));
    },
    changeSigning(query, status, index) {
      var url = '~/api/logistics_delivery/set?' + query;
      this.list[index]['signing_status'] = status = status == '待签收' ? '已签收' : '待签收';
      this.$post(url, { signing_status: status }, (json, status) => {
        if (json.result === 0 || json.result) {
          // this.renderTable = Number(Math.random().toString().substr(3,12) + Date.now()).toString(36)
        } else if (json.error) {
          this.$toast(json.error.message, 'danger');
        } else {
          this.$toast('服务器连接失败！', 'danger');
        }
      });
    },
  },
  created() {
    // 初始化配送状态列表
    this.get_list_delivery_status();
    // 初始化签收状态列表
    this.get_list_signing_status();
  },
};
</script>
<style lang="scss" scoped>
@import 'styles/pages/index.scss';
</style>
