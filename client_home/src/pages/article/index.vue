<template>
  <view id="page_article" :style="{ paddingTop: vuex_custom_bar_height + 'px' }">
    <tn-nav-bar :isBack="false">{{ nav_title ? nav_title : '新闻资讯'}}</tn-nav-bar>
    <view class="page_article">
      <view v-if="$check_action('/article/list', 'get')">
        <!-- 搜索栏 -->
        <!-- <view class="search">
          <uni-search-bar
            placeholder="搜索文章"
            @confirm="search_"
            @cancel="cancel"
            cancelText="取消"
            @input="input($event, 'title')"
          >
            <uni-icons slot="searchIcon" color="#999999" size="18" type="home" />
          </uni-search-bar>
        </view> -->
        <view class="split-line-10"></view>
        <view class="scroll-tabs">
          <scroll-view class="scroll-view" scroll-x="true">
            <view
              :class="['category-item', active == item.value ? 'active' : '']"
              @click="onClickCategory(item.value)"
              v-for="(item, index) in types"
              :key="index"
            >
              {{ item.value }}</view
            >
          </scroll-view>
        </view>
        <view class="split-line-10"></view>
		<Search
		  :value="query.title"
		  placeholder="搜索文章"
		  @input="(val) => inputValue(val, 'title')"
		  @search="search_"
		  @cancel="cancel"
		/>

        <view class="split-line-10"></view>
        <view class="filter-wrapper">
          <scroll-view class="scroll-wrapper" scroll-x="true">
            <view class="scroll-wrapper-item" v-for="(item, index) in filter_list" :key="index">
              <view
                :class="['filter-item', filter_key == item.key ? 'active' : '']"
                @click="filter_item(item)"
              >
                {{ item.name }}
              </view>
            </view>
          </scroll-view>
        </view>
        <!-- <view class="search-options">
          <uni-data-select
            @change="searchType"
            v-model="query.type"
            :localdata="types"
          ></uni-data-select>
        </view> -->
        <!-- 文章列表 -->
        <list_article style="background-color: #fff" :list="list" class="mb"></list_article>
        <!-- /文章列表 -->
        <uni-pagination
          style="padding: 10px"
          title="分页器"
          show-icon="true"
          :total="count"
          :pageSize="query.size"
          :current="query.page"
          @change="page_change"
        ></uni-pagination>
      </view>
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
import tabbar from '@/libs/mixins/tabbar.js';
import list_article from '@/components/diy/list_article.vue';
import bar_orderby from '@/components/diy/bar_orderby.vue';
import mixin from '@/libs/mixins/page.js';
import {getArticleTypeListApi} from '@/api/article';

export default {
  mixins: [mixin, tabbar],
  components: {
    Search,
    list_article,
    bar_orderby,
  },
  data() {
    return {
      active: '全部',
      tabbarIndex: 0,
      url_get_list: '~/api/article/get_list?like=0',
      list: [],
      query: {
        page: 1,
        size: 4,
        title: '',
        orderby: '`create_time` desc',
      },
      filter_key: '1',
      filter_list: [
        {
          key: '1',
          name: '最新',
          value: '`create_time` desc',
        },
        {
          key: '2',
          name: '热度',
          value: '`hits` desc',
        },
        {
          key: '3',
          name: '点赞最高',
          value: '`praise_len` desc',
        },
        // {
        //   key: '4',
        //   name: '收藏最多',
        //   value: '`collect` desc',
        // },
      ],
      list_orderby: [
        {
          name: '点击量',
          direction: '',
          command_asc: '`hits` asc',
          command_desc: '`hits` desc',
        },
        {
          name: '日期',
          direction: '',
          command_asc: '`create_time` asc',
          command_desc: '`create_time` desc',
        },
      ],
      // 分类
      types: [
        {
          value: '全部',
          text: '全部',
        },
      ],
      nav_title:null
    };
  },
  methods: {
    onClickCategory(val) {
      this.active = val;
      this.searchType(val);
    },
    /**
     * 添加文章过滤
     */
    get_article_type() {
      getArticleTypeListApi({
        page: 1,
      }).then((res) => {
        if (res.result) {
          let list = res.result.list;
          list.map((obj) => {
            this.types.push({
              value: obj.name,
              text: obj.name,
            });
          });
        }
      });
    },

    /**
     * 下拉商品筛选选择
     */
    filter_item(item) {
      this.filter_key = item.key;
      this.query.orderby = item.value;
      this.search_();
    },
    inputValue(val, key) {
      this.query[key] = val;
    },
    search_() {
      this.query.page = 1;
      this.get_list();
    },
    searchType(v) {
      if (v == '全部') {
        this.query.type = '';
      } else {
        this.query.type = v;
      }

      this.query.page = 1;
      this.get_list();
    },
    cancel() {
      this.query.title = '';
      this.search_();
    },
    // 控制排序
    handleOrderby(o) {
      // console.log(o);
      // 取出对应的orderby

      // 重置其他排序的direction
      this.list_orderby.map((val) => {
        if (val.name !== o.text) {
          return (val.direction = '');
        }
      });

      // 找到对应的排序项，发送排序请求
      var obj_orderby = this.list_orderby.find((val) => val.name === o.text);
      if (o.direction === '') {
        this.query.orderby = '';
        this.search_();
      } else if (o.direction === 'up') {
        this.query.orderby = obj_orderby.command_desc;
        this.search_();
      } else if (o.direction === 'down') {
        this.query.orderby = obj_orderby.command_asc;
        this.search_();
      }
    },
  },
  mounted() {
    this.get_article_type();
    for (let i = 0;i<this.tabbarList.length;i++){
      if (this.tabbarList[i].pagePath === "/pages/article/index") {
        this.tabbarIndex = i;
      }
    }
    let pages = getCurrentPages()
    let page = pages[pages.length - 1]
    this.nav_title = page.$holder.navigationBarTitleText
  }
};
</script>
<style lang="scss" scoped>
@import 'styles/pages/index.scss';
</style>
