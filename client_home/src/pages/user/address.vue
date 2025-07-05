<template>
  <view id="page_user_address" class="page_user_address" :style="{ paddingTop: vuex_custom_bar_height + 'px' }">
    <tn-nav-bar>收货地址</tn-nav-bar>

    <view class="address-list">
      <view class="address-item" v-for="(o, i) in list" :key="i">
        <view class="address-info">
          <view class="address-info-left">
            <view class="address-top">
              <view class="address_content">
                <view class="name">
                  <text>{{ o[vm.name] }}</text>
                </view>
                <view class="phone">
                  <text>{{ o[vm.phone] }}</text>
                </view>
                <view class="tag">
                  <text class="tag_default" :class="{ show: o[vm.default], hide: !o[vm.default] }"
                    >默认</text
                  >
                </view>
              </view>
            </view>
            <view class="address-bottom">
              <text>
                {{ o[vm.address] }}
              </text>
            </view>
          </view>
          <view class="address-info-right">
            <view class="btn_show" @click="more_show(o, i)">
              <uni-icons type="more-filled"></uni-icons>
            </view>
          </view>
        </view>
        <view class="btn-add" v-if="o[vm.display_btn]">
          <view
            width="100%"
            class="default-btn"
            @click="choose_default(o[vm.address_id], o[vm.user_id], i)"
            v-if="$check_action('/address/list', 'set')"
          >
            设为默认
          </view>
          <view
            width="100%"
            class="delete-btn"
            @click="del_address(o, i)"
            v-if="$check_action('/address/list', 'del') && list.length > 1"
          >
            删除
          </view>
          <view
            width="100%"
            class="edit-btn"
            @click="$nav('/pages/user/address_edit?address_id=' + o[vm.address_id])"
            v-if="$check_action('/address/list', 'set')"
          >
            编辑
          </view>
        </view>
      </view>
    </view>
    <view class="add-address">
      <view
        width="100%"
        class="me-btn btn-address"
        @click="$nav('/pages/user/address_edit')"
        v-if="$check_action('/address/list', 'add')"
        >+ 新增收货地址
      </view>
    </view>
  </view>
</template>

<script>
import { getUserAddressListApi, setUserAddressApi, deleteUserAddressApi } from '@/api/address';

export default {
  data() {
    return {
      list: [],
      vm: {
        name: 'name',
        phone: 'phone',
        address: 'address',
        user_id: 'user_id',
        address_id: 'address_id',
        default: 'default',
        display_btn: 'display_btn',
      },
      loading: false, // 是否正在加载状态
      isMore: true, // 是否有更多
      page: 1, // 当前请求的页码
      size: 10, // 每次请求的数据量
    };
  },
  onShow() {
    this.page = 1;
    this.list = [];
    this.loading = false;
    this.isMore = true;
    this.getUserAddressList();
  },
  methods: {
    getUserAddressList() {
      const params = {
        user_id: this.userInfo.user_id,
        page: this.page,
        size: this.size,
      };
      getUserAddressListApi(params).then((res) => {
        if (res.result.list.length > 0) {
          // 数据合并，假设返回的数据结构包含list属性
          this.list.push(...res.result.list);
          this.page++;
        } else {
          // 没有更多数据
          this.isMore = true;
        }
        this.loading = false; // 加载完成，重置加载状态为false
      });
    },
    // 选择默认地址
    async choose_default(address_id, user_id, i) {
      const res = await setUserAddressApi(
        { user_id },
        {
          default: 0,
        }
      );

      if (res.result) {
        this.list.map((o) => (o.default = 0));
        setUserAddressApi(
          { user_id, address_id },
          {
            default: 1,
          }
        ).then((json) => {
          if (json.result) {
            this.$toast('修改默认地址成功!');
            this.list[i].default = 1;
          } else if (json.error) {
            this.$toast(json.error.message);
          }
        });
      } else if (res.error) {
        this.$toast(res.error.message);
      }
    },

    // 删除
    del_address(o, index) {
      if (o.default === 1) {
        this.$toast('默认地址无法删除!');
        return;
      }
      if (this.list.length > 1) {
        deleteUserAddressApi({
          address_id: o.address_id,
        }).then(() => {
          this.list.splice(index, 1);
        });
      }
    },
    // 更多展示
    more_show(o, i) {
      o.display_btn = !o.display_btn;
      this.$set(this.list, i, o);
    },
  },
  onReachBottom() {
    if (this.isMore && !this.loading) {
      this.loading = true; // 开始加载，设置加载状态为true
      const params = {
        user_id: this.userInfo.user_id,
        page: this.page,
        size: this.size,
      };
      getUserAddressListApi(params)
        .then((res) => {
          if (res.result.list.length > 0) {
            // 数据合并，假设返回的数据结构包含list属性
            this.list.push(...res.result.list);
            this.page++;
          } else {
            // 没有更多数据
            this.isMore = false;
          }
          this.loading = false; // 加载完成，重置加载状态为false
        })
        .finally(() => {
          this.loading = false;
        });
    }
  },
};
</script>

<style lang="scss" scoped>
@import 'styles/pages/index.scss';
</style>
