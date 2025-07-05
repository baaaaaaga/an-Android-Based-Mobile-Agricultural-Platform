<template>
  <view class="slide-swiper-wrapper">
    <swiper
      class="swiper"
      :indicator-color="indicatorColor"
      :indicator-active-color="indicatorActiveColor"
      :indicator-dots="indicatorDots"
      :autoplay="autoplay"
      :interval="interval"
      :duration="duration"
    >
      <swiper-item v-for="(o, i) in list" :key="i">
        <image mode="scaleToFill" v-if="o[vm.img]" :src="$fullImgUrl(o[vm.img])" @click="toSlideUrl(o[vm.url],o[vm.title])"></image
        ><text class="title" v-if="show_title && o[vm.title]">{{ o[vm.title] }}</text>
      </swiper-item>
    </swiper>
  </view>
</template>

<script>
export default {
  name: 'SwiperImg',
  props: {
    show_title: {
      type: Boolean,
      default: false,
    },
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
          title: 'title',
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
    };
  },
  methods: {
    changeIndicatorDots(e) {
      this.indicatorDots = !this.indicatorDots;
    },
    changeAutoplay(e) {
      this.autoplay = !this.autoplay;
    },
    intervalChange(e) {
      this.interval = e.target.value;
    },
    durationChange(e) {
      this.duration = e.target.value;
    },
	toSlideUrl(url,title){
	  if (url){
	    uni.navigateTo({
	      url: `/pages/webview/webview?url=`+url+`&title=`+title
	    })
	  }
	}
  },
};
</script>

<style lang="scss" scoped>
@import 'styles/components/common.scss';

</style>
