<template>
  <view class="page_diy_table page_consumer_table" :style="{ paddingTop: vuex_custom_bar_height + 'px' }">
    <tn-nav-bar>消费者列表</tn-nav-bar>
    <view class="page-list" id="page_diy_table">
      <!-- 筛选模块(开始) -->
      <view class="search-wrap">
        <!-- 搜索栏 -->
        <uni-forms :modelValue="query" labelWidth="70px">
            <uni-forms-item label="用户姓名" name="user_name">
                <uni-easyinput type="text" v-model="query.user_name" placeholder="用户姓名" />
              </uni-forms-item>
            </uni-forms>
        <!-- /搜索栏 -->
        <view class="search-btn-wrap">
          <view class="me-btn btn-reset" @click="reset()"> 重置 </view>
          <view class="me-btn btn-search" @click="search_()"> 查询 </view>
        </view>
		<view class="toolbar">
				  <view width="100%" class="me-btn btn-add" @click="$navTo('/pagesC/consumer/view?')" v-if="$check_action('/consumer/table', 'add') || $check_action('/consumer/view', 'add')">添加</view>
				</view>
      </view>
      <!-- 列表 -->
      <view class="list-wrap-row">
        <view v-for="(o, i) in list" :key="i" class="list-item">
          <view class="item-row " v-if="0 && $check_field('get','user_name')">
            <view class="label" v-if="true">
              <span>用户姓名</span>
            </view>
              <view class="value">
              <span>{{ o['user_name'] }}</span>
            </view>
            </view>
          <view class="item-row " v-if="0 && $check_field('get','mobile_phone_number')">
            <view class="label" v-if="true">
              <span>手机号码</span>
            </view>
              <view class="value">
              <span>{{ o['mobile_phone_number'] }}</span>
            </view>
            </view>
          <view class="content">
          </view>
          <view class="operate-bar">
            <view width="100%" class="me-btn btn-delete" @click="delInfo(i)"
                  v-if="$check_action('/consumer/table', 'del') || $check_action('/consumer/view', 'del')">
              删除
            </view>
            <view width="100%" class="me-btn btn-info" @click="$navTo('/pagesC/consumer/view?' + field + '=' + o[field])"
                  v-if="$check_action('/consumer/table', 'set') || $check_action('/consumer/view', 'set') || $check_action('/consumer/view', 'get')">
              详情
            </view>
          </view>
        </view>
      </view>
      <!-- /列表 -->
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
  </view>
</template>
<script>
import mixin from '@/libs/mixins/page.js';

export default {
  mixins: [mixin],
  data() {
    return {
      // 获取数据地址
      url_get_list: '~/api/consumer/get_list?like=0',
      url_del: '~/api/consumer/del',

      // 字段ID
      field: 'consumer_id',

      // 查询
      query: {
        size: 7,
        page: 1,
              user_name: "",
                login_time: '',
        create_time: '',
      },

      // 数据
      list: [],
            };
  },
  methods: {
    search_() {
      this.query.page = 1;
      this.get_list();
    },
    /**
     * 重置
     */
    reset: function reset() {
      uni.clear(this.query);
      uni.push(this.query, this.config);
      this.get_list();
    },
    delInfo(v) {
      let _this = this;
      uni.showModal({
        title: '删除',
        content: '此操作将永久删除该文件, 是否继续?',
        success: function (res) {
          if (res.confirm) {
            let list = [v];
            _this.delInfoSub(list);
          } else if (res.cancel) {
            console.log('用户点击取消');
          }
        },
      });
    },
    async delInfoSub(list) {
      let _this = this;
      await this.delAll(list, async (list) => {
        var bl = true;
        for (var i = 0; i < list.length; i++) {
          var user_id = _this.list[list[i]].user_id;
          var res = await this.$get('~/api/user/del', { user_id });
          if (res.result) {
            console.log('删除成功' + i);
          } else {
            console.log('删除失败' + i);
            bl = false;
            break;
          }
        }
        if (bl) {
          _this.$toast('删除成功!', 'success');
          this.get_list();
        }
      });
    },
    get_list_after(param){
      let _this = this;
      for (let i = 0;i<this.list.length;i++){
        let user_id = _this.list[i].user_id
        _this.$get("~/api/user/get_obj", {
          user_id
        }, (json) => {
          if (json.result.obj){
            _this.$delete(_this.list[i],'username');
            _this.$set(_this.list[i],'username',json.result.obj.username);
            _this.$delete(_this.list[i],'nickname');
            _this.$set(_this.list[i],'nickname',json.result.obj.nickname);
          }
        });
      }
    },
              },
  created() {
          },
};
</script>

<style lang="scss" scoped>
  @import 'styles/pagesC/index.scss';
</style>