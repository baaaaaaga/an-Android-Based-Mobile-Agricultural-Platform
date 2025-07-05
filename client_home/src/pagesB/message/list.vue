<template>
  <view id="message_list" class="message_list" :style="{ paddingTop: vuex_custom_bar_height + 'px' }">
    <tn-nav-bar>在线留言列表</tn-nav-bar>
    <view class="message_wrapper">
      <!-- 留言列表模块(开始) -->
      <!-- <me-search @search="searchData"></me-search> -->
	  <Search v-model="query.title" placeholder="搜索留言" @search="search_" @cancel="cancel" />
      <!-- <uni-search-bar
        placeholder="搜索标题"
        @confirm="search"
        @cancel="cancel"
        cancelText="取消"
        @input="input($event, 'title')"
      >
        <uni-icons slot="searchIcon" color="#999999" size="18" type="home" />
      </uni-search-bar> -->

      <view
        class="me-btn btn-release"
        v-if="userGroup == '管理员' || $check_action('/message/edit', 'add')"
        @click="$navTo('/pagesB/message/edit')"
      >
        <text>发布内容</text>
      </view>
      <view class="list-warp" id="list-warp" style="height: 82vh;">
        <mescroll-uni
          :height="height"
          @init="mescrollInit"
          :fixed="false"
          @down="downCallback"
          :up="upOption"
          @up="upCallback"
          @emptyclick="emptyClick"
        >
          <view class="list-message">
            <view class="item-message" v-for="(o, i) in list" :key="i">
              <view class="message-box">
                <view class="title">
                  <view>{{ o.title }}</view>
                </view>
                <view class="user-info">
                  <view>{{ o.nickname }}</view>
                  <view class="time">{{ $toTime(o.create_time, 'yyyy-MM-dd hh:mm:ss') }}</view>
                </view>
                <view class="content">
                  <rich-text :nodes="o.content"></rich-text>
                </view>
              </view>

              <view class="list-reply-block" v-if="list[i].reply_state">
                <view>回复</view>
                <view class="list-reply-box" v-if="list[i].reply">
                  <rich-text class="content" :nodes="list[i].reply"></rich-text>
                </view>
              </view>
              <view class="line"></view>
            </view>
          </view>
        </mescroll-uni>
      </view>

      <!-- 留言列表模块(结束) -->
    </view>
  </view>
</template>

<script>
	import Search from '@/components/businessCp/search.vue';
import MescrollMixin from '@/uni_modules/mescroll-uni/components/mescroll-uni/mescroll-mixins.js';
// import mixin from '@/libs/mixins/page.js';

import { getMessageListApi } from '@/api/message';
export default {
  mixins: [MescrollMixin],
  components: {
    Search
  },
  data() {
    return {
      height: 0,
      query: {
        page: 1,
        size: 10,
		title: "",
        orderby: 'create_time asc',
      },
      upOption: {
        auto: false,
        // page: {
        // 	size: 10 // 每页数据的数量
        // },
        noMoreSize: 4, //如果列表已无数据,可设置列表的总数量要大于半页才显示无更多数据;避免列表数据过少(比如只有一条数据),显示无更多数据会不好看; 默认5
        textNoMore: '已经到底了', // 没有更多数据的提示文本
        empty: {
          tip: '暂无数据',
        },
      },
      list: [], //列表数据
    };
  },
  onShow() {
    // this.mescroll.resetDownScroll();

    // #ifdef MP
    this.getViewHeight();
    // #endif
  },
  methods: {
    getViewHeight() {
      const query = uni.createSelectorQuery().in(this);
      query
        .select('#list-warp')
        .boundingClientRect((data) => {
          console.log(data);
          if (data) {
            this.height = data.height * 2 - 130;
          }
        })
        .exec();
    },
    searchData(v) {
      if (!v) {
        delete this.query.title;
      } else {
        this.query.title = v;
      }
      // this.downCallback();
      this.mescroll.resetUpScroll();
    },
    /*下拉刷新的回调 */
    downCallback() {
      getMessageListApi(this.query)
        .then((res) => {
          //联网成功的回调,隐藏下拉刷新的状态
          this.mescroll.endSuccess();
          //设置列表数据
          this.list = res.result.list;
        })
        .catch(() => {
          //联网失败的回调,隐藏下拉刷新的状态
          this.mescroll.endErr();
        });
    },
    /*上拉加载的回调: 其中page.num:当前页 从1开始, page.size:每页数据条数,默认10 */
    upCallback(page) {
      this.query.page = page.num;

      getMessageListApi(this.query)
        .then((res) => {
          //联网成功的回调,隐藏下拉刷新和上拉加载的状态;
          this.mescroll.endSuccess(res.result.list.length);
          //设置列表数据
          if (page.num == 1) this.list = []; //如果是第一页需手动制空列表
          this.list = this.list.concat(res.result.list); //追加新数据
        })
        .catch(() => {
          //联网失败, 结束加载
          this.mescroll.endErr();
        });
    },
    //点击空布局按钮的回调
    emptyClick() {
      uni.showToast({
        title: '点击了按钮,具体逻辑自行实现',
      });
    },
    getMessageList() {
      getMessageListApi().then((res) => {});
    },
    get_list_before(param) {
      // let user_group = this.user.user_group;
      // if (!user_group || user_group === "游客"){
      //   this.url_get_list = "~/api/message/get_list?user_id=0";
      // }
      // if(user_group !== "管理员"){
      //   param.user_id = this.userInfo.user_id;
      // }
      return param;
    },
    get_list_after(json) {
      // let list = json.result.list
      // this.list = list.map((o) => {
      // 	o.list_reply = [];
      // 	return o
      // });
    },
	search_() {
	  this.query.page = 1;
	  this.get_list();
	},
	cancel() {
	  console.log('eer');
	  this.query.title = '';
	  this.search_();
	},
  },
};
</script>
<style lang="scss" scoped>
@import 'styles/pagesB/index.scss';
</style>
