<template>
  <view id="page_user" class="page_user" :style="{ paddingTop: vuex_custom_bar_height + 'px' }">
    <tn-nav-bar :isBack="false" :bottomShadow="false">个人中心</tn-nav-bar>
    <!-- 用户栏模块(开始) -->
    <view class="user">
      <!-- 头像 -->
      <view class="left">
        <view class="avatar">
          <image :src="$fullImgUrl(userInfo.avatar) || '/static/img/default.png'"></image>
        </view>
        <view class="base-info" v-if="token">
          <view class="username">{{ userInfo.nickname }}</view>
          <view class="signature">{{ userInfo.user_group }}</view>
        </view>
        <view class="base-info" v-else @click="toLogin">
          <view class="username">游客</view>
        </view>
      </view>
      <!-- 右侧其它 -->
      <view class="other">
        <view class="user-info-btn" @click="$navTo('/pages/user/info')">
          <text class="iconfont icon-jinggao"></text>
          基本信息
        </view>
      </view>
    </view>
    <!-- 用户栏模块(结束) -->
      <view class="menu-group my-money">
      <view class="title-wrap">
        <text class="title">我的资产</text>
      </view>
      <view class="menu-scroll">
        <scroll-view class="scroll-view" scroll-x="true">
		          <view class="menu-item coupon" @click="$navTo('/pages/user/coupon')">
            <view class="left">
              <image class="menu-img" :src="'/static/img/default.png'"></image>
            </view>
            <view class="right">
              <view class="name">优惠券</view>
              <view class="info"><text>{{ couponNumber }}</text>张未使用</view>
            </view>
          </view>
						        </scroll-view>
      </view>
    </view>
      <view class="split"></view>
    <view class="menu-group my-order">
      <view class="title-wrap">
        <view class="title">我的订单</view>
        <view class="more" @click="$navTo('/pagesA/order/list')">
          查看全部
          <text class="iconfont icon-right"></text>
        </view>
      </view>

      <view class="menu-row">
        <view class="menu-item" @click="$navTo('/pagesA/order/list?type=1')">
          <image class="menu-img" :src="'/static/img/default.png'"></image>
          <view class="name">待付款</view>
        </view>
        <view class="menu-item" @click="$navTo('/pagesA/order/list?type=2')">
          <image class="menu-img" :src="'/static/img/default.png'"></image>
          <view class="name">已付款</view>
        </view>
        <view class="menu-item" @click="$navTo('/pagesA/order/list?type=3')">
          <image class="menu-img" :src="'/static/img/default.png'"></image>
          <view class="name">已取消</view>
        </view>
        </view>
    </view>
    <view class="split"></view>
    <view class="menu-group my-data">
      <view class="menu-row-sm">
          <view class="menu-item address" @click="$navTo('/pages/user/address')">
          <image class="menu-img" :src="'/static/img/default.png'"></image>
          <view class="name">收货地址</view>
        </view>
          <view class="menu-item collect" @click="$navTo('/pages/user/collect')">
          <image class="menu-img" :src="'/static/img/default.png'"></image>
          <view class="name">收藏</view>
        </view>
        <view v-if="$check_action('/comment/table', 'get')" class="menu-item comment" @click="$navTo('/pages/user/comment')">
          <image class="menu-img" :src="'/static/img/default.png'"></image>
          <view class="name">评论</view>
        </view>
        <view class="menu-item data" v-if="chartAble" @click="$navTo('/pagesA/user_center/index')">
          <image class="menu-img" :src="'/static/img/default.png'"></image>
          <view class="name">统计</view>
        </view>
      </view>
    </view>

    <view class="split"></view>
    <!-- 自定义栏模块(开始) -->
    <view class="nav-list">
      <view v-for="(item, index) in cellList" :key="index" v-if="$check_action(item.auth, 'get')">
        <tn-list-cell
            @click="$navTo(item.url)"
            :arrow="true"
        >
          <view class="nav-list-row">
            <image class="menu-img" :src="'/static/img/default.png'"></image>
            <text>{{ item.title }}</text>
          </view>
        </tn-list-cell>
      </view>
    </view>

    <!-- 自定义栏模块(结束) -->

    <!-- 按钮模块(开始) -->
    <view class="user-center-footer">
      <view class="me-btn logout-btn" v-if="token" @click="sign_out">退出登录</view>
      <view v-else class="me-btn login-btn" @click="toLogin">立即登录</view>
    </view>
    <!-- 按钮模块(结束) -->
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
  import tabbar from '@/libs/mixins/tabbar.js';

  export default {
    mixins: [tabbar],
    data() {
      return {
        tabbarIndex: 0,
        chartAble: false,
        cellList: [
            {
            title: '农户商家',
            auth: '/farmers_merchants/table',
            url: '/pagesC/farmers_merchants/table',
            icon: 'icon-yonghu',
          },
              {
            title: '消费者',
            auth: '/consumer/table',
            url: '/pagesC/consumer/table',
            icon: 'icon-yonghu',
          },
                {
            title: '产地展示',
            auth: '/origin_display/table',
            url: '/pagesC/origin_display/table',
            icon: 'icon-yonghu',
          },
              {
            title: '产地类型',
            auth: '/type_of_place_of_origin/table',
            url: '/pagesC/type_of_place_of_origin/table',
            icon: 'icon-yonghu',
          },
              {
            title: '互动咨询',
            auth: '/interactive_consultation/table',
            url: '/pagesC/interactive_consultation/table',
            icon: 'icon-yonghu',
          },
              {
            title: '咨询回复',
            auth: '/consultation_reply/table',
            url: '/pagesC/consultation_reply/table',
            icon: 'icon-yonghu',
          },
              {
            title: '生产计划',
            auth: '/production_planning/table',
            url: '/pagesC/production_planning/table',
            icon: 'icon-yonghu',
          },
              {
            title: '经验分享',
            auth: '/experience_sharing/table',
            url: '/pagesC/experience_sharing/table',
            icon: 'icon-yonghu',
          },
              {
            title: '分享类型',
            auth: '/share_type/table',
            url: '/pagesC/share_type/table',
            icon: 'icon-yonghu',
          },
            {
            title: this.$page_title("/message/table") || '留言板管理',
            auth: '/message/table',
            url: '/pagesB/message/table',
            icon: 'icon-liuyanban',
          },
          {
            title: this.$page_title("/forum/table") || '论坛管理',
            auth: '/forum/table',
            url: '/pagesA/forum/table',
            icon: 'icon-luntan',
          },
            {
            title: '订单配送',
            auth: '/logistics_delivery/table',
            url: '/pages/logistics_delivery/table',
            icon: 'icon-dingdanguanli',
          },
          ],
        couponNumber: 0,
      };
    },
    onLoad() {
                          if (this.$check_figure("/order/table")){
        this.chartAble = true
      }
      if (this.token) {
        this.get_coupon_user_list();
      }
    },
    methods: {
      sign_out() {
        this.$store.dispatch('auth/logOut').then((res) => {
        this.$Router.replaceAll('/pagesB/account/login');
        });
      },
      toLogin() {
        this.$Router.replace('/pagesB/account/login');
      },
      /**
       *  当前用户未使用的优惠券
       */
      async get_coupon_user_list() {
        const result = await this.$get('~/api/coupon_user/get_list', {
          user_id: this.userInfo.user_id,
		  is_use: 0
        });
        this.couponNumber = result.result.count;
      },
    },
    mounted() {
      for (let i = 0;i<this.tabbarList.length;i++){
        if (this.tabbarList[i].pagePath === "/pages/user/index") {
          this.tabbarIndex = i;
        }
      }
    }
  };
</script>

<style lang="scss" scoped>
  @import 'styles/pages/index.scss';
</style>
