<template>
  <view class="page_media_image" :style="{ paddingTop: vuex_custom_bar_height + 'px' }">
    <tn-nav-bar>图片预览</tn-nav-bar>
    <view class="media_image" id="media_image">
      <view class="image-show">
        <view class="image">
        <image :mode="mode" :src="src" @error="imageError"></image>
      </view>
      </view>
    </view>
  </view>
</template>

<script>
export default {
  data() {
    return {
      mode: 'aspectFit',
    };
  },
  onLoad(options) {
    this.src = options.url;
  },
  methods: {
    imageError: function (e) {
      console.error('image发生error事件，携带值为' + e.detail.errMsg);
    },
  },
};
</script>
<style lang="scss" scoped>
@import 'styles/pages/index.scss';
</style>
