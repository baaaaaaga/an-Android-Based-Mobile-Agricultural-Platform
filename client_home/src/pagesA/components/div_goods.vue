<template>
  <view class="div_goods">
    <template v-if="swiper_img.length">
      <swiper
        @change="changeswiper"
        class="swiper"
        indicator-active-color="#fff"
        :indicator-dots="indicatorDots"
        :autoplay="autoplay"
        :interval="interval"
        :duration="duration"
        :current="currentNum"
        :style="{ height: bigImgHeight }"
      >
        <swiper-item v-for="(o_img, i) in swiper_img" :key="i" :style="{ height: bigImgHeight }">
          <!-- 要看效果把swiper_img变量名换成swiper_img2 -->
          <image
            :style="{ height: bigImgHeight }"
            class="swipeShowImg"
            @load="fitHight(1)"
            :src="$fullImgUrl(o_img)"
          ></image>
        </swiper-item>
      </swiper>
    </template>
    <template v-else>
      <image :src="$fullImgUrl(obj[vm.img])" style="width: 100%" mode=""></image>
    </template>

    <view class="wrap">
      <view class="includelittle_goodspic">
        <!-- 要看效果把swiper_img变量名换成swiper_img2 -->
        <image
          @load="fitHight(2)"
          :style="{ height: littleImgHeight }"
          v-for="(o_img, i) in swiper_img"
          :key="i"
          @click="changeswiperpic(i)"
          :class="['little_goodspic', currentNum == i ? 'little_goodspic_act' : '']"
          :src="$fullImgUrl(o_img)"
        ></image>
      </view>
      <text class="title">
        {{ obj[vm.title] }}
      </text>
	  <view class="info">
	    <text>{{ obj[vm.description] }}</text>
	  </view>
      <view class="price_wrap">
        <text class="price">￥{{ obj[vm.price] }}</text>
        <text class="price_ago">￥{{ obj[vm.price_ago] }}</text>
      </view>

      <view class="description">
      	                        <view class="sales">
          <text>已卖{{ sales_num }}</text>
        </view>
        <view class="sales">
          <text>库存{{ obj[vm.inventory] }}</text>
        </view>
        <view class="goods_details">
          <view v-for="(o, i) in customize_field_list" :key="i" class="goods_details_item">
            <label>{{ o.field_name }}</label>
            <span v-if="o.type === 'image'">
              <image
                v-if="o.field_value"
                style="width: 10rem; height: 10rem"
                :src="$fullImgUrl(o.field_value) || '/static/img/default.png'"
                mode="scaleToFill"
              ></image>
            </span>
            <span v-else-if="o.type === 'video'">
              <a
                v-if="o.field_value"
                :href="$fullUrl(o.field_value)"
                target="_blank"
                style="color: rgb(64, 158, 255)"
                >查看视频</a
              >
            </span>
            <span v-else-if="o.type === 'audio'">
              <a
                v-if="o.field_value"
                :href="$fullUrl(o.field_value)"
                target="_blank"
                style="color: rgb(64, 158, 255)"
                >聆听音频</a
              >
            </span>
            <span v-else-if="o.type === 'file'">
              <a
                v-if="o.field_value"
                :href="$fullUrl(o.field_value)"
                target="_blank"
                style="color: rgb(64, 158, 255)"
                >点击下载</a
              >
            </span>
            <span v-else-if="o.type === 'date'">
              {{ $toTime(o.field_value, 'yyyy-MM-dd') }}
            </span>
            <span v-else-if="o.type === 'time'">
              {{ $toTime(o.field_value, 'hh:mm:ss') }}
            </span>
            <span v-else-if="o.type === 'datetime'">
              {{ $toTime(o.field_value, 'yyyy-MM-dd hh:mm:ss') }}
            </span>
            <span v-else-if="o.type === 'uid'">
              {{ get_user_obj(o.field_value) }}
            </span>
            <span v-else>{{ o.field_value }}</span>
          </view>
        </view>
        
      </view>
    </view>
  </view>
</template>

<script>
export default {
  props: {
    obj: {
      type: Object,
      default: function () {
        return {};
      },
    },
    score_num: {
      type: Number,
      default: 0,
    },
    vm: {
      type: Object,
      default: function () {
        return {
          goods_id: 'goods_id',
          title: 'title',
          img: 'img',
          description: 'description',
          price_ago: 'price_ago',
          price: 'price',
          sales: 'sales',
          inventory: 'inventory',
          type: 'type',
          hits: 'hits',
          content: 'content',
          create_time: 'create_time',
          update_time: 'update_time',
          img_1: 'img_1',
          img_2: 'img_2',
          img_3: 'img_3',
          img_4: 'img_4',
          img_5: 'img_5',
          customize_field: 'customize_field',
        };
      },
    },
  },
  data() {
    return {
      currentNum: 0,
      /* 改了这里 */
      bigImgHeight: '300px',
      littleImgHeight: '50px',
      swiper_img2: [
        'https://dcdn.yuyuebus.com/front/img/buychoose.png',
        'https://dcdn.yuyuebus.com/front/img/buychoosenone.png',
        'https://dcdn.yuyuebus.com/front/img/buylocation.png',
        'https://dzgj.yuyuebus.com/static/front/dist/static/img/icon-question.png',
        'https://dcdn.yuyuebus.com/front/img/buychoose.png',
      ],
      // 轮播图属性
      indicatorDots: false,
      autoplay: true,
      interval: 2000,
      duration: 500,
      justicNum: 0,
      /* 改了这里 */
      sales_num: 0,
      user_list: 0,
    };
  },
  methods: {
    /* 改了这里 */
    changeswiper(e) {
      this.currentNum = e.detail.current;
    },
    changeswiperpic(num) {
      this.currentNum = num;
      this.autoplay = false;
      setTimeout(() => {
        this.autoplay = true;
      }, 2000);
    },
    fitHight(type) {
      if (type == 1) {
        let objbig = uni.createSelectorQuery().select('.swipeShowImg');
        objbig
          .boundingClientRect((data) => {
            // data - 各种参数
            if (data) {
              this.bigImgHeight = data.width * 0.92 + 'px';
            }
          })
          .exec();
      } else {
        uni.getSystemInfo({
          success: (res) => {
            // res - 各种参数
            let objlittle = uni.createSelectorQuery().select('.little_goodspic');
            objlittle
              .boundingClientRect((data) => {
                // data - 各种参数
                this.justicNum = this.justicNum + 1;
                if (data) {
                  this.littleImgHeight = data.width * 0.92 + 'px';
                }
              })
              .exec();
          },
        });
      }
    },
    async get_sales_num() {
      let _this = this;
      _this.sales_num = 0;
      let order_json = await this.$get('~/api/order/get_list', {
        goods_id: _this.obj.goods_id,
        state: '已付款',
      });
      if (order_json.result && order_json.result.list) {
        let list = order_json.result.list;
        for (let i = 0; i < list.length; i++) {
          _this.sales_num = _this.sales_num + list[i].num;
        }
      }
    },
    async get_user_list() {
      let _this = this;
      _this.user_list = 0;
      let user_json = await this.$get('~/api/user/get_list');
      if (user_json.result && user_json.result.list) {
        _this.user_list = user_json.result.list;
      }
    },
    get_user_obj(user_id) {
      let result = '';
      for (let i = 0; i < this.user_list.length; i++) {
        if (user_id == this.user_list[i].user_id) {
          result = this.user_list[i].nickname + '-' + this.user_list[i].username;
          break;
        }
      }
      console.log(result);
      return result;
    },

  },
  computed: {
    // 获得商品轮播图
    swiper_img: function () {
      var obj = this.obj;
      var list_img = [];
      for (let k in obj) {
        let sub_k = k;
        if (sub_k.substr(0, 3) === 'img' && obj[k]) {
          list_img.push(obj[k]);
        }
      }
      return list_img;
    },
    // 获得商品轮播图
    customize_field_list: function () {
      if (this.obj.customize_field) {
        let list_fields = JSON.parse(this.obj.customize_field);
        return list_fields;
      }
      return [];
    },
  },
  created() {
    setTimeout(() => {
      this.get_sales_num();
      this.get_user_list();
    }, 500);
  },
};
</script>
<style lang="scss" scoped>
@import 'styles/components/index.scss';
</style>
