<template>
  <view class="menu_list">
    <view v-if="$check_action(o[vm.url], 'get')" v-for="(o, i) in list" :key="i" class="item_menu">
      <view @click="$navTo('/pages' + o[vm.url])" class="menu" hover-class="hover">
        <image class="image" :src="$fullImgUrl(o[vm.img])" mode="widthFix"></image>
        <text class="name">{{ o[vm.name] }}</text>
      </view>
    </view>
  </view>
</template>

<script>
import mixin from '@/libs/mixins/component.js';
export default {
  mixins: [mixin],
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
          name: 'mod_name',
          url: 'path',
        };
      },
    },
  },
  methods: {},
};
</script>

<style lang="scss" scoped>
.menu_list {
  display: flex;
  justify-content: center;
  align-items: center;
  flex-wrap: wrap;
  text-align: center;
  background-color: #fff;
  padding: 20rpx 0;
  .item_menu {
    padding: 20rpx;
    image {
      width: 80%;
      &:hover {
        transform: scale(1.2);
        transition: 0.2 all;
      }
    }
    text {
      font-size: 24rpx;
    }
  }
}
</style>
