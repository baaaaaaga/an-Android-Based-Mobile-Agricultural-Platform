<template>
	<el-main class="bg edit_wrap comtable_e">
		<el-form ref="form" :rules="rules" :model="form" status-icon label-width="120px" v-if="is_view()">
		<el-row class="row_ce"> 
	            <el-col :xs="24" :sm="12" :lg="8" class="el_form_item_warp">
                <el-form-item label="封面图" prop="cart_avatar">
                    <el-upload class="avatar-uploader" drag accept="image/gif, image/jpeg, image/png, image/jpg"
                               action="" :http-request="upload_cart_img" :show-file-list="false">
                        <img id="cart_img" v-if="form.cart_img" :src="$fullUrl(form.cart_img)" class="avatar">
                        <i v-else class="el-icon-plus avatar-uploader-icon"></i>
                    </el-upload>
                </el-form-item>
            </el-col>

            <el-col :xs="24" :sm="12" :lg="8" class="el_form_item_warp">
                <el-form-item label="主图_1" prop="cart_avatar">
                    <el-upload class="avatar-uploader" drag accept="image/gif, image/jpeg, image/png, image/jpg"
                               action="" :http-request="upload_cart_img_1" :show-file-list="false">
                        <img id="cart_img_1" v-if="form.cart_img_1" :src="$fullUrl(form.cart_img_1)" class="avatar">
                        <i v-else class="el-icon-plus avatar-uploader-icon"></i>
                    </el-upload>
                </el-form-item>
            </el-col>

            <el-col :xs="24" :sm="12" :lg="8" class="el_form_item_warp">
                <el-form-item label="主图_2" prop="cart_avatar">
                    <el-upload class="avatar-uploader" drag accept="image/gif, image/jpeg, image/png, image/jpg"
                               action="" :http-request="upload_cart_img_2" :show-file-list="false">
                        <img id="cart_img_2" v-if="form.cart_img_2" :src="$fullUrl(form.cart_img_2)" class="avatar">
                        <i v-else class="el-icon-plus avatar-uploader-icon"></i>
                    </el-upload>
                </el-form-item>
            </el-col>

            <el-col :xs="24" :sm="12" :lg="8" class="el_form_item_warp">
                <el-form-item label="主图_3" prop="cart_avatar">
                    <el-upload class="avatar-uploader" drag accept="image/gif, image/jpeg, image/png, image/jpg"
                               action="" :http-request="upload_cart_img_3" :show-file-list="false">
                        <img id="cart_img_3" v-if="form.cart_img_3" :src="$fullUrl(form.cart_img_3)" class="avatar">
                        <i v-else class="el-icon-plus avatar-uploader-icon"></i>
                    </el-upload>
                </el-form-item>
            </el-col>

            <el-col :xs="24" :sm="12" :lg="8" class="el_form_item_warp">
                <el-form-item label="主图_4" prop="cart_avatar">
                    <el-upload class="avatar-uploader" drag accept="image/gif, image/jpeg, image/png, image/jpg"
                               action="" :http-request="upload_cart_img_4" :show-file-list="false">
                        <img id="cart_img_4" v-if="form.cart_img_4" :src="$fullUrl(form.cart_img_4)" class="avatar">
                        <i v-else class="el-icon-plus avatar-uploader-icon"></i>
                    </el-upload>
                </el-form-item>
            </el-col>

            <el-col :xs="24" :sm="12" :lg="8" class="el_form_item_warp">
                <el-form-item label="主图_5" prop="cart_avatar">
                    <el-upload class="avatar-uploader" drag accept="image/gif, image/jpeg, image/png, image/jpg"
                               action="" :http-request="upload_cart_img_5" :show-file-list="false">
                        <img id="cart_img_5" v-if="form.cart_img_5" :src="$fullUrl(form.cart_img_5)" class="avatar">
                        <i v-else class="el-icon-plus avatar-uploader-icon"></i>
                    </el-upload>
                </el-form-item>
            </el-col>

            <el-col :xs="24" :sm="12" :lg="12" class="el_form_item_warp">
                <el-form-item label="标题" prop="cart_title">
                    <el-input v-model="form.cart_title" placeholder="请输入标题"></el-input>
                </el-form-item>
            </el-col>

            <el-col :xs="24" :sm="12" :lg="12" class="el_form_item_warp">
                <el-form-item label="描述" prop="cart_description">
                    <el-input v-model="form.cart_description" placeholder="请输入描述"></el-input>
                </el-form-item>
            </el-col>

            <el-col :xs="24" :sm="12" :lg="8" class="el_form_item_warp">
                <el-form-item label="原价" prop="cart_price_ago">
                    <el-input-number v-model="form.cart_price_ago"></el-input-number>
                </el-form-item>
            </el-col>

		
            <el-col :xs="24" :sm="12" :lg="8" class="el_form_item_warp">
                <el-form-item label="卖价" prop="cart_price">
                    <el-input-number v-model="form.cart_price"></el-input-number>
                </el-form-item>
            </el-col>

		
            <el-col :xs="24" :sm="12" :lg="8" class="el_form_item_warp">
                <el-form-item label="库存" prop="cart_inventory">
                    <el-input-number v-model="form.cart_inventory" placeholder="请输入库存"></el-input-number>
                </el-form-item>
            </el-col>

            <el-col :xs="24" :sm="12" :lg="8" class="el_form_item_warp">
                <el-form-item label="分类" prop="cart_type">
                    <el-select v-model="form.cart_type">
                        <el-option v-for="(o ,i) in list_cart_goods_type" :value="o.name" :key="i"
                                   :label="o.name"></el-option>
                    </el-select>
                </el-form-item>
            </el-col>
							<el-col v-if="$check_field('get','product_specifications') || $check_field('add','product_specifications') || $check_field('set','product_specifications')" :xs="24" :sm="12" :lg="8" class="el_form_item_warp">
							<el-form-item label="产品规格" prop="product_specifications">
															<el-input id="product_specifications" v-model="form['product_specifications']" placeholder="请输入产品规格"
							  v-if="(form['agricultural_products_id'] && $check_field('set','product_specifications')) || (!form['agricultural_products_id'] && $check_field('add','product_specifications'))" :disabled="disabledObj['product_specifications_isDisabled']"></el-input>
					<div v-else-if="$check_field('get','product_specifications')">{{form['product_specifications']}}</div>
											</el-form-item>
			</el-col>
								<el-col v-if="$check_field('get','farmers_merchants') || $check_field('add','farmers_merchants') || $check_field('set','farmers_merchants')" :xs="24" :sm="12" :lg="8" class="el_form_item_warp">
							<el-form-item label="农户商家" prop="farmers_merchants">
																					<div v-if="user_group !== '管理员'">
							{{ get_user_session_farmers_merchants(form['farmers_merchants']) }}
							<el-select v-if="(form['agricultural_products_id'] && $check_field('set','farmers_merchants')) || (!form['agricultural_products_id'] && $check_field('add','farmers_merchants'))" id="farmers_merchants" v-model="form['farmers_merchants']" :disabled="disabledObj['farmers_merchants_isDisabled']">
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
							<el-form-item label="商家名称" prop="business_name">
															<el-input id="business_name" v-model="form['business_name']" placeholder="请输入商家名称"
							  v-if="(form['agricultural_products_id'] && $check_field('set','business_name')) || (!form['agricultural_products_id'] && $check_field('add','business_name'))" :disabled="disabledObj['business_name_isDisabled']"></el-input>
					<div v-else-if="$check_field('get','business_name')">{{form['business_name']}}</div>
											</el-form-item>
			</el-col>
								<el-col v-if="$check_field('get','contact_number') || $check_field('add','contact_number') || $check_field('set','contact_number')" :xs="24" :sm="12" :lg="8" class="el_form_item_warp">
							<el-form-item label="联系号码" prop="contact_number">
											<el-input id="contact_number" v-model="form['contact_number']" placeholder="请输入联系号码" type="tel"
						v-if="(form['agricultural_products_id'] && $check_field('set','contact_number')) || (!form['agricultural_products_id'] && $check_field('add','contact_number'))">
					</el-input>
					<div v-else-if="$check_field('get','contact_number')">{{form['contact_number']}}</div>
							</el-form-item>
			</el-col>
								<el-col v-if="$check_field('get','business_address') || $check_field('add','business_address') || $check_field('set','business_address')" :xs="24" :sm="12" :lg="8" class="el_form_item_warp">
							<el-form-item label="商家地址" prop="business_address">
															<el-input id="business_address" v-model="form['business_address']" placeholder="请输入商家地址"
							  v-if="(form['agricultural_products_id'] && $check_field('set','business_address')) || (!form['agricultural_products_id'] && $check_field('add','business_address'))" :disabled="disabledObj['business_address_isDisabled']"></el-input>
					<div v-else-if="$check_field('get','business_address')">{{form['business_address']}}</div>
											</el-form-item>
			</el-col>
						
	
	
		
		
	
	
	
	            <el-col :xs="24" :sm="24" :lg="24" class="el_form_editor_warp">
                <el-form-item label="正文" prop="cart_content">
                    <quill-editor v-model="form.cart_content">
                    </quill-editor>
                </el-form-item>
            </el-col>
		
		
	
		</el-row>
			<el-col :xs="24" :sm="12" :lg="8" class="el_form_btn_warp">
				<el-form-item v-if="$check_action('/agricultural_products/view','set') || $check_action('/agricultural_products/view','add') || $check_option('/agricultural_products/table','examine')">
					<el-button type="primary" @click="submitCheckNew">提交</el-button>
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
				field: "agricultural_products_id",
				url_add: "~/api/agricultural_products/add?",
				url_set: "~/api/agricultural_products/set?",
				url_get_obj: "~/api/agricultural_products/get_obj?",
				url_upload: "~/api/agricultural_products/upload?",

				query: {
					"agricultural_products_id": 0,
				},

				form: {
								"product_specifications":  '', // 产品规格
										"farmers_merchants": 0, // 农户商家
										"business_name":  '', // 商家名称
										"contact_number":  '', // 联系号码
										"business_address":  '', // 商家地址
						                    cart_title: "",
                    cart_img: "",
                    cart_description: "",
		                    cart_price_ago: 0,
                    cart_price: 0,
                    cart_inventory: 0,
		                    cart_type: '',
                    cart_content: "",
                    cart_img_1: "",
                    cart_img_2: "",
                    cart_img_3: "",
                    cart_img_4: "",
                    cart_img_5: "",
						"agricultural_products_id": 0, // ID
															},
				disabledObj:{
								"product_specifications_isDisabled": false,
										"farmers_merchants_isDisabled": false,
										"business_name_isDisabled": false,
										"contact_number_isDisabled": false,
										"business_address_isDisabled": false,
										},

	
			
					// 用户列表
				list_user_farmers_merchants: [],
						// 用户组
				group_user_farmers_merchants: "",
					
			
			
		                list_cart_goods_type: [],
				goods_form:{
					goods_id: 0,
					title: "",
					img: "",
					description: "",
					price_ago: 0,
					price: 0,
					inventory: 0,
						type: '',
					content: "",
					img_1: "",
					img_2: "",
					img_3: "",
					img_4: "",
					img_5: "",
					source_table: "",
					source_field: "",
					source_id: 0,
					user_id:this.$store.state.user.user_id
				},
				rules:{
					"cart_title": [
						{required: true, message: '请输入标题', trigger: 'blur'},
					],
					"cart_description": [
						{required: true, message: '请输入描述', trigger: 'blur'},
					],
					"cart_price_ago": [
						{required: true, message: '请输入原价', trigger: 'blur'},
					],
						"cart_price": [
						{required: true, message: '请输入卖价', trigger: 'blur'},
					],
					"cart_inventory": [
						{required: true, message: '请输入库存', trigger: 'blur'},
					],
					"cart_type": [
						{required: true, message: '请选择分类', trigger: 'change'},
					],
					"cart_content": [
						{required: true, message: '请输入正文', trigger: 'blur'},
					]
				}

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
			if(/^\d{10}$|^\d{13}$/.test(this.form["product_specifications"])){
			this.form["product_specifications"] = this.$toTime(parseInt(this.form["product_specifications"]),"yyyy-MM-dd hh:mm:ss")
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
					
																																										let contact_number_phone_regular = /^(13[0-9]|14[01456879]|15[0-35-9]|16[2567]|17[0-8]|18[0-9]|19[0-35-9])\d{8}$/;
				if(param.contact_number && !contact_number_phone_regular.test(param.contact_number)){
					return "手机号格式错误"
				}
																									return null;
			},

			is_view(){
				// var bl = this.user_group == "管理员";
				var bl = false;

				if(!bl){
					bl = this.$check_action('/agricultural_products/table','add');
					console.log(bl ? "你有表格添加权限视作有添加权限" : "你没有表格添加权限");
				}
				if(!bl){
					bl = this.$check_action('/agricultural_products/table','set');
					console.log(bl ? "你有表格添加权限视作有修改权限" : "你没有表格修改权限");
				}
				if(!bl){
					bl = this.$check_action('/agricultural_products/view','add');
					console.log(bl ? "你有视图添加权限视作有添加权限" : "你没有视图添加权限");
				}
				if(!bl){
					bl = this.$check_action('/agricultural_products/view','set');
					console.log(bl ? "你有视图修改权限视作有修改权限" : "你没有视图修改权限");
				}
				if(!bl){
					bl = this.$check_action('/agricultural_products/view','get');
					console.log(bl ? "你有视图查询权限视作有查询权限" : "你没有视图查询权限");
				}

				console.log(bl ? "具有当前页面的查看权，请注意这不代表你有字段的查看权" : "无权查看当前页，请注意即便有字段查询权限没有页面查询权限也不行");

				return bl;
			},
			submitCheckNew(){
				let that=this;
				for(var i=0;i<5;i++){
					if(i==0 && !this.form[`cart_img`]){
						this.$toast(`请上传封面图`,"error");
						return false;
					}else{
						if(!this.form['cart_img_'+(i+1)]){
							this.$toast('请上传主图'+(i+1),"error");
							return false;
						}
					}
				}
				this.$refs["form"].validate((valid) => {
					if (valid) {
						// 使用mixin里的submit方法
						that.events("submit")
					} else {
						console.error('error 提交失败!!');
					}
				});
			},
            /**
             * 获取商品分类
             */
            async get_cart_goods_type() {
                var res = await this.$get("~/api/goods_type/get_list?");
                this.list_cart_goods_type = res.result.list;
            },
            /**
             * 上传封面图
             * @param {Object} param
             */
            upload_cart_img(param) {
                this.uploadFile(param.file, "cart_img");
            },

            /**
             * 上传文件
             * @param {Object} param
             */
            upload_cart_img_1(param) {
                this.uploadFile(param.file, "cart_img_1");
            },

            /**
             * 上传文件
             * @param {Object} param
             */
            upload_cart_img_2(param) {
                this.uploadFile(param.file, "cart_img_2");
            },

            /**
             * 上传文件
             * @param {Object} param
             */
            upload_cart_img_3(param) {
                this.uploadFile(param.file, "cart_img_3");
            },

            /**
             * 上传文件
             * @param {Object} param
             */
            upload_cart_img_4(param) {
                this.uploadFile(param.file, "cart_img_4");
            },

            /**
             * 上传文件
             * @param {Object} param
             */
            upload_cart_img_5(param) {
                this.uploadFile(param.file, "cart_img_5");
            },

            submit_after(){
                console.log(this.form[this.field])
                if (this.form[this.field]){
                    this.submit_goods(this.form[this.field],"set");
                } else {
                    let query_form = {
                        cart_title:this.form.cart_title,
                        cart_description:this.form.cart_description
                    }
                    this.$get("~/api/agricultural_products/get_obj?",query_form,(res)=>{
                        console.log("商品息res",res);
                        if(res.result && res.result.obj){
                            this.submit_goods(res.result.obj[this.field],"add");
                        }else if(res.error){
                            console.error(res.error);
                            this.$toast(res.error.message,"error");
                        }
                    })
                }
            },
            submit_goods(source_id,add_flag){
				let customize_field = []
							customize_field.push({"field_name":"产品规格","field_value":this.form.product_specifications});
									customize_field.push({"field_name":"农户商家","field_value":this.form.farmers_merchants,"type":"uid"});
									customize_field.push({"field_name":"商家名称","field_value":this.form.business_name});
									customize_field.push({"field_name":"联系号码","field_value":this.form.contact_number});
									customize_field.push({"field_name":"商家地址","field_value":this.form.business_address});
			                this.goods_form = {
                    goods_id: 0,
                    title: this.form.cart_title,
                    img: this.form.cart_img,
                    description: this.form.cart_description,
                    price_ago: this.form.cart_price_ago,
	                    price: this.form.cart_price,
	                    inventory: this.form.cart_inventory,
                    type: this.form.cart_type,
                    content: this.form.cart_content,
                    img_1: this.form.cart_img_1,
                    img_2: this.form.cart_img_2,
                    img_3: this.form.cart_img_3,
                    img_4: this.form.cart_img_4,
                    img_5: this.form.cart_img_5,
                    source_table: "agricultural_products",
                    source_field: this.field,
                    source_id: source_id,
					customize_field: JSON.stringify(customize_field),
					user_id:this.$store.state.user.user_id
                }
                if (add_flag==='set'){
                    delete this.goods_form.goods_id;
					delete this.goods_form.user_id;
                    // 提交事件
                    this.$post("~/api/goods/set?source_table=agricultural_products&source_field=" + this.field + "&source_id=" + source_id,this.goods_form,(res)=>{
                        console.log("提交结果：" ,res)
                        if(res.result){
                            this.$toast("修改成功!" ,"success");
							this.$router.push("/agricultural_products/table");
                        }else if(res.error){
                            console.error(res.error);
                            this.$toast(res.error.message,"error");
                        }
                    });
                }else {
                    // 提交事件
                    this.$post("~/api/goods/add?",this.goods_form,(res)=>{
                        console.log("提交结果：" ,res)
                        if(res.result){
                            this.$toast("添加成功!" ,"success");
							this.$router.push("/agricultural_products/table");
                        }else if(res.error){
                            console.error(res.error);
                            this.$toast(res.error.message,"error");
                        }
                    });
                }
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
									            this.get_cart_goods_type();
		},
		mounted(){
			this.$refs["form"].resetFields();
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
