<template>
  <view class="div_article">
    <view class="title">{{ obj[vm.title] }}</view>
    <view class="aside">
      <view class="source_block" @click="$navTo(obj[vm.url])">
        <text class="source">{{ obj[vm.source] }}</text>
      </view>
      <text class="time"
        ><uni-tag :text="obj[vm.tag]" type="success" inverted style="margin-right: 20px"></uni-tag>
        {{ $toTime(obj[vm.create_time], "yyyy-MM-dd hh:mm:ss") }}</text
      >
    </view>
    <view class="desc">{{ obj[vm.description] }}</view>
    <!-- 文本内容 -->
    <rich-text class="rich_text" :nodes="$setRichTextImage(obj[vm.content])"></rich-text>
    <view class="doc">
      <view class="left_block">
        <view
          @click="add_praise()"
          v-if="$check_action('/praise/list', 'add') && !check_praised"
          class="praise"
        >
          <text class="iconfont icon-praise"></text>
          <text style="margin-left: 0.2rem">点赞</text>
        </view>
        <view
          @click="add_praise()"
          v-if="$check_action('/praise/list', 'del') && check_praised"
          class="praise"
        >
          <text class="iconfont icon-praise icon-praise--active"></text>
          <text style="margin-left: 0.2rem">已点赞</text>
        </view>
        <view
          @click="add_collect()"
          v-if="$check_action('/collect/list', 'add') && !check_collected"
          class="collect"
        >
          <text class="iconfont icon-collect"></text>
          <text style="margin-left: 0.2rem">收藏</text>
        </view>
        <view
          @click="add_collect()"
          v-if="$check_action('/collect/list', 'del') && check_collected"
          class="collect"
        >
          <text class="iconfont icon-collect icon-collect--active"></text>
          <text style="margin-left: 0.2rem">已收藏</text>
        </view>
      </view>
      <text class="see">
        <text v-if="obj[vm.hits] && obj[vm.hits] >= 0"><text class="num">{{ obj[vm.hits] }}</text>点击</text>
        <text v-if="obj[vm.praise_len] && obj[vm.praise_len] >= 0" style="padding-left: 1rem"><text class="num">{{ obj[vm.praise_len] }}</text>点赞</text>
      </text>
    </view>
  </view>
</template>

<script>
import { getPraiseCountApi, addPraiseApi, delPraiseApi } from '@/api/praise';
import { getCollectCountApi, addCollectApi, delCollectApi } from '@/api/collect';
import { setArticleApi } from '@/api/article';

export default {
  props: {
    obj: {
      type: Object,
      default: function () {
        return {};
      },
    },
    vm: {
      type: Object,
      default: function () {
        return {
          img: 'img',
          tag: 'tag',
          url: 'url',
          title: 'title',
          source: 'source',
          description: 'description',
          content: 'content',
          create_time: 'create_time',
          hits: 'hits',
          praise_len: 'praise_len',
        };
      },
    },
  },
  data() {
    return {
      // 是否已点赞
      check_praised: false,
      // 是否已收藏
      check_collected: false,
    };
  },
  methods: {
    /**
     * 获取点赞
     * @param {Object} obj
     */
    get_praise() {
      const user_id = this.userInfo.user_id;
      getPraiseCountApi({
        source_table: 'article',
        source_field: 'article_id',
        source_id: this.obj.article_id,
        user_id,
      }).then((res) => {
        if (res.result || res.result === 0) {
          this.check_praised = res.result ? true : false;
          console.log('点赞状态：', res.result);
        } else if (res.error) {
          this.$toast(res.error.message);
          console.error(res.error);
        }
      });
    },
    // 添加点赞
    add_praise() {
      const body = {
        source_table: 'article',
        source_field: 'article_id',
        source_id: this.obj.article_id,
        user_id: this.userInfo.user_id,
      };
      let _this = this;
      if (!this.check_praised) {
        _this.check_praised = true;

        addPraiseApi(body).then((res) => {
          _this.obj.praise_len += 1;
          console.log(res);
          const article_id = _this.obj.article_id;
          setArticleApi(article_id, {
            praise_len: _this.obj.praise_len,
          }).then((res) => {
            if (res.result) {
              console.log('添加点赞数状态：', res.result);
            } else if (res.error) {
              console.error(res.error);
            }
          });
        });
      } else {
        this.check_praised = false;

        delPraiseApi(body).then((res) => {
          this.obj.praise_len -= 1;
          console.log(res);
          const article_id = _this.obj.article_id;
          setArticleApi(article_id, {
            praise_len: _this.obj.praise_len,
          }).then((res) => {
            if (res.result) {
              console.log('添加点赞数状态：', res.result);
            } else if (res.error) {
              console.error(res.error);
            }
          });
        });
      }
    },
    /**
     * 初始化收藏状态
     */
    get_collect() {
      var user_id = this.userInfo.user_id;

      var query = {
        source_table: 'article',
        source_field: 'article_id',
        source_id: this.obj['article_id'],
        user_id,
      };
      getCollectCountApi(query).then((res) => {
        console.log('收藏状态：');
        if (res.result || res.result === 0) {
          var bl = res.result ? true : false;
          this.check_collected = bl;
          console.log('收藏状态：' + bl);
        } else if (res.error) {
          console.error(res.error);
        }
      });
    },
    // 添加收藏
    add_collect() {
      var { title, img, article_id } = this.obj;
      var body = {
        title,
        img,
        source_table: 'article',
        source_field: 'article_id',
        source_id: article_id,
        user_id: this.userInfo.user_id,
      };
      if (!this.check_collected) {
        this.check_collected = true;

        addCollectApi(body).then((res) => {
          this.$toast('收藏成功');
          console.log(res);
        });
      } else {
        this.check_collected = false;

        this.check_collected = false;
        delCollectApi(body).then(() => {
          this.$toast('取消收藏');
        });
      }
    },
  },
  computed: {
    praise_len() {
      return this.obj.praise_len;
    },
  },
  created() {
    setTimeout(() => {
      this.get_praise();
      this.get_collect();
    }, 1000);
  },
};
</script>
<style lang="scss" scoped>
@import 'styles/components/index.scss';
</style>
