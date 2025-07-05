<template>
  <view :style="{ paddingTop: vuex_custom_bar_height + 'px' }">
    <tn-nav-bar>我的订单</tn-nav-bar>

    <view class="page_order_list" id="order_list">
      <view class="top-warp">
		<Search v-model="query.title" placeholder="查询订单" @search="search_" @cancel="cancel" />
        <!-- <me-search @search="searchData"></me-search> -->
        <me-tabs v-model="tabIndex" :tabs="tabs" @change="tabChange" :height="80"></me-tabs>
      </view>
      <view class="order-list">
        <view class="order-item" v-for="(o, i) in list" :key="i">
          <view class="header" style="">
            <view class="state">{{ o.state }}</view>
          </view>
          <view class="goods-list" v-for="(obj, idx) in o.list" :key="idx">
	            <view
              @click="$navTo('/pagesA/order/details?order_number=' + o.order_number)"
              class="goods-item"
            >
	              <view class="goods-img">
                <image
                  :src="$fullImgUrl(obj[vm.img]) || '../../static/img/default.png'"
                  mode="scaleToFill"
                >
                </image>
              </view>
              <view class="goods-info">
                <view class="title text-ellipsis-2">
                  {{ obj[vm.title] }}
                </view>
                <view class="time">
                  <text>订单提交成功</text>
                  <text>{{ $toTime(o.create_time, 'yyyy-MM-dd hh:mm:ss') }}</text>
                </view>
              </view>

              <view class="right-info">
	                <view class="price"> ￥{{ obj[vm.price] }} </view>
	                <view class="num"> ×{{ obj[vm.num] }} </view>
              </view>
            </view>
          </view>

          <view class="footer">
            <view class="sum-price">
              <text>{{ o.state == '待付款' ? '需付款' : '实付' }}：</text>
	              <text class="price">￥{{ o.sum_price.toFixed(2) }}</text>
	            </view>

            <view class="btn-wrap">
			  <view
			    width="100%"
			    @click="cancel_order(o.order_number, i)"
			    v-if="o.state == '待付款'" 
			    class="me-btn btn-cancel"
			    >取消订单</view
			  >
	              <view
                width="100%"
                @click="del_order(o.order_number, i)"
                v-if="$check_action('/order/list', 'del')"
                class="me-btn btn-del"
                >删除订单</view
              >
            </view>
          </view>
        </view>
      </view>
    </view>
  </view>
</template>

<script>
import MescrollMixin from '@/uni_modules/mescroll-uni/components/mescroll-uni/mescroll-mixins.js';
import Search from '@/components/businessCp/search.vue';
import { getOrderListApi } from '@/api/order';
export default {
  mixins: [MescrollMixin],
  components: {
	Search
  },
  data() {
    return {
      query: {
        user_id: '',
        state: '',
        like: 0,
      },
      vm: {
        order_number: 'order_number',
        title: 'title',
        img: 'img',
        price: 'price',
        price_ago: 'price_ago',
        price_count: 'price_count',
        num: 'num',
        goods_id: 'goods_id',
        description: 'description',
        contact_name: 'contact_name',
        contact_phone: 'contact_phone',
        contact_address: 'contact_address',
        postal_code: 'postal_code',
        user_id: 'user_id',
        state: 'state',
      },
      list: [],
      tabs: [
        {
          name: '全部',
          type: '1',
        },
        {
          name: '待付款',
          type: '2',
          state: '待付款',
        },
        {
          name: '已付款',
          type: '3',
          state: '已付款',
        },
		{
		  name: '已取消',
		  type: '4',
		  state: '已取消',
		},
      ],
      tabIndex: 0,
    };
  },
  onLoad(e) {
    this.query.user_id = this.userInfo.user_id;
    /*#ifdef H5 || APP-PLUS*/
    let type = this.$route.query.type;
    /*#endif*/
    /*#ifdef  MP-WEIXIN*/
    let type = e.type;
    /*#endif*/
    if (type){
      this.tabIndex = parseInt(type)
    }
    this.getOrderList();
  },
  methods: {
    /**
     * 获取订单列表数据
     */
    getOrderList() {
      let curTab = this.tabs[this.tabIndex];
      let state = curTab.state;

      if (state) {
        this.query.state = state;
      }
      getOrderListApi(this.query)
        .then((res) => {
          this.list = this.get_list_after(res.result.list);
        })
        .catch(() => {});
    },
    // 切换菜单
    tabChange() {
      if (this.tabIndex === 1) {
        this.query.state = '待付款';
      } else if (this.tabIndex === 2) {
        this.query.state = '已付款';
      } else {
        delete this.query.state;
      }
      this.list = []; // 先置空列表,显示加载进度
      this.getOrderList();
    },
    // 删除订单
    del_order(order_number, i) {
      this.$get(
        '~/api/order/del',
        {
          order_number,
        },
        (res) => {
          this.list.splice(i, 1);
        }
      );
    },
	// 取消订单
	cancel_order(order_number, i) {
	  var _this = this;
	  uni.showModal({
	    title: '取消订单',
	    content: '是否要取消订单?',
	    success: async (res) => {
	      if (res.confirm) {
	        _this.$post(
	          "~/api/order/set?order_number=" + order_number,
	          {
	            state: "已取消",
	          },
	          (res) => {
	            _this.$toast('取消订单成功！', 'success');
	            _this.list[i].state = "已取消"
	          }
	        );
	      } else if (res.cancel) {
	        console.log('用户点击取消');
	      }
		},
	  })
	},
    /**
     * 搜索
     */
	search_() {
	  this.query.page = 1;
	  this.get_list();
	},
	cancel() {
	  console.log('eer');
	  this.query.title = '';
	  this.search_();
	},
    searchData(v) {
      this.query.page = 1;
      this.query.title = v;
      this.getOrderList();
    },
    input(e, key) {
      this.query[key] = e;
    },
    // 改变分类标签
    changeTab(val) {
      if (val === '全部') {
        this.query.state = '';
      } else {
        this.query.state = val;
      }
      this.search_();
    },
    get_list_before(param) {
      param.user_id = this.userInfo.user_id;
      return param;
    },
    get_list_after(list) {
      // 根据订单号区分列表
      let list_diff = [];
      let order_num = '';
      let index = -1;

      list.map((o) => {
        if (o.order_number === order_num) {
          list_diff[index]['list'].push(o);
          list_diff[index]['sum_price'] =
            parseFloat(o.price_count) + parseFloat(list_diff[index]['sum_price']);
        } else {
          index += 1;
          order_num = o.order_number;
          list_diff[index] = {};
          var obj_diff = list_diff[index];
          obj_diff['create_time'] = o.create_time;
          obj_diff['order_number'] = order_num;
          obj_diff['list'] = [];
          obj_diff['list'].push(o);
          obj_diff['sum_price'] = o.price_count;
          obj_diff['state'] = o.state;
        }
      });
      return list_diff;
    },
  },
};
</script>
<style lang="scss" scoped>
@import 'styles/pagesA/index.scss';
</style>
