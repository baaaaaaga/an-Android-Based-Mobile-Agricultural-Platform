<template>
  <view class="page_diy_table page_consultation_reply_table" :style="{ paddingTop: vuex_custom_bar_height + 'px' }">
    <tn-nav-bar>咨询回复列表</tn-nav-bar>
    <view class="page-list" id="page_diy_table">
      <!-- 筛选模块(开始) -->
      <view class="search-wrap">
        <!-- 搜索栏 -->
        <uni-forms :modelValue="query" labelWidth="70px">
                      <uni-forms-item label="咨询日期" name="date_of_consultation">
                <uni-easyinput type="text" v-model="query.date_of_consultation" placeholder="咨询日期" />
              </uni-forms-item>
                </uni-forms>
        <!-- /搜索栏 -->
        <view class="search-btn-wrap">
          <view class="me-btn btn-reset" @click="reset()"> 重置 </view>
          <view class="me-btn btn-search" @click="search_()"> 查询 </view>
        </view>
		<view class="toolbar">
						</view>
      </view>
      <!-- 列表 -->
      <view class="list-wrap-row">
        <view v-for="(o, i) in list" :key="i" class="list-item">
          <view class="item-row " v-if="0 && $check_field('get','consultation_number')">
            <view class="label" v-if="true">
              <span>咨询编号</span>
            </view>
              <view class="value">
              <span>{{ o['consultation_number'] }}</span>
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
          <view class="item-row " v-if="1 && $check_field('get','business_name')">
            <view class="label" v-if="true">
              <span>商家名称</span>
            </view>
              <view class="value">
              <span>{{ o['business_name'] }}</span>
            </view>
            </view>
          <view class="item-row " v-if="1 && $check_field('get','contact_number')">
            <view class="label" v-if="true">
              <span>联系号码</span>
            </view>
              <view class="value">
              <span>{{ o['contact_number'] }}</span>
            </view>
            </view>
          <view class="item-row " v-if="1 && $check_field('get','business_address')">
            <view class="label" v-if="true">
              <span>商家地址</span>
            </view>
              <view class="value">
              <span>{{ o['business_address'] }}</span>
            </view>
            </view>
          <view class="item-row " v-if="1 && $check_field('get','date_of_consultation')">
            <view class="label" v-if="true">
              <span>咨询日期</span>
            </view>
              <view class="value">
              <span>{{ $toTime(o['date_of_consultation'], 'yyyy-MM-dd') }}</span>
            </view>
            </view>
          <view class="item-row " v-if="0 && $check_field('get','consulting_users')">
            <view class="label" v-if="true">
              <span>咨询用户</span>
            </view>
              <view class="value">
              <span>{{ get_user_consulting_users(o['consulting_users']) }}</span>
            </view>
            </view>
          <view class="item-row " v-if="0 && $check_field('get','consulting_content')">
            <view class="label" v-if="true">
              <span>咨询内容</span>
            </view>
              <view class="value">
              <span>{{ o['consulting_content'] }}</span>
            </view>
            </view>
          <view class="item-row " v-if="0 && $check_field('get','reply_content')">
            <view class="label" v-if="true">
              <span>回复内容</span>
            </view>
              <view class="value">
              <span>{{ o['reply_content'] }}</span>
            </view>
            </view>
          <view class="content">
          </view>
          <view class="operate-bar">
            <view width="100%" class="me-btn btn-delete" @click="delInfo(i)"
                  v-if="$check_action('/consultation_reply/table', 'del') || $check_action('/consultation_reply/view', 'del')">
              删除
            </view>
            <view width="100%" class="me-btn btn-info" @click="$navTo('/pagesC/consultation_reply/view?' + field + '=' + o[field])"
                  v-if="$check_action('/consultation_reply/table', 'set') || $check_action('/consultation_reply/view', 'set') || $check_action('/consultation_reply/view', 'get')">
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
      url_get_list: '~/api/consultation_reply/get_list?like=0',
      url_del: '~/api/consultation_reply/del',

      // 字段ID
      field: 'consultation_reply_id',

      // 查询
      query: {
        size: 7,
        page: 1,
                        date_of_consultation: "",
                    login_time: '',
        create_time: '',
      },

      // 数据
      list: [],
                      // 用户列表
      list_user_farmers_merchants: [],
                                    // 用户列表
      list_user_consulting_users: [],
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
                                                                if(user_group=="消费者"){
          sqlwhere+= "consulting_users = " + this.user.user_id + " or ";
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
                                    /**
     * 获取消费者用户列表
     */
    async get_list_user_consulting_users() {
      var json = await this.$get("~/api/user/get_list?user_group=消费者");
      if(json.result && json.result.list){
        this.list_user_consulting_users = json.result.list;
      }
      else if(json.error){
        console.error(json.error);
      }
    },

    get_user_consulting_users(id){
      let obj = this.list_user_consulting_users;
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
                              this.get_list_user_consulting_users();
            },
};
</script>

<style lang="scss" scoped>
  @import 'styles/pagesC/index.scss';
</style>