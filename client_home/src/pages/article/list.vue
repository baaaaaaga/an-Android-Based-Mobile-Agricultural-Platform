<template>
  <view class="page_article_list" :style="{ paddingTop: vuex_custom_bar_height + 'px' }">
    <tn-nav-bar>新闻资讯列表</tn-nav-bar>
    <template v-if="$check_action('/article/list', 'get')">
      <!-- 搜索栏 -->
      <uni-search-bar
        placeholder="搜索文章"
        @confirm="search_"
        @cancel="cancel"
        cancelText="取消"
        @input="input($event, 'title')"
      >
        <uni-icons slot="searchIcon" color="#999999" size="18" type="home" />
      </uni-search-bar>
      <view style="padding: 10px">
        <uni-data-select
          @change="searchType"
          v-model="query.type"
          :localdata="types"
        ></uni-data-select>
      </view>
      <!-- 文章列表 -->
       <!-- 合并样式修改 -->
       <div class="m-3">
        <list_article style="background-color: #fff" :list="list"></list_article>
       </div>
      
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
    </template>
  </view>
</template>

<script>
import list_article from '@/components/diy/list_article.vue';
import bar_orderby from '@/components/diy/bar_orderby.vue';
import mixin from '@/libs/mixins/page.js';

export default {
  mixins: [mixin],
  components: {
    list_article,
    bar_orderby,
  },
  data() {
    return {
      url_get_list: '~/api/article/get_list?like=0',
      list: [],
      query: {
        title: '',
        page: 1,
        size: 4,
        type: '',
      },
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
          value: '',
          text: '全部',
        },
      ],
    };
  },
  methods: {
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
          if (res.result) {
            let list = res.result.list;
            list.map((obj) => {
              this.types.push({
                value: obj.name,
                text: obj.name,
              });
            });
            console.log(this.types);
          }
        }
      );
    },

    /**
     * 下拉商品筛选选择
     */
    filter_item(name) {
      if (name.name == '全部') {
        this.query = {
          page: 1,
          size: 4,
        };
        this.get_list();
      } else {
        this.query.type = name.name;
        this.search_();
      }
    },
    input(e, key) {
      this.query[key] = e;
    },
    search_() {
      this.query.page = 1;
      this.get_list();
    },
    searchType(v) {
      this.query.type = v;
      this.query.page = 1;
      this.get_list();
    },
    cancel() {
      console.log('eer');
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
  },
};
</script>
<style lang="scss" scoped>
@import 'styles/pages/index.scss';
</style>
