<template>
  <view class="page_user_info" id="page_user_info" :style="{ paddingTop: vuex_custom_bar_height + 'px' }">
    <tn-nav-bar>基本信息</tn-nav-bar>
    <!-- 信息修改模块(开始) -->

    <view class="base-info-list">
      <tn-list-cell class="user_avatar"
        ><view class="cell-wrap">
          <view class="cell-wrap-left">
            <view>头像</view>
          </view>
          <view class="cell-wrap-right">
            <tn-avatar size="lg" :src="$fullImgUrl(user.avatar)"></tn-avatar>
          </view>
        </view>
      </tn-list-cell>

      <tn-list-cell class="user_item"
        ><view class="cell-wrap">
          <view class="cell-wrap-left">
            <view>昵称</view>
          </view>
          <view class="cell-wrap-right">
            <tn-input
              type="text"
              v-model="form.nickname"
              placeholder="请输入昵称"
              inputAlign="right"
            ></tn-input>
          </view>
        </view>
      </tn-list-cell>

      <tn-list-cell class="user_item" @click="$navTo('/pages/user/password')" :arrow="true">修改密码</tn-list-cell>
      <tn-list-cell class="user_item" v-if="canEditInfo" :unlined="true" @click="$navTo(source_table_url)" :arrow="true"
        >修改资料</tn-list-cell
      >

      <view class="user-info-footer">
        <view class="me-btn save-btn" @click="save_nickname">保存</view>
      </view>
    </view>
    <!-- 信息修改模块(结束) -->
  </view>
</template>

<script>
import mixin from '@/libs/mixins/page.js';
export default {
  mixins: [mixin],
  data() {
    return {
      // 登录权限
      oauth: {
        signIn: true,
        user_group: '',
      },
      href: 'https://uniapp.dcloud.io/component/README?id=uniui',
      // 输入框是否隐藏
      display_input: 'none',
      display_name: 'block',
      // 输入聚焦
      focus_input: false,
      // 有昵称的表格对象
      form: {},
      source_table_url: '',
	  // 修改资料权限
	  canEditInfo: false,
    };
  },
  methods: {
    change_avatar() {
      var _self = this;
      // 选择图像方法
      uni.chooseImage({
        count: 1,
        sizeType: ['original', 'compressed'], //可以指定是原图还是压缩图，默认二者都有
        sourceType: ['album'], //从相册选择
        success: function (res) {
          const tempFilePaths = res.tempFilePaths;
          const uploadTask = uni.uploadFile({
            url: _self.$fullUrl('~/api/user/upload?'),
            filePath: tempFilePaths[0],
            name: 'file',
            header: {
              'x-auth-token': _self.$store.state.app.userInfo.token,
            },
            formData: {},
            success: function (uploadFileRes) {
              var filename = JSON.parse(uploadFileRes.data).result.url;
              console.log(filename);
              // 改用户表中的头像
              // var avatar = filename
              var avatar = JSON.parse(uploadFileRes.data).result.url;
              _self.$post(
                '~/api/user/set?user_id=' + _self.user.user_id,
                {
                  avatar,
                },
                (res) => {
                  console.log(res);
                  _self.user.avatar = filename;
                }
              );
            },
          });

          uploadTask.onProgressUpdate(function (res) {
            _self.percent = res.progress;
            console.log('上传进度' + res.progress);
            console.log('已经上传的数据长度' + res.totalBytesSent);
            console.log('预期需要上传的数据总长度' + res.totalBytesExpectedToSend);
          });
        },
        error: function (e) {
          console.log(e);
        },
      });
    },
    // 跳出修改昵称输入框
    change_nickname() {
      this.display_input = 'flex';
      this.display_name = 'none';
      this.focus_input = true;
    },
    // 保存昵称修改
    save_nickname() {
      var user = this.user;
      var nickname = this.form.nickname;
      this.$post(
        '~/api/user/set?user_id=' + user.user_id,
        {
          nickname,
        },
        (res) => {
          console.log(res);
          this.focus_input = false;
          this.display_input = 'none';
          this.display_name = 'block';
          this.user.nickname = nickname;
          this.$toast('保存成功');
        }
      );
    },
    async get_source_table_url() {
      let user_group = this.userInfo.user_group;
	  if(user_group != "管理员"){
		  var json = await this.$get('~/api/user_group/get_obj?name=' + user_group);
		  if (json.result && json.result.obj) {
			  if(this.$check_action('/' + json.result.obj.source_table + '/view', 'get')){
				  this.canEditInfo = true;
				  var json_sub = await this.$get(
				    '~/api/' + json.result.obj.source_table + '/get_obj?user_id=' + this.userInfo.user_id
				  );
				  if (json_sub.result && json_sub.result.obj) {
				  	if(json.result.obj.source_table != ''){
				  		let basePath = '/pagesC/';
				  		this.source_table_url =
				  		  	basePath +
				  		  	json.result.obj.source_table +
				  		  	'/view?' +
				  		  	json.result.obj.source_field +
				  		  	'=' +
				  		  	json_sub.result.obj[json.result.obj.source_field];
				  		  	console.log(this.source_table_url)
				  	}
				  }
			  }
		  }
	  }
    },
	
  },
  created() {
    this.get_source_table_url();
    this.form.nickname = this.userInfo.nickname;
  },
};
</script>
<style lang="scss" scoped>
@import 'styles/pages/index.scss';
</style>
