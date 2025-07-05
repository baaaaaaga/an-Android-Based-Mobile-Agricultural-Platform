<template>
  <view class="list_goods">
    <view
      v-for="(o, i) in list"
      :key="i"
      class="goods_item"
      @click="goodsClickFn('/pagesA/goods/details?goods_id=' + o[vm.goods_id], o)"
    >
      <view class="image">
        <image :src="$fullImgUrl(o[vm.img])"></image>
      </view>

      <view>
        <view class="title">
          {{ o[vm.title] }}
        </view>
		<view class="desc">{{ o[vm.description] }}</view>
      </view>
      <view class="bottom">
		    <view class="price"><text>￥</text>{{ o[vm.price] | keepTwoNum }} </view>
	        <view class="price_ago"> ￥{{ o[vm.price_ago] | keepTwoNum }} </view>
      </view>
	  <view class="info">
	  	<view class="sales">销量<text>{{ o[vm.sales] }}</text></view>
	  	<view class="inventory">库存<text>{{ o[vm.inventory] }}</text></view>
	  </view>
	  <view class="operation">
	  	<view class="add_cart" v-if="$check_cart_page('/' + o.source_table + '/details')" @click.native.stop="add_cart(o)">
	  		<image src="@/static/img/cart_b.png"></image>
	  	</view>
	  </view>
    </view>
  </view>
</template>

<script>
import { setGoodsApi } from '@/api/goods';
import { getCartListApi, setCartApi, addCartApi } from '@/api/cart';

import mixin from '@/libs/mixins/component.js';
export default {
  mixins: [mixin],
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
          goods_id: 'goods_id',
          img: 'img',
          title: 'title',
		  description: 'description',
          price: 'price',
          price_ago: 'price_ago',
          sales: 'sales',
          hits: 'hits',
          source_table: 'source_table',
		  inventory: 'inventory',
        };
      },
    },
    span: {
      type: Number,
      default: 2,
    },
  },
  data() {
    return {};
  },
  methods: {
    nav_goods_details(goods_id) {
      this.$u.router('/pagesA/goods/details?goods_id=' + goods_id);
    },
    /**
     * 添加购物车
     */
    add_cart(obj) {
      var { title, img, price, price_ago, num_buy: num, description, goods_id, type } = obj;
      var body = {
        title,
        img,
        price,
        price_ago,
        num,
        price_count: price,
        description,
        goods_id,
        type,
        user_id: this.userInfo.user_id,
      };
      body.num = 1;
      getCartListApi({
        goods_id: obj.goods_id,
        user_id: body.user_id,
      }).then((res) => {
        if (res.result.count) {
          var { cart_id, num, price, price_count } = res.result.list[0];
          num += 1;
          price_count += price;

          setCartApi(cart_id, {
            num,
            price,
            price_count,
          }).then((res) => {
            this.$toast('已加入购物车', 'success');
            console.log('更改值');
          });
        } else {
          addCartApi(body).then((res) => {
            this.$toast('已加入购物车', 'success');
          });
        }
      });
    },
    goodsClickFn(url, o) {
      setGoodsApi(o.goods_id, {
        hits: parseInt(o.hits) + 1,
      }).then((res) => {
        console.log(res);
        if (res.result) {
          uni.navigateTo({
            url,
          });
        } else {
          this.$toast(res.error.message);
        }
      });
    },
  },
  filters: {
    //过滤器 保留两位
    keepTwoNum: function (value) {
      value = Number(value);
      return value.toFixed(2);
    },
  },
};
</script>

<style lang="scss" scoped>
@import 'styles/components/index.scss';
</style>
