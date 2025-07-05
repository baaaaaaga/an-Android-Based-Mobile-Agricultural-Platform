<template>
  <view class="message_edit" :style="{ paddingTop: vuex_custom_bar_height + 'px' }">
    <tn-nav-bar>在线留言</tn-nav-bar>
    <view class="message_edit_wrapper" id="i_want_to_customize_edit">
      <view class="cell">
        <view class="label">
          <text> 标题: </text>
        </view>
        <view class="value">
          <input type="text" id="form_title" v-model="form.title" placeholder="请输入标题" />
        </view>
      </view>
      <view class="cell">
        <view class="label">
          <text> 用户名: </text>
        </view>
        <view class="value">
          <input
            type="text"
            id="form_nickname"
            v-model="form.nickname"
            placeholder="请输入用户名"
            :disabled="disabledObj.nickname_disabled"
          />
        </view>
      </view>

      <view class="cell border-none">
        <view class="label">
          <text> 留言内容: </text>
        </view>
        <view class="value">
          <textarea
            class="textarea"
            :inputBorder="true"
            v-model="form.content"
            placeholder="请输入留言内容"
          ></textarea>
        </view>
      </view>
      <view class="footer">
        <view class="me-btn btn-submit" @click="submitForm()">提交</view>
      </view>
    </view>
  </view>
</template>

<script>
export default {
  data() {
    return {
      form: {
        title: '',
        nickname: '',
        content: '',
        // phone: '',
        // email: ''
      },
      disabledObj: {
        nickname_disabled: false,
        // phone_disabled: false,
        // email_disabled: false,
      },
    };
  },
  onLoad() {},
  computed: {
    /**
     * 验证用户名
     */
    validation_nickname() {
      var length = this.form.nickname.length;
      if (!length) {
        return null;
      }
      return length > 0;
    },
    /**
     * 验证邮箱
     */
    // validation_email() {
    //   var length = this.form.email.length;
    //   if (!length) {
    //     return true;
    //   }
    //   return length > 4 && length < 17;
    // },
    /**
     * 验证手机
     */
    // validation_phone() {
    //   var length = this.form.phone.length;
    //   if (!length) {
    //     return null;
    //   }
    //   return length > 1 && length < 12;
    // },
    /**
     * 验证留言内容
     */
    validation_content() {
      var length = this.form.content.length;
      if (!length) {
        return true;
      }
      return length > 1 && length < 580;
    },
    /**
     * 验证标题
     */
    validation_title() {
      var length = this.form.title.length;
      if (!length) {
        return null;
      }
      return true;
    },
  },
  created() {
    let user = this.$store.state.app.userInfo;
    if (user && user.user_id) {
      this.form.nickname = user.nickname;
      this.disabledObj.nickname_disabled = true;
      // if (user.email){
      //   this.form.email = user.email;
      //   this.disabledObj.email_disabled = true;
      // }
      // if (user.phone){
      //   this.form.phone = user.phone;
      //   this.disabledObj.phone_disabled = true;
      // }
    }
  },
  methods: {
    /**
     * 手动提交
     * @param {Object} form
     */
    async submitForm() {
      console.log(this.validation_nickname);
      console.log(this.validation_title);
      console.log(this.validation_content);
      let condition = this.validation_nickname && this.validation_title && this.validation_content;

      if (!condition) {
        this.$toast('输入不合法');
        return;
      }

      let { user_id, avatar } = this.userInfo;
      this.$post(
        '~/api/message/add?',
        Object.assign({}, this.form, {
          user_id,
          avatar,
        }),
        (res) => {
          if (res.result) {
            const pages = getCurrentPages();
            const prevPage = pages[pages.length - 2]; // 上一个页面
            uni.navigateBack({
              delta: 1,
              success: () => {
                prevPage.$vm.mescroll.triggerDownScroll(); // 直接调用上个页面的刷新方法
              },
            });
          } else if (res.error) {
            this.$toast(res.error.message);
          }
        }
      );
    },
    /**
     * 手动重置表单
     */
    resetForm() {
      this.$refs.form.resetFields();
    },
  },
};
</script>

<style lang="scss" scoped>
@import 'styles/pagesB/index.scss';
</style>
