<template>
  <button
    class="tn-btn-class tn-btn"
    :class="[buttonClass, backgroundColorClass, fontColorClass]"
    :style="[buttonStyle]"
    hover-class="tn-hover"
    :loading="loading"
    :disabled="disabled"
    :form-type="formType"
    :open-type="openType"
    @getuserinfo="handleGetUserInfo"
    @getphonenumber="handleGetPhoneNumber"
    @contact="handleContact"
    @error="handleError"
    @tap="handleClick"
  >
    <slot></slot>
  </button>
</template>

<script>
import componentsColorMixin from '../../libs/mixin/components_color.js';
import { debounceFun, throttleFun } from '../../libs/function/applyEven.js';
let spanTime = 200;
export default {
  mixins: [componentsColorMixin],
  name: 'tn-button',
  // 解决再微信小程序种，自定义按钮无法触发bindsubmit
  behaviors: ['wx://form-field-button'],
  props: {
    // 按钮索引，用于区分多个按钮
    index: {
      type: [Number, String],
      default: 0,
    },
    // 按钮形状 default 默认 round 圆角 icon 图标按钮
    shape: {
      type: String,
      default: 'default',
    },
    // 是否加阴影
    shadow: {
      type: Boolean,
      default: false,
    },
    // 宽度 rpx或%
    width: {
      type: String,
      default: 'auto',
    },
    // 高度 rpx或%
    height: {
      type: String,
      default: '',
    },
    // 按钮的尺寸 sm lg
    size: {
      type: String,
      default: '',
    },
    // 字体是否加粗
    fontBold: {
      type: Boolean,
      default: false,
    },
    padding: {
      type: String,
      default: '0 30rpx',
    },
    // 外边距 与css的margin参数用法相同
    margin: {
      type: String,
      default: '',
    },
    // 是否镂空
    plain: {
      type: Boolean,
      default: false,
    },
    // 当plain=true时，是否显示边框
    border: {
      type: Boolean,
      default: true,
    },
    // 当plain=true时，是否加粗显示边框
    borderBold: {
      type: Boolean,
      default: false,
    },
    // 是否禁用
    disabled: {
      type: Boolean,
      default: false,
    },
    // 是否显示加载图标
    loading: {
      type: Boolean,
      default: false,
    },
    // 触发form表单的事件类型
    formType: {
      type: String,
      default: '',
    },
    // 开放能力
    openType: {
      type: String,
      default: '',
    },
    // 是否阻止重复点击(默认间隔是200ms)
    blockRepeatClick: {
      type: Boolean,
      default: false,
    },
    //场景：（如果开启blockRepeatClick，这里无效）none ： 不开启防抖节流模式，debounce ：防抖模式 throttle：节流模式
    scene: {
      type: String,
      default: 'none',
    },
    // 防抖节流间隔时间（毫秒）
    blockTime: {
      type: Number,
      default: 200,
    },
  },
  computed: {
    // 根据不同的参数动态生成class
    buttonClass() {
      let clazz = '';
      // 按钮形状
      switch (this.shape) {
        case 'icon':
        case 'round':
          clazz += ' tn-round';
          break;
      }

      // 阴影
      if (this.shadow) {
        if (this.backgroundColorClass !== '' && this.backgroundColorClass.indexOf('tn-bg') != -1) {
          const color = this.backgroundColor.slice(this.backgroundColor.lastIndexOf('-') + 1);
          clazz += ` tn-shadow-${color}`;
        } else {
          clazz += ' tn-shadow-blur';
        }
      }

      // 字体加粗
      if (this.fontBold) {
        clazz += ' tn-text-bold';
      }

      // 设置为镂空并且设置镂空便可才进行设置
      if (this.plain) {
        clazz += ' tn-btn--plain';
        if (this.border) {
          clazz += ' tn-border-solid';
          if (this.borderBold) {
            clazz += ' tn-bold-border';
          }
          if (this.backgroundColor !== '' && this.backgroundColor.includes('tn-bg')) {
            const color = this.backgroundColor.slice(this.backgroundColor.lastIndexOf('-') + 1);
            clazz += ` tn-border-${color}`;
          }
        }
      }

      return clazz;
    },
    // 按钮的样式
    buttonStyle() {
      let style = {};
      switch (this.size) {
        case 'sm':
          style.padding = '0 20rpx';
          style.fontSize = '22rpx';
          style.height = this.height || '48rpx';
          break;
        case 'lg':
          style.padding = '0 40rpx';
          style.fontSize = '32rpx';
          style.height = this.height || '80rpx';
          break;
        default:
          style.padding = '0 30rpx';
          style.fontSize = '28rpx';
          style.height = this.height || '64rpx';
      }

      // 是否手动设置了内边距
      if (this.padding) {
        style.padding = this.padding;
      }

      // 是否手动设置外边距
      if (this.margin) {
        style.margin = this.margin;
      }

      // 是否手动设置了字体大小
      if (this.fontSize) {
        style.fontSize = this.fontSize + this.fontUnit;
      }
      style.width = this.shape === 'icon' ? style.height : this.width;
      style.padding = this.shape === 'icon' ? '0' : style.padding;

      if (this.fontColorStyle) {
        style.color = this.fontColorStyle;
      }

      if (!this.backgroundColorClass) {
        if (this.plain) {
          style.borderColor = this.backgroundColorStyle || '#080808';
        } else {
          style.backgroundColor = this.backgroundColorStyle || '#FFFFFF';
        }
      }

      // 设置阴影
      if (this.shadow && !this.backgroundColorClass) {
        if (this.backgroundColorStyle.indexOf('#') != -1) {
          style.boxShadow = `6rpx 6rpx 8rpx ${this.backgroundColorStyle || '#000000'}10`;
        } else if (
          this.backgroundColorStyle.indexOf('rgb') != -1 ||
          this.backgroundColorStyle.indexOf('rgba') != -1 ||
          !this.backgroundColorStyle
        ) {
          style.boxShadow = `6rpx 6rpx 8rpx ${this.backgroundColorStyle || 'rgba(0, 0, 0, 0.1)'}`;
        }
      }

      return style;
    },
  },
  data() {
    return {};
  },
  watch: {
    //支持动态修改时间，但是这里是没有做撤销上一次的方法，毕竟这种场景非常少
    //这里只是防止用户使用时复用了组件，有场景时长要求二次变动，而做的优化
    blockTime: {
      handler(newVal, oldVal) {
        this.initScene();
      },
    },
  },
  mounted() {
    this.initScene();
  },
  methods: {
    initScene() {
      // 动态传入blockTime，需要重新初始化,参数
      //防抖模式
      this.debounceClick = debounceFun(function () {
        this.emitClick();
      }, this.blockTime);
      //节流模式
      this.throttleClick = throttleFun(function () {
        this.emitClick();
      }, this.blockTime);
    },
    //防抖模式
    debounceClick: debounceFun(function () {
      this.emitClick();
    }, spanTime),
    //节流模式
    throttleClick: throttleFun(function () {
      this.emitClick();
    }, spanTime),
    emitClick() {
      //触发事件
      this.$emit('click', {
        index: Number(this.index),
      });
      // 兼容tap事件
      this.$emit('tap', {
        index: Number(this.index),
      });
    },
    // 按钮点击事件
    handleClick() {
      if (this.disabled) {
        return;
      }
      //兼容旧的
      if (this.blockRepeatClick) {
        this.throttleClick();
        return;
      }
      //普通模式，触发多少次就回调多少次
      if (this.scene === 'none') {
        this.emitClick();
      } else if (this.scene == 'debounce') {
        //防抖模式
        this.debounceClick();
      } else {
        //节流模式
        this.throttleClick();
      }
    },
    handleGetUserInfo({ detail = {} } = {}) {
      this.$emit('getuserinfo', detail);
    },
    handleContact({ detail = {} } = {}) {
      this.$emit('contact', detail);
    },
    handleGetPhoneNumber({ detail = {} } = {}) {
      this.$emit('getphonenumber', detail);
    },
    handleError({ detail = {} } = {}) {
      this.$emit('error', detail);
    },
  },
};
</script>

<style lang="scss" scoped>
.tn-btn {
  position: relative;
  display: inline-flex;
  align-items: center;
  justify-content: center;
  box-sizing: border-box;
  line-height: 1;
  text-align: center;
  text-decoration: none;
  overflow: visible;
  transform: translate(0rpx, 0rpx);
  // background-color: $tn-mai
  border-radius: 12rpx;
  // color: $tn-font-color;
  margin: 0;

  &--plain {
    background-color: transparent !important;
    background-image: none;

    &.tn-round {
      border-radius: 1000rpx !important;
    }
  }
}
</style>
