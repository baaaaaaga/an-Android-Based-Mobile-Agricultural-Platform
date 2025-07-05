<template>
  <view class="page_user_password" id="page_user_password" :style="{ paddingTop: vuex_custom_bar_height + 'px' }">
    <tn-nav-bar>修改密码</tn-nav-bar>
    <view class="user-password-list">
      <tn-form
        :model="form"
        ref="formRef"
        :errorType="errorType"
        :labelPosition="labelPosition"
        :labelAlign="labelAlign"
      >
        <tn-form-item
          label="原密码"
          prop="o_password"
          :required="true"
          :labelPosition="labelPosition"
          :labelAlign="labelAlign"
          :labelWidth="200"
        >
          <tn-input v-model="form.o_password" placeholder="请输入密码" :border="border"></tn-input>
        </tn-form-item>
        <tn-form-item
          label="密码"
          prop="password"
          :required="true"
          :labelPosition="labelPosition"
          :labelAlign="labelAlign"
          :labelWidth="200"
        >
          <tn-input v-model="form.password" placeholder="请输入密码" :border="border"></tn-input>
        </tn-form-item>
        <tn-form-item
          label="确认密码"
          prop="confirm_password"
          :required="true"
          :labelPosition="labelPosition"
          :labelAlign="labelAlign"
          :labelWidth="200"
        >
          <tn-input
            v-model="form.confirm_password"
            placeholder="请再次输入密码"
            :border="border"
          ></tn-input>
        </tn-form-item>
      </tn-form>
    </view>
    <view class="user-password-footer">
      <view class="me-btn btn-save" size="lg" @click="changePassword">保存</view>
    </view>
  </view>
</template>

<script>
import mixin from '@/libs/mixins/page.js';
import { changePasswordApi } from '@/api/user';
export default {
  mixins: [mixin],
  data() {
    return {
      loading: false,
      border: false,
      labelPosition: 'left',
      labelAlign: 'left',
      errorType: ['message', 'border-bottom', 'toast'],
      // 登录权限
      oauth: {
        signIn: true,
        user_group: [],
      },
      form: {
        o_password: '',
        password: '',
        confirm_password: '',
      },
      rules: {
        password: [
          {
            required: true,
            message: '请输入密码',
            trigger: 'blur',
          },
          {
            min: 5,
            max: 16,
            message: '密码长度在5到16个字符',
            trigger: ['change', 'blur'],
          },
        ],
        o_password: [
          {
            required: true,
            message: '请输入原密码',
            trigger: 'blur',
          },
          {
            min: 5,
            max: 16,
            message: '原密码长度在5到16个字符',
            trigger: ['change', 'blur'],
          },
        ],
        confirm_password: [
          {
            required: true,
            message: '请输入确认密码',
            trigger: 'blur',
          },
          {
            min: 5,
            max: 16,
            message: '确认密码长度在5到16个字符',
            trigger: ['change', 'blur'],
          },
        ],
      },
    };
  },
  onReady() {
    this.$refs.formRef.setRules(this.rules);
  },
  methods: {
    changePassword() {
      if (this.loading) return;
      if (this.form.password !== this.form.confirm_password) {
        this.$toast('密码不相同', 'error');
        return;
      }
      this.loading = true;
      this.$refs.formRef.validate((valid) => {
        if (valid) {
          const data = { ...this.form };
          delete data.confirm_password;
          changePasswordApi(data)
            .then((res) => {
              if (res.result) {
                this.$toast('修改成功');
                setTimeout(() => {
                  this.$nav('/pages/index/index');
                }, 2000);
              } else if (res.error) {
                this.$toast(res.error.message, 'error');
              }
            })
            .finally(() => {
              this.loading = false;
            });
        }
      });
    },
  },
};
</script>

<style lang="scss" scoped>
@import 'styles/pages/index.scss';
</style>
