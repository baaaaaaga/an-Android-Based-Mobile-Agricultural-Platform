<template>
  <view class="home-swiper">
    <tn-swiper
      @click="clickSwiper"
      :list="dataList"
      :name="vm.img"
      :height="350"
      :effect3d="false"
      mode="dot"
      indicatorPosition="bottomRight"
    ></tn-swiper>
  </view>
</template>

<script>
export default {
  name: 'SwiperImg',
  props: {
    show_title: {
      type: String,
      default: '',
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
      this.dataList = newVal.map((item) => {
        const url = item[this.vm.img];
        item[this.vm.img] = this.$fullImgUrl(url);
        return item;
      });
    },
  },
  created() {
    this.dataList = this.list.map((item) => {
      const url = item[this.vm.img];
      item[this.vm.img] = this.$fullImgUrl(url);
      return item;
    });
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
    clickSwiper() {},
  },
};
</script>

<style lang="scss" scoped>
@import 'styles/components/common.scss';
</style>
