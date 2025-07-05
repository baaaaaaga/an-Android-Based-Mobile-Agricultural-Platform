<template>
  <view class="list_article">
    <view
      v-for="(o, i) in list"
      :key="i"
      class="item"
      my-link
      to="/tabbar-4"
      @click="goTo('/pages/article/details?' + vm.article_id + '=' + o[vm.article_id])"
    >
      <image
        class="image"
        :style="{ width: img_width, height: img_width }"
        :src="$fullImgUrl(o[vm.img])"
        mode="scaleToFill"
      >
      </image>
      <view class="right_block">
        <view class="top_info">
          {{ o[vm.title] }}
        </view>
        <view class="mid_info">{{ $toTime(o[vm.create_time], "yyyy-MM-dd hh:mm:ss") }}</view>
        <view class="bottom_info">
          <view class="see"
            ><text class="icon iconfont icon-chakan"> </text> <text>{{ o[vm.hits] }}</text>
          </view>
          <view class="praise">
            <text class="icon iconfont icon-dianzan"> </text>
            <text>{{ o[vm.praise_len] }}</text>
          </view>

          <view class="praise">
            <text class="icon iconfont icon-pinglun"> </text>
            <text>{{ o[vm.comment_len] }}</text>
          </view>
          <view class="praise">
            <text class="icon iconfont icon-shoucang"> </text>
            <text>{{ o[vm.collect_len] }}</text>
          </view>
        </view>
      </view>
    </view>
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
          article_id: 'article_id',
          title: 'title',
          description: 'description',
          title: 'title',
          create_time: 'create_time',
          content: 'content',
          praise_len: 'praise_len',
          collect_len: 'collect_len',
          comment_len: 'comment_len',
          hits: 'hits',
        };
      },
    },
    img_width: {
      type: String,
      default: '160rpx',
    },
  },
  data() {
    return {};
  },
  methods: {
    goTo(url) {
      this.$Router.push(url);
    },
  },
  created() {},
};
</script>

<style lang="scss" scoped>
@import 'styles/components/index.scss';
</style>
