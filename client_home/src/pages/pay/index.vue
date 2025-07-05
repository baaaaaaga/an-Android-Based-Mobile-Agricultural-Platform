<template>
  <view class="page_pay" :style="{ paddingTop: vuex_custom_bar_height + 'px' }">
    <tn-nav-bar>支付</tn-nav-bar>
    <view class="pay_wrapper" id="page_pay">
      <view class="warp">
        <view class="container">
          <view class="row">
            <view class="col-12 col-md-6">
              <view class="card">
                <view>
                  <h4 class="text-center">总支付：￥{{ query.sum_price }}</h4>
                </view>

                <view class="card-body">
                  <view class="form-group" label="支付方式">
                    <view
                      class="form-radio"
                      v-model="selected"
                      :aria-describedby="ariaDescribedby"
                      name="some-radios"
                      value="A"
                    >
                      支付宝
                    </view>
                    <view
                      class="form-radio"
                      v-model="selected"
                      :aria-describedby="ariaDescribedby"
                      name="some-radios"
                      value="B"
                    >
                      微信
                    </view>
                  </view>
                </view>

                <view class="card-footer text-center">
                  <b-button variant="outline-primary" @click="pay" block>支付</b-button>
                </view>
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
    return {
      query: {
        sum_price: '',
        order_number: '',
        selected: '',
      },
    };
  },

  methods: {
    pay() {
      this.$post(
        '~/api/order/set?order_number=' + this.query.order_number,
        {
          state: '已付款',
        },
        (res) => {
          if (res.result) {
            console.log(res.result);
            this.$toast('支付成功');
            this.$nav('/order/list?state=已付款');
          }
        }
      );
    },
  },
  mounted() {},
};
</script>
<style lang="scss" scoped>
@import 'styles/pages/index.scss';
</style>
