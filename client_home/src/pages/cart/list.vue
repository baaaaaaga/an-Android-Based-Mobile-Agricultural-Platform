<template>
  <view id="page_cart" class="page_cart_list" :style="{ paddingTop: vuex_custom_bar_height + 'px' }">
    <tn-nav-bar>购物车列表</tn-nav-bar>
    <!-- 购物车模块(开始) -->
    <list_cart :list="list"></list_cart>
    <!-- 购物车模块(结束) -->
  </view>
</template>

<script>
import list_cart from '@/components/diy/list_cart.vue';
import mixin from '@/libs/mixins/page.js';

export default {
  mixins: [mixin],
  components: {
    list_cart,
  },
  data() {
    return {
      // 登录权限
      oauth: {
        signIn: true,
        user_group: [],
      },
      url_get_list: '~/api/cart/get_list?',
      query: {
        user_id: 0,
      },
    };
  },
  methods: {
    get_list_before(param) {
      param.user_id = this.userInfo.user_id;
      return param;
    },
    get_list_after(json) {
      return json.result.list.map((o) => {
        o.selected = false;
      });
    },
  },
  onShow() {},
};
</script>

<style lang="scss" scoped>
@import 'styles/pages/index.scss';
</style>
