<template>
	<el-form ref="form" :rules="rules" :model="form" status-icon label-width="80px">
			<el-col :xs="24" :sm="12" :lg="8" class="el_form_item_warp">
			<el-form-item label="产品规格" prop="product_specifications">
						<el-input id="product_specifications" v-model="form['product_specifications']" placeholder="请输入产品规格"
					v-if="(form['agricultural_products_id'] && $check_field('set','product_specifications') ) || $check_field('add','product_specifications')"></el-input>
				<div v-else-if="$check_field('get','product_specifications')">{{form['product_specifications']}}</div>
					</el-form-item>
		</el-col>
						<el-col :xs="24" :sm="12" :lg="8" class="el_form_item_warp">
			<el-form-item label="商家名称" prop="business_name">
						<el-input id="business_name" v-model="form['business_name']" placeholder="请输入商家名称"
					v-if="(form['agricultural_products_id'] && $check_field('set','business_name') ) || $check_field('add','business_name')"></el-input>
				<div v-else-if="$check_field('get','business_name')">{{form['business_name']}}</div>
					</el-form-item>
		</el-col>
				<el-col :xs="24" :sm="12" :lg="8" class="el_form_item_warp">
			<el-form-item label="联系号码" prop="contact_number">
						<el-input id="contact_number" v-model="form['contact_number']" placeholder="请输入联系号码" type="tel"
					v-if="(form['agricultural_products_id'] && $check_field('set','contact_number') ) || $check_field('add','contact_number')">
				</el-input>
				<div v-else-if="$check_field('get','contact_number')">{{form['contact_number']}}</div>
					</el-form-item>
		</el-col>
				<el-col :xs="24" :sm="12" :lg="8" class="el_form_item_warp">
			<el-form-item label="商家地址" prop="business_address">
						<el-input id="business_address" v-model="form['business_address']" placeholder="请输入商家地址"
					v-if="(form['agricultural_products_id'] && $check_field('set','business_address') ) || $check_field('add','business_address')"></el-input>
				<div v-else-if="$check_field('get','business_address')">{{form['business_address']}}</div>
					</el-form-item>
		</el-col>
	
		<el-col :xs="24" :sm="12" :lg="8" class="el_form_item_warp">
			<el-form-item label="点击数" prop="hits">
				<el-input-number id="hits" v-model="form['hits']"
					v-if="$check_field('set','hits')"></el-input-number>
				<div v-else-if="$check_field('get','hits')">{{form["hits"]}}</div>
			</el-form-item>
		</el-col>


		<el-col :xs="24" :sm="24" :lg="24" style="text-align: center;" class="el_form_btn_warp">
			<el-button type="primary" @click="submit()">提交</el-button>
			<el-button @click="cancel()">取消</el-button>
		</el-col>

	</el-form>
</template>

<script>
	import mixin from "../../mixins/component.js";

	export default {
		mixins: [mixin],
		props:{
			query: {
				type: Object,
				default: function(){
					return {
						"agricultural_products_id": 0
					}
				}
			},
			form_goods:{
				type: Object,
				default: function(){
					return {}
				}
			},
			func_check:{
				type: Function,
				default: function(fun){
					console.log("调试输出",fun);
				}
			},
			func_submit:{
				type: Function,
				default: function(fun){
					console.log("调试输出",fun);
				}
			}
		},
		data() {
			return {
				field: "agricultural_products_id",
				url_add: "~/api/agricultural_products/add?",
				url_set: "~/api/agricultural_products/set?",
				url_get_obj: "~/api/agricultural_products/get_obj?",
				url_upload: "~/api/agricultural_products/upload?",

				form: {
						"product_specifications":  '',
							"farmers_merchants": 0,
							"business_name":  '',
							"contact_number":  '',
							"business_address":  '',
						"hits": 0,
				},

					
				rules: {
					"product_specifications": [     {required: true,message: '产品规格不能为空'},  ],
					"farmers_merchants": [     {required: true,message: '农户商家不能为空'},  ],
					"business_name": [     ],
					"contact_number": [   {validator: this.$is_phone,trigger: 'blur'},    ],
					"business_address": [     {required: true,message: '商家地址不能为空'},  ],
				}

			}
		},
		methods: {

			/**
			 * 请求列表前
			 * @param {Object} param
			 */
			get_list_before(param) {
				var user_group = this.user.user_group;
				if (user_group !== "管理员") {
					switch (user_group) {
												case "农户商家":
							param["farmers_merchants"] = this.user.user_id;
							break;
																	}
				}

				return param;
			},

	
	
		
	
		
	
		
	
		
	
	
			submit(){
				this.func_check(()=>{
					this.$refs["form"].validate((valid)} => {
						if (valid) {
							this.submit();
						} else {
							console.error('error 提交失败!!');
						}
					});
				})
			},

			submit_after(){
				var source_id = this.form_goods.source_id;
				if(source_id){
					this.func_submit();
				}else{
					this.$get('~/api/agricultural_products/get_obj?',this.form,(res)=>{
						if(res.result && res.result.obj){
							this.form_goods.source_id = res.result.obj["agricultural_products_id"];
							this.func_submit();
						}else{
							console.error(res.error);
						}

					})
				}
			}
		},
		created() {
							}
	}
</script>

<style>
	.avatar-uploader .el-upload {
		border: 1px dashed #d9d9d9;
		border-radius: 6px;
		cursor: pointer;
		position: relative;
		overflow: hidden;
	}

	.avatar-uploader .el-upload:hover {
		border-color: #409EFF;
	}

	.avatar-uploader-icon {
		font-size: 28px;
		color: #8c939d;
		width: 178px;
		height: 178px;
		line-height: 178px;
		text-align: center;
	}

	.avatar {
		width: 178px;
		height: 178px;
		display: block;
	}
</style>
