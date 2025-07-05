<template>
  <view id="page_forum" :style="{ paddingTop: vuex_custom_bar_height + 'px' }">
    <tn-nav-bar :isBack="false">交流论坛</tn-nav-bar>
    <view class="page_forum">
      <view class="split-line-10"></view>
      <view class="scroll-tabs">
        <scroll-view class="scroll-view" scroll-x="true">
          <view
            :class="['category-item', active == item.value ? 'active' : '']"
            @click="onClickCategory(item.value)"
            v-for="(item, index) in list_forum_type"
            :key="index"
          >
            {{ item.value }}
          </view>
        </scroll-view>
      </view>
      <view class="split-line-10"></view>

      <Search
        :value="query.title"
        placeholder="搜索内容"
        @input="(val) => inputValue(val, 'title')"
        @search="search_"
        @cancel="cancel"
      />
	  <view class="me-btn button" v-if="user_group == '管理员' || $check_action('/forum/list', 'add')" @click="$navTo('/pagesA/forum/add')">
	    <text>发布内容</text>
	  </view>
      <view class="split-line-10"></view>

      <view class="forum-hot">
        <view class="forum-hot-title">热门帖子</view>

        <scroll-view class="scroll-wrapper" scroll-x="true">
          <view class="scroll-wrapper-item" v-for="(item, index) in list_hot" :key="index">
            <view
              class="forum-hot-item"
              @click="$navTo('/pagesA/forum/details?forum_id=' + item.forum_id)"
            >
              <view class="category">
                <view class="tag">
                  {{ item.type }}
                </view>
              </view>
              <view class="details text-ellipsis-2">
                {{ item.title }}
              </view>
              <view class="hits"> 浏览量：{{ item.hits }} </view>
            </view>
          </view>
        </scroll-view>
      </view>

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

      <!-- <view class="search">
        <uni-search-bar
          placeholder="搜索帖子"
          @confirm="search_"
          @cancel="cancel"
          cancelText="取消"
          @input="input($event, 'title')"
        >
          <uni-icons slot="searchIcon" color="#999999" size="18" type="home" />
        </uni-search-bar>
      </view>

      <view class="search-bar">
        <view class="options">
          <uni-data-select @change="searchType" v-model="query.type" :localdata="list_forum_type">
          </uni-data-select>
        </view>
        <view
          class="nav-btn"
          v-if="user_group == '管理员' || $check_action('/forum/list', 'add')"
          @click="$navTo('/pagesA/forum/view')"
        >
          <button class="me-btn">发布内容</button>
        </view>
      </view> -->

      <!-- 论坛列表模块(开始) -->

      <template v-if="$check_action('/forum/list', 'get')">
        <!-- 论坛列表 -->
        <list_forum style="background-color: #fff" :list="list" class="mb"></list_forum>

        <!-- /论坛列表 -->
      </template>
      <!-- 分页器 -->
      <uni-pagination
        class="pager"
        show-icon="true"
        :total="count"
        :pageSize="query.size"
        :current="query.page"
        @change="page_change"
      ></uni-pagination>
      <!-- /分页器 -->
    </view>

    <!-- 论坛列表模块(结束) -->
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
import mixin from '@/libs/mixins/page.js';
import list_forum from '@/components/diy/list_forum.vue';
import { getForumListApi } from '@/api/forum';
export default {
  mixins: [mixin, tabbar],
  components: {
    Search,
    list_forum,
  },
  data() {
    return {
      active: '全部',
      tabbarIndex: 0,
      url_get_list: '~/api/forum/get_list?like=0',
      list: [],
      list_hot: [],
      query: {
        page: 1,
        size: 4,
        title: '',
        orderby: '`istop` desc,`create_time` desc',
      },
      list_forum_type: [
        {
          value: '全部',
          text: '全部',
        },
      ],
      type_names: [],
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
      filter_title: '筛选',
      sort_title: '排序',
      sort_list: [
        {
          name: '热度从高到低',
          value: '`hits` desc',
        },
        {
          name: '热度从低到高',
          value: '`hits` asc',
        },
        {
          name: '创建时间从高到低',
          value: '`create_time` desc',
        },
        {
          name: '创建时间从低到高',
          value: '`create_time` asc',
        },
      ],
    };
  },
  methods: {
    onClickCategory(val) {
      this.active = val;
      this.searchType(val);
    },
    /**
     * 添加论坛内容过滤
     */
    get_forum_type() {
      getForumListApi().then((res) => {
        if (res.result) {
          res.result.list.map((o) =>
            this.list_forum_type.push({
              value: o.name,
              text: o.name,
            })
          );
        }
      });
    },
    /**
     * 筛选选择
     */
    filter_item(item) {
      this.filter_key = item.key;
      this.query.orderby = item.value;
      this.search_();
    },
    /**
     *下拉排序
     */
    sort_item(o) {
      this.query.orderby = o.name.value;
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
      console.log('eer');
      this.query.title = '';
      this.search_();
    },
    getHotList() {
      this.$get(this.url_get_list, {
        page: 1,
        size: 10,
        orderby: '`hits` desc',
      }).then((res) => {
        this.list_hot = res.result.list;
      });
    },
  },
  mounted() {
    this.get_forum_type();
    this.getHotList();
    for (let i = 0;i<this.tabbarList.length;i++){
      if (this.tabbarList[i].pagePath === "/pages/forum/index") {
        this.tabbarIndex = i;
      }
    }
  }
};
</script>

<style lang="scss" scoped>
@import 'styles/pages/index.scss';
</style>
