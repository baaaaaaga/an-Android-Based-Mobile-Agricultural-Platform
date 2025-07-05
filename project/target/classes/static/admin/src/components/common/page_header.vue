<template>
	<header>
		<div class="warp">
			<el-row>
				<el-col :span="24">
					<div class="action_left">
						<a class="btn_menu" href="javascript:void(0)" @click="$emit('change', !isCollapse)">
							<i :class="{'el-icon-menu' : !isCollapse,  'el-icon-s-grid': isCollapse }"></i>
						</a>
						<Borde/>
					</div>
          <div class="action_center">欢迎使用农产品市场平台</div>
					<div class="action_right">
					<div class="timess">
							<div>{{ currentDateTime }}</div>
						</div>
						<el-dropdown @command="handleCommand">
							<div class="el-dropdown-link" style="margin-right: 2rem;">
								<el-avatar style="margin-top: 0.25rem; width: 2.3rem; overflow: hidden;"
									:src="$fullUrl(user.avatar)">
									<img style="width: 2.3rem; overflow: hidden" src="../../../public/img/error.png" />
								</el-avatar>
								<span style="margin-left: 0.5rem; position: relative;top: -0.75rem;">{{ user.nickname || user.username }}</span>
							</div>
							<el-dropdown-menu slot="dropdown">
								<el-dropdown-item command="/user/info">个人信息</el-dropdown-item>
								<el-dropdown-item command="/user/password">修改密码</el-dropdown-item>
								<el-dropdown-item command="/quit" divided>退出</el-dropdown-item>
							</el-dropdown-menu>
						</el-dropdown>
					</div>

				</el-col>
			</el-row>
		</div>
	</header>
</template>


<script>
	import Borde from "../diy/diy_Breadcrumb.vue"
	export default {
		model: {
			event: 'change',
			prop: 'isCollapse'
		},
		props: {
			isCollapse: {
				trye: Boolean,
				default: true
			}
		},
		data() {
			return {
				activeIndex: '1',
				activeIndex2: '1',
				user: this.$store.state.user,
				search: "",
				currentDateTime: "",
				homeUrl:""
			};
		},
		methods: {
			handleSelect(key, keyPath) {
				console.log(key, keyPath);
			},
			handleCommand(command) {
				if (command === "/quit") {
					this.$get("~/api/user/quit",{},(res)=>{
						this.$store.commit("quit");
						this.$router.push("/login");
					});
				} else if(command.indexOf("http")!==-1){
					let token = $.db.get("token");
					if (token){
						location.href = command+"?token="+encodeURIComponent(token);
					}
				} else {
					this.$router.push(command);
				}
			},
			updateDateTime() {
			const now = new Date();
			const year = now.getFullYear();
			const month = String(now.getMonth() + 1).padStart(2, "0");
			const day = String(now.getDate()).padStart(2, "0");
			const hours = String(now.getHours()).padStart(2, "0");
			const minutes = String(now.getMinutes()).padStart(2, "0");
			const seconds = String(now.getSeconds()).padStart(2, "0");

			this.currentDateTime = `${year}-${month}-${day} ${hours}:${minutes}:${seconds}`;
			}
		},
		beforeDestroy() {
    		// 在组件销毁前清除定时器
    		clearInterval(this.timer);
		},
		mounted() {
			this.updateDateTime();
    		// 在组件挂载后，每秒更新一次时间
   		 	this.timer = setInterval(this.updateDateTime, 1000);
   		 	this.homeUrl =  window.location.origin+window.location.pathname.replace("/admin/dist","/home/dist")
  		},

	}
</script>

<style scoped="scoped">
	header {
		background-color: rgb(84, 92, 100);
		border-bottom: var(--color_border);
		color: #fff;
	}

  .action_left {
    float: left;
    width: 30%;
	display:flex;
  }

  .action_center {
    float: left;
    line-height: 51px;
    width: 40%;
    text-align: center;
  }

  .action_right {
	text-align: right;
    float: right;
    display: flex;
    width: 30%;
    align-items: center;
    justify-content: space-around;
  }

	.el-dropdown {
		color: #fff;
	}

	.btn_menu {
		display: inline-block;
		padding: 0.625rem;
	}
</style>
