<template>
  <view
    v-if="showNotice"
    class="tn-notice-bar-class tn-notice-bar"
    :style="{
      borderRadius: radius + 'rpx',
    }"
  >
    <block v-if="mode === 'horizontal' && circular">
      <tn-row-notice
        :backgroundColor="backgroundColor"
        :fontColor="fontColor"
        :fontSize="fontSize"
        :fontUnit="fontUnit"
        :list="valueList"
        :show="show"
        :playStatus="playStatus"
        :leftIcon="leftIcon"
        :leftIconName="leftIconName"
        :leftIconSize="leftIconSize"
        :rightIcon="rightIcon"
        :rightIconName="rightIconName"
        :rightIconSize="rightIconSize"
        :closeBtn="closeBtn"
        :autoplay="autoplay"
        :radius="radius"
        :padding="padding"
        :align="align"
        :speed="speed"
        @click="click"
        @close="close"
        @clickLeft="clickLeftIcon"
        @clickRight="clickRightIcon"
      ></tn-row-notice>
    </block>
    <block v-if="mode === 'vertical' || (mode === 'horizontal' && !circular)">
      <tn-column-notice
        :backgroundColor="backgroundColor"
        :fontColor="fontColor"
        :fontSize="fontSize"
        :fontUnit="fontUnit"
        :list="valueList"
        :show="show"
        :mode="mode"
        :playStatus="playStatus"
        :leftIcon="leftIcon"
        :leftIconName="leftIconName"
        :leftIconSize="leftIconSize"
        :rightIcon="rightIcon"
        :rightIconName="rightIconName"
        :rightIconSize="rightIconSize"
        :closeBtn="closeBtn"
        :autoplay="autoplay"
        :radius="radius"
        :padding="padding"
        :align="align"
        :duration="duration"
        @click="click"
        @close="close"
        @clickLeft="clickLeftIcon"
        @clickRight="clickRightIcon"
        @end="end"
      ></tn-column-notice>
    </block>
  </view>
</template>

<script>
import componentsColorMixin from '../../libs/mixin/components_color.js';
export default {
  name: 'tn-notice-bar',
  mixins: [componentsColorMixin],
  props: {
    // 显示的内容
    list: {
      type: Array,
      default() {
        return [];
      },
    },
    keyName: {
      type: String,
      default: 'key',
    },
    valueName: {
      type: String,
      default: 'value',
    },
    keyValue: {
      type: String,
      default: undefined,
    },
    // 是否显示
    show: {
      type: Boolean,
      default: true,
    },
    // 播放状态
    // play -> 播放 paused -> 暂停
    playStatus: {
      type: String,
      default: 'play',
    },
    // 滚动方向
    // horizontal -> 水平滚动 vertical -> 垂直滚动
    mode: {
      type: String,
      default: 'horizontal',
    },
    align: {
      type: String,
      default: 'left',
    },
    // 是否显示左边图标
    leftIcon: {
      type: Boolean,
      default: true,
    },
    // 左边图标的名称
    leftIconName: {
      type: String,
      default: 'sound',
    },
    // 左边图标的大小
    leftIconSize: {
      type: Number,
      default: 34,
    },
    // 是否显示右边的图标
    rightIcon: {
      type: Boolean,
      default: false,
    },
    // 右边图标的名称
    rightIconName: {
      type: String,
      default: 'right',
    },
    // 右边图标的大小
    rightIconSize: {
      type: Number,
      default: 26,
    },
    // 是否显示关闭按钮
    closeBtn: {
      type: Boolean,
      default: false,
    },
    // 圆角
    radius: {
      type: Number,
      default: 0,
    },
    // 内边距
    padding: {
      type: String,
      default: '18rpx 24rpx',
    },
    // 自动播放
    autoplay: {
      type: Boolean,
      default: true,
    },
    // 滚动周期
    duration: {
      type: Number,
      default: 2000,
    },
    // 水平滚动时的速度，即每秒滚动多少rpx
    speed: {
      type: Number,
      default: 160,
    },
    // 水平滚动的时候是否采用衔接的模式
    circular: {
      type: Boolean,
      default: true,
    },
    // 没有数据时是否显示通知
    autoHidden: {
      type: Boolean,
      default: true,
    },
  },
  computed: {
    // 当设置了show为false，或者autoHidden为true且list为空时，不显示通知
    showNotice() {
      return !(this.show === false || (this.autoHidden && this.list.length === 0));
    },
  },
  watch: {
    keyValue: {
      handler(value) {
        this.loadList();
      },
      deep: true,
    },
  },
  data() {
    return {
      //显示的值
      valueList: [],
    };
  },
  mounted() {
    this.loadList();
  },
  methods: {
    // 点击了通知栏
    click(index) {
      let value = this.findValue(index);
      //如果是对象，返回传入的对象
      if (this.isObj(value)) {
        this.$emit('click', value);
      } else {
        this.$emit('click', index);
      }
    },
    findValue(findIndex) {
      let objList = [];
      for (let index in this.list) {
        let v = this.list[index];
        if (this.isObj(v)) {
          //判断是否指定key显示，如果是则显示指定的列表，否则就返回所有列表
          if (this.keyValue == undefined || v[this.keyName] == this.keyValue) {
            objList.push(v);
          }
        } else {
          //兼容旧的，旧的直接返回下表
          return findIndex;
        }
      }
      return findIndex >= objList.length ? undefined : objList[findIndex];
    },
    // 点击了关闭按钮
    close() {
      this.$emit('close');
    },
    //判断元素是否是对象
    isObj(value) {
      return typeof value === 'object';
    },
    // 点击了左边图标
    clickLeftIcon() {
      this.$emit('clickLeft');
    },
    // 点击了右边图标
    clickRightIcon() {
      this.$emit('clickRight');
    },
    // 一个周期滚动结束
    end() {
      this.$emit('end');
    },
    loadList() {
      let tmpList = [];
      for (let index in this.list) {
        let v = this.list[index];
        if (this.isObj(v)) {
          //判断是否指定key显示，如果是则显示指定的列表，否则就返回所有列表
          if (this.keyValue == undefined || v[this.keyName] == this.keyValue) {
            tmpList.push(v[this.valueName]);
          }
        } else {
          tmpList.push(v);
        }
      }
      this.valueList = tmpList;
    },
  },
};
</script>

<style lang="scss" scoped>
.tn-notice-bar {
  overflow: hidden;
}
</style>
