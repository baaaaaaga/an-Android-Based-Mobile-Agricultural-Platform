<template>
  <view class="page_user_coupon" :style="{ paddingTop: vuex_custom_bar_height + 'px' }">
    <tn-nav-bar>我的优惠券</tn-nav-bar>
    <view id="user_coupon_wrapper" class="user_coupon_wrapper">
      <view class="coupon-list">
        <view class="coupon-item" v-for="item in list" :key="item.coupon_id">
          <view
            class="coupon-wrap"
            :class="!isEffective(item.coupon_time) || isUse(item.id) ? 'bg_grey' : ''"
          >
            <view style="margin-left: 10px">
              <view class="title">{{ item.coupon_name }}</view>
              <view class="price"><text>¥</text>{{ item.coupon_price1 }}</view>
              <view class="rules">使用规则:<text>满 {{ item.coupon_price }} 减 {{ item.coupon_price1 }}</text></view>
              <view class="time">
                有效期：<text>{{ $toTime(item['coupon_time'].split(',')[0], 'yyyy-MM-dd hh:mm:ss') }}
                到
                {{ $toTime(item['coupon_time'].split(',')[1], 'yyyy-MM-dd hh:mm:ss') }}</text>
              </view>
            </view>

            <view class="state">
              <view v-if="isUse(item.id)">已使用</view>
              <view v-else-if="!isEffective(item.coupon_time) && !isUse(item.id)">
                不在有效期内
              </view>
            </view>
          </view>
        </view>
      </view>
    </view>
  </view>
</template>

<script>
import mixin from '@/libs/mixins/page.js';

export default {
  mixins: [mixin],

  components: {},
  data() {
    return {};
  },

  methods: {
    /**
     *  当前用户的优惠券
     */
    async get_coupon_user_list() {
      const result = await this.$get('~/api/coupon_user/get_list', {
        user_id: this.userInfo.user_id,
      });

      for (let i = 0; i < result.result.list.length; i++) {
        const res = await this.$get('~/api/coupon/get_obj', {
          coupon_id: result.result.list[i].coupon_id,
        });

        this.list.push({
          ...res.result.obj,
          id: result.result.list[i].id,
          is_use: result.result.list[i].is_use,
        });
      }
    },
  },
  mounted() {},
  computed: {
    isUse(id) {
      return function (id) {
        if (this.list) {
          for (let i = 0; i < this.list.length; i++) {
            if (this.list[i].id === id && this.list[i].is_use == 1) {
              return true;
            }
          }
        }
      };
    },
    isEffective(time) {
      return function (time) {
        const now = new Date().getTime();
        const date = time.split(',');
        const start = new Date(date[0]);
        const end = new Date(date[1]);
        return start <= now && now <= end;
      };
    },
  },
  async created() {
    await this.get_coupon_user_list();
  },
};
</script>
<style lang="scss" scoped>
@import 'styles/pages/index.scss';
</style>
