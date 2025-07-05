<template>
  <view class="page_diy_table page_type_of_place_of_origin_table" :style="{ paddingTop: vuex_custom_bar_height + 'px' }">
    <tn-nav-bar>产地类型列表</tn-nav-bar>
    <view class="page-list" id="page_diy_table">
      <!-- 筛选模块(开始) -->
      <view class="search-wrap">
        <!-- 搜索栏 -->
        <uni-forms :modelValue="query" labelWidth="70px">
            <uni-forms-item label="产地类型" name="type_of_place_of_origin">
                <uni-easyinput type="text" v-model="query.type_of_place_of_origin" placeholder="产地类型" />
              </uni-forms-item>
          </uni-forms>
        <!-- /搜索栏 -->
        <view class="search-btn-wrap">
          <view class="me-btn btn-reset" @click="reset()"> 重置 </view>
          <view class="me-btn btn-search" @click="search_()"> 查询 </view>
        </view>
		<view class="toolbar">
				  <view width="100%" class="me-btn btn-add" @click="$navTo('/pagesC/type_of_place_of_origin/view?')" v-if="$check_action('/type_of_place_of_origin/table', 'add') || $check_action('/type_of_place_of_origin/view', 'add')">添加</view>
				</view>
      </view>
      <!-- 列表 -->
      <view class="list-wrap-row">
        <view v-for="(o, i) in list" :key="i" class="list-item">
          <view class="item-row " v-if="0 && $check_field('get','type_of_place_of_origin')">
            <view class="label" v-if="true">
              <span>产地类型</span>
            </view>
              <view class="value">
              <span>{{ o['type_of_place_of_origin'] }}</span>
            </view>
            </view>
          <view class="content">
          </view>
          <view class="operate-bar">
            <view width="100%" class="me-btn btn-delete" @click="delInfo(i)"
                  v-if="$check_action('/type_of_place_of_origin/table', 'del') || $check_action('/type_of_place_of_origin/view', 'del')">
              删除
            </view>
            <view width="100%" class="me-btn btn-info" @click="$navTo('/pagesC/type_of_place_of_origin/view?' + field + '=' + o[field])"
                  v-if="$check_action('/type_of_place_of_origin/table', 'set') || $check_action('/type_of_place_of_origin/view', 'set') || $check_action('/type_of_place_of_origin/view', 'get')">
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
      url_get_list: '~/api/type_of_place_of_origin/get_list?like=0',
      url_del: '~/api/type_of_place_of_origin/del',

      // 字段ID
      field: 'type_of_place_of_origin_id',

      // 查询
      query: {
        size: 7,
        page: 1,
              type_of_place_of_origin: "",
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
            _this.delAll(list);
          } else if (res.cancel) {
            console.log('用户点击取消');
          }
        },
      });
    },
        },
  created() {
      },
};
</script>

<style lang="scss" scoped>
  @import 'styles/pagesC/index.scss';
</style>