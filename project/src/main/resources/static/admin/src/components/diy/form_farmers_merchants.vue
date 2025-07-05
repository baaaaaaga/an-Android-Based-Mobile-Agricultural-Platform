<template>
	<div>
			<el-form-item v-if="$check_register_field('add','business_name','/farmers_merchants/view')" label="商家名称" prop="business_name">
				<el-input id="business_name" v-model="form['business_name']" placeholder="请输入商家名称" ></el-input>
				</el-form-item>
				<el-form-item v-if="$check_register_field('add','contact_number','/farmers_merchants/view')" label="联系号码" prop="contact_number">
				<el-input id="contact_number" v-model="form['contact_number']" placeholder="请输入联系号码" type="tel">
		</el-input>
				</el-form-item>
				<el-form-item v-if="$check_register_field('add','business_address','/farmers_merchants/view')" label="商家地址" prop="business_address">
				<el-input id="business_address" v-model="form['business_address']" placeholder="请输入商家地址" ></el-input>
				</el-form-item>
				<el-form-item v-if="$check_register_field('add','business_license','/farmers_merchants/view')" label="营业执照" prop="business_license">
				<el-upload id="business_license" class="avatar-uploader" drag
			accept="image/gif, image/jpeg, image/png, image/jpg" action="" :http-request="uploadimg_business_license"
			:show-file-list="false" >
			<img v-if="form['business_license']" :src="$fullUrl(form['business_license'])" class="avatar">
			<i v-else class="el-icon-plus avatar-uploader-icon"></i>
		</el-upload>
				</el-form-item>
				<el-form-item v-if="$check_register_field('add','certification_application','/farmers_merchants/view')" label="认证申请" prop="certification_application">
				<el-upload id="certification_application" class="avatar-uploader" drag
			accept="image/gif, image/jpeg, image/png, image/jpg" action="" :http-request="uploadimg_certification_application"
			:show-file-list="false" >
			<img v-if="form['certification_application']" :src="$fullUrl(form['certification_application'])" class="avatar">
			<i v-else class="el-icon-plus avatar-uploader-icon"></i>
		</el-upload>
				</el-form-item>
	
	</div>
</template>

<script>
	import mixin from "@/mixins/component.js";

	export default {
		mixins: [mixin],
		props:{

			form:{
				type: Object,
				default: function(){
					return {
							"business_name":  '' ,
								"contact_number":  '' ,
								"business_address":  '' ,
								"business_license":  '' ,
								"certification_application":  '' ,
						}
				}
			},

		},
		data() {
			return {
				field: "farmers_merchants_id",
				url_add: "~/api/farmers_merchants/add?",
				url_set: "~/api/farmers_merchants/set?",
				url_upload: "~/api/farmers_merchants/upload?",

														rules: {
					"business_name": [    {required: true,message: '商家名称不能为空'},  ],
					"contact_number": [   {validator: this.$is_phone,trigger: 'blur'},   {required: true,message: '联系号码不能为空'},  ],
					"business_address": [    {required: true,message: '商家地址不能为空'},  ],
					"business_license": [    {required: true,message: '营业执照不能为空'},  ],
					"certification_application": [    {required: true,message: '认证申请不能为空'},  ],
				}

			}
		},
		methods: {
	
	
		
	
		
	
					/**
			 * 上传营业执照
			 * @param {Object} param 图片参数
			 */
			uploadimg_business_license(param) {
								this.uploadFile(param.file, "business_license");
							},
	
	
					/**
			 * 上传认证申请
			 * @param {Object} param 图片参数
			 */
			uploadimg_certification_application(param) {
								this.uploadFile(param.file, "certification_application");
							},
	
	
			},
		created() {
												}
	}
</script>
