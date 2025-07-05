<template>
  <view class="list_link">
	<view class="title">友情链接</view>
    <scroll-view class="scroll-view" scroll-x="true">
      <view class="link-list-item" v-for="(o, index) in list" :key="index">
        <view class="link-list-warp" @click="openUrl(o[vm.url])">
          <view class="img-box">
            <image class="img" :src="$fullImgUrl(o[vm.img]) || '/static/img/default.png'"></image>
          </view>
          <view class="name-box"
            ><text>{{ o[vm.name] }}</text></view
          >
        </view>
      </view>
    </scroll-view>
  </view>
</template>

<script>
export default {
  props: {
    list: {
      type: Array,
      default: function () {
        return [];
      },
    },
    vm: {
      type: Object,
      default: function () {
        return {
          img: 'img',
          name: 'name',
          url: 'url',
        };
      },
    },
    span: {
      type: Number,
      default: 3,
    },
  },
  data() {
    var col = 12 / this.span;
    return {
      col,
    };
  },
  methods: {
    openUrl(url) {
      console.log(1111);
      uni.navigateTo({
        url: `/pages/webview/webview?url=${url}`,
      });
    },
  },
};
</script>

<style lang="scss" scoped>
@import 'styles/components/index.scss';
</style>
