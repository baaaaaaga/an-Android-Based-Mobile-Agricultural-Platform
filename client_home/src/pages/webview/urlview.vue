<template>
  <view class="page_urlview" :style="{ paddingTop: vuex_custom_bar_height + 'px' }">
    <!-- #ifndef MP -->
    <tn-nav-bar>天气预报</tn-nav-bar>
    <view class="webview-container">
      <web-view id="inneriframe" src="http://www.nmc.cn/publish/forecast.html	"> </web-view>
    </view>
    <!-- #endif -->

    <!-- #ifdef MP -->
    <web-view id="inneriframe" src="http://www.nmc.cn/publish/forecast.html	"></web-view>
    <!-- #endif -->
  </view>
</template>

<script>
export default {
  data() {
    return {};
  },
  onLoad() {},
};
</script>

<script lang="renderjs">
export default {
  data() {
    return {
		style_outer:{},
		style_inner:{}
    };
  },
  onLoad() {

  }
}
</script>
<style lang="scss" scoped>
@import 'styles/pages/index.scss';
</style>
