<template>
	<div class="page_root" id="root_index">
		<div class="warp">
			<div class="container-fluid">
				<el-row>
<!--					<el-col :span="4">-->
<!--						<div_label bg_color="bg_red" icon="el-icon-message" :url="url_message_count" unit="条"-->
<!--								  title="留言信息"></div_label>-->
<!--					</el-col>-->
					<el-col :span="4">
						<div_label bg_color="bg_purple" icon="el-icon-user-solid" :url="url_user_count" unit="人"
								  title="用户数量"></div_label>
					</el-col>
<!--					<el-col :span="4">-->
<!--						<div_label bg_color="bg_green" icon="el-icon-view" :url="url_article_hits" unit="次"-->
<!--								  title="文章浏览量"></div_label>-->
<!--					</el-col>-->
				</el-row>

				<el-row>
					<el-col v-if="$check_figure('/order/table')" :span="8">
						<div v-loading="line_obj_shop_money.loading" class="card chart">
							<el-date-picker
									v-model="line_obj_shop_money.month"
									:default-time="['00:00:00', '23:59:59']"
									align="right"
									end-placeholder="结束日期"
									start-placeholder="开始日期"
									type="datetimerange"
									format="yyyy-MM-dd"
									@change="changeMonth($event, line_obj_shop_money)">
							</el-date-picker>
							<span v-if="!line_obj_shop_money.loading" style="margin-left: 20px;display: inline!important;">总销售金额：{{line_obj_shop_money.total}}</span>
							<newLineChart :color="['#fff000']" v-if="line_obj_shop_money.values.length > 0" id="line_obj_shop_money"
										  :timeout="0" :title="'商品销售金额统计'" :vm="line_obj_shop_money" style="margin-top: 20px;height: 300px">
							</newLineChart>
						</div>
					</el-col>
					<el-col v-if="$check_figure('/order/table')" :span="8">
						<div v-loading="bar_obj_shop_num.loading" class="card chart">
							<el-date-picker
									v-model="bar_obj_shop_num.month"
									:default-time="['00:00:00', '23:59:59']"
									align="right"
									end-placeholder="结束日期"
									start-placeholder="开始日期"
									type="datetimerange"
									format="yyyy-MM-dd"
									@change="changeMonth($event, bar_obj_shop_num)">
							</el-date-picker>
							<span v-if="!bar_obj_shop_num.loading" style="margin-left: 20px">总销售数量：{{bar_obj_shop_num.total}}</span>
							<newBarChart v-if="bar_obj_shop_num.values.length > 0" id="bar_obj_shop_num"
										 :timeout="0" :title="'商品销售数量统计'" :vm="bar_obj_shop_num" style="margin-top: 20px;height: 300px">
							</newBarChart>
						</div>
					</el-col>
														</el-row>

			</div>
		</div>
	</div>
</template>
<script>
	import mixin from "@/mixins/page.js";
	import newBarChart from "@/components/charts/new_bar_chart";
	import newLineChart from "@/components/charts/new_line_chart";
	import div_label from "@/components/div_label.vue";
	export default {
		mixins: [mixin],
		name: "Home",
		components: {
			newBarChart,
			newLineChart,
			div_label
		},
		data() {
			return {
				activeName: "third",
																								line_obj_shop_money: {
					type: "money",
					names: ["销售金额"],
					xAxis: [],
					values: [],
					month: [],
					loading: false,
					total: 0
				},
				bar_obj_shop_num: {
					type: "num",
					names: ["销售数量"],
					xAxis: [],
					values: [],
					month: [],
					loading: false,
					total: 0
				},
				url_message_count: "~/api/message/count?",
				url_user_count: "~/api/user/count?",
				url_article_hits: "~/api/article/sum?field=hits",
			};
		},
		created() {
													this.get_order_month_some_price(null, this.line_obj_shop_money)
			this.get_order_month_some_price(null, this.bar_obj_shop_num)
		},
		mounted() {},
		methods: {
			async get_nickname(list,flag){
				if (flag) {
					for (let i=0;i<list.length;i++){
						await this.$get(
								"~/api/user/get_obj?user_id="+list[i],
								null,
								(json) => {
									if (json.result) {
										list[i] = json.result.obj.nickname;
									}
								});
					}
				}else {
					for (let i=0;i<list.length;i++){
						await this.$get(
								"~/api/user/get_obj?user_id="+list[i].name,
								null,
								(json) => {
									if (json.result) {
										list[i].name = json.result.obj.nickname;
									}
								});
					}
				}
			},
																				
			// 获取指定日期的数据
			async get_order_month_some_price(date, o) {

				function getDateBetween(start, end) {
					var result = [];
					//使用传入参数的时间
					var startTime = new Date(start);
					var endTime = new Date(end);
					while (endTime - startTime >= 0) {
						let year = startTime.getFullYear();
						let month = startTime.getMonth();
						month = month < 9 ? '0' + (month + 1) : month + 1;
						let day = startTime.getDate().toString().length === 1 ? "0" + startTime.getDate() : startTime.getDate();
						//加入数组
						result.push(year + "-" + month + "-" + day);
						//更新日期
						startTime.setDate(startTime.getDate() + 1);
					}
					return result;
				}

				const now = new Date();
				const nowYear = now.getFullYear();
				const nowMonth = now.getMonth() + 1;
				const nowDate = now.getDate();
				let days = []
				if(date){
					days = getDateBetween(date[0], date[1])
				}else{
					o.month[0] = new Date(nowYear, nowMonth - 1, 1, 0, 0, 0)
					o.month[1] = new Date(nowYear, nowMonth - 1, nowDate, 23, 59, 59)
					days = getDateBetween(o.month[0], o.month[1])
				}

				o.xAxis = []
				o.values = []
				o.loading = true
				let list = {
					result: [],
					total: 0
				}
				let field = o.type === "money" ? "price_count" : "num"
				for (let i = 0; i < days.length; i++) {
					const t = new Date(days[i])
                	const time = t.getFullYear() + "-" + (t.getMonth()+1) + "-" + t.getDate()
					o.xAxis.push((t.getMonth()+1) + "-" + t.getDate())
					await this.get_order_sum_price_sub(list, time, i, field)
				}
				o.loading = false
				o.values = list.result
				o.total = list.total
			},
			// 获取某一天的销售数量
			async get_order_sum_price_sub(list, date, index, field) {
				let time = new Date(date).toStr("yyyy-MM-dd");
				var $where = ""
				if (this.user.user_group != "管理员")
						$where = '&merchant_id=' + this.user.user_id
				const json = await this.$get(
						`~/api/order/sum?field=${field}&create_time_min=${time} 00:00:00&create_time_max=${time} 23:59:59&state=已付款` + $where,
						null,
				);
				list.result[index] = []
				if (json.result) {
					list.total += json.result
					list.result[index].push(json.result)
				} else {
					list.result[index].push(0)
				}
			},

			// 选择日期
			changeMonth(e, o) {
				this.get_order_month_some_price(e, o)
			},
		},
		computed:{
			recognitionHeight(){
				return "830px"
			},
			recognitionUrl(){
				return "https://www.faceplusplus.com.cn/${model.filter.recognitionType}/"
			}
		}
	};
</script>

<style scoped="scoped">
	.chart {
		display: block;
		width: 100%;
		height: 400px;
		padding: 1rem;
		position: relative;
	}

	.el-col {
		padding: 0.5rem;
	}

	.card {
		overflow: hidden;
	}

	.iframe_box ,.iframe_box_change{
		width: 100%;
		height: 1180px;
		position: relative;
		margin-top: 25px;
	}
	.iframe_box_change{
		height: 580px;
		padding-top: 50px;
	}
	.iframe_box	.iframe_box_content, .iframe_box_change .iframe_box_content{
		width: 100%;
		height: 100%;
	}
	.iframe_box_top{
		position: absolute;
		top: 0;
		left: 0;
		width: 100%;
		height: 100px;
		font-size: 25px;
		line-height: 100px;
		background: #fff;
		z-index: 99999999;
		padding-left: 50px;
	}
	#iframe_box_face div::before {
		content: '';
		width: 100px;
		position: absolute;
		top: 154px;
		right: 129px;
		z-index: 999;
		height: 20px;
		background-color: #FFFFFF;
	}

	#iframe_box_face>h1 {
		margin-top: 100px;
		margin-bottom: 20px;
	}
</style>
