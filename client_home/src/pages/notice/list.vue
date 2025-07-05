<template>
  <view class="page_notice_list" :style="{ paddingTop: vuex_custom_bar_height + 'px' }">
    <tn-nav-bar>网站公告列表</tn-nav-bar>
    <view class="page_notice" id="notice_list">
      <!-- 公告细节模块(开始) -->

      <!-- 搜索栏 -->
      <!-- <uni-search-bar
        placeholder="搜索标题"
        @confirm="search_"
        @cancel="cancel"
        cancelText="取消"
        @input="input($event, 'title')"
      >
        <uni-icons slot="searchIcon" color="#999999" size="18" type="home" />
      </uni-search-bar> -->
      <view class="search-wrapper">
        <Search
          v-model="query.title"
          placeholder="搜索产品"
          @input="(val) => inputValue(val, 'title')"
          @search="search_"
          @cancel="cancel"
        />
      </view>

      <!-- /搜索栏 -->
      <uni-list>
        <uni-list-item
          v-for="(o, i) in list"
          :title="o.title"
          :key="i"
          :to="'./details?notice_id=' + o.notice_id"
          :rightText="$toTime(o.create_time, 'yyyy-MM-dd hh:mm:ss')"
        >
        </uni-list-item>
      </uni-list>

      <uni-pagination
        style="padding: 10px"
        title="分页器"
        show-icon="true"
        :total="count"
        :pageSize="query.size"
        :current="query.page"
        @change="page_change"
      ></uni-pagination>

      <!-- 公告细节模块(结束) -->
    </view>
  </view>
</template>

<script>
import Search from '@/components/businessCp/search.vue';
import mixin from '@/libs/mixins/page.js';
export default {
  components: {
    Search,
  },
  mixins: [mixin],
  data() {
    return {
      url_get_list: '~/api/notice/get_list?like=0',
      list: [],
      query: {
        title: '',
        page: 1,
        size: 10,
      },
      count: 50,
    };
  },
  methods: {
    page_change(e) {
      console.log(e);
    },
    search_() {
      this.query.page = 1;
      this.get_list();
    },
    cancel() {
      this.title = '';
      this.search_();
    },
    inputValue(val, key) {
      this.query[key] = val;
    },
  },
};
</script>
<style lang="scss" scoped>
@import 'styles/pages/index.scss';
</style>
