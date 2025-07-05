import { mapState } from 'vuex';
export default {
  data() {
    return {
      // 底部tabbar菜单数据
      tabbarList: [
        {
          title: '首页',
          activeIcon: 'home',
          inactiveIcon: 'home',
          pagePath: '/pages/index/index',
        },
        {
          title: '购物车',
          activeIcon: 'basket',
          inactiveIcon: 'basket',
          pagePath: '/pages/cart/index',
        },
        {
          title: '交流论坛',
          activeIcon: 'moments',
          inactiveIcon: 'moments',
          pagePath: '/pages/forum/index',
        },
        {
          title: '农业知识',
          activeIcon: 'level',
          inactiveIcon: 'level',
          pagePath: '/pages/article/index',
        },
        {
          title: '我的',
          activeIcon: 'my',
          inactiveIcon: 'my',
          pagePath: '/pages/user/index',
        },
      ],
    };
  },
  methods: {
    // 切换导航
    switchTabbar(index) {
      const menu = this.tabbarList[index];
      if (menu.pagePath !== this.$Router.currentRoute.path) {
        this.$Router.pushTab(menu.pagePath);
      }
      setTimeout(() => {
        this._switchTabbarPage(index);
      }, 0);
    },

    // 导航页面滚动到底部
    tabbarPageScrollLower(e) {},

    // 切换导航页面
    _switchTabbarPage(index) {},
  },

  onLoad(options) {
    uni.hideTabBar();
  },

  onShow() {},

  onHide() {},
};
