<template>
	<el-main class="bg edit_wrap comtable_e">
		<el-form ref="form" :model="form" status-icon label-width="120px" v-if="is_view()">
		<el-row class="row_ce"> 
							<el-col v-if="$check_field('get','plan_no') || $check_field('add','plan_no') || $check_field('set','plan_no')" :xs="24" :sm="12" :lg="8" class="el_form_item_warp">
							<el-form-item label="计划编号" prop="plan_no">
															<el-input id="plan_no" v-model="form['plan_no']" placeholder="请输入计划编号"
							  v-if="(form['production_planning_id'] && $check_field('set','plan_no')) || (!form['production_planning_id'] && $check_field('add','plan_no'))" :disabled="disabledObj['plan_no_isDisabled']"></el-input>
					<div v-else-if="$check_field('get','plan_no')">{{form['plan_no']}}</div>
											</el-form-item>
			</el-col>
								<el-col v-if="$check_field('get','schedule_title') || $check_field('add','schedule_title') || $check_field('set','schedule_title')" :xs="24" :sm="12" :lg="8" class="el_form_item_warp">
							<el-form-item label="计划标题" prop="schedule_title">
															<el-input id="schedule_title" v-model="form['schedule_title']" placeholder="请输入计划标题"
							  v-if="(form['production_planning_id'] && $check_field('set','schedule_title')) || (!form['production_planning_id'] && $check_field('add','schedule_title'))" :disabled="disabledObj['schedule_title_isDisabled']"></el-input>
					<div v-else-if="$check_field('get','schedule_title')">{{form['schedule_title']}}</div>
											</el-form-item>
			</el-col>
								<el-col v-if="$check_field('get','planned_date') || $check_field('add','planned_date') || $check_field('set','planned_date')" :xs="24" :sm="12" :lg="8" class="el_form_item_warp">
							<el-form-item label="计划日期" prop="planned_date">
											<el-date-picker :disabled="disabledObj['planned_date_isDisabled']" v-if="(form['production_planning_id'] && $check_field('set','planned_date')) || (!form['production_planning_id'] && $check_field('add','planned_date'))" id="planned_date"
						v-model="form['planned_date']" type="date" placeholder="选择日期" value-format="yyyy-MM-dd">
					</el-date-picker>
					<div v-else-if="$check_field('get','planned_date')">{{form['planned_date']}}</div>
							</el-form-item>
			</el-col>
								<el-col v-if="$check_field('get','plan_content') || $check_field('add','plan_content') || $check_field('set','plan_content')" :xs="24" :sm="12" :lg="8" class="el_form_item_warp">
							<el-form-item label="计划内容" prop="plan_content">
											<el-input type="textarea" id="plan_content" v-model="form['plan_content']" placeholder="请输入计划内容"
						v-if="(form['production_planning_id'] && $check_field('set','plan_content')) || (!form['production_planning_id'] && $check_field('add','plan_content'))" :disabled="disabledObj['plan_content_isDisabled']"></el-input>
					<div v-else-if="$check_field('get','plan_content')">{{form['plan_content']}}</div>
							</el-form-item>
			</el-col>
								<el-col v-if="$check_field('get','farmers_merchants') || $check_field('add','farmers_merchants') || $check_field('set','farmers_merchants')" :xs="24" :sm="12" :lg="8" class="el_form_item_warp">
							<el-form-item label="农户商家" prop="farmers_merchants">
																					<div v-if="user_group !== '管理员'">
							{{ get_user_session_farmers_merchants(form['farmers_merchants']) }}
							<el-select v-if="(form['production_planning_id'] && $check_field('set','farmers_merchants')) || (!form['production_planning_id'] && $check_field('add','farmers_merchants'))" id="farmers_merchants" v-model="form['farmers_merchants']" :disabled="disabledObj['farmers_merchants_isDisabled']">
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
						
	
	
		
		
	
	
	
		
		
	
		</el-row>
			<el-col :xs="24" :sm="12" :lg="8" class="el_form_btn_warp">
				<el-form-item v-if="$check_action('/production_planning/view','set') || $check_action('/production_planning/view','add') || $check_option('/production_planning/table','examine')">
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
				field: "production_planning_id",
				url_add: "~/api/production_planning/add?",
				url_set: "~/api/production_planning/set?",
				url_get_obj: "~/api/production_planning/get_obj?",
				url_upload: "~/api/production_planning/upload?",

				query: {
					"production_planning_id": 0,
				},

				form: {
								"plan_no":  '', // 计划编号
										"schedule_title":  '', // 计划标题
										"planned_date":  '', // 计划日期
										"plan_content":  '', // 计划内容
										"farmers_merchants": 0, // 农户商家
											"production_planning_id": 0, // ID
															},
				disabledObj:{
								"plan_no_isDisabled": false,
										"schedule_title_isDisabled": false,
										"planned_date_isDisabled": false,
										"plan_content_isDisabled": false,
										"farmers_merchants_isDisabled": false,
										},

	
			
			
			
			
					// 用户列表
				list_user_farmers_merchants: [],
						// 用户组
				group_user_farmers_merchants: "",
				
			}
		},
		methods: {

	
	
			
	
			
	
			
	
			
	
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
			if(/^\d{10}$|^\d{13}$/.test(this.form["plan_no"])){
			this.form["plan_no"] = this.$toTime(parseInt(this.form["plan_no"]),"yyyy-MM-dd hh:mm:ss")
		}
				if(/^\d{10}$|^\d{13}$/.test(this.form["schedule_title"])){
			this.form["schedule_title"] = this.$toTime(parseInt(this.form["schedule_title"]),"yyyy-MM-dd hh:mm:ss")
		}
		        if (this.form["planned_date"] && this.form["planned_date"].indexOf("-")===-1){
          this.form["planned_date"] = this.$toTime(parseInt(this.form["planned_date"]),"yyyy-MM-dd")
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
																if(this.form["planned_date"]=="0000-00-00"){
				  this.form["planned_date"] = null;
				}
				if(parseInt(this.form["planned_date"]) > 9999){
					this.form["planned_date"] = this.$toTime(parseInt(this.form["planned_date"]),"yyyy-MM-dd")
				}
														

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
					
																													if (!param.planned_date){
					return "计划日期不能为空";
				}
																																						return null;
			},

			is_view(){
				// var bl = this.user_group == "管理员";
				var bl = false;

				if(!bl){
					bl = this.$check_action('/production_planning/table','add');
					console.log(bl ? "你有表格添加权限视作有添加权限" : "你没有表格添加权限");
				}
				if(!bl){
					bl = this.$check_action('/production_planning/table','set');
					console.log(bl ? "你有表格添加权限视作有修改权限" : "你没有表格修改权限");
				}
				if(!bl){
					bl = this.$check_action('/production_planning/view','add');
					console.log(bl ? "你有视图添加权限视作有添加权限" : "你没有视图添加权限");
				}
				if(!bl){
					bl = this.$check_action('/production_planning/view','set');
					console.log(bl ? "你有视图修改权限视作有修改权限" : "你没有视图修改权限");
				}
				if(!bl){
					bl = this.$check_action('/production_planning/view','get');
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
