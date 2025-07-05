<template>
	<el-main class="bg table_wrap messge">
		<el-form label-position="right" :model="query" class="form p_4" label-width="120">
			<el-row class="rows row1">
				<el-col :xs="24" :sm="12" :lg="8" class="el_form_search_wrap">
					<el-form-item label="标题">
						<el-input v-model="query.title"></el-input>
					</el-form-item>
				</el-col>

				<el-col :xs="24" :sm="12" :lg="8" class="el_form_search_wrap">
					<el-form-item label="昵称">
						<el-input v-model="query.nickname"></el-input>
					</el-form-item>
				</el-col>
			</el-row>
			<el-row class="rows row2">
				<el-col :xs="24" :sm="24" :lg="24" class="search_btn_wrap">
					<el-col :xs="24" :sm="12" :lg="12" class="search_btn_1 btns">
					
							<el-button type="primary" @click="search()" class="search_btn_find">查询</el-button>
							<el-button @click="reset()" class="search_btn_reset">重置</el-button>
							<el-button v-if="$check_action('/message/table','del')" class="float-right search_btn_del" type="danger" @click="delInfo()">删除</el-button>
<!--							<router-link v-if="user_group == '管理员' || $check_action('/message/view')" class="el-button float-right el-button&#45;&#45;default el-button&#45;&#45;primary search_btn_add"-->
<!--								to="./view?"><span>添加</span>-->
<!--							</router-link>-->
						
					</el-col>
					
				</el-col>

			</el-row>
		</el-form>

		<el-table border :data="list" @selection-change="selectionChange" @sort-change="$sortChange" style="width: 100%" stripe>

			<!-- 多选按钮 -->
			<el-table-column fixed type="selection" tooltip-effect="dark" width="55">
			</el-table-column>
			<!-- /多选按钮 -->

			<el-table-column label="头像" width="120">
				<template slot-scope="scope">
					<div class="block" >
						<el-avatar :src="$fullUrl(scope.row.avatar)" :size="60">
							<img src="../../../public/img/bg.jpg" />
						</el-avatar>
					</div>
				</template>
			</el-table-column>

			<el-table-column label="标题" prop="title" sortable min-width="160">
			</el-table-column>

			<el-table-column label="昵称" prop="nickname" sortable min-width="100">
			</el-table-column>

<!--			<el-table-column label="留言者" prop="user_id" sortable min-width="100">-->
<!--				<template slot-scope="scope">-->
<!--					{{list_user.getVal('nickname', {"user_id":scope.row.user_id})}}-->
<!--				</template>-->
<!--			</el-table-column>-->

<!--			<el-table-column label="留言手机号" prop="phone" sortable min-width="140">-->
<!--			</el-table-column>-->

<!--			<el-table-column label="留言邮箱" prop="email" sortable min-width="140">-->
<!--			</el-table-column>-->

      <el-table-column label="内容" prop="content" sortable min-width="140">
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

			<!-- 操作 -->
			<el-table-column fixed="right" label="操作" width="200">
				<template slot-scope="scope">
					<div class="view_a">
					<router-link class="e-button el-button--small is-plain el-button--primary"
						:to="'./view?' + field + '=' + scope.row[field]" size="small">
            			<span>详情</span>
					</router-link>

						<el-button @click="reply(scope.row)" v-if="user_group ==='管理员' && scope.row['reply_state']==0" class="e-button el-button--small is-plain el-button--primary">回复</el-button>
						<el-button @click="show_reply(scope.row)" v-if="scope.row['reply_state']==1" class="e-button el-button--small is-plain el-button--primary">查看回复</el-button>
					</div>
				</template>
			</el-table-column>
			<!-- /操作 -->

		</el-table>

		<!-- 分页器 -->
		<div class="mt text_center">
			<el-pagination @size-change="handleSizeChange" @current-change="handleCurrentChange" :current-page="query.page"
			 :page-sizes="[7, 10, 30, 100]" :page-size="query.size" layout="total, sizes, prev, pager, next, jumper" :total="count">
			</el-pagination>
		</div>
		<!-- /分页器 -->

    <el-dialog title="回复" :visible.sync="showModal">
      <quill-editor v-if="is_check" class="editor el_form_editor_warp" v-model="form.reply">
      </quill-editor>
      <div v-else v-html="form.reply"></div>
      <div slot="footer" class="dialog-footer">
        <el-button @click="showModal = false">取 消</el-button>
        <el-button type="primary" v-if="canReply" @click="submit_reply">确 定</el-button>
      </div>
    </el-dialog>

	</el-main>
</template>

<script>
  import mixin from "@/mixins/page.js";

	export default {
		mixins: [mixin],
		data() {
			return {
				table: "message",
				field: "message_id",
				url_get_list: "~/api/message/get_list?like=0",
				url_del: "~/api/message/del?",

				query: {
					size: 10,
					page: 1,
				},

				// 数据
				list: [],

				// 获取用户信息
				list_user: [],
        //回复
        showModal: false,
        form:{
          message_id: 0,
          reply: null,
          reply_state: 0
        },
        canReply:false,
        is_check:true
			}
		},
		methods: {
      get_list_before(param){
        let user_group = this.user.user_group;
        if (!user_group || user_group === "游客"){
          this.url_get_list = "~/api/message/get_list?like=0&user_id=0";
        }
        if(user_group !== "管理员"){
          param.user_id = this.$store.state.user.user_id;
        }
        return param;
      },
			// 获取用户列表
			async get_list_user() {
				var json = await this.$get("~/api/user/get_list?");
				if(json.result){
					this.list_user = json.result.list;
				}
				else if(json.error){
					console.error(json.error);
				}
			},
			table_class({row, column, rowIndex, columnIndex}){
				return "table_class";
			},
      submit_reply(){
        this.form.reply_state = 1;
        let _this = this;
        _this.$post("~/api/message/set?message_id="+_this.form.message_id, _this.form, function (json, status) {
          if (json.result) {
            _this.$toast("回复成功", 'success');
          } else if (json.error) {
            _this.$toast(json.error.message, 'danger');
          }
          _this.showModal = false
          _this.get_list();
        });
      },
      reply(v){
        this.form.message_id = v.message_id;
        this.form.reply = "";
        this.canReply = true;
        this.is_check = true;
        this.showModal = true
      },
      show_reply(v){
        this.form.reply = v.reply;
        this.canReply = false;
        this.is_check = false;
        this.showModal = true
      }
		},
		created() {
			// 初始化用户列表
			this.get_list_user();
		}
	}
</script>

<style>

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
</style>
