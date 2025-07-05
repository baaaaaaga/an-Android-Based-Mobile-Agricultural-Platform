<template>
  <view class="charts-box">
    <qiun-data-charts type="line" :opts="opts" :chartData="chartData" />
  </view>
</template>

<script>
import qiunDataCharts from '../../components/qiun-data-charts/components/qiun-data-charts/qiun-data-charts.vue';
export default {
  components: {
    qiunDataCharts,
  },
  props: ['vm', 'lineValue'],
  data() {
    return {
      chartData: {},
      //您可以通过修改 config-ucharts.js 文件中下标为 ['line'] 的节点来配置全局默认参数，如都是默认参数，此处可以不传 opts 。实际应用过程中 opts 只需传入与全局默认参数中不一致的【某一个属性】即可实现同类型的图表显示不同的样式，达到页面简洁的需求。
      opts: {
        color: [
          '#1890FF',
          '#91CB74',
          '#FAC858',
          '#EE6666',
          '#73C0DE',
          '#3CA272',
          '#FC8452',
          '#9A60B4',
          '#ea7ccc',
        ],
        padding: [15, 10, 0, 15],
        enableScroll: false,
        legend: {},
        xAxis: {
          disableGrid: true,
          rotateLabel: true,
          rotateAngle: -90,
          marginTop: 10,
        },
        yAxis: {
          gridType: 'dash',
          dashLength: 2,
        },
        extra: {
          line: {
            type: 'straight',
            width: 2,
            activeType: 'hollow',
          },
        },
      },
    };
  },
  created() {
    var series = [];
    this.vm.names.forEach((item, index) => {
      var seriesItem = {},
        values = [];
      seriesItem.name = item;
      this.vm.values.forEach((item_0, index_0) => {
        values.push(item_0[item_0.length - index - 1]);
      });
      seriesItem.data = values;
      series.push(seriesItem);
    });
    let res = {
      categories: this.vm.xAxis,
      series,
    };
    this.chartData = JSON.parse(JSON.stringify(res));
  },
  methods: {},
};
</script>

<style scoped>
/* 请根据实际需求修改父元素尺寸，组件自动识别宽高 */
.charts-box {
  width: 100%;
  height: 300px;
  margin-top: 30px;
}
</style>
