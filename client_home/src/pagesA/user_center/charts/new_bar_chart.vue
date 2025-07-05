<template>
  <view class="charts-box">
    <qiun-data-charts type="column" :opts="opts" :chartData="chartData" />
  </view>
</template>

<script>
import qiunDataCharts from '../../components/qiun-data-charts/components/qiun-data-charts/qiun-data-charts.vue';
export default {
  components: {
    qiunDataCharts,
  },
  props: ['vm'],
  data() {
    return {
      chartData: {},
      //您可以通过修改 config-ucharts.js 文件中下标为 ['column'] 的节点来配置全局默认参数，如都是默认参数，此处可以不传 opts 。实际应用过程中 opts 只需传入与全局默认参数中不一致的【某一个属性】即可实现同类型的图表显示不同的样式，达到页面简洁的需求。
      opts: {
        color: [
          '#91CB74',
          '#1890FF',
          '#FAC858',
          '#EE6666',
          '#73C0DE',
          '#3CA272',
          '#FC8452',
          '#9A60B4',
          '#ea7ccc',
        ],
        padding: [15, 15, 0, 5],
        enableScroll: false,
        legend: {},
        xAxis: {
          disableGrid: true,
          rotateLabel: true,
          rotateAngle: -90,
          marginTop: 10,
        },
        yAxis: {
          data: [
            {
              min: 0,
            },
          ],
        },
        extra: {
          column: {
            type: 'group',
            width: 30,
            activeBgColor: '#000000',
            activeBgOpacity: 0.08,
          },
        },
      },
    };
  },
  created() {
    const categories = this.vm.xAxis;
    const res = {
      categories,
      series: [
        // {
        //   name: "目标值",
        //   data
        // },{
        //   name: "完成量",
        //   data: [18,27,21,24,6,28]
        // }
      ],
    };
    this.vm.names.forEach((value, index) => {
      const data = [];
      this.vm.values.forEach((v, i) => {
        data.push(parseFloat(v[index]));
      });
      res.series.push({
        name: value,
        data: data,
      });
    });
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
