<template>
  <view class="comment_edit" :style="{ paddingTop: vuex_custom_bar_height + 'px' }">
    <tn-nav-bar>评论</tn-nav-bar>
    <view class="comment-wrapper" id="comment_edit">
      <!-- 评论区 -->
      <view class="comment_auth" v-if="query.nickname"> 对 <text>{{ query.nickname }}</text> 回复... </view>
      <uni-easyinput type="textarea" class="e-value" v-model="eValue"></uni-easyinput>
      <view class="footer">
        <view class="me-btn btn-main" @click="publish()">
          <span>发表</span>
        </view>
      </view>

      <!-- /评论区 -->
    </view>
  </view>
</template>

<script>
import mixin from '@/libs/mixins/page.js';
import tColorPicke from '@/components/diy/t-color-picker.vue';
import { addCommentApi } from '@/api/comment';

export default {
  mixins: [mixin],
  components: {
    't-color-picker': tColorPicke,
  },
  data() {
    return {
      // 登录权限
      oauth: {
        signIn: true,
        user_group: [],
      },
      form: {
        content: 'ceshi',
      },
      color: {
        r: 255,
        g: 0,
        b: 0,
        a: 0.6,
      },
      isEdit: false,
      fontColor: '#000',
      formats: {},
      readOnly: false,
      placeholder: '开始输入...',
      editorHeight: 300,
      keyboardHeight: 0,
      isIOS: false,
      content: '',
      editoValue: '',
      query: {
        nickname: '',
      },
      eValue: '',
    };
  },
  onLoad() {},

  methods: {
    cancel() {
      this.isEdit = false;
    },
    open() {
      this.$refs.colorPicker.open();
      this.isEdit = true;
      // uni.hideKeyboard();
    },
    hideKey() {
      uni.hideKeyboard();
    },
    async confirm(e) {
      this.isEdit = false;
      this.fontColor = await e.hex;
      this.onStatusChange({
        detail: {
          color: e.hex,
        },
      });
      this.$forceUpdate();
    },
    readOnlyChange() {
      this.readOnly = !this.readOnly;
    },
    onEditorReady() {
      uni
        .createSelectorQuery()
        .select('#editor')
        .context((res) => {
          console.log(res);
          this.editorCtx = res.context;
        })
        .exec();
    },
    undo() {
      this.editorCtx.undo();
    },

    redo() {
      this.editorCtx.redo();
    },

    blur() {
      this.editorCtx.blur();
    },

    format(e) {
      // this.hideKey();
      let { name, value } = e.target.dataset;
      if (!name) return; // console.log('format', name, value)
      this.editorCtx.format(name, value);
    },

    onStatusChange(e) {
      this.formats = e.detail;
    },

    insertDivider() {
      this.editorCtx.insertDivider({
        success: function () {
          console.log('insert divider success');
        },
      });
    },

    store(e) {
      this.editorCtx.getContents({
        success: function (res) {
          e.currentTarget.id == 1
            ? console.log('保存内容:', res.html)
            : uni.navigateTo({
                url: `../preview/preview?rich=${encodeURIComponent(res.html)}`,
              });
        },
      });
    },

    clear_() {
      this.editorCtx.clear({
        success: function (res) {
          console.log('clear success');
        },
      });
    },

    removeFormat() {
      this.editorCtx.removeFormat();
    },

    insertDate() {
      const date = new Date();
      const formatDate = `${date.getFullYear()}/${date.getMonth() + 1}/${date.getDate()}`;
      this.editorCtx.insertText({
        text: formatDate,
      });
    },

    insertImage() {
      uni.chooseImage({
        count: 1,
        success: (res) => {
          this.blobToDataURI(res.tempFiles[0], (result) => {
            this.editorCtx.insertImage({
              src: result,
              data: {
                id: 'abcd',
                role: 'god',
              },
              width: '80%',
              success: function () {
                console.log('insert image success');
              },
            });
          });
        },
      });
    },
    blobToDataURI(blob, callback) {
      console.log(blob);
      let reader = new FileReader();
      reader.readAsDataURL(blob);
      reader.onload = function (e) {
        callback(e.target.result);
      };
    },
    // 发送按钮
    async publish() {
      var content = this.eValue;
      var obj_url = getCurrentPages()[getCurrentPages().length - 1];
      var body = Object.assign({}, obj_url.options, {
        user_id: this.userInfo.user_id,
        nickname: this.userInfo.nickname,
        avatar: this.userInfo.avatar,
        content,
      });

      addCommentApi(body).then((res) => {
        if (res.result === 0 || res.result) {
		  this.$toast(res.result, 'success');
		  if (obj_url.options.source_table != 'article' && obj_url.options.source_table !=
		  	'forum' && obj_url.options.source_table != 'goods') {
		  	// 更新模块评论数
		  	let source_table = obj_url.options.source_table
		  	let source_field = obj_url.options.source_field
		  	let source_id = obj_url.options.source_id
		  	this.$get("~/api" + source_table + "/get_obj", {
		  		[source_field]: source_id
		  	}, (json) => {
		  		if(json.result && json.result.obj){
		  			let comment_len = json.result.obj.comment_len + 1
		  			this.$post('~/api/' + source_table + '/set?' + source_field + '=' + source_id,
		  			    {comment_len},(res) => {
		  			      if (res.result) {
		  			        console.log('添加评论数状态：', res.result);
		  			      } else if (res.error) {
		  			        console.error(res.error);
		  			      }
		  			    }
		  			);
		  		}
		  		console.log(json)
		  	});
		  }
          console.log(res.result, 'success');
          var url = this.$redirect();
          this.$nav(url);
        } else if (res.error) {
          console.log(res.error.message, 'error');
          this.$toast(res.error.message, 'error');
        }
      });

      //插入一条留言
      // this.$post('~/api/message/add?', body, (res) => {
      // 	if (res.result) {
      // 		this.$toast(res.result, 'success');
      // 		var url = this.$redirect();
      // 		this.$nav(url);
      // 	} else if (res.error) {
      // 		this.$toast(res.error.message, 'error');
      // 	}
      // })
    },
  },
};
</script>
<style lang="scss" scoped>
@import '/static/css/editor.css';
@import 'styles/pagesB/index.scss';
</style>
