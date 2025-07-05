<template>
  <view class="page_diy_table page_production_planning_table" :style="{ paddingTop: vuex_custom_bar_height + 'px' }">
    <tn-nav-bar>生产计划列表</tn-nav-bar>
    <view class="page-list" id="page_diy_table">
      <!-- 筛选模块(开始) -->
      <view class="search-wrap">
        <!-- 搜索栏 -->
        <uni-forms :modelValue="query" labelWidth="70px">
            <uni-forms-item label="计划编号" name="plan_no">
                <uni-easyinput type="text" v-model="query.plan_no" placeholder="计划编号" />
              </uni-forms-item>
              <uni-forms-item label="计划标题" name="schedule_title">
                <uni-easyinput type="text" v-model="query.schedule_title" placeholder="计划标题" />
              </uni-forms-item>
              <uni-forms-item label="计划日期" name="planned_date">
                <uni-easyinput type="text" v-model="query.planned_date" placeholder="计划日期" />
              </uni-forms-item>
              </uni-forms>
        <!-- /搜索栏 -->
        <view class="search-btn-wrap">
          <view class="me-btn btn-reset" @click="reset()"> 重置 </view>
          <view class="me-btn btn-search" @click="search_()"> 查询 </view>
        </view>
		<view class="toolbar">
				  <view width="100%" class="me-btn btn-add" @click="$navTo('/pagesC/production_planning/view?')" v-if="$check_action('/production_planning/table', 'add') || $check_action('/production_planning/view', 'add')">添加</view>
				</view>
      </view>
      <!-- 列表 -->
      <view class="list-wrap-row">
        <view v-for="(o, i) in list" :key="i" class="list-item">
          <view class="item-row " v-if="0 && $check_field('get','plan_no')">
            <view class="label" v-if="true">
              <span>计划编号</span>
            </view>
              <view class="value">
              <span>{{ o['plan_no'] }}</span>
            </view>
            </view>
          <view class="item-row " v-if="1 && $check_field('get','schedule_title')">
            <view class="label" v-if="true">
              <span>计划标题</span>
            </view>
              <view class="value">
              <span>{{ o['schedule_title'] }}</span>
            </view>
            </view>
          <view class="item-row " v-if="1 && $check_field('get','planned_date')">
            <view class="label" v-if="true">
              <span>计划日期</span>
            </view>
              <view class="value">
              <span>{{ $toTime(o['planned_date'], 'yyyy-MM-dd') }}</span>
            </view>
            </view>
          <view class="item-row " v-if="0 && $check_field('get','plan_content')">
            <view class="label" v-if="true">
              <span>计划内容</span>
            </view>
              <view class="value">
              <span>{{ o['plan_content'] }}</span>
            </view>
            </view>
          <view class="item-row " v-if="0 && $check_field('get','farmers_merchants')">
            <view class="label" v-if="true">
              <span>农户商家</span>
            </view>
              <view class="value">
              <span>{{ get_user_farmers_merchants(o['farmers_merchants']) }}</span>
            </view>
            </view>
          <view class="content">
          </view>
          <view class="operate-bar">
            <view width="100%" class="me-btn btn-delete" @click="delInfo(i)"
                  v-if="$check_action('/production_planning/table', 'del') || $check_action('/production_planning/view', 'del')">
              删除
            </view>
            <view width="100%" class="me-btn btn-info" @click="$navTo('/pagesC/production_planning/view?' + field + '=' + o[field])"
                  v-if="$check_action('/production_planning/table', 'set') || $check_action('/production_planning/view', 'set') || $check_action('/production_planning/view', 'get')">
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
      url_get_list: '~/api/production_planning/get_list?like=0',
      url_del: '~/api/production_planning/del',

      // 字段ID
      field: 'production_planning_id',

      // 查询
      query: {
        size: 7,
        page: 1,
              plan_no: "",
                    schedule_title: "",
                    planned_date: "",
                  login_time: '',
        create_time: '',
      },

      // 数据
      list: [],
                                  // 用户列表
      list_user_farmers_merchants: [],
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
    get_list_before(param){
      var user_group = this.user.user_group;
      if(user_group != "管理员"){
          let sqlwhere = "(";
                                                          if(user_group=="农户商家"){
          sqlwhere+= "farmers_merchants = " + this.user.user_id + " or ";
        }
                  if (sqlwhere.length>1){
          sqlwhere = sqlwhere.substr(0,sqlwhere.length-4);
          sqlwhere += ")";
          param["sqlwhere"] = sqlwhere;
        }
        }
      return param;
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
     * 获取农户商家用户列表
     */
    async get_list_user_farmers_merchants() {
      var json = await this.$get("~/api/user/get_list?user_group=农户商家");
      if(json.result && json.result.list){
        this.list_user_farmers_merchants = json.result.list;
      }
      else if(json.error){
        console.error(json.error);
      }
    },

    get_user_farmers_merchants(id){
      let obj = this.list_user_farmers_merchants;
      let ret = "";
      for(let i=0;i<obj.length;i++){
        if(obj[i].user_id==id){
          ret = obj[i].nickname+"-"+obj[i].username;
        }
      }
      return ret;
    },
    },
  created() {
                            this.get_list_user_farmers_merchants();
    },
};
</script>

<style lang="scss" scoped>
  @import 'styles/pagesC/index.scss';
</style>