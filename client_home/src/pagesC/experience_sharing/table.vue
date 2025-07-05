<template>
  <view class="page_diy_table page_experience_sharing_table" :style="{ paddingTop: vuex_custom_bar_height + 'px' }">
    <tn-nav-bar>经验分享列表</tn-nav-bar>
    <view class="page-list" id="page_diy_table">
      <!-- 筛选模块(开始) -->
      <view class="search-wrap">
        <!-- 搜索栏 -->
        <uni-forms :modelValue="query" labelWidth="70px">
            <uni-forms-item label="标题" name="title">
                <uni-easyinput type="text" v-model="query.title" placeholder="标题" />
              </uni-forms-item>
              <uni-forms-item label="分享类型" name="share_type">
                      <uni-data-select
                    placeholder="请选择分享类型"
                    v-model="query['share_type']"
                    :localdata="list_share_type"
            ></uni-data-select>
                    </uni-forms-item>
            </uni-forms>
        <!-- /搜索栏 -->
        <view class="search-btn-wrap">
          <view class="me-btn btn-reset" @click="reset()"> 重置 </view>
          <view class="me-btn btn-search" @click="search_()"> 查询 </view>
        </view>
		<view class="toolbar">
				  <view width="100%" class="me-btn btn-add" @click="$navTo('/pagesC/experience_sharing/view?')" v-if="$check_action('/experience_sharing/table', 'add') || $check_action('/experience_sharing/view', 'add')">添加</view>
				</view>
      </view>
      <!-- 列表 -->
      <view class="list-wrap-row">
        <view v-for="(o, i) in list" :key="i" class="list-item">
          <view class="item-row " v-if="0 && $check_field('get','title')">
            <view class="label" v-if="true">
              <span>标题</span>
            </view>
              <view class="value">
              <span>{{ o['title'] }}</span>
            </view>
            </view>
          <view class="item-row " v-if="0 && $check_field('get','share_type')">
            <view class="label" v-if="true">
              <span>分享类型</span>
            </view>
              <view class="value">
              <span>{{ o['share_type'] }}</span>
            </view>
            </view>
          <view class="item-row " v-if="0 && $check_field('get','experience_content')">
            <view class="label" v-if="true">
              <span>经验内容</span>
            </view>
              <view class="value">
              <span>{{ o['experience_content'] }}</span>
            </view>
            </view>
          <view class="content">
          </view>
          <view class="operate-bar">
            <view width="100%" class="me-btn btn-delete" @click="delInfo(i)"
                  v-if="$check_action('/experience_sharing/table', 'del') || $check_action('/experience_sharing/view', 'del')">
              删除
            </view>
            <view width="100%" class="me-btn btn-info" @click="$navTo('/pagesC/experience_sharing/view?' + field + '=' + o[field])"
                  v-if="$check_action('/experience_sharing/table', 'set') || $check_action('/experience_sharing/view', 'set') || $check_action('/experience_sharing/view', 'get')">
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
      url_get_list: '~/api/experience_sharing/get_list?like=0',
      url_del: '~/api/experience_sharing/del',

      // 字段ID
      field: 'experience_sharing_id',

      // 查询
      query: {
        size: 7,
        page: 1,
              title: "",
                    share_type: "",
                login_time: '',
        create_time: '',
      },

      // 数据
      list: [],
                // 分享类型列表
      list_share_type: [{value:"",text:"全部"}],
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
            _this.delAll(list);
          } else if (res.cancel) {
            console.log('用户点击取消');
          }
        },
      });
    },
            /**
     * 获取分享类型列表
     */
    async get_list_share_type() {
                    var json = await this.$get("~/api/share_type/get_list");
        if(json.result){
          json.result.list.map((o) => this.list_share_type.push({value:o.share_type,text:o.share_type}));
        }else if (json.error){
          console.log(json.error);
        }
          },
              },
  created() {
          // 初始化分享类型列表
    this.get_list_share_type();
          },
};
</script>

<style lang="scss" scoped>
  @import 'styles/pagesC/index.scss';
</style>