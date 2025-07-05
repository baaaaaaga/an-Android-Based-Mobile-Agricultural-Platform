<template>
  <view :style="{ paddingTop: vuex_custom_bar_height + 'px' }">
    <tn-nav-bar>领取优惠券</tn-nav-bar>
    <view id="page_coupon" class="page_coupon">
      <view class="container">
        <view class="row">
          <view class="col-12 col-md-6">
            <view v-for="item in coupon_list" :key="item.coupon_id" v-if="coupon_list.length > 0">
              <view class="coupon_box">
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
                <button class="coupon_btn"
                  :disabled="isDisabled(item.coupon_id)"
                  style="margin-right: 10px; font-size: 0.7rem"
                  type="primary"
                  @click="
                    receive_coupon({
                      coupon_id: item.coupon_id,
                      is_use: 0,
                    })
                  "
                >
                  {{ isDisabled(item.coupon_id) ? '已领取' : '领取' }}
                </button>
              </view>
            </view>
            <view v-if="coupon_list.length <= 0" style="text-align: center">无可领取的优惠券</view>
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
    return {
      url_get_list: '~/api/coupon/get_list?like=0',
      field: 'coupon_id',
      list: [],
      coupon_list: [],
      admin_userId: 0,
      coupon_user_list: [],
      goods_user_id: 0,
    };
  },

  methods: {
    /**
     * 获取用户
     */
    async get_list_user() {
      var json = await this.$get('~/api/user/get_list?');
      if (json.result) {
        for (let i = 0; i < json.result.list.length; i++) {
          if (json.result.list[i].user_group === '管理员') {
            this.admin_userId = json.result.list[i].user_id;
          }
        }
      } else if (json.error) {
        console.error(json.error);
      }
    },
    /**
     *  领取优惠券
     */
    receive_coupon(data) {
      data.user_id = this.userInfo.user_id;
      this.$post('~/api/coupon_user/add', data, (res) => {
        if (res.result === 1) {
          this.get_coupon_user_list();
        }
      });
    },
    /**
     *  当前用户的优惠券
     */
    async get_coupon_user_list() {
      const result = await this.$get('~/api/coupon_user/get_list', {
        user_id: this.userInfo.user_id,
      });
      this.coupon_user_list = result.result.list;
    },
  },
  mounted() {
    console.log(this.$store);
  },
  computed: {
    isDisabled(id) {
      return function (id) {
        if (this.coupon_user_list) {
          for (let i = 0; i < this.coupon_user_list.length; i++) {
            if (this.coupon_user_list[i].coupon_id === id) {
              return true;
            }
          }
        }
      };
    },
  },
  async created() {
    await this.get_list_user();
    await this.get_coupon_user_list();
  },
  watch: {
    list() {
      for (var j = 0; j < this.list.length; j++) {
        if (
          this.list[j].coupon_user_id == this.admin_userId ||
          this.list[j].coupon_user_id == this.goods_user_id
        ) {
          this.coupon_list.push(this.list[j]);
        }
      }
    },
  },
  onLoad(e) {
    this.goods_user_id = e.user_id;
  },
};
</script>
<style lang="scss" scoped>
@import 'styles/pagesA/index.scss';
</style>
