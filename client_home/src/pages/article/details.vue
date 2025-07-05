<template>
  <view id="page_article_details" class="page_article_details" :style="{ paddingTop: vuex_custom_bar_height + 'px' }">
    <tn-nav-bar>新闻资讯详情</tn-nav-bar>
    <!-- 文章详情模块(开始) -->
    <template v-if="$check_action('/article/details', 'get')">
      <div_article style="background-color: #fff" :obj="obj" class="mb"></div_article>
      <!-- 推荐文章 -->
      <uni-card title="推荐文章" v-if="$check_action('/comment/list', 'get')">
        <list_article :list="list_article"></list_article>
      </uni-card>
      <!-- /推荐文章 -->

      <!-- 文章评论列表 -->
      <uni-card title="文章点评" v-if="$check_action('/comment/list', 'get')">
        <list_comment
          style="background-color: #fff"
          :list="list_comment"
          :obj="form_comment"
          @refresh="get_comment"
        ></list_comment>
      </uni-card>

      <!-- /文章评论列表 -->
      <!-- 发表评论 -->
      <view class="btn-box" v-if="$check_action('/comment/list', 'add')">
        <view
          class="me-btn btn-link"
          @click="
            $navTo(
              '/pagesB/comment/edit?source_table=article&source_field=article_id&source_id=' +
                obj.article_id
            )
          "
        >
          发表评论
        </view>
      </view>
    </template>

    <!-- 文章详情模块(结束) -->
  </view>
</template>

<script>
import list_article from '@/components/diy/list_article.vue';
import div_article from '@/components/diy/div_article.vue';
import list_comment from '@/components/diy/list_comment.vue';

import mixin from '@/libs/mixins/page.js';
import { getArticleListApi, setArticleApi } from '@/api/article';
import { getCommentListApi } from '@/api/comment';
export default {
  mixins: [mixin],
  components: {
    list_article,
    div_article,
    list_comment,
  },
  data() {
    return {
      url_get_obj: '~/api/article/get_obj?',
      field: 'article_id',
      query: {
        article_id: 0,
      },
      obj: {
        article_id: 0,
        title: '',
        type: '',
        hits: 0,
        create_time: '',
        update_time: '',
        source: '',
        url: '',
        tag: '',
        content: '',
        img: '',
        description: '',
        praise_len: 0,
      },
      list_article: [],
      list_comment: [],
      form: {
        content: '',
      },
      form_comment: {
        source_table: 'article',
        source_field: 'article_id',
        source_id: 0,
        reply_to_id: 0,
      },
    };
  },
  methods: {
    onEditorReady() {
      uni
        .createSelectorQuery()
        .select('#editor')
        .context((res) => {
          this.editorCtx = res.context;
          this.editorCtx.setContents({
            html: this.form.content,
            success: (res) => {
              console.log(res);
            },
            fail: (res) => {
              console.log(res);
            },
          });
        })
        .exec();
    },
    // 获取文章
    get_article() {
      getArticleListApi({
        page: 1,
        size: 2,
      }).then((res) => {
        if (res.result) {
          this.list_article = res.result.list;
        }
      });
    },
    // 获取评论
    get_comment() {
      var options = getCurrentPages()[getCurrentPages().length - 1].options;
      var query = {
        source_table: 'article',
        source_field: 'article_id',
        source_id: options.article_id,
        orderby: 'create_time desc',
        reply_to_id: '0',
      };

      getCommentListApi(query).then((res) => {
        if (res.result) {
          var list_comment = res.result.list;
          list_comment.map((o) => {
            o.list_reply = [];
          });
          this.add_reply(list_comment).then((list) => {
            this.list_comment = list;
          });
        }
      });
    },
    /**
     * @param { Array } list 评论列表
     * 添加回复到评论列表
     */
    add_reply(list) {
      return new Promise((resolve) => {
        for (let idx = 0; idx < list.length; idx++) {
          const obj = list[idx];

          const params = {
            source_table: 'article',
            source_field: 'article_id',
            source_id: obj.article_id,
            orderby: 'create_time desc',
            reply_to_id: obj.comment_id,
          };
          getCommentListApi(params).then((res) => {
            if (res.result) {
              obj.list_reply = res.result.list;
            }
          });
        }
        resolve(list);
      }).catch((e) => {});
    },
    editorChange: function (e) {
      this.gongsijieshao = e.detail.html;
    },
    /**
     * 获取对象之后
     * @param {Object} json 结果对象
     */
    get_obj_after(json) {
      this.add_hits(this.obj);
      let obj = this.obj;
      this.get_comment(obj);
      this.form_comment.source_id = obj.article_id;
    },
    /**
     * 添加访问量
     */
    add_hits(obj) {
      setArticleApi(obj.article_id, {
        hits: obj.hits + 1,
      }).then((res) => {
        obj.hits += 1;
        console.log(res);
      });
    },
  },
  onLoad() {
    this.get_article();
    this.get_comment();
  },
};
</script>
<style lang="scss" scoped>
@import 'styles/pages/index.scss';
</style>
