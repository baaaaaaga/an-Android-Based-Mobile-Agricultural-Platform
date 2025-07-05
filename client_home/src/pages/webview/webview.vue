<template>
  <view class="page_webview" :style="{ paddingTop: vuex_custom_bar_height + 'px' }">
    <!-- #ifndef MP -->
    <tn-nav-bar>{{ title ? title : '智能客服聊天'}}</tn-nav-bar>
    <view class="webview-container">
      <web-view :src="url"></web-view>
    </view>
    <!-- #endif -->
    <!-- #ifdef MP -->
    <web-view :src="url"></web-view>
    <!-- #endif -->
  </view>
</template>

<script>
export default {
  data() {
    return {
      url: '',
	  title: ''
    };
  },
  onLoad(item) {
    if (item.download) {
      this.url = decodeURIComponent(item.url) + '#' + item.download;
    } else {
      this.url = decodeURIComponent(item.url);
    }
	if(item.title){
		this.title = item.title
	}
  },
};
</script>

<style scoped lang="scss">
@import 'styles/pages/index.scss';
</style>
