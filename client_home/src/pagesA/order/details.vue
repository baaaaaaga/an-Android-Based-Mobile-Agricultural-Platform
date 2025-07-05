<template>
  <view id="page_order_details" :style="{ paddingTop: vuex_custom_bar_height + 'px' }">
    <tn-nav-bar>订单详情</tn-nav-bar>
    <view class="page_order_details" id="order_details">
      <!-- 订单细节模块(开始) -->

      <view v-if="$check_action('/order/details', 'get')">
        <view class="order-state">
          {{ state }}
        </view>
        <view class="contact-info">
          <view class="info">
            <uni-icons class="icon-address" size="16" type="location-filled"> </uni-icons>
            <text class="name">{{ contact_name }}</text>
            <text class="phone"> {{ contact_phone }}</text>
          </view>
          <text class="address-info">{{ contact_address }}</text>
        </view>

        <view class="goods-list" v-for="(obj, idx) in list" :key="idx">
          <view
            @click="$navTo('/pagesA/order/details?order_number=' + o.order_number)"
            class="goods-item"
          >
            <view class="goods-img">
              <image
                :src="$fullImgUrl(obj.img) || '../../static/img/default.png'"
                mode="scaleToFill"
              >
              </image>
            </view>
            <view class="goods-info">
              <view class="title text-ellipsis-2">
                {{ obj.title }}
              </view>
              <view class="total-info">
			  				<view class="price"> ￥{{ obj.price }} </view>
			                  <view class="num"> ×{{ obj.num }} </view>
              </view>
            </view>
          </view>
        </view>

		<view class="cell coupon" v-if="state === '待付款' ">
          <view class="label"> 优惠券</view>
          <view class="value">
            <view v-if="use_coupon_list.length > 0" @click="showCoupon = true">
              {{ selected_coupon_index[0]==0 ? '请选择优惠券' : use_coupon_list[selected_coupon_index[0]].coupon_name }}
            </view>

            <view v-else>无可使用的优惠券</view>
            <tn-picker
              :range="use_coupon_list"
              mode="selector"
              rangeKey="coupon_name"
              v-model="showCoupon"
              :defaultSelector="defaultSelector"
              @confirm="bindPickerChange"
            ></tn-picker>
          </view>
        </view>
        <view class="cell total">
          <view class="label">需付款</view>
          <view class="value">￥{{ sum_price }}</view>
        </view>
        <view class="cell order_no">
          <view class="label">订单编号：</view><view class="value">{{ order_number }}</view>
        </view>
        <view class="cell create_time">
          <view class="label">下单时间：</view><view class="value">{{ create_time }}</view>
        </view>
        <view class="cell remark border-none">
          <view class="label">订单备注：</view>
          <view class="value">
            <view class="textarea-wrap" v-if="state === '待付款'">
              <tn-input
                v-model="remark"
                type="textarea"
                :border="true"
                :height="100"
                :autoHeight="true"
              />
            </view>
            <text v-else>{{ remark }}</text>
          </view>
        </view>
		<view class="pay-wrap" v-if="$check_action('/order/details', 'set')">
		  <view class="me-btn btn-pay" v-if="state === '待付款'" @click="goto_pay()"> 
			去支付
		  </view>
		</view>
      </view>
    </view>

    <!-- 订单细节模块(结束) -->
    <view class="pay-model" v-if="!!model">
      <view class="mask" @click="closemodel"></view>
      <view class="pay-model-inn">
        <view class="pay_tab">
          <view
                  @click="choosepayway(idx)"
                  v-for="(obj, idx) in payway"
                  :key="idx"
                  :class="['pay_tab_one', paywayact == idx ? 'pay_tab_one_act' : '']"
          >{{ obj.name }}</view
          >
        </view>
        <view v-if="payway[paywayact].id == 3" class="inclued_pay_image">
          <view style="margin-bottom: 20rpx">
            <view style="width: 100%; margin: 0 auto; margin-top: 30px" class="account">
              <view style="width: 80%; margin: 0 auto">
                <view style="line-height: 40px">请输入网银账号：</view>
              </view>
              <view style="width: 80%; margin: 0 auto">
                <uni-easyinput v-model="pay_obj.account" placeholder="请输入网银账号" />
              </view>
            </view>
            <view style="width: 100%; margin: 0 auto; margin-top: 20px" class="password">
              <view style="width: 80%; margin: 0 auto">
                <view style="line-height: 40px">请输入支付密码，6位数字：</view>
              </view>
              <view style="width: 80%; margin: 0 auto">
                <uni-easyinput
                  placeholder="请输入密码"
                  type="password"
                  v-model="pay_obj.password"
                  maxlength="6"
                />
              </view>
            </view>
          </view>
        </view>
	        <view v-else class="inclued_pay_image">
            <image mode="widthFix" class="pay_image" :src="payway[paywayact].url"></image
          ></view>
          <view class="tn-flex tn-flex-col-center tn-flex-row-center">
            <button class="me-btn assure-btn" type="primary" @click="submit_pay">
              确认支付
            </button></view
          >
        </view>
      </view>
    </view>
  </view>
</template>

<script>
import { getOrderListApi } from '@/api/order';
export default {
  data() {
    return {
      query: {
        order_number: '',
      },
      contact_name: '',
      contact_phone: '',
      contact_address: '',
      order_number: '',
      create_time: '',
      state: '',
      remark: '',
      paywayact: 0,
      model: false,
      pay_obj: {
        payActiveName: '微信',
        account: '',
        password: '',
        id: '',
      },
      defaultSelector: [0],
      selected_coupon_index: [0],
      use_coupon_list: [],
      coupon_list: [],
      showCoupon: false,
	  coupon_price: 0,
      list: [],
	  // 支付方式
	  payway: [
	    { name: "微信", url: "/static/img/wx.png", id: 1 },
	    { name: "支付宝", url: "/static/img/aplipay.png", id: 2 },
	    { name: "其他", url: "", id: 3 },
	  ],
    };
  },
  onLoad(options) {
    this.query.order_number = options.order_number;
    this.getOrderList();
  },
  methods: {
    /**
     * 获取订单列表数据
     */
    getOrderList() {
      getOrderListApi(this.query)
        .then((res) => {
          this.list = res.result.list;
          let {
            contact_name,
            contact_phone,
            contact_address,
            order_number,
            create_time,
            state,
            remark,
          } = this.list[0];
          this.contact_name = contact_name;
          this.contact_phone = contact_phone;
          this.contact_address = contact_address;
          this.order_number = order_number;
          if (create_time && JSON.stringify(create_time).indexOf('-') === -1) {
            this.create_time = this.$toTime(create_time, 'yyyy-MM-dd hh:mm:ss');
          } else {
            this.create_time = create_time;
          }
          this.state = state;
          this.remark = remark;
          this.get_list_after();
        })
        .catch(() => {});
    },
    choosepayway(idx) {
      this.paywayact = idx;
    },
    async get_list_after() {
      await this.get_coupon_user_list();

      let tempCouponlist = JSON.parse(JSON.stringify(this.coupon_list));
      tempCouponlist = tempCouponlist.map((item) => {
        return {
          ...item,
          sum: 0,
        };
      });
      tempCouponlist.forEach((item) => {
        this.list.forEach((goods) => {
          if (goods.merchant_id === item.coupon_user_id || item.coupon_user_auth === '管理员') {
            item.sum += goods.price_count;
          }
        });
      });

      const now = new Date().getTime();
      for (let i = 0; i < tempCouponlist.length; i++) {
        if (tempCouponlist[i].coupon_id) {
          const time = tempCouponlist[i].coupon_time.split(',');

          const start = new Date(time[0]);
          const end = new Date(time[1]);
          const is_effective = start <= now && now <= end;

          if (
            tempCouponlist[i].sum < tempCouponlist[i].coupon_price ||
            !is_effective ||
            tempCouponlist[i].is_use == 1
          ) {
            tempCouponlist.splice(i, 1);
            --i;
          }
        }
      }

      this.use_coupon_list = tempCouponlist;
      this.use_coupon_list.unshift({
        coupon_name: '选择优惠券',
        coupon_id: '',
        coupon_price1: 0,
        id: 0
      })
    },
    closemodel() {
      //关闭选择支付方式
      this.model = false;
    },
    /**
     * 打开支付
     */
    goto_pay() {
	  //打开选择支付方式
	  this.model = true;
	      },
    async update_order_price_count(o) {
	  if (this.coupon_price > 0) {
	    await this.$post(
	      '~/api/order/set?order_id=' + o.order_id,
	      {
	        price_count: o.price_count,
	      },
	      (res) => {
	        if (res.result) {
	          console.log(res);
	        } else if (res.error) {
	          this.$toast(res.error.message);
	          console.log(res.error);
	        }
	      }
	    );
	  }
    },
    async update_goods_inventory(o) {
      await this.$get('~/api/goods/get_obj?', { goods_id: o.goods_id }, (json) => {
        if (json.result && json.result.obj) {
          let inventory = { inventory: json.result.obj.inventory - o.num };
		  let data = {
		  	inventory: json.result.obj.inventory - o.num,
		  	sales: json.result.obj.sales + o.num
		  }
          this.$post('~/api/goods/set?goods_id=' + o.goods_id, data, (res) => {
            if (
              res.result &&
              json.result.obj.source_table &&
              json.result.obj.source_field &&
              json.result.obj.source_id
            ) {
              let inventory_sub = { cart_inventory: inventory.inventory };
              this.$post(
                '~/api/' +
                  json.result.obj.source_table +
                  '/set?' +
                  json.result.obj.source_field +
                  '=' +
                  json.result.obj.source_id,
                inventory_sub,
                (res_sub) => {
                  console.log(res_sub);
                }
              );
            }
          });
        }
      });
    },
    /**
     * 支付
     */
    submit_pay() {
      var _this = this;
	  if( _this.payway[_this.paywayact].id == 3){
	    const passwordRegex = /^\d{6}$/;
	   if(!_this.pay_obj.account){
	    return this.$toast('请输入网银账号');
	   }else if(!passwordRegex.test(_this.pay_obj.password)){
	    return this.$toast('网银密码格式为6位数字');
	   }
	  }
	  
      let params = {
        state: '已付款',
        remark: _this.remark,
      }
      this.$post(
        '~/api/order/set?order_number=' + this.order_number,
        params,
        (res) => {
          if (res.result) {
            //修改数量
            for (let i = 0; i < _this.list.length; i++) {
              _this.update_order_price_count(_this.list[i]);
              _this.update_goods_inventory(_this.list[i]);
            }
            _this.$toast('支付成功');
			if(this.selected_coupon_index[0] != 0){
				const id = this.use_coupon_list[this.selected_coupon_index[0]].id;
				if (id) {
				  this.$post('~/api/coupon_user/set?id=' + id, {
					is_use: 1,
				  });
				}
			}
            setTimeout(() => {
              _this.$nav('/pagesA/order/details?order_number='+this.order_number);
            }, 700);
          } else if (res.error) {
            _this.$toast(res.error.message);
            console.log(res.error);
          }
        }
      );
    },
    /**
     *  当前用户的优惠券
     */
    async get_coupon_user_list() {
      const result = await this.$get('~/api/coupon_user/get_list', {
        user_id: this.userInfo.user_id,
        is_use: 0,
      });

      for (let i = 0; i < result.result.list.length; i++) {
        const res = await this.$get('~/api/coupon/get_obj', {
          coupon_id: result.result.list[i].coupon_id,
        });

        this.coupon_list.push({
          ...res.result.obj,
          id: result.result.list[i].id,
          is_use: result.result.list[i].is_use,
        });
      }
    },
    /**
     *  选择优惠券
     */
    bindPickerChange(v) {
      this.selected_coupon_index = v;
    },
  },
  computed: {
    sum_price() {
      var sum_price = 0;
      this.list.map((o) => (sum_price += parseFloat(o.price_count)));
      let coupon_price = 0;
      if (this.use_coupon_list && this.use_coupon_list.length>0){
        const coupon_id = this.use_coupon_list[this.selected_coupon_index[0]].coupon_id
        for (let i = 0; i < this.use_coupon_list.length; i++) {
          if (coupon_id == this.use_coupon_list[i].coupon_id) {
            coupon_price = this.use_coupon_list[i].coupon_price1
			this.coupon_price = coupon_price
          }
        }
      }
      this.list.map((o) => {
        if (coupon_price>0){
          o.price_count = (o.price_count - ((o.price_count/sum_price)*coupon_price)).toFixed(2);
        }
      });
      sum_price = 0;
      this.list.map((o) => (sum_price += parseFloat(o.price_count)));
      return sum_price.toFixed(2);
    },
    /**
     * 计算原价
     */
    sum_price_ago() {
      var sum_price_ago = 0;
      this.list.map((o) => (sum_price_ago += parseFloat(o.price) * parseInt(o.num)));
      return sum_price_ago.toFixed(2);
    },
  },
};
</script>
<style lang="scss" scoped>
@import 'styles/pagesA/index.scss';
</style>
