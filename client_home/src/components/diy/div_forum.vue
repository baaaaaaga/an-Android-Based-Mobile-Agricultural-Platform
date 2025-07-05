<template>
  <view class="div_forum">
    <view class="title">{{ obj[vm.title] || '' }}</view>
    <view class="aside">
      <view class="info">
        <uni-icons type="person" size="14" color="#6a737d"> </uni-icons>
        <view>{{ obj ? obj[vm.nickname] : '' }}</view>
      </view>
      <view class="time" style="margin-left: 10px">{{
        obj ? $toTime(obj[vm.create_time], 'yyyy-MM-dd hh:mm:ss') : ''
      }}</view>
    </view>
    <view class="desc" v-if="obj[vm.img]">
      <image style="width: 100px; height: 100px" :src="$fullImgUrl(obj[vm.img])" />
    </view>
    <rich-text class="rich_text" :nodes="$setRichTextImage(obj[vm.content])"></rich-text>
    <view class="tag_block">
      标签：<text class="tag" v-for="o in tag_list" :key="o">{{ o }}</text>
    </view>
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
          <!-- <uni-icons style="margin-right: 0.2rem" type="star" size="14"></uni-icons> -->
          <text class="iconfont icon-collect"></text>
          <text style="margin-left: 0.2rem">收藏</text>
        </view>
        <view
          @click="add_collect()"
          v-if="$check_action('/collect/list', 'del') && check_collected"
          class="collect"
        >
          <!-- <uni-icons style="margin-right: 0.2rem" type="star-filled" size="14"></uni-icons> -->
          <text class="iconfont icon-collect icon-collect--active"></text>
          <text style="margin-left: 0.2rem">已收藏</text>
        </view>
      </view>
      <text class="see">
        <text style="padding-right: 1rem"><text class="num">{{ obj[vm.hits] }}</text>点击</text>
        <text><text class="num">{{ obj[vm.praise_len] }}</text>点赞</text>
      </text>
    </view>
  </view>
</template>

<script>
import { getPraiseCountApi, addPraiseApi, delPraiseApi } from '@/api/praise';
import { getCollectCountApi, addCollectApi, delCollectApi } from '@/api/collect';
import { setForumApi } from '@/api/forum';

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
          nickname: 'nickname',
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
      tag_list: [],
    };
  },
  methods: {
    /**
     * 获取点赞
     * @param {Object} obj
     */
    get_praise() {
      const user_id = this.userInfo.user_id;
      const parasm = {
        source_table: 'forum',
        source_field: 'forum_id',
        source_id: this.obj.forum_id,
        user_id,
      };
      getPraiseCountApi(parasm).then((res) => {
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
      var body = {
        source_table: 'forum',
        source_field: 'forum_id',
        source_id: this.obj.forum_id,
        user_id: this.userInfo.user_id,
      };
      let _this = this;
      const forum_id = _this.obj.forum_id;
      if (!this.check_praised) {
        _this.check_praised = true;
        addPraiseApi(body).then((res) => {
          _this.obj.praise_len += 1;
          console.log(res);
          setForumApi(forum_id, {
            praise_len: _this.obj.praise_len,
          }).then((rest) => {
            if (rest.result) {
              console.log('添加点赞数状态：', rest.result);
            } else if (rest.error) {
              console.error(rest.error);
            }
          });
        });
      } else {
        this.check_praised = false;

        delPraiseApi(body).then((res) => {
          this.obj.praise_len -= 1;
          console.log(res);
          setForumApi(forum_id, {
            praise_len: _this.obj.praise_len,
          }).then((rest) => {
            if (rest.result) {
              console.log('添加点赞数状态：', rest.result);
            } else if (rest.error) {
              console.error(rest.error);
            }
          });
        });
      }
    },
    /**
     * 初始化收藏状态
     * @param {Object} obj
     */
    get_collect() {
      const user_id = this.userInfo.user_id;
      const query = {
        source_table: 'forum',
        source_field: 'forum_id',
        source_id: this.obj.forum_id,
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
      var { title, img, forum_id } = this.obj;
      var body = {
        title,
        img,
        source_table: 'forum',
        source_field: 'forum_id',
        source_id: forum_id,
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
        delCollectApi(body).then(() => {
          this.$toast('取消收藏');
        });
      }
    },
    init_tag() {
      this.tag_list = this.obj.tag.split('|');
    },
  },
  computed: {},
  created() {
    setTimeout(() => {
      this.init_tag();
      this.get_praise();
      this.get_collect();
    }, 500);
  },
};
</script>

<style lang="scss" scoped>
@import 'styles/components/index.scss';
</style>
