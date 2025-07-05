<template>
  <!-- 合并样式修改 修改class名称 -->
  <view class="list_forum">
    <view
      v-for="(o, i) in list"
      :key="i"
      class="item"
      @click="$navTo('/pagesA/forum/details?' + vm.forum_id + '=' + o[vm.forum_id])"
    >
	  <view class="tag" v-if="o.istop">置顶</view>
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
        <view class="mid_info">{{ $toTime(o[vm.create_time], 'yyyy-MM-dd hh:mm:ss') }}</view>
        <view class="bottom_info">
          <view class="user_info">
            <image class="avatar" :src="$fullImgUrl(o.avatar)" mode="scaleToFill"> </image>
            <text class="name">{{ o[vm.nickname] }}</text>
          </view>
          <view class="info_right">
            <view class="see"
              ><text class="icon iconfont icon-chakan"> </text> <text>{{ o[vm.hits] }}</text>
            </view>
            <view class="praise">
              <text class="icon iconfont icon-dianzan"> </text>
              <text> {{ o[vm.praise_len] }}</text>
            </view>
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
          forum_id: 'forum_id',
          title: 'title',
          description: 'description',
          create_time: 'create_time',
          content: 'content',
          praise_len: 'praise_len',
          hits: 'hits',
          nickname: 'nickname',
		  avatar: 'avatar',
        };
      },
    },
    img_width: {
      type: String,
      default: '5rem',
    },
  },
  data() {
    return {};
  },
  methods: {},
};
</script>

<style lang="scss" scoped>
@import 'styles/components/index.scss';
</style>
