<template>
  <view v-show="show" class="t-color-picker" @touchmove.stop.prevent="moveHandle">
    <view class="t-mask" :class="{ active: active }" @click.stop="close"></view>
    <view class="t-box" :class="{ active: active }">
      <view class="t-header">
        <view class="t-header-button" @click="close">取消</view>
        <view class="t-header-button" @click="confirm">确认</view>
      </view>
      <view
        class="t-color__box"
        :style="{ background: 'rgb(' + bgcolor.r + ',' + bgcolor.g + ',' + bgcolor.b + ')' }"
      >
        <view
          class="t-background boxs"
          @touchstart="touchstart($event, 0)"
          @touchmove="touchmove($event, 0)"
          @touchend="touchend($event, 0)"
        >
          <view class="t-color-mask"></view>
          <view
            class="t-pointer"
            :style="{ top: site[0].top - 8 + 'px', left: site[0].left - 8 + 'px' }"
          ></view>
        </view>
      </view>
      <view class="t-control__box">
        <view class="t-control__color">
          <view
            class="t-control__color-content"
            :style="{
              background: 'rgba(' + rgba.r + ',' + rgba.g + ',' + rgba.b + ',' + rgba.a + ')',
            }"
          ></view>
        </view>
        <view class="t-control-box__item">
          <view
            class="t-controller boxs"
            @touchstart="touchstart($event, 1)"
            @touchmove="touchmove($event, 1)"
            @touchend="touchend($event, 1)"
          >
            <view class="t-hue">
              <view class="t-circle" :style="{ left: site[1].left - 12 + 'px' }"></view>
            </view>
          </view>
          <view
            class="t-controller boxs"
            @touchstart="touchstart($event, 2)"
            @touchmove="touchmove($event, 2)"
            @touchend="touchend($event, 2)"
          >
            <view class="t-transparency">
              <view class="t-circle" :style="{ left: site[2].left - 12 + 'px' }"></view>
            </view>
          </view>
        </view>
      </view>
      <view class="t-result__box">
        <view v-if="mode" class="t-result__item">
          <view class="t-result__box-input">{{ hex }}</view>
          <view class="t-result__box-text">HEX</view>
        </view>
        <template v-else>
          <view class="t-result__item">
            <view class="t-result__box-input">{{ rgba.r }}</view>
            <view class="t-result__box-text">R</view>
          </view>
          <view class="t-result__item">
            <view class="t-result__box-input">{{ rgba.g }}</view>
            <view class="t-result__box-text">G</view>
          </view>
          <view class="t-result__item">
            <view class="t-result__box-input">{{ rgba.b }}</view>
            <view class="t-result__box-text">B</view>
          </view>
          <view class="t-result__item">
            <view class="t-result__box-input">{{ rgba.a }}</view>
            <view class="t-result__box-text">A</view>
          </view>
        </template>

        <view class="t-result__item t-select" @click="select">
          <view class="t-result__box-input">
            <view>切换</view>
            <view>模式</view>
          </view>
        </view>
      </view>
      <view class="t-alternative">
        <view class="t-alternative__item" v-for="(item, index) in colorList" :key="index">
          <view
            class="t-alternative__item-content"
            :style="{
              background: 'rgba(' + item.r + ',' + item.g + ',' + item.b + ',' + item.a + ')',
            }"
            @click="selectColor(item)"
          >
          </view>
        </view>
      </view>
    </view>
  </view>
</template>

<script>
export default {
  props: {
    color: {
      type: Object,
      default() {
        return {
          r: 0,
          g: 0,
          b: 0,
          a: 0,
        };
      },
    },
    spareColor: {
      type: Array,
      default() {
        return [];
      },
    },
  },
  data() {
    return {
      show: false,
      active: false,
      // rgba 颜色
      rgba: {
        r: 0,
        g: 0,
        b: 0,
        a: 1,
      },
      // hsb 颜色
      hsb: {
        h: 0,
        s: 0,
        b: 0,
      },
      site: [
        {
          top: 0,
          left: 0,
        },
        {
          left: 0,
        },
        {
          left: 0,
        },
      ],
      index: 0,
      bgcolor: {
        r: 255,
        g: 0,
        b: 0,
        a: 1,
      },
      hex: '#000000',
      mode: true,
      colorList: [
        {
          r: 244,
          g: 67,
          b: 54,
          a: 1,
        },
        {
          r: 233,
          g: 30,
          b: 99,
          a: 1,
        },
        {
          r: 156,
          g: 39,
          b: 176,
          a: 1,
        },
        {
          r: 103,
          g: 58,
          b: 183,
          a: 1,
        },
        {
          r: 63,
          g: 81,
          b: 181,
          a: 1,
        },
        {
          r: 33,
          g: 150,
          b: 243,
          a: 1,
        },
        {
          r: 3,
          g: 169,
          b: 244,
          a: 1,
        },
        {
          r: 0,
          g: 188,
          b: 212,
          a: 1,
        },
        {
          r: 0,
          g: 150,
          b: 136,
          a: 1,
        },
        {
          r: 76,
          g: 175,
          b: 80,
          a: 1,
        },
        {
          r: 139,
          g: 195,
          b: 74,
          a: 1,
        },
        {
          r: 205,
          g: 220,
          b: 57,
          a: 1,
        },
        {
          r: 255,
          g: 235,
          b: 59,
          a: 1,
        },
        {
          r: 255,
          g: 193,
          b: 7,
          a: 1,
        },
        {
          r: 255,
          g: 152,
          b: 0,
          a: 1,
        },
        {
          r: 255,
          g: 87,
          b: 34,
          a: 1,
        },
        {
          r: 121,
          g: 85,
          b: 72,
          a: 1,
        },
        {
          r: 158,
          g: 158,
          b: 158,
          a: 1,
        },
        {
          r: 0,
          g: 0,
          b: 0,
          a: 0.5,
        },
        {
          r: 0,
          g: 0,
          b: 0,
          a: 0,
        },
      ],
    };
  },
  created() {
    this.rgba = this.color;
    if (this.spareColor.length !== 0) {
      this.colorList = this.spareColor;
    }
  },
  methods: {
    /**
     * 初始化
     */
    init() {
      // hsb 颜色
      this.hsb = this.rgbToHex(this.rgba);
      // this.setColor();
      this.setValue(this.rgba);
    },
    moveHandle() {},
    open() {
      uni.hideKeyboard();
      this.show = true;
      this.$nextTick(() => {
        this.init();
        setTimeout(() => {
          this.active = true;
          setTimeout(() => {
            this.getSelectorQuery();
          }, 350);
        }, 50);
      });
    },
    close() {
      this.active = false;
      this.$nextTick(() => {
        setTimeout(() => {
          this.show = false;
        }, 500);
      });
      this.$emit('cancel', {});
    },
    confirm() {
      this.close();
      this.$emit('confirm', {
        rgba: this.rgba,
        hex: this.hex,
      });
    },
    // 选择模式
    select() {
      this.mode = !this.mode;
    },
    // 常用颜色选择
    selectColor(item) {
      this.setColorBySelect(item);
    },
    touchstart(e, index) {
      const { pageX, pageY } = e.touches[0];
      this.pageX = pageX;
      this.pageY = pageY;
      this.setPosition(pageX, pageY, index);
    },
    touchmove(e, index) {
      const { pageX, pageY } = e.touches[0];
      this.moveX = pageX;
      this.moveY = pageY;
      this.setPosition(pageX, pageY, index);
    },
    touchend(e, index) {},
    /**
     * 设置位置
     */
    setPosition(x, y, index) {
      this.index = index;
      const { top, left, width, height } = this.position[index];
      // 设置最大最小值

      this.site[index].left = Math.max(0, Math.min(parseInt(x - left), width));
      if (index === 0) {
        this.site[index].top = Math.max(0, Math.min(parseInt(y - top), height));
        // 设置颜色
        this.hsb.s = parseInt((100 * this.site[index].left) / width);
        this.hsb.b = parseInt(100 - (100 * this.site[index].top) / height);
        this.setColor();
        this.setValue(this.rgba);
      } else {
        this.setControl(index, this.site[index].left);
      }
    },
    /**
     * 设置 rgb 颜色
     */
    setColor() {
      const rgb = this.HSBToRGB(this.hsb);
      this.rgba.r = rgb.r;
      this.rgba.g = rgb.g;
      this.rgba.b = rgb.b;
    },
    /**
     * 设置二进制颜色
     * @param {Object} rgb
     */
    setValue(rgb) {
      this.hex = '#' + this.rgbToHex(rgb);
    },
    setControl(index, x) {
      const { top, left, width, height } = this.position[index];

      if (index === 1) {
        this.hsb.h = parseInt((360 * x) / width);
        this.bgcolor = this.HSBToRGB({
          h: this.hsb.h,
          s: 100,
          b: 100,
        });
        this.setColor();
      } else {
        this.rgba.a = (x / width).toFixed(1);
      }
      this.setValue(this.rgba);
    },
    /**
     * rgb 转 二进制 hex
     * @param {Object} rgb
     */
    rgbToHex(rgb) {
      let hex = [rgb.r.toString(16), rgb.g.toString(16), rgb.b.toString(16)];
      hex.map(function (str, i) {
        if (str.length == 1) {
          hex[i] = '0' + str;
        }
      });
      return hex.join('');
    },
    setColorBySelect(getrgb) {
      const { r, g, b, a } = getrgb;
      let rgb = {};
      rgb = {
        r: r ? parseInt(r) : 0,
        g: g ? parseInt(g) : 0,
        b: b ? parseInt(b) : 0,
        a: a ? a : 0,
      };
      this.rgba = rgb;
      this.hsb = this.rgbToHsb(rgb);
      this.changeViewByHsb();
    },
    changeViewByHsb() {
      const [a, b, c] = this.position;
      this.site[0].left = parseInt((this.hsb.s * a.width) / 100);
      this.site[0].top = parseInt(((100 - this.hsb.b) * a.height) / 100);
      this.setColor(this.hsb.h);
      this.setValue(this.rgba);
      this.bgcolor = this.HSBToRGB({
        h: this.hsb.h,
        s: 100,
        b: 100,
      });

      this.site[1].left = (this.hsb.h / 360) * b.width;
      this.site[2].left = this.rgba.a * c.width;
    },
    /**
     * hsb 转 rgb
     * @param {Object} 颜色模式  H(hues)表示色相，S(saturation)表示饱和度，B（brightness）表示亮度
     */
    HSBToRGB(hsb) {
      let rgb = {};
      let h = Math.round(hsb.h);
      let s = Math.round((hsb.s * 255) / 100);
      let v = Math.round((hsb.b * 255) / 100);
      if (s == 0) {
        rgb.r = rgb.g = rgb.b = v;
      } else {
        let t1 = v;
        let t2 = ((255 - s) * v) / 255;
        let t3 = ((t1 - t2) * (h % 60)) / 60;
        if (h == 360) h = 0;
        if (h < 60) {
          rgb.r = t1;
          rgb.b = t2;
          rgb.g = t2 + t3;
        } else if (h < 120) {
          rgb.g = t1;
          rgb.b = t2;
          rgb.r = t1 - t3;
        } else if (h < 180) {
          rgb.g = t1;
          rgb.r = t2;
          rgb.b = t2 + t3;
        } else if (h < 240) {
          rgb.b = t1;
          rgb.r = t2;
          rgb.g = t1 - t3;
        } else if (h < 300) {
          rgb.b = t1;
          rgb.g = t2;
          rgb.r = t2 + t3;
        } else if (h < 360) {
          rgb.r = t1;
          rgb.g = t2;
          rgb.b = t1 - t3;
        } else {
          rgb.r = 0;
          rgb.g = 0;
          rgb.b = 0;
        }
      }
      return {
        r: Math.round(rgb.r),
        g: Math.round(rgb.g),
        b: Math.round(rgb.b),
      };
    },
    rgbToHsb(rgb) {
      let hsb = {
        h: 0,
        s: 0,
        b: 0,
      };
      let min = Math.min(rgb.r, rgb.g, rgb.b);
      let max = Math.max(rgb.r, rgb.g, rgb.b);
      let delta = max - min;
      hsb.b = max;
      hsb.s = max != 0 ? (255 * delta) / max : 0;
      if (hsb.s != 0) {
        if (rgb.r == max) hsb.h = (rgb.g - rgb.b) / delta;
        else if (rgb.g == max) hsb.h = 2 + (rgb.b - rgb.r) / delta;
        else hsb.h = 4 + (rgb.r - rgb.g) / delta;
      } else hsb.h = -1;
      hsb.h *= 60;
      if (hsb.h < 0) hsb.h = 0;
      hsb.s *= 100 / 255;
      hsb.b *= 100 / 255;
      return hsb;
    },
    getSelectorQuery() {
      const views = uni.createSelectorQuery().in(this);
      views
        .selectAll('.boxs')
        .boundingClientRect((data) => {
          if (!data || data.length === 0) {
            setTimeout(() => this.getSelectorQuery(), 20);
            return;
          }
          this.position = data;
          // this.site[0].top = data[0].height;
          // this.site[0].left = 0;
          // this.site[1].left = data[1].width;
          // this.site[2].left = data[2].width;
          this.setColorBySelect(this.rgba);
        })
        .exec();
    },
  },
  watch: {
    spareColor(newVal) {
      this.colorList = newVal;
    },
  },
};
</script>

<style lang="scss" scoped>
@import 'styles/components/index.scss';
</style>
