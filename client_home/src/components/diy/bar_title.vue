<template>
  <view class="bar_title">
    <view class="title">
      <view @click="$navTo(url)" v-if="url">
        <text>
          {{ title }}
        </text>
      </view>
	  <view v-else>
		  <text>
		    {{ title }}
		  </text>
	  </view>
    </view>
    <view class="more" v-if="url">
      <view @click="$navTo(url)">
        <text style="color: var(--color_primary); font-size: 0.8rem">更多++</text>
      </view>
    </view>
  </view>
</template>

<script>
export default {
  props: {
    title: {
      type: String,
      default: '',
    },
    url: {
      type: String,
      default: '',
    },
  },
};
</script>

<style lang="scss" scoped>
@import 'styles/components/index.scss';
</style>
