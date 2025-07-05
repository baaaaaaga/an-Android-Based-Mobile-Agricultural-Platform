<template>
  <view
    class="page_cart"
    id="page_cart"
    :style="{ paddingTop: vuex_custom_bar_height + 'px' }"
  >
    <tn-nav-bar :isBack="false">购物车</tn-nav-bar>
    <!-- 购物车模块(开始) -->
    <list_cart :list="list"></list_cart>
    <!-- 购物车模块(结束) -->
    <tn-tabbar
      :value="tabbarIndex"
      :list="tabbarList"
      @change="switchTabbar"
      :animation="true"
      :safeAreaInsetBottom="true"
    ></tn-tabbar>
  </view>
</template>

<script>
import list_cart from '@/components/diy/list_cart.vue';
import mixin from '@/libs/mixins/page.js';
import tabbar from '@/libs/mixins/tabbar.js';
export default {
  mixins: [mixin, tabbar],
  components: {
    list_cart,
  },
  data() {
    return {
      tabbarIndex: 0,
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
  mounted() {
    for (let i = 0;i<this.tabbarList.length;i++){
      if (this.tabbarList[i].pagePath === "/pages/cart/index") {
        this.tabbarIndex = i;
      }
    }
  },
};
</script>

<style lang="scss" scoped>
@import 'styles/pages/index.scss';
</style>
