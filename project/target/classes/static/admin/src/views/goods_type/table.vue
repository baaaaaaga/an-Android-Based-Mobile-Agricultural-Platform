<template>
	<el-main class="bg table_wrap goods_type">
		<el-form label-position="right" :model="query" class="form p_4" label-width="120">
			<el-row class="rows row1">
				<el-col :xs="24" :sm="24" :lg="8" class="el_form_search_wrap">
					<el-form-item label="分类名称">
						<el-input v-model="query.name"></el-input>
					</el-form-item>
				</el-col>
			</el-row>
			<el-row class="rows row2">
				<el-col :xs="24" :sm="24" :lg="24" class="search_btn_wrap">
					<el-col :xs="24" :sm="12" :lg="12" class="search_btn_1 btns">
					
							<el-button type="primary" @click="search()" class="search_btn_find">查询</el-button>
							<el-button @click="reset()" class="search_btn_reset">重置</el-button>
							<el-button v-if="$check_action('/goods/table','del')" class="float-right search_btn_del" type="danger" @click="delInfo()">删除</el-button>
							<!-- <router-link v-if="user_group == '管理员' || $check_action('/goods_type/view')" class="el-button float-right el-button--default el-button--primary search_btn_add"
								to="./view?"><span>添加</span>
							</router-link> -->
							<el-button  v-if="$check_action('/goods/view')" class="float-right  search_btn_add" @click="$router.push('./view?')">添加</el-button>
				
						
					</el-col>
					
				</el-col>
			</el-row>
		</el-form>

		<el-table border :data="list" @selection-change="selectionChange" style="width: 100%">

			<!-- 多选按钮 -->
			<el-table-column fixed type="selection" tooltip-effect="dark" width="55">
			</el-table-column>
			<!-- /多选按钮 -->

			<el-table-column fixed label="分类名称" prop="name" width="120">
			</el-table-column>

			<!--<el-table-column label="图标" prop="icon" min-width="100">-->
				<!--<template slot-scope="scope">-->
					<!--<el-image style="width: 100px; height: 100px" :src="$fullUrl(scope.row.icon)" :preview-src-list="[$fullUrl(scope.row.icon)]">-->
						<!--<div slot="error" class="image-slot">-->
							<!--<img src="/img/error.png" style="width: 90px; height: 90px" />-->
						<!--</div>-->
					<!--</el-image>-->
				<!--</template>-->
			<!--</el-table-column>-->

			<!--<el-table-column label="描述" prop="desc" min-width="80">-->
			<!--</el-table-column>-->

			<el-table-column sortable prop="create_time" label="创建时间" min-width="200">
			    <template slot-scope="scope">
			        {{ $toTime(scope.row["create_time"],"yyyy-MM-dd hh:mm:ss") }}
			    </template>
			</el-table-column>

			<el-table-column sortable prop="update_time" label="更新时间" min-width="200">
			    <template slot-scope="scope">
			        {{ $toTime(scope.row["update_time"],"yyyy-MM-dd hh:mm:ss") }}
			    </template>
			</el-table-column>

			<!-- 操作 -->
			<el-table-column fixed="right" label="操作" width="120">
				<template slot-scope="scope">
					<div class="view_a">
						<router-link class="e-button el-button--small is-plain el-button--primary" :to="'./view?' + field + '=' + scope.row[field]"
						size="small"><span>详情</span></router-link>
					</div>
				</template>
			</el-table-column>
			<!-- /操作 -->

		</el-table>

		<!-- 分页器 -->
		<div class="mt text_center">
			<el-pagination @size-change="handleSizeChange" @current-change="handleCurrentChange" :current-page="query.page" :page-sizes="[7, 10, 30, 100]" :page-size="query.size" layout="total, sizes, prev, pager, next, jumper" :total="count">
			</el-pagination>
		</div>
		<!-- /分页器 -->

	</el-main>
</template>

<script>
	import mixin from "@/mixins/page.js";

	export default {
		mixins: [mixin],
		data() {
			return {

				// 表
				table:"goods_type",

				// 获取数据地址
				url_get_list: "~/api/goods_type/get_list?like=0",
				url_del: "~/api/goods_type/del?",

				// 字段ID
				field:"type_id",

				// 查询
				query: {
					size: 10,
					page: 1,
					name: ""
				},

				// 数据
				list: [],

				// 状态
				list_state: [
					{"name":"使用中","value":1},
					{"name":"已失效","value":0}
				]
			}
		},
		methods: {
		},
		created(){
		}
	}
</script>

<style type="text/css">
	.bg {
		background: white;
	}

	.form.p_4 {
		padding: 1rem;
	}

	.form .el-input {
		width: initial;
	}

	.mt {
		margin-top: 1rem;
	}

	.float-right {
		float: right;
	}

	.mr-1 {
		margin-right: 1rem;
	}

	.el-table .table_class {
		background: rgba(150, 150, 150, 0.1);
		text-align: center;
	}

	.text_center {
		text-align: center;
	}

	.float-right {
		float: right;
	}
</style>
