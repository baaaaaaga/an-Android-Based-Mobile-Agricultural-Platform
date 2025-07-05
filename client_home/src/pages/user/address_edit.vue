<template>
  <view class="page_user_address_edit" :style="{ paddingTop: vuex_custom_bar_height + 'px' }">
    <tn-nav-bar>{{ isEdit ? '编辑收货地址' : '新增收货地址' }}</tn-nav-bar>
    <view class="user_address_edit_wrapper" id="user_address_edit">
      <view class="content">
        <view class="row">
          <view class="nominal"> 收件人 </view>
          <view class="input">
            <input placeholder="请输入收货人姓名" type="text" v-model="form[vm.name]" />
          </view>
        </view>
        <view class="row">
          <view class="nominal"> 电话号码 </view>
          <view class="input">
            <input placeholder="请输入收货人手机号" type="text" v-model="form[vm.phone]" />
          </view>
        </view>

        <view class="row">
          <view class="nominal"> 详细地址 </view>
          <view class="input">
            <textarea
              v-model="form[vm.address]"
              auto-height="true"
              placeholder="输入详细地址"
            ></textarea>
          </view>
        </view>
      </view>

      <view class="footer">
        <view class="me-btn btn-save" @click="save_address">保存 </view>
      </view>
    </view>
  </view>
</template>

<script>
import { getUserAddressApi } from '@/api/address';
export default {
  data() {
    return {
      isEdit: false,
      form: {
        user_id: '',
        address: '',
        address_id: '',
        name: '',
        phone: '',
      },
      vm: {
        address: 'address',
        address_id: 'address_id',
        name: 'name',
        phone: 'phone',
      },
    };
  },
  methods: {
    getUserAddress() {
      getUserAddressApi({
        user_id: this.userInfo.user_id,
        default: 1,
      }).then((res) => {
        const address = res.result.obj;
        for (const key in this.form) {
          this.form[key] = address[key];
        }
      });
    },
    // 保存地址
    save_address() {
      var { address, name, phone, address_id, user_id } = this.form;
      let phone_regular =
        /^(13[0-9]|14[01456879]|15[0-35-9]|16[2567]|17[0-8]|18[0-9]|19[0-35-9])\d{8}$/;
      if (phone && !phone_regular.test(phone)) {
        this.$toast('请输入正确的手机号码', 'error');
        return;
      }
      user_id = this.userInfo.user_id;
      if (address_id) {
        this.$post(
          `~/api/address/set?address_id=${address_id}`,
          { address, name, phone, user_id },
          (res) => {
            console.log(res);
            uni.navigateBack({
              delta: 1,
            });
          }
        );
      } else {
        this.$post(`~/api/address/add?`, { address, name, phone, user_id }, (res) => {
          console.log(res);
          uni.navigateBack({
            delta: 1,
          });
        });
      }
    },
  },
  onLoad(e) {
    if (e.address_id) {
      this.isEdit = true;
      this.getUserAddress();
    }
  },
};
</script>

<style lang="scss" scoped>
@import 'styles/pages/index.scss';
</style>
