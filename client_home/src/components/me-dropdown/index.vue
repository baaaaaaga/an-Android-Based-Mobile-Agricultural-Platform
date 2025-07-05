<template>
  <view :class="['le-dropdown', isCeiling && 'le-dropdown-ceiling']">
    <!-- 导航 -->
    <view class="le-dropdown-menu">
      <view
        class="le-dropdown-menu-item"
        v-for="(item, index) in menuList"
        :key="index"
        @tap.stop="menuClick(index)"
      >
        <view class="le-flex">
          <text
            class="le-dropdown-menu-item-text"
            :style="{
              color: index === current ? themeColor : inactiveColor,
            }"
            >{{ item.title }}</text
          >
          <view
            v-if="item.type === 'sort'"
            :class="[
              'le-dropdown-menu-item-arrow',
              item.value === 'asc' && 'le-dropdown-menu-item-arrow_top',
              item.value === 'desc' && 'le-dropdown-menu-item-arrow_bottom',
            ]"
          >
          </view>
          <view
            v-if="item.type !== 'sort'"
            :class="[
              'le-dropdown-menu-item-basicarrow',
              index === current && 'le-dropdown-menu-item-basicarrow_rotate',
            ]"
          >
          </view>
        </view>
      </view>
    </view>
    <!-- 展示的内容 -->
    <view
      class="le-dropdown-content"
      :style="[
        {
          transition: `opacity ${duration / 1000}s linear`,
          top: 'auto',
          bottom: `calc(100vh - ${contentHeight + windowTop}px)`,
          height: `calc(100vh - ${contentHeight + windowTop}px)`,
        },
        contentStyle,
      ]"
      @tap="close"
    >
      <view
        ref="leDropdownContentPopupRef"
        class="le-dropdown-content-popup"
        :style="[popupStyle]"
        @tap.stop.prevent
      >
        <block v-for="(item, index) in menuList" :key="index">
          <!-- 单选列表 -->
          <view
            class="le-dropdown-popup-content le-dropdown-cell"
            v-if="item.type === 'cell' && index === current"
          >
            <view
              :class="[
                'le-dropdown-cell-item',
                item.value === sItem.value && 'le-dropdown-cell-active',
              ]"
              v-for="(sItem, sIndex) in item.options"
              :key="sIndex"
              @click="onSelectCell(sItem, index)"
            >
              <view class="le-dropdown-cell-active-text">{{ sItem.label }}</view>
              <view v-show="item.value === sItem.value" class="le-dropdown-cell-active-icon"></view>
            </view>
          </view>
          <!-- 级联动选择 -->
          <view
            class="le-dropdown-popup-content le-dropdown-picker"
            v-if="item.type === 'picker' && index === current"
          >
            <le-dropdown-picker :value.sync="item.value">
              {{ item.componentProps }}
            </le-dropdown-picker>
            <view class="le-dropdown-footer">
              <view class="le-dropdown-confirm" @click="onFilterConfirm(item, index)">
                {{ item.confirmText || '确定' }}
              </view>
            </view>
          </view>
          <!-- 筛选 -->
          <view
            class="le-dropdown-popup-content le-dropdown-filter"
            v-if="item.type === 'filter' && index === current"
          >
            <view
              class="le-dropdown-filter-item"
              v-for="(sItem, sIndex) in item.children"
              :key="sIndex"
            >
              <view class="le-dropdown-filter-title">
                {{ sItem.title }}
                <text class="le-dropdown-filter-subtitle" v-if="sItem.type === 'slider'"
                  >{{ sItem.value }}{{ sItem.suffix }}</text
                >
              </view>
              <view class="le-dropdown-filter-content">
                <!-- 单选类型 -->
                <block v-if="sItem.type === 'radio'">
                  <view
                    v-for="(ssItem, ssIndex) in sItem.options"
                    :class="[
                      'le-dropdown-filter-box',
                      sItem.value === ssItem.value && 'le-dropdown-filter-box-active',
                    ]"
                    :key="ssIndex"
                    @click="onRadioFilter(sIndex, ssItem, index)"
                  >
                    {{ ssItem.label }}
                  </view>
                </block>
                <!-- 多选类型 -->
                <block v-else-if="sItem.type === 'checkbox'">
                  <view
                    v-for="(ssItem, ssIndex) in sItem.options"
                    :class="[
                      'le-dropdown-filter-box',
                      sItem.value.includes(ssItem.value) && 'le-dropdown-filter-box-active',
                    ]"
                    :key="ssIndex"
                    @click="onCheckboxFilter(sIndex, ssItem, index)"
                  >
                    {{ ssItem.label }}
                  </view>
                </block>
                <!-- 滑块类型 -->
                <block v-else-if="sItem.type === 'slider'">
                  <slider
                    style="width: 100%"
                    :activeColor="themeColor"
                    :value="sItem.value"
                    :min="sItem.componentProps.min || 0"
                    :max="sItem.componentProps.max || 100"
                    :step="sItem.componentProps.step || 1"
                    :show-value="sItem.componentProps['show-value'] || true"
                    @change="onSliderChange($event, sIndex, ssItem, index)"
                  />
                </block>
              </view>
            </view>
            <view class="le-dropdown-footer">
              <view class="le-dropdown-reset" @click="onFilterReset(item, index)">重置</view>
              <view class="le-dropdown-confirm" @click="onFilterConfirm(item, index)">
                {{ item.confirmText || '确定' }}
              </view>
            </view>
          </view>
        </block>
      </view>
      <view class="le-dropdown-content-mask" @click="close"></view>
    </view>
  </view>
</template>

<script>
import cloneDeep from './utils/cloneDeep.js';
import hexToRgb from './utils/hexToRgb.js';
import LeDropdownPicker from './components/le-picker.vue';
export default {
  components: {
    LeDropdownPicker,
  },
  props: {
    // 导航数据
    menuList: {
      type: Array,
      default: () => {
        return [];
      },
    },
    // 主题的颜色
    themeColor: {
      type: String,
      default: '#3185FF',
    },
    // 没选中的颜色
    inactiveColor: {
      type: String,
      default: '#333333',
    },
    // 过渡时间
    duration: {
      type: [Number, String],
      default: 300,
    },
    // 是否吸顶
    isCeiling: {
      type: Boolean,
      default: false,
    },
  },
  data() {
    return {
      initMenuList: cloneDeep(this.$props.menuList),
      active: false,
      current: 99999,
      contentStyle: {
        zIndex: -1,
        opacity: 0,
      },
      contentHeight: 0,
      leDropdownContentPopupRef: null,
      windowTop: 0,
    };
  },
  computed: {
    popupStyle() {
      let style = {};
      // 进行Y轴位移，展开状态时，恢复原位。收齐状态时，往上位移100%，进行隐藏
      style.transform = `translateY(${this.active ? 0 : '-100%'})`;
      style['transition-duration'] = this.$props.duration / 1000 + 's';
      return style;
    },
  },
  watch: {},
  created() {
    let sys = uni.getSystemInfoSync();
    this.windowTop = sys.windowTop;
  },
  mounted() {
    this.getContentHeight();
  },
  methods: {
    callHexToRgb() {
      hexToRgb(this.$props.themeColor);
    },

    // 点击菜单
    menuClick(index) {
      this.getContentHeight();
      switch (this.$props.menuList[index].type) {
        case 'sort':
          this.onSort(index);
          break;
        case 'click':
          this.onClick(index);
          break;
        default:
          // 如果点击时的索引和当前激活项索引相同，意味着点击了激活项，需要收起下拉菜单
          if (index === this.current) {
            this.close();
            return;
          }
          this.open(index);
          break;
      }
    },
    // 打开当前筛选窗
    open(index) {
      // 展开时，设置下拉内容的样式
      this.active = true;
      this.contentStyle.zIndex = 11;
      this.contentStyle.opacity = 1;
      this.contentStyle.bottom = `0px`;
      this.contentStyle.top = `80rpx`;
      // 标记展开状态以及当前展开项的索引
      console.log('展开状态以及当前展开项的索引', this.active, this.current);
      this.current = index;
      this.$emit('open', this.current);
    },
    // 关闭当前筛选窗
    close() {
      this.active = false;
      this.contentStyle.opacity = 0;
      // 等动画结束后，再移除下拉菜单中的内容，否则直接移除，也就没有下拉菜单收起的效果了
      setTimeout(() => {
        this.contentStyle.zIndex = -1;
        this.current = 99999;
        this.contentStyle.bottom = `calc(100vh - ${this.contentHeight + this.windowTop}px)`;
        this.contentStyle.top = 'auto';
      }, this.$props.duration);
      this.$emit('close', this.current);
    },
    // 获取下拉菜单内容的高度
    getContentHeight() {
      uni
        .createSelectorQuery()
        .in(this)
        .selectAll('.le-dropdown-menu')
        .boundingClientRect()
        .exec((data) => {
          this.contentHeight = data[0][0].bottom;
        });
    },
    // 点击排序
    onSort(index) {
      let _this = this;
      const type = this.current === 99999 ? this.current : this.$props.menuList[this.current].type;
      switch (type) {
        case 'sort':
        case 'click':
        case 99999:
          start();
          break;
        default:
          this.close();
          setTimeout(() => {
            start();
          }, this.$props.duration);
          break;
      }

      function start() {
        const menuList = cloneDeep(_this.$props.menuList);
        _this.current = index;
        menuList[index].value = !menuList[index].value
          ? 'asc'
          : menuList[index].value == 'asc'
          ? 'desc'
          : null;
        _this.$emit('update:menuList', menuList);
        _this.$emit('onConfirm', menuList[index]);
      }
    },
    // 点击按钮
    onClick(index) {
      let _this = this;
      const type = this.current === 99999 ? this.current : this.$props.menuList[this.current].type;
      switch (type) {
        case 'sort':
        case 'click':
        case 99999:
          start();
          break;
        default:
          this.close();
          setTimeout(() => {
            start();
          }, this.$props.duration);
          break;
      }

      function start() {
        const menuList = cloneDeep(_this.$props.menuList);
        _this.current = index;
        _this.$emit('onConfirm', menuList[index]);
      }
    },
    // 单选列表选中事件
    onSelectCell(sItem, index) {
      const menuList = cloneDeep(this.$props.menuList);
      menuList[index].title = sItem.label;
      menuList[index].value = sItem.value;
      this.$emit('update:menuList', menuList);
      close();
      this.$emit('onConfirm', menuList[index]);
    },
    // 筛选单选选中事件
    onRadioFilter(sIndex, ssItem, index) {
      const menuList = cloneDeep(this.$props.menuList);
      menuList[index].children[sIndex].value = ssItem.value;
      this.$emit('update:menuList', menuList);
      this.$emit('onChange', menuList[index], sIndex);
    },
    // 筛选多选选中事件
    onCheckboxFilter(sIndex, ssItem, index) {
      const menuList = cloneDeep(this.$props.menuList);
      const indexs = menuList[index].children[sIndex].value.indexOf(ssItem.value);
      if (indexs != -1) {
        menuList[index].children[sIndex].value.splice(indexs, 1);
      } else {
        menuList[index].children[sIndex].value.push(ssItem.value);
      }
      this.$emit('update:menuList', menuList);
      this.$emit('onChange', menuList[index], sIndex);
    },
    // 滑块值的变化事件
    onSliderChange(event, sIndex, ssItem, index) {
      const menuList = cloneDeep(this.$props.menuList);
      menuList[index].children[sIndex].value = event.detail.value;
      this.$emit('update:menuList', menuList);
      this.$emit('onChange', menuList[index], sIndex);
    },
    // 筛选选中事件
    onSelectFilter(sIndex, ssItem, index) {
      const menuList = cloneDeep(this.$props.menuList);
      menuList[index].active[sIndex] = ssItem.value;
      this.$emit('update:menuList', menuList);
      this.$emit('onChange', menuList[index], sIndex);
    },
    // 重置筛选
    onFilterReset(item, index) {
      const menuList = cloneDeep(this.$props.menuList);
      menuList[index].children.forEach((items, indexs) => {
        items.value = this.initMenuList[index].children[indexs].value;
      });
      this.$emit('update:menuList', menuList);
      // close();
      // this.$emit("onConfirm",menuList[index])
    },
    // 确定筛选
    onFilterConfirm(item, index) {
      this.close();
      const menuList = cloneDeep(this.$props.menuList);
      this.$emit('onConfirm', menuList[index]);
    },
    bindFun(data) {
      return data;
    },
  },
};
</script>

<style lang="scss" scoped>
$dropdownThemeColor: #3185ff;
.le-flex {
  display: flex;
  align-items: center;
  height: 100%;
}

.le-dropdown {
  width: 100%;
  position: relative;

  .le-dropdown-menu {
    display: flex;
    position: relative;
    z-index: 11;
    height: 80rpx;

    .le-dropdown-menu-item {
      height: 100%;
      flex: 1;
      display: flex;
      justify-content: flex-start;
      align-items: center;

      .le-dropdown-menu-item-text {
        font-size: 28rpx;
      }

      .le-dropdown-menu-item-arrow {
        margin-left: 6rpx;
        transition: transform 0.3s;
        align-items: center;
        display: flex;
        position: relative;
        width: 10rpx;
        height: 100%;

        &::before {
          content: '';
          position: absolute;
          top: calc(50% - 8rpx);
          right: -2rpx;
          transform: translateY(-50%);
          border: 6rpx solid transparent;
          border-bottom-color: #c1c1c1;
        }

        &::after {
          content: '';
          position: absolute;
          top: calc(50% + 8rpx);
          right: -2rpx;
          transform: translateY(-50%);
          border: 6rpx solid transparent;
          border-top-color: #c1c1c1;
        }
      }

      .le-dropdown-menu-item-arrow_top {
        &::before {
          border-bottom-color: $dropdownThemeColor;
        }
      }

      .le-dropdown-menu-item-arrow_bottom {
        &::after {
          border-top-color: $dropdownThemeColor;
        }
      }

      .le-dropdown-menu-item-basicarrow {
        margin-left: 6rpx;
        transition: transform 0.3s;
        align-items: center;
        display: flex;
        position: relative;
        border: 6rpx solid transparent;
        border-bottom: 0rpx solid transparent;
        border-top-color: #c1c1c1;
      }

      .le-dropdown-menu-item-basicarrow_rotate {
        transform: rotate(180deg);
        border-top-color: $dropdownThemeColor;
      }
    }
  }

  .le-dropdown-content {
    position: absolute;
    z-index: 8;
    width: 100%;
    left: 0px;
    bottom: 0;
    overflow: hidden;

    .le-dropdown-content-mask {
      position: absolute;
      z-index: 9;
      background: rgba(0, 0, 0, 0.3);
      width: 100%;
      left: 0;
      top: 0;
      bottom: 0;
    }

    .le-dropdown-content-popup {
      position: relative;
      max-height: 100%;
      overflow: auto;
      overscroll-behavior: contain;
      z-index: 10;
      transition: all 0.3s;
      transform: translate3D(0, -100%, 0);
    }
  }
}

.le-dropdown-ceiling {
  position: sticky;
  top: 0;
  z-index: 1;
}

.le-dropdown-popup-content {
  font-size: 28rpx;
  border-radius: 0 0 20rpx 20rpx;
  background-color: #ffffff;
}

// 单选列表
.le-dropdown-cell {
  padding: 0 30rpx;

  .le-dropdown-cell-item {
    padding: 20rpx 0;
    color: #333333;
    font-size: 28rpx;
    border-bottom: 1rpx solid #d5d5d5;
    display: flex;
    align-items: center;
    justify-content: space-between;
    .le-dropdown-cell-active-text {
      flex: 1;
      padding-right: 20rpx;
    }
  }

  .le-dropdown-cell-item:last-child {
    border-bottom: 0rpx solid #d5d5d5;
  }

  .le-dropdown-cell-active {
    color: $dropdownThemeColor;
    .le-dropdown-cell-active-icon {
      width: 12rpx;
      height: 28rpx;
      margin-right: 10rpx;
      border-color: $dropdownThemeColor;
      border-style: solid;
      border-width: 0 4rpx 4rpx 0;
      transform: rotate(45deg);
    }
  }
}

// 筛选
.le-dropdown-filter {
  .le-dropdown-filter-item {
    padding: 0 26rpx;
  }

  .le-dropdown-filter-title {
    padding-top: 34rpx;
    margin-bottom: 18rpx;
    color: #333333;
    font-size: 28rpx;

    .le-dropdown-filter-subtitle {
      margin-left: 10rpx;
      color: $dropdownThemeColor;
    }
  }

  .le-dropdown-filter-content {
    display: flex;
    flex-wrap: wrap;
  }

  .le-dropdown-filter-box {
    width: 200rpx;
    margin-right: 30rpx;
    margin-bottom: 14rpx;
    padding: 18rpx 0;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 28rpx;
    color: #333333;
    background-color: #f5f5f5;
    border-radius: 999rpx;
  }

  .le-dropdown-filter-box-active {
    color: $dropdownThemeColor;
  }
}

.le-dropdown-footer {
  display: flex;
  align-items: center;
  margin-top: 14rpx;

  .le-dropdown-reset {
    flex: 1;
    margin: 26rpx;
    display: flex;
    align-items: center;
    justify-content: center;
    height: 68rpx;
    font-size: 28rpx;
    background-color: #ffffff;
    color: $dropdownThemeColor;
    border: 2rpx solid $dropdownThemeColor;
    border-radius: 999rpx;
  }

  .le-dropdown-confirm {
    flex: 1;
    margin: 26rpx;
    display: flex;
    align-items: center;
    justify-content: center;
    height: 68rpx;
    font-size: 28rpx;
    background-color: $dropdownThemeColor;
    border: 2rpx solid $dropdownThemeColor;
    color: #ffffff;
    border-radius: 999rpx;
  }
}
</style>
