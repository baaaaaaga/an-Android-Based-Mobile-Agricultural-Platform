<template>
  <view class="page_search" :style="{ paddingTop: vuex_custom_bar_height + 'px' }">
    <tn-nav-bar>搜索结果</tn-nav-bar>
    <view class="search-wrapper">
      <Search
        v-model="keyword"
        placeholder="搜索"
        @cancel="cancel"
        @search="debounceSearch"
        @input="debounceSearch"
      />
    </view>

    <view class="search-list" v-if="searchList.length > 0">
      <view class="search-item-wrapper" v-for="(item, index) in searchList" :key="index">
        <view class="search-item-common" @click="navHandle(item)">
          <view class="title text-ellipsis-2">{{ item.title }} </view>
          <view class="content">
            <view class="content-left" v-if="item.img">
              <image :src="$fullImgUrl(item.img) || '/static/img/default.png'" mode="scaleToFill" />
            </view>
            <view class="content-right">
              <view class="details text-ellipsis-2"> {{ item.description }}</view>
              <view class="datetime"> {{ item.create_time }}</view>
            </view>
          </view>
        </view>
      </view>
    </view>
    <view class="search-list-empty" v-else> </view>
  </view>
</template>

<script>
import Search from '@/components/businessCp/search.vue';
import * as HomeApi from '@/api/home';
import { debounce } from '@/utils';
export default {
  components: {
    Search,
  },
  data() {
    return {
      keyword: '',
      searchList: [],
    };
  },
  mounted() {},
  methods: {
    //防抖模式
    debounceSearch: debounce(
      function () {
        this.search();
      },
      500,
      true
    ),
    search() {
      let params = {
        like: 0,
        page: 1,
        size: 10,
      };
      if (this.keyword) {
        params['title'] = this.keyword;
      }
      Promise.all([
        HomeApi.getHomeGoodsSearchListApi(params),
        HomeApi.getHomeArticleListApi(params),
        HomeApi.getHomeForumListApi(params),
      ]).then((res) => {
        let list = [];
		if(res[0]){
			res[0].result.list.forEach((item) => {
			  list.push({
			    search_type: 'goods',
			    ...item,
			  });
			});
		}
		if(res[1]){
			res[1].result.list.forEach((item) => {
			  list.push({
			    search_type: 'article',
			    ...item,
			  });
			});
		}
        if(res[2]){
			res[2].result.list.forEach((item) => {
			  list.push({
			    search_type: 'forum',
			    ...item,
			  });
			});
		}
        this.searchList = list;
      });
    },
    cancel() {
      this.searchList = [];
    },
    navHandle(o) {
      if (o.search_type == 'article') {
        this.$navTo('/pages/article/details?article_id' + '=' + o.article_id);
      }
      if (o.search_type == 'forum') {
        this.$navTo('/pagesA/forum/details?forum_id' + '=' + o.forum_id);
      }
      if (o.search_type == 'goods') {
        this.$navTo('/pagesA/goods/details?goods_id' + '=' + o.goods_id);
      }
    },
  },
};
</script>

<style lang="scss" scoped>
  @import 'styles/pages/index.scss';
</style>
