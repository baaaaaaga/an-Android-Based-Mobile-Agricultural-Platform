<template>
  <view class="me-btn">
    <slot></slot>
  </view>
</template>

<script>
export default {
  props: {
    tabs: {
      // 支持格式: ['全部', '待付款'] 或 [{name:'全部'}, {name:'待付款'}]
      type: Array,
      default() {
        return [];
      },
    },
    nameKey: {
      // 取name的字段
      type: String,
      default: 'name',
    },
    value: {
      // 当前显示的下标 (使用v-model语法糖: 1.props需为value; 2.需回调input事件)
      type: [String, Number],
      default: 0,
    },
    fixed: Boolean, // 是否悬浮,默认false
    tabWidth: Number, // 每个tab的宽度,默认不设置值,为flex平均分配; 如果指定宽度,则不使用flex,每个tab居左,超过则水平滑动(单位默认rpx)
    height: {
      // 高度,单位rpx
      type: Number,
      default: 64,
    },
    top: {
      // 顶部偏移的距离,默认单位rpx (当fixed=true时,已加上windowTop)
      type: Number,
      default: 0,
    },
  },
  data() {
    return {};
  },
  computed: {},
  watch: {
    value() {},
  },
  created() {},
  mounted() {},
  methods: {},
};
</script>

<style lang="scss"></style>
