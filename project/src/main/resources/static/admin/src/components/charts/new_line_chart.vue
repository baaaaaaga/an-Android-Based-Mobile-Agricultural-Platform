<template>
	<div class="line_chart" :id="id">折线图</div>
</template>

<script>
	import echarts from "@/assets/js/echarts.min.js";
	import option from "element-ui/packages/option";
	export default {
		name: "Home",
		components: {},
		props: {
			id: {
				type: String,
				default: "lineChart"
			},
			title: {
				type: String,
				default: "XXX折线图"
			},
			vm: {
				type: Object,
				default: function() {
					return {
						xAxis: "xAxis",
						names: "names",
						values: "values",
					};
				},
			},
			timeout:{
				type: Number,
				default: 2000
			},
			color:{
				type: Array,
				default:[]
			}
		},
		data() {
			return {
				option: {
					title: {
						text: "XXX折线图",
						left: "center",
					},
					tooltip: {
						trigger: 'axis'
					},
					legend: {
						type: 'scroll',
						orient: 'horizontal',
						y: 'bottom'
					},
					grid: {
						left: "3%",
						right: "10%",
						bottom: "14%",
						containLabel: true,
					},
					toolbox: {
						feature: {
							saveAsImage: {},
						},
					},
					xAxis: [{
						type: 'category',
						boundaryGap: false,
						data: []
					}],
					yAxis: [{
						type: 'value'
					}],
					series: [
						// {
						// 	name: 'Forest',
						// 	type: 'bar',
						// 	barGap: 0,
						// 	emphasis: {
						// 		focus: 'series'
						// 	},
						// 	data: [320, 332, 301, 334, 390]
						// },
					]
				}
			};
		},
		created() {
			if(this.color.length > 0){
				this.option.color = this.color
			}
		},
		mounted() {
			let that=this;
			setTimeout(function(){
				that.init_chart();
			}, this.timeout)
		},
		methods: {
			init_chart() {
				var option = this.option;

				var title = this.title;
				if (title) {
					option.title.text = title;
				}

				var series = this.series;
				option.series = series;

				var xAxis = option.xAxis[0];
				xAxis.data = this.vm.xAxis;

        if (xAxis.data.length>4){
          option.axisLabel= {
            interval: 0, //使x轴文字显示全
            formatter: function (params) {
              let newParamsName = '';
              const paramsNameNumber = params.length; // 文字总长度
              const provideNumber = 4; //一行显示几个字
              const rowNumber = Math.ceil(paramsNameNumber / provideNumber);
              if (paramsNameNumber > provideNumber) {
                for (let p = 0; p < rowNumber; p++) {
                  const start = p * provideNumber;
                  const end = start + provideNumber;
                  const tempStr = p === rowNumber - 1 ? params.substring(start, paramsNameNumber) : params.substring(start, end) + '\n';
                  newParamsName += tempStr;
                }
              } else {
                newParamsName = params;
              }
              return newParamsName;
            },
          }
        }
				let myChart = echarts.init(document.getElementById(this.id));
				myChart.setOption(option);
			},
		},
		computed: {
			series() {
				var vm = this.vm;
				var list = this.vm.names;
				var values = vm.values;
				var series = [];
				for (let i=0;i<list.length;i++){
					let data = []
					for (let j=0;j<values.length;j++){
						data.push(values[j][i]);
					}
					let dict_type = {
							name: list[i],
							type: 'line',
						 	data: data
					}
					series.push(dict_type);
				}

				return series;
			},
      getValues() {
        return this.vm.values
      }
		},
		watch: {
			list() {
				this.init_chart();
			},
      getValues(newV,oldV) {
        this.init_chart();
      }
		},
	};
</script>
