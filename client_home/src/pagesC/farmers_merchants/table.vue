<template>
  <view class="page_diy_table page_farmers_merchants_table" :style="{ paddingTop: vuex_custom_bar_height + 'px' }">
    <tn-nav-bar>农户商家列表</tn-nav-bar>
    <view class="page-list" id="page_diy_table">
      <!-- 筛选模块(开始) -->
      <view class="search-wrap">
        <!-- 搜索栏 -->
        <uni-forms :modelValue="query" labelWidth="70px">
            <uni-forms-item label="商家名称" name="business_name">
                <uni-easyinput type="text" v-model="query.business_name" placeholder="商家名称" />
              </uni-forms-item>
                      <uni-forms-item label="审核状态" name="examine_state">
              <uni-data-select placeholder="请选择审核状态"
                               v-model="query['examine_state']"
                               :localdata="list_examine_state"
              ></uni-data-select>
            </uni-forms-item>
        </uni-forms>
        <!-- /搜索栏 -->
        <view class="search-btn-wrap">
          <view class="me-btn btn-reset" @click="reset()"> 重置 </view>
          <view class="me-btn btn-search" @click="search_()"> 查询 </view>
        </view>
		<view class="toolbar">
				  <view width="100%" class="me-btn btn-add" @click="$navTo('/pagesC/farmers_merchants/view?')" v-if="$check_action('/farmers_merchants/table', 'add') || $check_action('/farmers_merchants/view', 'add')">添加</view>
				</view>
      </view>
      <!-- 列表 -->
      <view class="list-wrap-row">
        <view v-for="(o, i) in list" :key="i" class="list-item">
          <view class="item-row " v-if="0 && $check_field('get','business_name')">
            <view class="label" v-if="true">
              <span>商家名称</span>
            </view>
              <view class="value">
              <span>{{ o['business_name'] }}</span>
            </view>
            </view>
          <view class="item-row " v-if="0 && $check_field('get','contact_number')">
            <view class="label" v-if="true">
              <span>联系号码</span>
            </view>
              <view class="value">
              <span>{{ o['contact_number'] }}</span>
            </view>
            </view>
          <view class="item-row " v-if="0 && $check_field('get','business_address')">
            <view class="label" v-if="true">
              <span>商家地址</span>
            </view>
              <view class="value">
              <span>{{ o['business_address'] }}</span>
            </view>
            </view>
          <view class="item-row diy-image" v-if="0 && $check_field('get','business_license')">
            <view class="label" v-if=" false">
              <span>营业执照</span>
            </view>
              <view class="value diy_img">
              <image :src="$fullImgUrl(o['business_license'])" width="100%" height="100" />
            </view>
            </view>
          <view class="item-row diy-image" v-if="0 && $check_field('get','certification_application')">
            <view class="label" v-if=" false">
              <span>认证申请</span>
            </view>
              <view class="value diy_img">
              <image :src="$fullImgUrl(o['certification_application'])" width="100%" height="100" />
            </view>
            </view>
          <view class="content">
          </view>
          <view class="operate-bar">
            <view width="100%" class="me-btn btn-delete" @click="delInfo(i)"
                  v-if="$check_action('/farmers_merchants/table', 'del') || $check_action('/farmers_merchants/view', 'del')">
              删除
            </view>
            <view width="100%" class="me-btn btn-info" @click="$navTo('/pagesC/farmers_merchants/view?' + field + '=' + o[field])"
                  v-if="$check_action('/farmers_merchants/table', 'set') || $check_action('/farmers_merchants/view', 'set') || $check_action('/farmers_merchants/view', 'get')">
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
      url_get_list: '~/api/farmers_merchants/get_list?like=0',
      url_del: '~/api/farmers_merchants/del',

      // 字段ID
      field: 'farmers_merchants_id',

      // 查询
      query: {
        size: 7,
        page: 1,
              business_name: "",
                      "examine_state":"",
        login_time: '',
        create_time: '',
      },

      // 数据
      list: [],
                          list_examine_state: [
        { value: '', text: '全部' },
        { value: '未审核', text: '未审核' },
        { value: '已通过', text: '已通过' },
        { value: '未通过', text: '未通过' },
      ],
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