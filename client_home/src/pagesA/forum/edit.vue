<template>
  <view
    :style="{ paddingTop: vuex_custom_bar_height + 'px' }"
    class="page_forum_edit"
    id="forum_edit"
  >
    <tn-nav-bar>论坛管理</tn-nav-bar>
    <view class="warp diy_detail--new">
      <view class="container-fluid">
        <view class="row">
          <view class="col-12 col-6">
            <view class="view">
              <view class="diy_title">
                <span>封面图</span>
              </view>
              <view class="diy_field diy_text">
                <span>
                  <image
                    style="width: 5rem; height: 5rem; border: 1px #d1d1d1 solid"
                    :src="$fullImgUrl(obj.img)"
                    mode="scaleToFill"
                    @click="change_avatar(obj.forum_id)"
                  />
                </span>
              </view>
            </view>
          </view>
          <view class="col-12 col-6">
            <view class="view">
              <view class="diy_title">
                <span>标题</span>
              </view>
              <view class="diy_field diy_text">
                <span>
                  <input class="uni-input" v-model="obj.title" placeholder="请输入标题" />
                </span>
              </view>
            </view>
          </view>
          <view class="col-12 col-6">
            <view class="view">
              <view class="diy_title">
                <span>分类</span>
              </view>
              <view class="diy_field diy_text">
                <span>
                  <uni-data-select :localdata="type_list" v-model="obj.type"> </uni-data-select>
                </span>
              </view>
            </view>
          </view>
          <view class="col-12 col-6">
            <view class="view">
              <view class="diy_title">
                <span>标签</span>
              </view>
              <view class="diy_field diy_text">
                <span>
                  <input class="uni-input" v-model="obj.tag" />
                </span>
              </view>
            </view>
          </view>
          <view class="col-12 col-6">
            <view class="view">
              <view class="diy_title">
                <span>昵称</span>
              </view>
              <view class="diy_field diy_text">
                <span>
                  <text>{{ obj.nickname }}</text>
                </span>
              </view>
            </view>
          </view>
          <view class="col-12 col-6">
            <view class="view">
              <view class="diy_title">
                <span>正文</span>
              </view>
              <view class="diy_field diy_text">
                <span>
                  <textarea v-model="obj.content"></textarea>
                </span>
              </view>
            </view>
          </view>
		  <view class="col-12 col-6" v-if="userInfo.user_group == '管理员'">
		    <view class="view">
		      <view class="diy_title">
		        <span>置顶状态</span>
		      </view>
		      <view class="diy_field diy_text">
		        <span>
		          <switch :checked="obj.istop" @change="istopChange" style="transform:scale(0.7);margin-top: -5px;"></switch>
		        </span>
		      </view>
		    </view>
		  </view>

          <view class="col-12 col-6">
            <view class="col-12">
              <view class="answer_btn_box">
                <button class="answer_btn_submit me-btn" @click="submit()">提交</button>
                <view class="clear"> </view>
              </view>
            </view>
          </view>
        </view>
      </view>
    </view>
  </view>
</template>

<script>
import bar_title from '@/components/diy/bar_title.vue';
import { setForumApi } from '@/api/forum';
import mixin from '@/libs/mixins/page.js';
export default {
  mixins: [mixin],
  components: {
    bar_title,
  },
  data() {
    return {
      url_get_obj: '/forum/get_obj?',
      url_add: '/forum/add',
      url_set: '/forum/set',
      url_get_type_list: '/forum_type/get_list',
      field: 'forum_id',
      query: {
        forum_id: 0,
      },
      // 商品详情初始化
      obj: {
        forum_id: 0,
        title: '',
        content: '',
        description: '',
        display: 0,
        tag: '',
        type: '',
        img: '',
        nickname: '',
		istop: 0,
      },
      type_list: [],
    };
  },
  methods: {
    get_forum_type() {
      let _slef = this;
      this.$get(this.url_get_type_list, {}, function (json, status) {
        console.log(json);
        _slef.type_list = json.result.list.map((item) => {
          return {
            value: item.name,
            text: item.name,
          };
        });
      });
    },
	istopChange(){
		this.obj.istop = this.obj.istop == 1 ? 0 : 1;
	},
    change_avatar(forum_id) {
      var _self = this;
      // 选择图像方法
      uni.chooseImage({
        count: 1,
        sizeType: ['original', 'compressed'], //可以指定是原图还是压缩图，默认二者都有
        sourceType: ['album'], //从相册选择
        success: function (res) {
          const tempFilePaths = res.tempFilePaths;
          const uploadTask = uni.uploadFile({
            url: _self.$fullUrl('~/api/forum/upload?'),
            filePath: tempFilePaths[0],
            name: 'file',
            header: {
              'x-auth-token': _self.$store.state.app.userInfo.token,
            },
            success: function (uploadFileRes) {
              var filename = JSON.parse(uploadFileRes.data).result.url;
              console.log(filename);
              var img = JSON.parse(uploadFileRes.data).result.url;

              setForumApi(forum_id, {
                img,
              }).then(() => {
                _self.obj.img = filename;
              });
            },
          });

          uploadTask.onProgressUpdate(function (res) {
            _self.percent = res.progress;
            console.log('上传进度' + res.progress);
            console.log('已经上传的数据长度' + res.totalBytesSent);
            console.log('预期需要上传的数据总长度' + res.totalBytesExpectedToSend);
          });
        },
        error: function (e) {
          console.log(e);
        },
      });
    },
	async submit_check() {
	  var msg = '';
	  var params = this.obj
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
    submit_main() {
      let _slef = this;
      let form = _slef.obj;
      delete form.update_time;
      delete form.create_time;

      setForumApi(form.forum_id, form).then((res) => {
        uni.showToast({
          icon: 'success',
          title: '保存成功',
        });
        setTimeout(() => {
          uni.hideToast();
          //关闭提示后跳转
          uni.navigateTo({
            url: '/pagesA/forum/table',
          });
        }, 1500);
      });
    },
  },
  created() {
    this.get_forum_type();
  },
};
</script>

<style lang="scss" scoped>
@import 'styles/pagesA/index.scss';
</style>
