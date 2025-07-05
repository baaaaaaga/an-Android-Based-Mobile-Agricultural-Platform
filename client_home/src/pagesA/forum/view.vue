<template>
  <view class="page_forum_view" :style="{ paddingTop: vuex_custom_bar_height + 'px' }">
    <tn-nav-bar>发布内容</tn-nav-bar>
    <view class="container diy_view" id="forum_view">
      <uni-forms :modelValue="form">
        <uni-forms-item label="封面图" name="img">
          <!-- 修改权限 -->
          <view class="diy_field diy_img" v-if="form.img">
            <image
              style="width: 100px; height: 100px"
              :src="$fullImgUrl(form.img)"
              @click="change_img('img')"
            />
          </view>
          <!-- 添加权限 -->
          <view class="diy_field diy_img" v-else>
            <view
              style="width: 100px; height: 100px"
              class="btn_add_img"
              @click="change_img('img')"
            >
              <text>+</text>
            </view>
          </view>
        </uni-forms-item>
        <uni-forms-item label="标题" name="title">
          <uni-easyinput type="text" v-model="form.title" />
        </uni-forms-item>
        <uni-forms-item label="分类" name="type">
          <uni-data-select v-model="form.type" :localdata="list_forum_type"></uni-data-select>
        </uni-forms-item>
        <uni-forms-item label="标签" name="tag">
          <uni-easyinput type="text" v-model="form.tag" />
        </uni-forms-item>
        <uni-forms-item label="正文" name="content">
          <uni-easyinput type="textarea" v-model="form.content" />
        </uni-forms-item>
      </uni-forms>
      <view class="form_button">
        <button class="me-btn" @click="submit()">发表内容</button>
      </view>
    </view>
  </view>
</template>

<script>
import mixin from '@/libs/mixins/page.js';
import { uploadFilePathApi, uploadFileApi } from '@/api/common.js';
export default {
  mixins: [mixin],
  components: {},
  data() {
    return {
      field: 'forum_id',
      url_add: '/forum/add?',
      url_set: '/forum/set?',
      url_get_obj: '/forum/get_obj?',
      url_upload: '/forum/upload?',
      query: {
        forum_id: 0,
      },
      list_forum_type: [],
      form: {
        forum_id: 0,
        user_id: '',
        display: 0,
        nickname: '',
        hits: 0,
        title: '',
        keywords: '',
        description: '',
        url: '',
        tag: '',
        img: '',
        content: '',
        avatar: '',
        type: '',
      },
    };
  },
  methods: {
    /**
     * 上传图片
     * @param {Object} param文件参数
     */
    change_img(key_name) {
      var _self = this;
      // 选择图像方法
      uni.chooseImage({
        count: 1,
        sizeType: ['original', 'compressed'], //可以指定是原图还是压缩图，默认二者都有
        sourceType: ['album'], //从相册选择
        success: (res) => {
          const tempFilePaths = res.tempFilePaths;
          const filePath = tempFilePaths[0];
          console.log(filePath);
          uploadFilePathApi('/forum/upload', filePath, undefined, undefined, (task) => {
            task.onProgressUpdate((res) => {
              this.percent = res.progress;
              console.log('上传进度' + res.progress);
              console.log('已经上传的数据长度' + res.totalBytesSent);
              console.log('预期需要上传的数据总长度' + res.totalBytesExpectedToSend);
            });
          }).then((res) => {
            this.form[key_name] = res.result.url;
          });
        },
        error: function (e) {
          console.log(e);
        },
      });
    },

    async submit_check(params) {
      var msg = '';
      if (params.title === '') {
        msg = '标题不能为空';
        return msg;
      }

      var sensitiveWords = await this.filterSensitiveWords(params.content);
      if (sensitiveWords.length > 0) {
        return '当前消息中包含敏感词: ' + sensitiveWords.join(',');
      }

      var titleSensitiveWords = await this.filterSensitiveWords(params.title);
      if (titleSensitiveWords.length > 0) {
        return '当前标题中包含敏感词: ' + titleSensitiveWords.join(',');
      }

      var tagSensitiveWords = await this.filterSensitiveWords(params.tag);
      if (tagSensitiveWords.length > 0) {
        return '当前标签中包含敏感词: ' + tagSensitiveWords.join(',');
      }
    },

    async get_forum_type() {
      var json = await this.$get('~/api/forum_type/get_list?');
      if (json.result) {
        // this.list_forum_type = json.result.list;
        console.log(json.result.list);
        json.result.list.map((o) => {
          this.list_forum_type.push({ value: o.name, text: o.name });
        });
      } else if (json.error) {
        console.error(json.error);
      }
    },
  },
  created() {
    this.get_forum_type();
  },
  mounted() {
    this.form.user_id = this.userInfo.user_id;
    this.form.nickname = this.userInfo.nickname;
    this.form.avatar = this.userInfo.avatar;
  },
};
</script>
<style lang="scss" scoped>
@import 'styles/pagesA/index.scss';
</style>
