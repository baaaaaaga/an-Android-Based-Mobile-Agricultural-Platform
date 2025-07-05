<template>
  <view class="picker-view">
    <scroll-view
      v-for="(num, index) in colNum"
      :key="index"
      :style="{
        width: `${(1 / colNum) * 100}%`,
        height: '100%',
        backgroundColor: index === 0 ? '#F6F6F6' : '#FFFFFF',
      }"
      scroll-y
    >
      <view
        :class="['picker-view-item', value[index] == item.value && 'picker-view-item-active']"
        v-for="(item, indexs) in colList[index]"
        :key="indexs"
        @click="onSelect(index, item, indexs)"
      >
        {{ item.label }}
      </view>
    </scroll-view>
  </view>
</template>

<script>
export default {
  props: {
    value: {
      // 当前显示的下标 (使用v-model语法糖: 1.props需为value; 2.需回调input事件)
      type: Array,
      default: () => [],
    },
    // 展示的列数
    colNum: {
      type: Number,
      default: 1,
    },
    // options 数据
    options: {
      type: Array,
      default: [],
    },
    // 自定义节点 label、value、children 的字段
    fieldNames: {
      type: Object,
      default: () => {
        return {
          label: 'label',
          value: 'value',
          children: 'children',
        };
      },
    },
  },
  data() {
    return {};
  },
  computed: {
    colList() {
      const arr = [];
      let option = this.$props.options;
      for (let i = 0; i < this.$props.colNum; i++) {
        if (
          (this.$props.value[i] != undefined && option) ||
          (this.$props.value[i - 1] && option) ||
          (i === 0 && option)
        ) {
          arr.push(this.funOptions(option));
          const index = option?.findIndex(
            (item) => item[this.$props.fieldNames.value] == this.$props.value[i]
          );
          option = (option[index] && option[index]?.[this.$props.fieldNames.children]) || [];
        }
      }
      return arr;
    },
  },
  methods: {
    funOptions(data) {
      return data.map((item) => {
        return {
          label: item[this.$props.fieldNames.label],
          value: item[this.$props.fieldNames.value],
          children: item[this.$props.fieldNames.children] || [],
        };
      });
    },
    onSelect(index, item, indexs) {
      const modelValue = JSON.parse(JSON.stringify(this.$props.value));
      if (modelValue[index] != item.value) {
        modelValue[index] = item.value;
        let option = item[this.$props.fieldNames.children] || [];
        for (let i = index + 1; i < this.$props.colNum; i++) {
          if (option[0]) {
            modelValue[i] = option[0][this.$props.fieldNames.value];
            option = option[0]?.[this.$props.fieldNames.children] || [];
          } else if (modelValue[i]) {
            modelValue.splice(i, modelValue.length);
          }
        }
      }
      this.$emit('update:value', modelValue);
    },
  },
};
</script>

<style lang="scss" scoped>
.picker-view {
  width: 100%;
  height: 600rpx;
  display: flex;
  .picker-view-item {
    padding: 30rpx 0;
    text-align: center;
    font-size: 24rpx;
    color: #333333;
  }
  .picker-view-item-active {
    color: var(--dropdownThemeColor);
  }
}
</style>
