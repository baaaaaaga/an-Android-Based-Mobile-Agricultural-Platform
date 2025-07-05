<template>
    <view class="page_user_coupon" :style="{ paddingTop: vuex_custom_bar_height + 'px' }">
    <tn-nav-bar>钱包</tn-nav-bar>
  <view class="tn-flex" style="width: 100%">
    <view class="wallet-container tn-flex tn-flex-direction-column">
      <view
        class="wallet-part tn-flex tn-flex-direction-column tn-flex-row-cente tn-flex-col-center"
      >
        <text class="margin-top-two">钱包余额</text>
        <text class="moneyCol margin-top-two">￥{{ beforeBalance }}</text>
      </view>

      <view class="wallet-part">
        <view class="wallet-left-name">充值金额</view>
        <view class="wallet-detail tn-flex tn-flex-direction-column">
          <view
            class="wallet-recharged-money tn-flex tn-flex-direction-row tn-flex-col-center tn-flex-wrap"
          >
            <text
              :class="[chooseIdx == index ? 'act' : '']"
              v-for="(item, index) in priceArr"
              :key="item"
              @click="changePrice(index)"
              >{{ item }}元</text
            >
          </view>
          <view class="wallet-write-input">
            <tn-input
              v-model="priceInput"
              @input="justicInput"
              type="number"
              id="moneyinput"
              placeholder="请输入其他充值金额"
            />
          </view>
          <view>
            <button type="primary" class="layui-btn" @click="recharged">充值</button>
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
  data() {
    return {
      priceArr: [5, 10, 20, 50, 100, 200],
      chooseIdx: 99,
      beforeBalance: 0,
      priceInput: '',
    };
  },

  methods: {
    justicInput() {
      if (!!this.priceInput) {
        this.chooseIdx = 99;
      }
    },
    changePrice(index) {
      this.chooseIdx = index;
      this.priceInput = '';
    },
    recharged() {
      let _this = this;
      if (_this.chooseIdx == 99 && !_this.priceInput) {
        uni.showToast({
          title: '请输入充值金额',
          icon: 'none',
        });
      } else {
        let moneyNum =
          _this.chooseIdx != 99
            ? Number(_this.priceArr[_this.chooseIdx])
            : Number(_this.priceInput);
        uni.navigateTo({ url: `/pages/pay/index?moneyNow=${moneyNum}` });
      }
    },
  },
  onShow() {
    let _this = this;
    _this.chooseIdx=99;
    _this.priceInput= '';
    _this.$get('~/api/user/state', null, function (json, status) {
      if (json.result) {
        var user = json.result;
        if (user.obj) {
          user = user.obj;
        }
        _this.$store.commit('user_set', user);
        _this.beforeBalance = Number(user.balance);
        if (func) {
          func(user);
        }
      } else if (json.error) {
        _this.$get('quit');
        _this.$store.commit('sign_out');
        if (func) {
          func(user);
        }
      }
    });
  },
};
</script>

<style scoped lang="scss">
.wallet-container {
  width: 94%;
  margin-left: 3%;
  font-size: 28rpx;
}
.wallet-part {
  width: 100%;
  margin-top: 40rpx;
}

.moneyCol {
  font-weight: bolder;
  font-size: 40rpx;
  color: #e13a0c;
}

.wallet-left-name {
  margin-top: 2vh;
  margin-bottom: 1vh;
}
.wallet-recharged-money text {
  width: 32%;
  text-align: center;
  padding: 8px 0;
  background: #eee;
  margin-bottom: 20rpx;
  margin-right: 2%;
  border-radius: 2px;
}
.wallet-recharged-money text:nth-child(3n) {
  margin-right: 0;
}
.margin-top-two {
  margin-top: 2vh;
}

.wallet-recharged-money .act {
  background: #78410e;
  color: #fff;
}
</style>
