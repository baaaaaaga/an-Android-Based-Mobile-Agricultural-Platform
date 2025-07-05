<template>
	<el-main class="bg edit_wrap comtable_e">
		<el-form ref="form" :model="form" status-icon label-width="120px" v-if="is_view()">
		<el-row class="row_ce"> 
							<el-col v-if="$check_field('get','name_of_place_of_origin') || $check_field('add','name_of_place_of_origin') || $check_field('set','name_of_place_of_origin')" :xs="24" :sm="12" :lg="8" class="el_form_item_warp">
							<el-form-item label="产地名称" prop="name_of_place_of_origin">
															<el-input id="name_of_place_of_origin" v-model="form['name_of_place_of_origin']" placeholder="请输入产地名称"
							  v-if="(form['origin_display_id'] && $check_field('set','name_of_place_of_origin')) || (!form['origin_display_id'] && $check_field('add','name_of_place_of_origin'))" :disabled="disabledObj['name_of_place_of_origin_isDisabled']"></el-input>
					<div v-else-if="$check_field('get','name_of_place_of_origin')">{{form['name_of_place_of_origin']}}</div>
											</el-form-item>
			</el-col>
								<el-col v-if="$check_field('get','cover_chart') || $check_field('add','cover_chart') || $check_field('set','cover_chart')" :xs="24" :sm="12" :lg="8" class="el_form_item_warp">
							<el-form-item label="封面图" prop="cover_chart">
											<el-upload :disabled="disabledObj['cover_chart_isDisabled']" class="avatar-uploader" drag
						accept="image/gif, image/jpeg, image/png, image/jpg" action="" :http-request="upload_cover_chart"
						:show-file-list="false" v-if="(form['origin_display_id'] && $check_field('set','cover_chart')) || (!form['origin_display_id'] && $check_field('add','cover_chart'))">
						<img id="cover_chart" v-if="form['cover_chart']" :src="$fullUrl(form['cover_chart'])" class="avatar">
						<i v-else class="el-icon-plus avatar-uploader-icon"></i>
					</el-upload>
					<el-image v-else-if="$check_field('get','cover_chart')" style="width: 100px; height: 100px"
						:src="$fullUrl(form['cover_chart'])" :preview-src-list="[$fullUrl(form['cover_chart'])]">
						<div slot="error" class="image-slot">
							<img src="../../../public/img/error.png" style="width: 90px; height: 90px" />
						</div>
					</el-image>
							</el-form-item>
			</el-col>
								<el-col v-if="$check_field('get','place_of_origin_address') || $check_field('add','place_of_origin_address') || $check_field('set','place_of_origin_address')" :xs="24" :sm="12" :lg="8" class="el_form_item_warp">
							<el-form-item label="产地地址" prop="place_of_origin_address">
															<el-input id="place_of_origin_address" v-model="form['place_of_origin_address']" placeholder="请输入产地地址"
							  v-if="(form['origin_display_id'] && $check_field('set','place_of_origin_address')) || (!form['origin_display_id'] && $check_field('add','place_of_origin_address'))" :disabled="disabledObj['place_of_origin_address_isDisabled']"></el-input>
					<div v-else-if="$check_field('get','place_of_origin_address')">{{form['place_of_origin_address']}}</div>
											</el-form-item>
			</el-col>
								<el-col v-if="$check_field('get','type_of_place_of_origin') || $check_field('add','type_of_place_of_origin') || $check_field('set','type_of_place_of_origin')" :xs="24" :sm="12" :lg="8" class="el_form_item_warp">
							<el-form-item label="产地类型" prop="type_of_place_of_origin">
											<el-select id="type_of_place_of_origin" v-model="form['type_of_place_of_origin']"						v-if="(form['origin_display_id'] && $check_field('set','type_of_place_of_origin')) || (!form['origin_display_id'] && $check_field('add','type_of_place_of_origin'))">
						<el-option v-for="o in list_type_of_place_of_origin" :key="o['type_of_place_of_origin']" :label="o['type_of_place_of_origin']"
							:value="o['type_of_place_of_origin']">
						</el-option>
					</el-select>
					<div v-else-if="$check_field('get','type_of_place_of_origin')">{{form['type_of_place_of_origin']}}</div>
							</el-form-item>
			</el-col>
								<el-col v-if="$check_field('get','scale_of_origin') || $check_field('add','scale_of_origin') || $check_field('set','scale_of_origin')" :xs="24" :sm="12" :lg="8" class="el_form_item_warp">
							<el-form-item label="产地规模" prop="scale_of_origin">
															<el-input id="scale_of_origin" v-model="form['scale_of_origin']" placeholder="请输入产地规模"
							  v-if="(form['origin_display_id'] && $check_field('set','scale_of_origin')) || (!form['origin_display_id'] && $check_field('add','scale_of_origin'))" :disabled="disabledObj['scale_of_origin_isDisabled']"></el-input>
					<div v-else-if="$check_field('get','scale_of_origin')">{{form['scale_of_origin']}}</div>
											</el-form-item>
			</el-col>
								<el-col v-if="$check_field('get','introduction_of_origin') || $check_field('add','introduction_of_origin') || $check_field('set','introduction_of_origin')" :xs="24" :sm="12" :lg="8" class="el_form_item_warp">
							<el-form-item label="产地介绍" prop="introduction_of_origin">
											<el-input type="textarea" id="introduction_of_origin" v-model="form['introduction_of_origin']" placeholder="请输入产地介绍"
						v-if="(form['origin_display_id'] && $check_field('set','introduction_of_origin')) || (!form['origin_display_id'] && $check_field('add','introduction_of_origin'))" :disabled="disabledObj['introduction_of_origin_isDisabled']"></el-input>
					<div v-else-if="$check_field('get','introduction_of_origin')">{{form['introduction_of_origin']}}</div>
							</el-form-item>
			</el-col>
								<el-col v-if="$check_field('get','farmers_merchants') || $check_field('add','farmers_merchants') || $check_field('set','farmers_merchants')" :xs="24" :sm="12" :lg="8" class="el_form_item_warp">
							<el-form-item label="农户商家" prop="farmers_merchants">
																					<div v-if="user_group !== '管理员'">
							{{ get_user_session_farmers_merchants(form['farmers_merchants']) }}
							<el-select v-if="(form['origin_display_id'] && $check_field('set','farmers_merchants')) || (!form['origin_display_id'] && $check_field('add','farmers_merchants'))" id="farmers_merchants" v-model="form['farmers_merchants']" :disabled="disabledObj['farmers_merchants_isDisabled']">
								<el-option v-for="o in list_user_farmers_merchants" :key="o['username']" :label="o['nickname'] + '-' + o['username']"
										   :value="o['user_id']">
								</el-option>
							</el-select>
							<el-select v-else-if="$check_field('get','farmers_merchants')" id="farmers_merchants" v-model="form['farmers_merchants']" :disabled="true">
								<el-option v-for="o in list_user_farmers_merchants" :key="o['username']" :label="o['nickname'] + '-' + o['username']"
										   :value="o['user_id']">
								</el-option>
							</el-select>
						</div>
						<el-select v-else id="farmers_merchants" v-model="form['farmers_merchants']" :disabled="disabledObj['farmers_merchants_isDisabled']">
							<el-option v-for="o in list_user_farmers_merchants" :key="o['username']" :label="o['nickname'] + '-' + o['username']"
									   :value="o['user_id']">
							</el-option>
						</el-select>
																</el-form-item>
			</el-col>
								<el-col v-if="$check_field('get','business_name') || $check_field('add','business_name') || $check_field('set','business_name')" :xs="24" :sm="12" :lg="8" class="el_form_item_warp">
							<el-form-item prop="business_name">
					<div slot="label">
						<i style="color: red;">*</i>
						商家名称
					</div>
															<el-input id="business_name" v-model="form['business_name']" placeholder="请输入商家名称"
							  v-if="(form['origin_display_id'] && $check_field('set','business_name')) || (!form['origin_display_id'] && $check_field('add','business_name'))" :disabled="disabledObj['business_name_isDisabled']"></el-input>
					<div v-else-if="$check_field('get','business_name')">{{form['business_name']}}</div>
											</el-form-item>
			</el-col>
								<el-col v-if="$check_field('get','contact_number') || $check_field('add','contact_number') || $check_field('set','contact_number')" :xs="24" :sm="12" :lg="8" class="el_form_item_warp">
							<el-form-item prop="contact_number">
					<div slot="label">
						<i style="color: red;">*</i>
						联系号码
					</div>
											<el-input id="contact_number" v-model="form['contact_number']" placeholder="请输入联系号码" type="tel"
						v-if="(form['origin_display_id'] && $check_field('set','contact_number')) || (!form['origin_display_id'] && $check_field('add','contact_number'))">
					</el-input>
					<div v-else-if="$check_field('get','contact_number')">{{form['contact_number']}}</div>
							</el-form-item>
			</el-col>
								<el-col v-if="$check_field('get','business_address') || $check_field('add','business_address') || $check_field('set','business_address')" :xs="24" :sm="12" :lg="8" class="el_form_item_warp">
							<el-form-item prop="business_address">
					<div slot="label">
						<i style="color: red;">*</i>
						商家地址
					</div>
															<el-input id="business_address" v-model="form['business_address']" placeholder="请输入商家地址"
							  v-if="(form['origin_display_id'] && $check_field('set','business_address')) || (!form['origin_display_id'] && $check_field('add','business_address'))" :disabled="disabledObj['business_address_isDisabled']"></el-input>
					<div v-else-if="$check_field('get','business_address')">{{form['business_address']}}</div>
											</el-form-item>
			</el-col>
						
	
	
		
		
						<el-col :xs="24" :sm="12" :lg="8" class="el_form_item_warp" v-if="!form['source_user_id'] && 0 > 0">
			  <el-form-item label="咨询限次">
				<el-input id="limit_times" v-model="form['interactive_consultation_limit_times']" placeholder="咨询限制次数，0为不限"
						  v-if="$check_option('/origin_display/view','can_limits')"
				></el-input>
				<div v-else-if="$check_action('/origin_display/view','get')" v-html="form['interactive_consultation_limit_times']"></div>
			  </el-form-item>
			</el-col>
			
	
	
		
		
	
		</el-row>
			<el-col :xs="24" :sm="12" :lg="8" class="el_form_btn_warp">
				<el-form-item v-if="$check_action('/origin_display/view','set') || $check_action('/origin_display/view','add') || $check_option('/origin_display/table','examine')">
					<el-button type="primary" @click="submit()">提交</el-button>
					<el-button @click="cancel()">取消</el-button>
				</el-form-item>
				<el-form-item v-else>
					<el-button @click="cancel()">返回</el-button>
				</el-form-item>
			</el-col>

		</el-form>
	</el-main>
</template>

<script>
	import mixin from "@/mixins/page.js";
	export default {
		mixins: [mixin],
		data() {
			return {
				field: "origin_display_id",
				url_add: "~/api/origin_display/add?",
				url_set: "~/api/origin_display/set?",
				url_get_obj: "~/api/origin_display/get_obj?",
				url_upload: "~/api/origin_display/upload?",

				query: {
					"origin_display_id": 0,
				},

				form: {
								"name_of_place_of_origin":  '', // 产地名称
										"cover_chart":  '', // 封面图
										"place_of_origin_address":  '', // 产地地址
										"type_of_place_of_origin":  '', // 产地类型
										"scale_of_origin":  '', // 产地规模
										"introduction_of_origin":  '', // 产地介绍
										"farmers_merchants": 0, // 农户商家
										"business_name": null, // 商家名称
										"contact_number": null, // 联系号码
										"business_address": null, // 商家地址
											"origin_display_id": 0, // ID
													"interactive_consultation_limit_times": 0, // 咨询限制次数
												},
				disabledObj:{
								"name_of_place_of_origin_isDisabled": false,
										"cover_chart_isDisabled": false,
										"place_of_origin_address_isDisabled": false,
										"type_of_place_of_origin_isDisabled": false,
										"scale_of_origin_isDisabled": false,
										"introduction_of_origin_isDisabled": false,
										"farmers_merchants_isDisabled": false,
										"business_name_isDisabled": false,
										"contact_number_isDisabled": false,
										"business_address_isDisabled": false,
										},

	
			
			
									// 产地类型选项列表
				list_type_of_place_of_origin: [""],
	
			
			
			
					// 用户列表
				list_user_farmers_merchants: [],
						// 用户组
				group_user_farmers_merchants: "",
					
			
			
		
			}
		},
		methods: {

	
	
						/**
			 * 上传封面图
			 * @param {Object} param 图片参数
			 */
			upload_cover_chart(param){
									this.uploadFile(param.file, "cover_chart");
								},
	
	
			
	
			
				/**
			 * 获取产地类型列表
			 */
			
						async get_list_type_of_place_of_origin() {
				var json = await this.$get("~/api/type_of_place_of_origin/get_list?");
				if(json.result && json.result.list){
					this.list_type_of_place_of_origin = json.result.list;
				}
				else if(json.error){
					console.error(json.error);
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
					/**
			 * 获取农户商家用户组
			 */
			async get_group_user_farmers_merchants() {
							this.form["farmers_merchants"] = this.user.user_id;
							var json = await this.$get("~/api/user_group/get_obj?name=农户商家");
				if(json.result && json.result.obj){
					this.group_user_farmers_merchants = json.result.obj;
				}
				else if(json.error){
					console.error(json.error);
				}
			},
			get_user_session_farmers_merchants(id){
				var _this = this;
				var user_id = {"user_id":id}
				var url = "~/api/"+_this.group_user_farmers_merchants.source_table+"/get_obj?"
				this.$get(url, user_id, function(res) {
					if (res.result && res.result.obj) {
						var arr = []
						for (let key in res.result.obj) {
							arr.push(key)
						}
						var arrForm = []
									for (let key in _this.form) {
							arrForm.push(key)
						}
												_this.form["farmers_merchants"] = id
									_this.disabledObj['farmers_merchants' + '_isDisabled'] = true
						for (var i=0;i<arr.length;i++){
						  if (arr[i]!=='examine_state' && arr[i]!=='examine_reply') {
							for (var j = 0; j < arrForm.length; j++) {
							  if (arr[i] === arrForm[j]) {
								if (arr[i] !== "farmers_merchants") {
			                      _this.form[arrForm[j]] = res.result.obj[arr[i]]
			                      _this.disabledObj[arrForm[j] + '_isDisabled'] = true
								  break;
								} else {
								  _this.disabledObj[arrForm[j] + '_isDisabled'] = true
								}
							  }
							}
						  }
						}
					}
				});
			},
					get_user_farmers_merchants(id){
				var obj = this.list_user_farmers_merchants.getObj({"user_id":id});
				var ret = "";
				if(obj){
					if(obj.nickname){
						ret = obj.nickname;}
					else{
						ret = obj.username;
					}
				}
				return ret;
			},
			
	
			
	
			
	
		
			/**
			 * 获取对象之前
			 * @param {Object} param
			 */
			get_obj_before(param) {
				var form = "";
																
				if(this.form && form){
					Object.keys(this.form).forEach(key => {
						Object.keys(form).forEach(dbKey => {
							// if(dbKey === "charging_standard"){
							// 	this.form['charging_rules'] = form[dbKey];
							// 	this.disabledObj['charging_rules_isDisabled'] = true;
							// };
							if(key === dbKey){
								this.disabledObj[key+'_isDisabled'] = true;
								this.form[key] = form[dbKey]
							}
							if(dbKey === "source_table"){
								this.form['source_table'] = form[dbKey];
							}
							if(dbKey === "source_id"){
								this.form['source_id'] = form[dbKey];
							}
							if(dbKey === "source_user_id"){
								this.form['source_user_id'] = form[dbKey];
							}
						})
					})
				}
			if(/^\d{10}$|^\d{13}$/.test(this.form["name_of_place_of_origin"])){
			this.form["name_of_place_of_origin"] = this.$toTime(parseInt(this.form["name_of_place_of_origin"]),"yyyy-MM-dd hh:mm:ss")
		}
					if(/^\d{10}$|^\d{13}$/.test(this.form["place_of_origin_address"])){
			this.form["place_of_origin_address"] = this.$toTime(parseInt(this.form["place_of_origin_address"]),"yyyy-MM-dd hh:mm:ss")
		}
					if(/^\d{10}$|^\d{13}$/.test(this.form["scale_of_origin"])){
			this.form["scale_of_origin"] = this.$toTime(parseInt(this.form["scale_of_origin"]),"yyyy-MM-dd hh:mm:ss")
		}
						if(/^\d{10}$|^\d{13}$/.test(this.form["business_name"])){
			this.form["business_name"] = this.$toTime(parseInt(this.form["business_name"]),"yyyy-MM-dd hh:mm:ss")
		}
					if(/^\d{10}$|^\d{13}$/.test(this.form["business_address"])){
			this.form["business_address"] = this.$toTime(parseInt(this.form["business_address"]),"yyyy-MM-dd hh:mm:ss")
		}
					$.db.del("form");

				return param;
			},

			/**
			 * 获取对象之后
			 * @param {Object} json
			 * @param {Object} func
			 */
			get_obj_after(json, func){
																																																		

			},

																																																																																		async submit(param, func){
				if (!param) {
					param = this.form;
				}
						
				var pm = this.events("submit_before", Object.assign({}, param)) || param;
				var msg = await this.events("submit_check", pm);
				var ret;
				if (msg) {
					this.$toast(msg, 'danger');
				} else {
																																																																														ret = this.events("submit_main", pm, func);
				}
				return ret;
			},
			
			/**
			 * 提交前验证事件
			 * @param {Object} 请求参数
			 * @return {String} 验证成功返回null, 失败返回错误提示
			 */
						submit_check(param) {
					
																																																																																				if (!param.business_name){
					return "商家名称不能为空";
				}
																	if (!param.contact_number){
					return "联系号码不能为空";
				}
								let contact_number_phone_regular = /^(13[0-9]|14[01456879]|15[0-35-9]|16[2567]|17[0-8]|18[0-9]|19[0-35-9])\d{8}$/;
				if(param.contact_number && !contact_number_phone_regular.test(param.contact_number)){
					return "手机号格式错误"
				}
															if (!param.business_address){
					return "商家地址不能为空";
				}
																return null;
			},

			is_view(){
				// var bl = this.user_group == "管理员";
				var bl = false;

				if(!bl){
					bl = this.$check_action('/origin_display/table','add');
					console.log(bl ? "你有表格添加权限视作有添加权限" : "你没有表格添加权限");
				}
				if(!bl){
					bl = this.$check_action('/origin_display/table','set');
					console.log(bl ? "你有表格添加权限视作有修改权限" : "你没有表格修改权限");
				}
				if(!bl){
					bl = this.$check_action('/origin_display/view','add');
					console.log(bl ? "你有视图添加权限视作有添加权限" : "你没有视图添加权限");
				}
				if(!bl){
					bl = this.$check_action('/origin_display/view','set');
					console.log(bl ? "你有视图修改权限视作有修改权限" : "你没有视图修改权限");
				}
				if(!bl){
					bl = this.$check_action('/origin_display/view','get');
					console.log(bl ? "你有视图查询权限视作有查询权限" : "你没有视图查询权限");
				}

				console.log(bl ? "具有当前页面的查看权，请注意这不代表你有字段的查看权" : "无权查看当前页，请注意即便有字段查询权限没有页面查询权限也不行");

				return bl;
			},
			/**
			 * 上传文件
			 * @param {Object} param
			 */
			uploadimg(param) {
				this.uploadFile(param.file, "avatar");
			},

		},
		created() {
										this.get_list_type_of_place_of_origin();
											this.get_list_user_farmers_merchants();
					this.get_group_user_farmers_merchants();
											},
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
	
	.img_multiple{
		overflow: hidden;
	}
	.img_multiple .img_block{
		float: left;
		margin-right: 5px;
		margin-bottom: 5px;
		position: relative;
	}
	.img_multiple .img_block img{
		height: 100px;
		width: auto;
	}
	.img_multiple .img_del{
		position: absolute;
		top: 5px;
		right: 5px;
		width: 20px;
		height: 20px;
		background: #0000008a;
		color: #fff;
		line-height: 20px;
		text-align: center;
		border-radius: 100%;
		cursor: pointer;
	}




	
</style>
