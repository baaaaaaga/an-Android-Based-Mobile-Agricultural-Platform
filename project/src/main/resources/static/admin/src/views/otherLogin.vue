<template>
	<div class="authorize-all">
		<div class="authorize-line">
			<i v-if="type == 'wechat'" class="otherlogin-icon wechat-icon"></i>
			<i v-if="type == 'qq'" class="otherlogin-icon qq-icon"></i>
			<i v-if="type == 'wb'" class="otherlogin-icon wb-icon"></i>
			<img class="exchange-icon" src="@/assets/images/exchange.png" alt="">
			<img class="user-icon" src="@/assets/images/user.png" alt="">
		</div>
		<div class="msg-list">
			<template v-if="type == 'wechat'">
				<div><i class="dot"></i>获取你的名字和登录名</div>
				<div><i class="dot"></i>获取你的企业名称</div>
				<div><i class="dot"></i>获取你的昵称、头像、性别、地区和用户状态</div>
			</template>
			<template v-if="type == 'qq'">
				<div>快捷登录</div>
				<div>使用QQ手机版扫码登录，或点击头像授权登录。</div>
			</template>

			<template v-if="type == 'wb'">
				<div>将允许进行以下操作：</div>
				<div><i class="dot"></i>获取你的个人信息，好友关系</div>
				<div><i class="dot"></i>分享内容到你的微博</div>
				<div><i class="dot"></i>获得你的评论</div>
			</template>
		</div>
		<div>
			<el-button @click='cancel' type="default">暂不授权</el-button>
			<el-button @click='sign_in' type="primary">确认授权</el-button>
		</div>
	</div>
</template>

<script>
export default {
	data: function () {
		return {
			type: '',
			password:'',
			username:'',
		}
	},
	methods: {
		cancel() {
			//暂不授权
			this.$router.go(-1)
		},
		sign_in() {
			//确认授权

			var _this = this;
			var form = {
				password: _this.password,
				username: _this.username
			};



			// 查询用户
			this.$post('~/api/user/login?', form, (res) => {
				if (res.result && res.result.obj) {
					var obj = res.result.obj;

					// 缓存用户
					_this.$store.commit('user_set', obj);

					// 存储用户
					if (_this.remember_me) {
						$.db.set('account', account);
					}

					// 获取权限
					_this.$get_auth(obj.user_group, () => {
						var url = _this.$redirect();
						_this.$router.push(url || '/');
					})

					// 存储登录回来的用户信息
					$.db.set('user_group', JSON.stringify(res.result.obj));
				} else if (res.error) {
					console.log(res.error);
					_this.$toast(res.error.message, 'error');
				}
			});

		},
	},
	created() {

	},
	mounted() {
		if(!!this.$route.params.type){
			this.type = this.$route.params.type;
			this.username = this.$route.params.username;
			this.password = this.$route.params.password;
		}else{
			this.type = this.$store.state.web.otherLogin.type;
			this.username = this.$store.state.web.otherLogin.username;
			this.password = this.$store.state.web.otherLogin.password;
		}
		
	},
	components: {
	}
}
</script>

<style scoped>
.authorize-all {
	width: 100vw;
	height: 100vh;
	display: flex;
	flex-direction: column;
	align-items: center;
	font-size: 14px;
}

.authorize-line {
	display: flex;
	flex-direction: row;
	align-items: center;
	justify-content: center;
	margin-bottom: 40px;
	margin-top: 20vh;
}

.otherlogin-icon {
	width: 45px;
	height: 45px;
	display: inline-block;
	margin-right: 20px;
	cursor: pointer;
	background-image: url('../assets/images/otherlogin.png');
	background-repeat: no-repeat;
}

.authorize-line .wechat-icon {
	background-position: 0px 0px;

}

.authorize-line .qq-icon {
	background-position: 0px;
}

.authorize-line .wb-icon {
	background-position: 0px -95px;
	margin-right: 0;
}

.exchange-icon {
	width: 30px;
	margin: 0 20px;
}

.user-icon {
	width: 45px;

}

.msg-list {
	margin-bottom: 20px;
	line-height: 26px;

}

.msg-list div {
	display: flex;
	flex-direction: row;
	align-items: center;
}

.msg-list .dot {
	width: 6px;
	height: 6px;
	background: #999;
	display: inline-block;
	border-radius: 50%;
	margin-right: 5px;
}
</style>
