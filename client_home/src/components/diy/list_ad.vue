<template>
  <view class="list-ad" v-if="dataList.length > 0">
    <rich-text
      class="ad"
      v-for="(o, i) in dataList"
      :key="i"
      :nodes="$setRichTextImage(o[vm.content])"
      @click="openUrl(o[vm.url])"
    ></rich-text>
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
    location: {
      type: String,
      default: '顶部广告',
    },
    vm: {
      type: Object,
      default: function () {
        return {
          location: 'location',
          content: 'content',
          url: 'url',
        };
      },
    },
  },
  data() {
    return {
      background: ['color1', 'color2', 'color3'],
      indicatorDots: true,
      indicatorColor: 'rgba(0, 0, 0, .3)',
      indicatorActiveColor: '#fff',
      autoplay: true,
      interval: 2000,
      duration: 500,
      dataList: [],
    };
  },
  watch: {
    list(newVal) {
      this.dataList = newVal.filter((item) => item[this.vm.location] === this.location);
    },
  },
  created() {
    this.dataList = this.list.filter((item) => item[this.vm.location] === this.location);
  },
  methods: {
    openUrl(url) {
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
