<template>
  <view class="page_forum_details" id="page_forum_details" :style="{ paddingTop: vuex_custom_bar_height + 'px' }">
    <tn-nav-bar>交流论坛详情</tn-nav-bar>

    <view class="forum-details-wrap" v-if="$check_action('/forum/details', 'get')">
      <!-- 论坛详情模块(开始) -->
      <view class="forum-info">
        <div_forum :obj="obj" style="background-color: #fff"></div_forum>
      </view>
      <!-- 论坛详情模块(结束) -->

      <!-- 评论列表(开始) -->
      <view class="comment-list">
        <tn-list-view title="文章点评" :card="true" v-if="$check_action('/comment/list', 'get')">
          <view class="card-wrap">
            <list_comment
              style="background-color: #fff"
              :list="list_comment"
              :obj="form_comment"
              @refresh="get_comment"
            ></list_comment>
          </view>
        </tn-list-view>
      </view>

      <!-- 评论列表(结束) -->
      <!-- 发表评论模块(开始) -->
      <view class="forum-footer" v-if="$check_action('/comment/list', 'add')">
        <view class="me-btn save-btn" @click="clickComment(obj)">我来评论</view>
      </view>
      <!-- 发表评论模块(结束) -->
    </view>
  </view>
</template>

<script>
import { getCommentListApi } from '@/api/comment';
import { setForumApi } from '@/api/forum';
import bar_title from '@/components/diy/bar_title.vue';
import div_forum from '@/components/diy/div_forum.vue';
import list_comment from '@/components/diy/list_comment.vue';
import mixin from '@/libs/mixins/page.js';
export default {
  mixins: [mixin],
  components: {
    bar_title,
    div_forum,
    list_comment,
  },
  data() {
    return {
      url_get_obj: '/forum/get_obj?',
      field: 'forum_id',
      query: {
        forum_id: 0,
      },
      obj: {
        forum_id: 0,
        display: 0,
        user_id: 0,
        nickname: '',
        hits: 0,
        title: '',
        keywords: '',
        description: '',
        url: '',
        tag: '',
        img: '',
        content: '',
        create_time: '',
        update_time: '',
        avatar: '',
        type: '',
        praise_len: 0,
      },
      list_comment: [],
      form: {
        content: '',
      },
      form_comment: {
        source_table: 'forum',
        source_field: 'forum_id',
        source_id: 0,
        reply_to_id: 0,
      },
    };
  },
  methods: {
    clickComment(obj) {
      const path =
        '/pagesB/comment/edit?source_table=forum&source_field=forum_id&source_id=' + obj.forum_id;
      this.$navTo(path);
    },
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
    // 获取评论
    get_comment() {
      var options = getCurrentPages()[getCurrentPages().length - 1].options;
      var query = {
        source_table: 'forum',
        source_field: 'forum_id',
        source_id: options.forum_id,
        orderby: 'create_time desc',
        reply_to_id: '0',
      };
      getCommentListApi(query).then((json) => {
        if (json.result) {
          var list_comment = json.result.list;
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
    async add_reply(list) {
      return new Promise((resolve) => {
        for (let idx = 0; idx < list.length; idx++) {
          const obj = list[idx];
          const params = {
            source_table: 'forum',
            source_field: 'forum_id',
            source_id: obj.forum_id,
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
      this.get_comment(this.obj);
      this.form_comment.source_id = this.obj.article_id;
    },
    /**
     * 添加访问量
     */
    add_hits(obj) {
      setForumApi(obj.forum_id, {
        hits: obj.hits + 1,
      }).then((res) => {
        obj.hits += 1;
        console.log(res);
      });
    },
  },
  onLoad() {
    this.get_comment();
  },
};
</script>
<style lang="scss" scoped>
@import 'styles/pagesA/index.scss';
</style>
