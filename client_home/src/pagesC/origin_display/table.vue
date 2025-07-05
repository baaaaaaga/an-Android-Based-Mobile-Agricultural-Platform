<template>
  <view class="page_diy_table page_origin_display_table" :style="{ paddingTop: vuex_custom_bar_height + 'px' }">
    <tn-nav-bar>产地展示列表</tn-nav-bar>
    <view class="page-list" id="page_diy_table">
      <!-- 筛选模块(开始) -->
      <view class="search-wrap">
        <!-- 搜索栏 -->
        <uni-forms :modelValue="query" labelWidth="70px">
            <uni-forms-item label="产地名称" name="name_of_place_of_origin">
                <uni-easyinput type="text" v-model="query.name_of_place_of_origin" placeholder="产地名称" />
              </uni-forms-item>
                  <uni-forms-item label="产地类型" name="type_of_place_of_origin">
                      <uni-data-select
                    placeholder="请选择产地类型"
                    v-model="query['type_of_place_of_origin']"
                    :localdata="list_type_of_place_of_origin"
            ></uni-data-select>
                    </uni-forms-item>
                      </uni-forms>
        <!-- /搜索栏 -->
        <view class="search-btn-wrap">
          <view class="me-btn btn-reset" @click="reset()"> 重置 </view>
          <view class="me-btn btn-search" @click="search_()"> 查询 </view>
        </view>
		<view class="toolbar">
				  <view width="100%" class="me-btn btn-add" @click="$navTo('/pagesC/origin_display/view?')" v-if="$check_action('/origin_display/table', 'add') || $check_action('/origin_display/view', 'add')">添加</view>
				</view>
      </view>
      <!-- 列表 -->
      <view class="list-wrap-row">
        <view v-for="(o, i) in list" :key="i" class="list-item">
          <view class="item-row " v-if="1 && $check_field('get','name_of_place_of_origin')">
            <view class="label" v-if="true">
              <span>产地名称</span>
            </view>
              <view class="value">
              <span>{{ o['name_of_place_of_origin'] }}</span>
            </view>
            </view>
          <view class="item-row diy-image" v-if="1 && $check_field('get','cover_chart')">
            <view class="label" v-if=" false">
              <span>封面图</span>
            </view>
              <view class="value diy_img">
              <image :src="$fullImgUrl(o['cover_chart'])" width="100%" height="100" />
            </view>
            </view>
          <view class="item-row " v-if="1 && $check_field('get','place_of_origin_address')">
            <view class="label" v-if="true">
              <span>产地地址</span>
            </view>
              <view class="value">
              <span>{{ o['place_of_origin_address'] }}</span>
            </view>
            </view>
          <view class="item-row " v-if="1 && $check_field('get','type_of_place_of_origin')">
            <view class="label" v-if="true">
              <span>产地类型</span>
            </view>
              <view class="value">
              <span>{{ o['type_of_place_of_origin'] }}</span>
            </view>
            </view>
          <view class="item-row " v-if="1 && $check_field('get','scale_of_origin')">
            <view class="label" v-if="true">
              <span>产地规模</span>
            </view>
              <view class="value">
              <span>{{ o['scale_of_origin'] }}</span>
            </view>
            </view>
          <view class="item-row " v-if="0 && $check_field('get','introduction_of_origin')">
            <view class="label" v-if="true">
              <span>产地介绍</span>
            </view>
              <view class="value">
              <span>{{ o['introduction_of_origin'] }}</span>
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
          <view class="content">
            <view class="item-row">
              <view class="value">点击数{{ o['hits'] }}</view>
            </view>
          </view>
          <view class="operate-bar">
            <view width="100%" class="me-btn btn-delete" @click="delInfo(i)"
                  v-if="$check_action('/origin_display/table', 'del') || $check_action('/origin_display/view', 'del')">
              删除
            </view>
            <view width="100%" class="me-btn btn-info" @click="$navTo('/pagesC/origin_display/view?' + field + '=' + o[field])"
                  v-if="$check_action('/origin_display/table', 'set') || $check_action('/origin_display/view', 'set') || $check_action('/origin_display/view', 'get')">
              详情
            </view>
      <!--跨表按钮-->
			              <view width="100%" class="me-btn btn-pay"
                    v-if="$check_action('/interactive_consultation/view', 'add')"
                    @click="to_form('/pagesC/interactive_consultation/view', o)">
                <span>咨询</span>
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
      url_get_list: '~/api/origin_display/get_list?like=0',
      url_del: '~/api/origin_display/del',

      // 字段ID
      field: 'origin_display_id',

      // 查询
      query: {
        size: 7,
        page: 1,
              name_of_place_of_origin: "",
                        type_of_place_of_origin: "",
                          login_time: '',
        create_time: '',
      },

      // 数据
      list: [],
                        // 产地类型列表
      list_type_of_place_of_origin: [{value:"",text:"全部"}],
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
     * 获取产地类型列表
     */
    async get_list_type_of_place_of_origin() {
                    var json = await this.$get("~/api/type_of_place_of_origin/get_list");
        if(json.result){
          json.result.list.map((o) => this.list_type_of_place_of_origin.push({value:o.type_of_place_of_origin,text:o.type_of_place_of_origin}));
        }else if (json.error){
          console.log(json.error);
        }
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
                  // 初始化产地类型列表
    this.get_list_type_of_place_of_origin();
                        this.get_list_user_farmers_merchants();
                },
};
</script>

<style lang="scss" scoped>
  @import 'styles/pagesC/index.scss';
</style>