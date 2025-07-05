<template>
  <uni-card margin="0" :isShadow="false">
    <view class="card-title-box">
      <text class="card-title">{{ title }}</text>
      <view @click="clickMore" v-if="url" class="more"> 更多 </view>
    </view>
    <slot></slot>
  </uni-card>
</template>
<script>
export default {
  name: 'CardList',
  props: {
    title: {
      type: String,
      default: '',
    },
    url: {
      type: String,
      default: '',
    },
	toTab: {
	  type: Boolean,
	  default: false,
	},
  },
  methods: {
    clickMore() {
      if (this.toTab) {
        this.$navToTab(this.url);
      } else {
        this.$navTo(this.url);
      }
    },
  },
};
</script>
<style lang="scss" scoped>
@import 'styles/components/common.scss';
</style>
