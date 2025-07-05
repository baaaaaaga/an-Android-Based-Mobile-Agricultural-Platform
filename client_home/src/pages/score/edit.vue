<template>
  <view id="page_score_edit" :style="{ paddingTop: vuex_custom_bar_height + 'px' }">
    <tn-nav-bar>评分</tn-nav-bar>
    <view class="page_score_edit">
      <view class="score_title">{{ scoreReadOnly ? "我的评分" : "评分"}}</view>
      <view class="score_num">
        <tn-rate
          v-model="score_num"
          allowHalf
          activeColor="#ffba00"
          inactiveColor="#CCCCCC"
          :size="80"
        ></tn-rate>
      </view>

      <view v-if="!scoreReadOnly" class="me-btn btn_submit_score" @click="submit_score">提交评分</view>
    </view>
  </view>
</template>

<script>
export default {
  data() {
    return {
      score_num: 0,
	  scoreReadOnly: true,
    };
  },
  methods: {
    async submit_score() {
      const obj_url = getCurrentPages()[getCurrentPages().length - 1];

      let params = Object.assign({}, obj_url.options, {
        user_id: this.userInfo.user_id,
        nickname: this.userInfo.nickname,
        score_num: this.score_num,
      });

      await this.$post('~/api/score/add', params).then((res) => {
        if (res.result) {
          this.$toast('评分成功');
          setTimeout(() => {
            this.$Router.back(1);
          }, 1000);
        } else {
          this.$toast('评分失败');
        }
      });
    },
	// 查询个人评分
	async getOwnScore() {
	  const obj_url = getCurrentPages()[getCurrentPages().length - 1];
	  const url = "~/api/score/get_obj";
	  const user_id = this.userInfo.user_id;
	  const params = {
	    source_table: obj_url.options.source_table,
		source_field: obj_url.options.source_field,
	    source_id: obj_url.options.source_id,
	    user_id: user_id,
	  };
	  const res = await this.$get(url, params);
	  this.score_num = res.result.obj?.score_num || 0;
	  if(this.score_num > 0) {
	    this.scoreReadOnly = true;
	  } else {
	    this.scoreReadOnly = false;
	  }
	},
  },
  onShow() {
      this.getOwnScore();
  },
};
</script>

<style lang="scss" scoped>
@import 'styles/pages/index.scss';
</style>
