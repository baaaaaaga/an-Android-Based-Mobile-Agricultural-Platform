<template>
  <view class="search-warpper">
    <view class="left">
      <text class="icon iconfont icon-sousuo"></text>
      <input
        :class="['search-input', disabled ? 'events-none' : '']"
        type="text"
        v-model="keyword"
        :placeholder="placeholder"
        :disabled="disabled"
        @input="input"
      />
      <text class="iconfont icon-quxiao" @click="cancel" v-if="keyword"></text>
    </view>
    <view class="right">
      <view class="search-btn" @click="search">搜索</view>
    </view>
  </view>
</template>

<script>
export default {
  components: {},
  props: {
    value: {
      type: String,
      default: '',
    },
    placeholder: {
      type: String,
      default: '请输入',
    },

    disabled: {
      type: Boolean,
      default: false,
    },
  },
  // model: {
  //   prop: 'value',
  //   event: 'change',
  // },
  data() {
    return {
		keyword: '',
	};
  },
  watch: {},
  methods: {
    search() {
      if (!this.disabled) {
        this.$emit('search');
      }
    },
    cancel() {
      this.keyword = '';
      this.$emit('cancel');
    },
    input() {
      this.$emit('input', this.keyword);
    },
  },
  created() {},
  mounted() {},
};
</script>
<style lang="scss" scoped>
.search-warpper {
  display: flex;
  height: 70rpx;
  width: 100%;
  .left {
    flex: 1;
    width: 100%;
    height: 100%;
    margin-right: 10rpx;
    position: relative;
    padding: 0 10rpx;
    border: 1px solid #e2e2e2;
    display: flex;
    align-items: center;
    .icon {
      font-size: 46rpx;
    }
    .icon-quxiao {
      font-size: 36rpx;
    }
    .search-input {
      width: 100%;
      height: 100%;
      padding: 0 10rpx;
      font-size: 28rpx;
      &.events-none {
        pointer-events: none;
      }
    }
  }
  .right {
    width: 180rpx;
    .search-btn {
      width: 100%;
      height: 100%;
      background-color: $main-color;
      display: flex;
      align-items: center;
      justify-content: center;
      color: #fff;
      border-radius: $uni-border-radius-sm;
    }
  }
}
</style>
