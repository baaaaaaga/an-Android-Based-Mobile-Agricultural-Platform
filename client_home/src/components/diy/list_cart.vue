<template>
  <view class="list_cart">
    <view class="goods-list">
      <view class="tis" v-if="list.length == 0">购物车是空的哦~</view>
      <view class="row" v-for="(row, index) in list" :key="index">
        <!-- 商品 -->
        <view class="carrier">
          <!-- checkbox -->
          <view class="checkbox-box" @click="select_func(index)">
            <view class="checkbox">
              <view :class="[row.selected ? 'on' : '']"></view>
            </view>
          </view>
          <!-- 商品信息 -->
          <view class="goods-info">
            <view class="img">
              <image :src="$fullImgUrl(row[vm.img])" mode="scaleToFill"></image>
            </view>
            <view class="info">
              <view class="base">
                <view class="title">{{ row[vm.title] }}</view>
                <view
                    class="del-goods"
                    @click="del_cart(row, index)"
                    v-if="$check_action('/cart/list', 'del')"
                >
                  <uni-icons type="trash"></uni-icons>
                </view>
              </view>
              <view class="price-number">
                <view class="price-box"
                >
                  <view class="price">￥{{ row.price }}</view>
                  <view class="price-old">￥{{ row.price }}</view>
                </view
                >
                <view class="number" v-if="$check_action('/cart/details', 'set')">
                  <view class="sub" @click="change_num('sub', index, row)">
                    <view class="icon">-</view>
                  </view>
                  <view class="input" @tap.stop="discard">
                    <input type="number" v-model="row['num']"/>
                  </view>
                  <view class="add" @click="change_num('add', index, row)">
                    <view class="icon">+</view>
                  </view>
                </view>
              </view>
            </view>
          </view>
        </view>
      </view>
    </view>
    <!-- 脚部菜单 -->
    <view class="footer">
      <view class="checkbox-box" @click="select_all">
        <view class="checkbox">
          <view :class="[select_all_flag ? 'on' : '']"></view>
        </view>
        <view class="text">全选</view>
      </view>
      <!-- <view class="delBtn" @tap="deleteList" v-if="selectedList.length > 0">删除</view> -->
      <view class="settlement">
        <view class="sum"
        >合计:
          <view class="money">￥{{ sum_price() }}</view>
        </view>
        <view class="btn" @click="settle_all">结算</view>
      </view>
    </view>
  </view>
</template>

<script>
import {setCartApi, deleteCartGoodsNumberApi, createOrderApi, deleteCartApi} from '@/api/cart';

import {getGoodsInfoApi} from '@/api/goods';

import {getUserAddressApi} from '@/api/address';
export default {
  props: {
    list: {
      type: Array,
      default: function () {
        return [];
      },
    },
    vm: {
      type: Object,
      default: function () {
        return {
          cart_id: 'cart_id',
          title: 'title',
          img: 'img',
          user_id: 'user_id',
          state: 'state',
          price: 'price',
          price_ago: 'price_ago',
          price_count: 'price_count',
          num: 'num',
          goods_id: 'goods_id',
          description: 'description',
          selected: 'selected',
        };
      },
    },
  },
  watch: {
    list: {
      handler(value) {
        this.select_all_flag = false;
      },
      deep: true,
    },
  },
  data() {
    return {
      select_all_flag: false,
      vip_discount: 0,
    };
  },
  computed: {},
  mounted() {
    this.vip_discount = this.userInfo.vip_discount;
    this.select_all_flag = false;
  },
  methods: {
    sum_price() {
      var sum_price = 0;
      this.list.map((o) => {
        if (o.selected) {
          sum_price += o.price_count;
        }
      });
      return sum_price.toFixed(2);
    },
    selectedAll() {
      return this.list.every((o) => o.selected);
    },
    change_num(type, idx, obj) {
      let num = obj['num'];
      console.log(num);

      if (type == 'add') {
        if (num > 998) {
          return;
        }
        num++;
      } else {
        if (num < 2) {
          return;
        }
        num--;
      }
      // const num = Number(arr[0]);
      obj.num = num;
      const data = {
        num,
        price: obj.price,
        price_count: obj.price * num,
      };
      setCartApi(obj.cart_id, data).then((res) => {
        this.list.map((o) => {
          if (o.cart_id === obj.cart_id) {
            o.price_count = num * obj.price;
          }
        });
      });
    },
    del_cart(o, i) {
      deleteCartGoodsNumberApi(o.cart_id).then((res) => {
        this.list.splice(i, 1);
      });
    },
    // 选择
    select_func(i) {
      this.list[i].selected = !this.list[i].selected;
      this.$set(this.list, i, this.list[i]);
      setTimeout(() => {
        this.select_all_flag = this.selectedAll();
      }, 0);
    },
    // 全选
    select_all() {
      if (this.selectedAll()) {
        this.list.map((o) => {
          o.selected = false;
        });

        this.$nextTick(() => {
          this.select_all_flag = false;
        });
      } else {
        this.list.map((o) => {
          o.selected = true;
        });
        this.$nextTick(() => {
          this.select_all_flag = true;
        });
      }
    },
    // 根据当前时间和随机数生成流水号
    order_code() {
      var orderCode = '';
      for (
          var i = 0;
          i < 6;
          i++ //6位随机数，用以加在时间戳后面。
      ) {
        orderCode += Math.floor(Math.random() * 10);
      }
      orderCode = new Date().getTime() + orderCode; //时间戳，用来生成订单号。
      return orderCode;
    },
    // 单个结算
    async settle_one(obj, index, order_number) {
      // 获取被选中的商品
      let {
        title,
        img,
        price,
        price_ago,
        price_count,
        num,
        type,
        goods_id,
        description,
        user_id,
        cart_id,
      } = obj;

      // 获取联系方式
      var address_promise = new Promise((resolve, reject) => {
        getUserAddressApi({
          user_id,
          default: 1,
        }).then((res) => {
          if (res.result && res.result.obj) {
            resolve(res.result.obj);
          } else {
            this.$toast('地址未添加');
            return;
          }
        });
      }).catch((e) => {
      });
      const {
        name: contact_name,
        phone: contact_phone,
        address: contact_address,
        postcode: postal_code,
      } = await address_promise;
      // 请求参数
      if (this.vip_discount > 0) {
        price_count = price_count * this.vip_discount;
      }
      var body = {
        order_number,
        title,
        img,
        price,
        price_ago: price_ago,
        price_count: price_count,
        num,
        type,
        goods_id,
        description,
        contact_name,
        contact_phone,
        contact_address,
        postal_code,
        user_id,
        merchant_id: obj.merchant_id,
        vip_discount: this.vip_discount,
      };
      // 发送添加订单请求
      await new Promise((resolve, reject) => {
        createOrderApi(body).then((res) => {
          if (res.result) {
            this.$toast('加入订单成功');
            resolve();
          }
        });
      }).catch((e) => {
      });
      // 删除购物车
      await new Promise((resolve, reject) => {
        deleteCartApi(cart_id).then((res) => {
          if (res.result) {
            this.list.splice(index, 1);
            resolve();
          }
        });
      });
    },
    // 选中的结算
    async settle_all() {
      //查询数据
      let select_flag = true;
      // 查询库存
      let flag = false;
      for (let i = 0; i < this.list.length; i++) {
        if (this.list[i].selected) {
          select_flag = false;
          const goods_id = this.list[i].goods_id;
          const goods_json = await getGoodsInfoApi(goods_id);

          if (goods_json.result && goods_json.result.obj) {
            if (this.list[i].num > goods_json.result.obj.inventory) {
              flag = true;
              this.$toast('库存不足');
              break;
            } else {
              this.list[i].merchant_id = goods_json.result.obj.user_id;
            }
          }
        }
      }
      if (flag) {
        return;
      }
      if (select_flag){
        this.$toast("请先选中数据");
        return;
      }
      // 生成订单号
      var order_number = this.order_code();
      // 选出选中的物品
      var list_settle = this.list.map(async (o, i) => {
        if (o.selected) {
          await this.settle_one(o, i, order_number);
          this.$nav('/pagesA/order/details?order_number=' + order_number);
        }
      });
    },
    // 判断是否在微信小程序
    is_wx_env() {
      // 判断是否在微信小程序中打开
      var ua = window.navigator.userAgent.toLowerCase();

      var bool = false;
      if (ua.match(/MicroMessenger/i) == 'micromessenger') {
        //判断是否是微信环境
        //微信环境下
      }
      return bool;
    },
  },
};
</script>

<style lang="scss" scoped>
@import 'styles/components/index.scss';
</style>
