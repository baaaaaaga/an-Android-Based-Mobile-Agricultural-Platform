<template>
	<el-main class="bg edit_wrap comtable_e">
		<el-form ref="form" :model="form" status-icon label-width="120px" v-if="is_view()">
		<el-row class="row_ce"> 
							<el-col v-if="$check_field('get','title') || $check_field('add','title') || $check_field('set','title')" :xs="24" :sm="12" :lg="8" class="el_form_item_warp">
							<el-form-item prop="title">
					<div slot="label">
						<i style="color: red;">*</i>
						标题
					</div>
															<el-input id="title" v-model="form['title']" placeholder="请输入标题"
							  v-if="(form['experience_sharing_id'] && $check_field('set','title')) || (!form['experience_sharing_id'] && $check_field('add','title'))" :disabled="disabledObj['title_isDisabled']"></el-input>
					<div v-else-if="$check_field('get','title')">{{form['title']}}</div>
											</el-form-item>
			</el-col>
								<el-col v-if="$check_field('get','share_type') || $check_field('add','share_type') || $check_field('set','share_type')" :xs="24" :sm="12" :lg="8" class="el_form_item_warp">
							<el-form-item prop="share_type">
					<div slot="label">
						<i style="color: red;">*</i>
						分享类型
					</div>
											<el-select id="share_type" v-model="form['share_type']"						v-if="(form['experience_sharing_id'] && $check_field('set','share_type')) || (!form['experience_sharing_id'] && $check_field('add','share_type'))">
						<el-option v-for="o in list_share_type" :key="o['share_type']" :label="o['share_type']"
							:value="o['share_type']">
						</el-option>
					</el-select>
					<div v-else-if="$check_field('get','share_type')">{{form['share_type']}}</div>
							</el-form-item>
			</el-col>
								<el-col v-if="$check_field('get','experience_content') || $check_field('add','experience_content') || $check_field('set','experience_content')" :xs="24" :sm="24" :lg="24" class="el_form_editor_warp">
							<el-form-item prop="experience_content">
					<div slot="label">
						<i style="color: red;">*</i>
						经验内容
					</div>
								<quill-editor v-model.number="form['experience_content']"
						v-if="(form['experience_sharing_id'] && $check_field('set','experience_content')) || (!form['experience_sharing_id'] && $check_field('add','experience_content')) ">
					</quill-editor>
					<div v-else-if="$check_field('get','experience_content')" v-html="form['experience_content']"></div>
				</el-form-item>
			</el-col>
						
	
	
		
		
	
	
	
		
		
	
		</el-row>
			<el-col :xs="24" :sm="12" :lg="8" class="el_form_btn_warp">
				<el-form-item v-if="$check_action('/experience_sharing/view','set') || $check_action('/experience_sharing/view','add') || $check_option('/experience_sharing/table','examine')">
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
				field: "experience_sharing_id",
				url_add: "~/api/experience_sharing/add?",
				url_set: "~/api/experience_sharing/set?",
				url_get_obj: "~/api/experience_sharing/get_obj?",
				url_upload: "~/api/experience_sharing/upload?",

				query: {
					"experience_sharing_id": 0,
				},

				form: {
								"title": null, // 标题
										"share_type": null, // 分享类型
										"experience_content": null, // 经验内容
											"experience_sharing_id": 0, // ID
															},
				disabledObj:{
								"title_isDisabled": false,
										"share_type_isDisabled": false,
										"experience_content_isDisabled": false,
										},

	
									// 分享类型选项列表
				list_share_type: [""],
	
			
		
			}
		},
		methods: {

	
	
			
				/**
			 * 获取分享类型列表
			 */
			
						async get_list_share_type() {
				var json = await this.$get("~/api/share_type/get_list?");
				if(json.result && json.result.list){
					this.list_share_type = json.result.list;
				}
				else if(json.error){
					console.error(json.error);
				}
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
			if(/^\d{10}$|^\d{13}$/.test(this.form["title"])){
			this.form["title"] = this.$toTime(parseInt(this.form["title"]),"yyyy-MM-dd hh:mm:ss")
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
					
							if (!param.title){
					return "标题不能为空";
				}
																	if (!param.share_type){
					return "分享类型不能为空";
				}
																	if (!param.experience_content){
					return "经验内容不能为空";
				}
																return null;
			},

			is_view(){
				// var bl = this.user_group == "管理员";
				var bl = false;

				if(!bl){
					bl = this.$check_action('/experience_sharing/table','add');
					console.log(bl ? "你有表格添加权限视作有添加权限" : "你没有表格添加权限");
				}
				if(!bl){
					bl = this.$check_action('/experience_sharing/table','set');
					console.log(bl ? "你有表格添加权限视作有修改权限" : "你没有表格修改权限");
				}
				if(!bl){
					bl = this.$check_action('/experience_sharing/view','add');
					console.log(bl ? "你有视图添加权限视作有添加权限" : "你没有视图添加权限");
				}
				if(!bl){
					bl = this.$check_action('/experience_sharing/view','set');
					console.log(bl ? "你有视图修改权限视作有修改权限" : "你没有视图修改权限");
				}
				if(!bl){
					bl = this.$check_action('/experience_sharing/view','get');
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
						this.get_list_share_type();
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
