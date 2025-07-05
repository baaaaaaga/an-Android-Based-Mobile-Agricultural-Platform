<template>
  <view id="page_goods_list" class="page_goods_list" :style="{ paddingTop: vuex_custom_bar_height + 'px' }">
    <tn-nav-bar>产品展示</tn-nav-bar>

    <view class="search-wrapper">
      <Search
        v-model="query.title"
        placeholder="搜索产品"
        @input="(val) => inputValue(val, 'title')"
        @search="search_"
        @cancel="cancel"
      />
    </view>
    <view class="goods-wrapper">
      <scroll-view scroll-y class="left-aside">
        <!-- :class="{ active: index === selected }" -->
        <view
          v-for="(item, index) in types"
          :key="item.id"
          class="f-item"
          :class="{ active: index === selected }"
          @click="searchType(item, index)"
        >
          {{ item.text }}
        </view>
      </scroll-view>
      <scroll-view scroll-with-animation scroll-y class="right-aside" @scrolltolower="lowerBottom">
        <view class="goods-list">
          <view class="guess-section">
					            <view
              v-for="(item, index) in list"
              :key="index"
              class="guess-item"
              @click="goodsClickFn('/pagesA/goods/details?goods_id=' + item[vm.goods_id], item)"
            >
										              <view class="image-wrapper">
                <image :src="$fullImgUrl(item[vm.img])" mode="aspectFill"></image>
              </view>
              <text class="title clamp text-ellipsis-2">{{ item[vm.title] }}</text>
              <text class="title2 clamp text-ellipsis-2">{{ item.description }}</text>
              <view class="price-wrapper">
	                <view class="price"> ￥{{ item[vm.price] | keepTwoNum }} </view>
	                <view class="price_ago"> ￥{{ item[vm.price_ago] | keepTwoNum }} </view>
              </view>
			  <view class="info">
			  	<view class="sales">销量<text>{{ item[vm.sales] }}</text></view>
			  	<view class="inventory">库存<text>{{ item[vm.inventory] }}</text></view>
			  </view>
			  <view class="operation">
			  	<view class="add_cart" v-if="$check_cart_page('/' + item.source_table + '/details')" @click.native.stop="add_cart(item)">
			  		<image src="@/static/img/cart_b.png"></image>
			  	</view>
			  </view>
													            </view>
          </view>
          <view class="medicine-title">
            {{ no_data ? '没有更多数据了～' : '下拉加载更多' }}
          </view>
        </view>
      </scroll-view>
    </view>
    </view>
</template>

<script>
import Search from '@/components/businessCp/search.vue';
import { setGoodsApi } from '@/api/goods';
import { getCartListApi, setCartApi, addCartApi } from '@/api/cart';

export default {
  components: {
    Search,
  },
  filters: {
    //过滤器 保留两位
    keepTwoNum: function (value) {
      value = Number(value);
      return value.toFixed(2);
    },
  },
  data() {
    return {
      list: [],
      selected: 0,
      query: {
        title: '',
        page: 1,
        size: 10,
		like: 0,
        type: '',
        orderby: 'hits desc',
      },
      // 分类
      types: [{ value: '', text: '全部' }],
      vm: {
        goods_id: 'goods_id',
        img: 'img',
        title: 'title',
        price: 'price',
        price_ago: 'price_ago',
        sales: 'sales',
        hits: 'hits',
        source_table: 'source_table',
        description: 'description',
		inventory: 'inventory',
      },
      no_data: false,
      	                    };
  },
                          methods: {
      	                    /**
     * 触底加载
     */
    lowerBottom() {
      if (this.no_data) {
        return;
      }
      this.query.page++;
      this.get_list();
    },
    /**
     * 跳转商品详情
     */
    goodsClickFn(url, o) {
      setGoodsApi(o.goods_id, {
        hits: parseInt(o.hits) + 1,
      }).then((res) => {
        if (res.result) {
          uni.navigateTo({
            url,
          });
        } else {
          this.$toast(res.error.message);
        }
      });
    },
    /**
     * 获取商品列表
     */
    get_list() {
      this.$get('/goods/get_list', this.query, (res) => {
        if (this.query.page === 1) {
          this.list = [];
          this.no_data = false;
        }
        this.list = this.list.concat(res.result.list);
        if (this.list.length >= res.result.count) {
          this.no_data = true;
        }
      });
    },
    /**
     * 添加商品过滤
     */
    get_goods_type() {
      this.$get('/goods_type/get_list', {}, (res) => {
        if (res.result) {
          let list = res.result.list;
          list.map((obj) => {
            this.types.push({ value: obj.name, text: obj.name });
          });
        }
      });
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

    /**
     * 搜索
     */

    search_() {
      this.query.page = 1;
      this.get_list();
    },
    /**
     * 取消搜索
     */
    cancel() {
      this.query.title = '';
      this.search_();
    },
    // 改变分类标签
    searchType(v, index) {
      this.selected = index;
	  this.query.type = this.types[index]['value'];
      this.query.page = 1;
      this.get_list();
    },
	inputValue(val, key) {
	  this.query[key] = val;
	},
  },
  mounted() {
    this.get_goods_type();
    this.get_list();
  },
};
</script>

<style lang="scss" scoped>
@import 'styles/pagesA/index.scss';
</style>
