<template>
  <view class="page_media_video" :style="{ paddingTop: vuex_custom_bar_height + 'px' }">
    <tn-nav-bar>视频</tn-nav-bar>
    <view class="media_video" id="media_video">
      <!-- 视频模块(开始) -->
      <view class="yyy">
        <video
          id="my_video"
          :src="$fullImgUrl(query.url)"
          @error="videoErrorCallback"
          :danmu-list="danmuList"
          enable-danmu
          danmu-btn
          controls
        ></video>
      </view>

      <!-- #ifndef MP-ALIPAY -->
      <view class="form">
        <uni-easyinput
          v-model="danmuValue"
          class="uni-input"
          type="text"
          placeholder="在此处输入弹幕内容"
        />
      </view>
      <view class="btn-row">
        <button @click="sendDanmu" class="btn-send">发送弹幕</button>
      </view>
      <!-- #endif -->

      <!-- 视频模块(结束) -->
    </view>
  </view>
</template>

<script>
export default {
  data() {
    return {
      query: {
        url: 'https://img.cdn.aliyun.dcloud.net.cn/guide/uniapp/%E7%AC%AC1%E8%AE%B2%EF%BC%88uni-app%E4%BA%A7%E5%93%81%E4%BB%8B%E7%BB%8D%EF%BC%89-%20DCloud%E5%AE%98%E6%96%B9%E8%A7%86%E9%A2%91%E6%95%99%E7%A8%8B@20200317.mp4',
      },
      danmuList: [
        {
          text: '第 1s 出现的弹幕',
          color: '#ff0000',
          time: 1,
        },
        {
          text: '第 3s 出现的弹幕',
          color: '#ff00ff',
          time: 3,
        },
      ],
      danmuValue: '',
    };
  },
  methods: {
    sendDanmu: function () {
      this.videoContext.sendDanmu({
        text: this.danmuValue,
        color: this.getRandomColor(),
      });
      this.danmuValue = '';
    },
    videoErrorCallback: function (e) {
      uni.showModal({
        content: e.target.errMsg,
        showCancel: false,
      });
    },
    getRandomColor: function () {
      const rgb = [];
      for (let i = 0; i < 3; ++i) {
        let color = Math.floor(Math.random() * 256).toString(16);
        color = color.length == 1 ? '0' + color : color;
        rgb.push(color);
      }
      return '#' + rgb.join('');
    },
  },
  onReady: function (res) {
    // #ifndef MP-ALIPAY
    this.videoContext = uni.createVideoContext('myVideo');
    // #endif
  },
};
</script>
<style lang="scss" scoped>
@import 'styles/pages/index.scss';
</style>
