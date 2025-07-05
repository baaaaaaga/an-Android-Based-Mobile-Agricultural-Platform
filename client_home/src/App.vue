<script>
export default {
  onLaunch: function () {
    console.log('App Launch');
    // this.$u.vuex('tabbarIndex', 0);
    // #ifndef APP-PLUS
    // uni.hideTabBar();
    // #endif
  },
  onShow: function () {
    console.log('App Show');
  },
  onHide: function () {
    console.log('App Hide');
  },
};
</script>

<style lang="scss">
@import './styles/index.scss';
@import './styles/ui/index.scss';
@import './styles/ui/iconfont.css';
@import './static/css/iconfont.css';
@import './static/iconfont/iconfont.css';
</style>
