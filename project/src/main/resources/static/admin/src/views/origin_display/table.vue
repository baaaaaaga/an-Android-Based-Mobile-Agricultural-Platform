<template>
	<el-main class="bg table_wrap comtabel_t">
		<el-form label-position="right" :model="query" class="form p_4" label-width="120">
			<el-row class="rows row1">



							<el-col :xs="24" :sm="24" :lg="8" class="el_form_search_wrap">
					<el-form-item label="产地名称">
									<el-input v-model="query.name_of_place_of_origin"></el-input>
								</el-form-item>
				</el-col>
															<el-col :xs="24" :sm="24" :lg="8" class="el_form_search_wrap">
					<el-form-item label="产地类型">
									<el-select v-model="query.type_of_place_of_origin">
											<el-option v-for="o in list_type_of_place_of_origin" :key="o.type_of_place_of_origin" :label="o.type_of_place_of_origin"
								:value="o.type_of_place_of_origin">
							</el-option>
										</el-select>
								</el-form-item>
				</el-col>
																						</el-row>
	<el-row class="rows row2">

		<el-col :xs="24" :sm="24" :lg="24" class="search_btn_wrap search_btns">

				<el-col :xs="24" :sm="10" :lg="8" class="search_btn_1 search_btn_wrap_1 btns">

										<el-button type="primary" @click="search()" class="search_btn_find">查询</el-button>
						<el-button @click="reset()" style="margin-right: 74px;" class="search_btn_reset">重置</el-button>
																		

						<el-button v-if="$check_action('/origin_display/table','del') || $check_action('/origin_display/view','del')" class="search_btn_del" type="danger" @click="delInfo()">删除</el-button>
								
				</el-col>
		</el-col>
	</el-row >

		</el-form>
				<el-table :data="list" @selection-change="selectionChange" @sort-change="$sortChange" style="width: 100%" id="dataTable">
					<el-table-column fixed type="selection" tooltip-effect="dark" width="55">
			</el-table-column>
				<el-table-column prop="name_of_place_of_origin" @sort-change="$sortChange" label="产地名称" 				v-if="$check_field('get','name_of_place_of_origin')" min-width="200">
					</el-table-column>
					<el-table-column prop="cover_chart" @sort-change="$sortChange" label="封面图" 				v-if="$check_field('get','cover_chart')" min-width="200">
						<template slot-scope="scope">
					<el-image style="width: 100px; height: 100px" :src="$fullUrl(scope.row['cover_chart'])"
						:preview-src-list="[$fullUrl(scope.row['cover_chart'])]">
						<div slot="error" class="image-slot">
							<img src="../../../public/img/error.png" style="width: 90px; height: 90px" />
						</div>
					</el-image>
				</template>
					</el-table-column>
					<el-table-column prop="place_of_origin_address" @sort-change="$sortChange" label="产地地址" 				v-if="$check_field('get','place_of_origin_address')" min-width="200">
					</el-table-column>
					<el-table-column prop="type_of_place_of_origin" @sort-change="$sortChange" label="产地类型" 				v-if="$check_field('get','type_of_place_of_origin')" min-width="200">
					</el-table-column>
					<el-table-column prop="scale_of_origin" @sort-change="$sortChange" label="产地规模" 				v-if="$check_field('get','scale_of_origin')" min-width="200">
					</el-table-column>
					<el-table-column prop="introduction_of_origin" @sort-change="$sortChange" label="产地介绍" 				v-if="$check_field('get','introduction_of_origin')" min-width="200">
					</el-table-column>
					<el-table-column prop="farmers_merchants" @sort-change="$sortChange" label="农户商家" 				v-if="$check_field('get','farmers_merchants')" min-width="200">
						<template slot-scope="scope">
					{{ get_user_farmers_merchants(scope.row['farmers_merchants']) }}
				</template>
					</el-table-column>
					<el-table-column prop="business_name" @sort-change="$sortChange" label="商家名称" 				v-if="$check_field('get','business_name')" min-width="200">
					</el-table-column>
					<el-table-column prop="contact_number" @sort-change="$sortChange" label="联系号码" 				v-if="$check_field('get','contact_number')" min-width="200">
					</el-table-column>
					<el-table-column prop="business_address" @sort-change="$sortChange" label="商家地址" 				v-if="$check_field('get','business_address')" min-width="200">
					</el-table-column>
	


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







			<el-table-column fixed="right" label="操作" min-width="200" v-if="$check_action('/origin_display/table','set') || $check_action('/origin_display/view','set') || $check_action('/origin_display/view','get') 
						|| $check_action('/interactive_consultation/table','add') || $check_action('/interactive_consultation/view','add') 
						" >


				<template slot-scope="scope">
					<div class="view_a">
					<router-link class="e-button el-button--small is-plain el-button--success" style="margin: 5px !important;"
					v-if="$check_action('/origin_display/table','set') || $check_action('/origin_display/view','set') || $check_action('/origin_display/view','get')"
						:to="'./view?' + field + '=' + scope.row[field]"
						 size="small">
						<span>详情</span>
					</router-link>
						<router-link v-if="$check_comment('/origin_display/table')" class="e-button el-button--small is-plain el-button--primary"
								  :to="'../comment/table?size=10&page=1&source_table=origin_display&source_field=' + field + '&source_id=' + scope.row[field]" size="small">
						<span>查看评论</span>
					</router-link>
					</div>
				</template>
			</el-table-column>

		</el-table>

		<!-- 分页器 -->
		<div class="mt text_center">
			<el-pagination @size-change="handleSizeChange" @current-change="handleCurrentChange"
				:current-page="query.page" :page-sizes="[7, 10, 30, 100]" :page-size="query.size"
				layout="total, sizes, prev, pager, next, jumper" :total="count">
			</el-pagination>
		</div>
		<!-- /分页器 -->
										
		<div class="modal_wrap" v-if="showModal">
			<div class="modal_box">
				<!-- <div class="modal_box_close" @click="closeModal">X</div> -->
				<p class="modal_box_title">重要提醒</p>
				<p class="modal_box_text">当前有数据达到预警值！</p>
				<p class="modal_box_text">{{ message }}</p>
				<div class="btn_box">
					<span @click="closeModal">取消</span>
					<span @click="closeModal">确定</span>
				</div>
			</div>
		</div>


	</el-main>
</template>
<script>
	import mixin from "@/mixins/page.js";

	export default {
		mixins: [mixin],
		data() {
			return {
				// 弹框
				showModal: false,
				// 获取数据地址
				url_get_list: "~/api/origin_display/get_list?like=0",
				url_del: "~/api/origin_display/del?",

				// 字段ID
				field: "origin_display_id",

				// 查询
				query: {
					"size": 7,
					"page": 1,
								"name_of_place_of_origin": "",
													"type_of_place_of_origin": "",
														"login_time": "",
					"create_time": "",
					"orderby": `create_time desc`
				},

				// 数据
				list: [],
																					// 产地类型列表
				list_type_of_place_of_origin: [""],
														// 用户列表
				list_user_farmers_merchants: [],
											message: '',
			}
		},
		methods: {
			// 关闭弹框
			closeModal(){
				this.showModal = false;
				},
			/**
			 * @description 获取到列表事件
			 * @param {Object} res 响应结果
			 */
			get_list_after: function get_list_after(res, func, url) {
				let _this = this
																																																									},
			get_list_before(param){
				var user_group = this.user.user_group;
				if(user_group != "管理员"){
						let sqlwhere = "(";
																																								if(user_group=="农户商家"){
						sqlwhere+= "farmers_merchants = " + this.user.user_id + " or ";
					}
																									if (sqlwhere.length>1){
						sqlwhere = sqlwhere.substr(0,sqlwhere.length-4);
						sqlwhere += ")";
						param["sqlwhere"] = sqlwhere;
					}
					}
				return param;
			},

										/**
			 * 获取产地类型列表
			 */
			async get_list_type_of_place_of_origin() {
				var json = await this.$get("~/api/type_of_place_of_origin/get_list?");
				if(json.result){
					this.list_type_of_place_of_origin = json.result.list;
				}else if (json.error){
					console.log(json.error);
				}
			},
														



																/**
			 * 获取农户商家用户列表
			 */
			async get_list_user_farmers_merchants() {
				var json = await this.$get("~/api/user/get_list?user_group=农户商家");
				if(json.result && json.result.list){
					this.list_user_farmers_merchants = json.result.list;
				}
				else if(json.error){
					console.error(json.error);
				}
			},

			get_user_farmers_merchants(id){
				var obj = this.list_user_farmers_merchants.getObj({"user_id":id});
				var ret = "";
				if(obj){
					ret = obj.nickname+"-"+obj.username;
					// if(obj.nickname){
					// 	ret = obj.nickname;
					// }
					// else{
					// 	ret = obj.username;
					// }
				}
				return ret;
			},
										},
				created() {
										// 初始化产地类型列表
			this.get_list_type_of_place_of_origin();
													this.get_list_user_farmers_merchants();
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

	.text_center {
		text-align: center;
	}

	.float-right {
		float: right;
	}


	.modal_wrap{
		width: 100vw;
		height: 100vh;
		position: fixed;
		top: 0;
		left: 0;
		background: rgba(0,0,0,0.5);
		z-index: 9999999999;
	}
	.modal_wrap .modal_box{
		width: 400px;
		height: auto;
		background: url("../../assets/modal_bg.jpg") no-repeat center;
		background-size: cover;
		position: absolute;
		top: 50%;
		left: 50%;
		margin-left: -200px;
		margin-top: -100px;
		border-radius: 10px;
		padding: 10px;
		}
	.modal_wrap .modal_box .modal_box_close{
		font-size: 20px;
		position: absolute;
		top: 10px;
		right: 10px;
		cursor: pointer;
		}
	.modal_wrap .modal_box .modal_box_title{
	  text-align: center;
    font-size: 18px;
    margin: 16px auto;
    color: #fff;
    border-bottom: 1px solid rgba(117, 116, 116,0.5);
    padding-bottom: 16px;
    width: 356px;
		}
	.modal_wrap .modal_box .modal_box_text{
		text-align: center;
		font-size: 14px;
		color: #fff;
		margin: 5px auto;
		width: 90%;
		}
	.modal_wrap .modal_box .btn_box{
		display: flex;
		flex-direction: row;
		justify-content: center;
		margin-top: 42px;
		margin-bottom: 20px;
		}
			.modal_wrap .modal_box .btn_box span{
				display: inline-block;
				width: 80px;
				height: 30px;
				line-height: 30px;
				text-align: center;
				border: 1px solid #ccc;
				font-size: 14px;
				cursor: pointer;
				color: #fff;
			}
	.modal_wrap .modal_box .btn_box span:nth-child(2){
		background: #409EFF;
		color: #fff;
		border-color: #409EFF;
		margin-left: 15px;
	}
	.el-date-editor .el-range-separator{
		width: 10% !important;
	}
</style>
