<template>
  <view id="home" class="page_home" :style="{ paddingTop: vuex_custom_bar_height + 'px' }">
	<view class="header_bg"></view>
    <tn-nav-bar fixed :isBack="false">
      <view class="nav-wrapper">
        <view class="nav-user" @click="$navTo('/pages/user/info')">
          <image :src="$fullImgUrl(userInfo.avatar) || '/static/img/default.png'"></image>
        </view>
        <view class="tabs">
          <view :class="['tab-item', tabIndex === 0 ? 'active' : '']" @click="onClickTab(0)">
            <view class="name">推荐</view>
            <view class="active-flag" v-if="tabIndex === 0"> </view>
          </view>
                  <view :class="['tab-item', tabIndex === 4 ? 'active' : '']" @click="onClickTab(4)" v-if="$check_action('/origin_display/list', 'get')">
            <view class="name">产地展示</view>
            <view class="active-flag" v-if="tabIndex === 4"> </view>
          </view>
                      </view>
      </view>
    </tn-nav-bar>

    <view class="tab-pane" v-show="tabIndex === 0">
      <view class="search-wrapper" @click.stop="$navTo('/pages/search/index')">
        <Search disabled placeholder="搜索内容" @cancel="cancel" />
      </view>

      <view class="scroll-x">
        <view class="left">
          <scroll-view class="scroll-view" :style="[!isExpand ? expandStyle : '']" scroll-x="true">
		    <view class="item">
		      推荐
		    </view>
            <view
              class="item"
              @click="clickMore(item.path)"
              v-for="(item, index) in list_menu"
              :key="index"
			   v-if="$check_action(item.path,'get') || item.path == '/webview/urlview' || item.path == '/chat/index'"
            >
              {{ item.mod_name }}
            </view>
          </scroll-view>
        </view>
        <view class="right">
          <view class="iconfont icon-liebiao" @click="isExpand = !isExpand"></view
        ></view>
      </view>

      <!-- 轮播图模块(开始) -->
      <view class="swiper">
        <Slide :list="list_slide" :show_title="true" />
      </view>
      <!-- 轮播图模块(结束) -->

      <!-- 菜单模块(开始) -->
      <view class="menu" v-if="list_menu.length > 0">
        <list_menu :list="list_menu"></list_menu>
      </view>
      <!-- 菜单模块(结束) -->

      <!-- 农业知识模块(开始) -->
      <Card
        v-if="$check_action('/article/list', 'get')"
        title="农业知识"
        url="/pages/article/index"
	    toTab
        :list="list_article"
        class="article_list"
      >
        <view class="scroll-category">
          <scroll-view class="scroll-view" scroll-x="true">
            <view
              :class="['category-item', activeArticle == item.value ? 'active' : '']"
              @click="onClickCategory(item.value)"
              v-for="(item, index) in types_article"
              :key="index"
            >
              {{ item.value }}</view
            >
          </scroll-view>
        </view>
        <list_article :list="list_article"></list_article>
      </Card>
      <view class="split-line"></view>
      <!-- 农业知识模块(结束) -->
      <!-- 商品模块(开始) -->
      <Card
        v-if="$check_action('/goods/list', 'get')"
        class="goods_list"
        title=" 农产品 "
        url="/pagesA/goods/list"
        :list="list_goods"
      >
        <view class="scroll-category">
          <scroll-view class="scroll-view" scroll-x="true">
            <view
              :class="['category-item', activeGoods == item.value ? 'active' : '']"
              @click="onClickGoods(item.value)"
              v-for="(item, index) in types_goods"
              :key="index"
            >
              {{ item.value }}</view
            >
          </scroll-view>
        </view>

        <list_goods :list="list_goods"></list_goods>
      </Card>
      <view class="split-line"></view>
      <!-- 商品模块(结束) -->
	  <view class="home_recommend">
        		<Card
		  v-if="$check_action('/origin_display/list', 'get')"
		  class="list_diy"
		  title="产地展示"
		  url="/pagesC/origin_display/list"
		  :list="list_origin_display"
		>
		  <list_origin_display :list="list_origin_display"></list_origin_display>
		</Card>
              	  </view>


      <!-- 版权模块(开始) -->
      <view class="copyright">
        <text>https://github.com/baaaaaaga/an-Android-Based-Mobile-Agricultural-Platform</text>
      </view>
      <!-- 版权模块(结束) -->
    </view>

            <view class="tab-pane" v-show="tabIndex === 4">
      <view class="split-line"></view>
      <view
        v-if="$check_action('/origin_display/list', 'get')"
        class="list_diy"
        url="/pagesC/origin_display/list"
      >
        <list_origin_display :list="list_origin_display"></list_origin_display>
      </view>
      <view class="see-more">
        <view @click="$navTo('/pagesC/origin_display/list')">
          查看更多<text class="iconfont icon-right"></text>
        </view>
      </view>

      <view class="split-line"></view>
    </view>
              


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
import Search from '@/components/businessCp/search.vue';
        import list_origin_display from "@/components/diy/list_origin_display.vue";
              import Card from '@/components/common/card.vue';
import list_menu from '@/components/diy/list_menu.vue';
import list_goods from '@/components/diy/list_goods.vue';
import list_article from '@/components/diy/list_article.vue';
import Slide from '@/components/common/slide.vue';

import mixin from '@/libs/mixins/page.js';
import tabbar from '@/libs/mixins/tabbar.js';
import * as HomeApi from '@/api/home';

export default {
  mixins: [mixin, tabbar],
  components: {
    Search,
    Card,
            list_origin_display,
                  list_menu,
    list_goods,
    list_article,
    Slide,
  },
  data() {
    return {
      tabIndex: 0,
      isExpand: false,
      expandStyle: {
        whiteSpace: 'nowrap',
      },
      tabbarIndex: 0,
              list_origin_display: [],
                    list_goods: [],
      list_slide: [],
      list_article: [],
      list_menu: [],
      activeGoods: '全部',
      types_goods: [],
      activeArticle: '全部',
      types_article: [],
    };
  },
  created() {
  },
  methods: {
    onClickGoods(val) {
      this.activeGoods = val;
      this.get_goods();
    },
    /**
     *  获取商品
     */
    get_goods() {
      let params = {
        page: 1,
        size: 12,
      };
      if (this.activeGoods && this.activeGoods != '全部') {
        params['type'] = this.activeGoods;
      }
                  if (this.userInfo.user_group != '管理员' && this.activeGoods == '全部') {
        params.user_id = this.userInfo.user_id;
      }
                                      HomeApi.getHomeGoodsListApi(params).then((res) => {
        if (res.result && res.result.list) {
          this.list_goods = res.result.list;
        }
      });
    },
    /**
     * 添加商品过滤
     */
    get_goods_type() {
      this.$get('/goods_type/get_list', {}, (res) => {
        if (res.result && res.result.list) {
          let list = res.result.list.map((obj) => {
            return { value: obj.name, text: obj.name };
          });
          let arr = [
            {
              value: '全部',
              text: '全部',
            },
          ];
          this.types_goods = arr.concat(list);
        }
      });
    },
    onClickCategory(val) {
      this.activeArticle = val;
      this.get_article();
    },
    /**
     *  获取文章
     */
    get_article() {
      let params = {
        page: 1,
        size: 6,
      };
      if (this.activeArticle && this.activeArticle != '全部') {
        params['type'] = this.activeArticle;
      }
      HomeApi.getHomeArticleListApi(params).then((res) => {
        if (res.result && res.result.list) {
          this.list_article = res.result.list;
        }
      });
    },
    /**
     * 添加文章过滤
     */
    get_article_type() {
      this.$get(
        '~/api/article_type/get_list',
        {
          page: 1,
        },
        (res) => {
          if (res.result && res.result.list) {
            let list = res.result.list.map((obj) => {
              return { value: obj.name, text: obj.name };
            });
            let arr = [
              {
                value: '全部',
                text: '全部',
              },
            ];
            this.types_article = arr.concat(list);
          }
        }
      );
    },
    getFullPath(path) {
      if (path) {
        const fullPath = this.pathList[path];
        if (fullPath) {
          return fullPath + path;
        } else {
          return '/pagesC' + path;
        }
      }
      return '';
    },
    onClickTab(val) {
      this.tabIndex = val;
    },
                    /**
     *  获取产地展示
     */
    get_origin_display() {
      const params = {
            user_id: this.userInfo.user_id,
		size: 12,
          };
          if(this.userInfo.user_group=="管理员"){
        delete param.user_id;
      }
          HomeApi.get_origin_display_api(params).then((res) => {
        if (res.result && res.result.list) {
          this.list_origin_display = res.result.list;
        }
      });
    },
                          
    /**
     *  获取轮播图
     */
    get_slides() {
      HomeApi.gethomeSlidesListApi().then((res) => {
        if (res.result && res.result.list) {
          this.list_slide = res.result.list;
        }
      });
    },

    /**
     *  获取导航栏
     */
    get_menu() {
      const user_group = this.userGroup;
      HomeApi.getMenuListApi({
        size: '0',
        get: 1,
        user_group,
        position: 'top',
      }).then((res) => {
        if (res.result && res.result.list) {
          this.list_menu = res.result.list;
        }
          this.list_menu.push({mod_name:"农产品",path:"/goods/list"})
          this.list_menu.unshift({ mod_name: "留言投诉", path: "/message/list" });
		this.list_menu.push({mod_name:"农业知识",path:"/article/index"})
		this.list_menu.push({mod_name:"交流论坛",path:"/forum/index"})
      });
    },

	clickMore(url){
		if(url == "/article/index" || url == "/forum/index"){
			this.$navToTab(this.getFullPath(url))
		}else{
			this.$navTo(this.getFullPath(url))
		}
	}
  },
  onShow() {
    this.get_slides();
    this.get_menu();
            this.get_origin_display();
                  this.get_article_type();
    this.get_article();
    this.get_goods_type();
    this.get_goods();
  },
};
</script>
<style lang="scss" scoped>
@import 'styles/pages/index.scss';
</style>
