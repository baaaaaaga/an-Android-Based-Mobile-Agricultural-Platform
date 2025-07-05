<template>
  <view :style="{ paddingTop: vuex_custom_bar_height + 'px' }" class="page_diy_list page_origin_display_list container">
	<view class="content">
	  <tn-nav-bar>产地展示列表</tn-nav-bar>
	  <view class="page-list" id="page_diy_list">
	        <!-- 筛选模块(开始) -->
	        <view class="search-wrap">
	  	    	      	          <Search v-model="query.name_of_place_of_origin" placeholder="搜索产地名称" @search="search_" @cancel="search_cancel('name_of_place_of_origin')" @input="(val) => inputValue(val, 'name_of_place_of_origin')" />
	      	    	  	    	  	    	  	    	      	    	  	    	  	    	  	    	  	    	  	    	  	    	  	  	    	      	    	  	    	  	    	  	    	      	        	          <view class="drop_down">
	            <uni-data-select
	                    @change="change_type_of_place_of_origin"
	                    v-model="query.type_of_place_of_origin"
	                    :localdata="list_type_of_place_of_origin"
	  				  :placeholder="placeholder_type_of_place_of_origin"
	            ></uni-data-select>
	          </view>
	        	      	    	  	    	  	    	  	    	  	    	  	    	  	    	  	  	          <MeDropdown
	            :menuList.sync="menuList"
	            themeColor="#0079fe"
	            :duration="300"
	            :isCeiling="true"
	            @onConfirm="onConfirmDropdown"
	            @onChange="onChangeDropdown"
	          ></MeDropdown>
	        </view>
	  
	        <!-- 筛选模块(结束) -->
	  <!-- 列表 -->
	        <view class="customized-list">
	  	          <view v-for="(o, i) in list" :key="i" class="customized-item">
	  	  	            <view
	              class="customized-item-body"
	              @click=" $navTo('/pagesC/origin_display/details?origin_display_id=' + o['origin_display_id'])">
	  	              <view class="item-row " v-if="1 && $check_field('get', 'name_of_place_of_origin')">
	                <view class="label" v-if="true">
	                  <span>产地名称</span>
	                </view>
	    	                <view class="value">
	                  <span>{{ o['name_of_place_of_origin'] }}</span>
	                </view>
	    	              </view>
	  	              <view class="item-row diy-image" v-if="1 && $check_field('get', 'cover_chart')">
	                <view class="label" v-if=" false">
	                  <span>封面图</span>
	                </view>
	    	                <view class="value diy_img">
	                  <image :src="$fullImgUrl(o['cover_chart'])" width="100%" height="100" />
	                </view>
	    	              </view>
	  	              <view class="item-row " v-if="1 && $check_field('get', 'place_of_origin_address')">
	                <view class="label" v-if="true">
	                  <span>产地地址</span>
	                </view>
	    	                <view class="value">
	                  <span>{{ o['place_of_origin_address'] }}</span>
	                </view>
	    	              </view>
	  	              <view class="item-row " v-if="1 && $check_field('get', 'type_of_place_of_origin')">
	                <view class="label" v-if="true">
	                  <span>产地类型</span>
	                </view>
	    	                <view class="value">
	                  <span>{{ o['type_of_place_of_origin'] }}</span>
	                </view>
	    	              </view>
	  	              <view class="item-row " v-if="1 && $check_field('get', 'scale_of_origin')">
	                <view class="label" v-if="true">
	                  <span>产地规模</span>
	                </view>
	    	                <view class="value">
	                  <span>{{ o['scale_of_origin'] }}</span>
	                </view>
	    	              </view>
	  	              <view class="item-row " v-if="0 && $check_field('get', 'introduction_of_origin')">
	                <view class="label" v-if="true">
	                  <span>产地介绍</span>
	                </view>
	    	                <view class="value">
	                  <span>{{ o['introduction_of_origin'] }}</span>
	                </view>
	    	              </view>
	  	              <view class="item-row " v-if="0 && $check_field('get', 'farmers_merchants')">
	                <view class="label" v-if="true">
	                  <span>农户商家</span>
	                </view>
	    	                <view class="value">
	                  <span>{{ get_user_farmers_merchants(o['farmers_merchants']) }}</span>
	                </view>
	    	              </view>
	  	              <view class="item-row " v-if="0 && $check_field('get', 'business_name')">
	                <view class="label" v-if="true">
	                  <span>商家名称</span>
	                </view>
	    	                <view class="value">
	                  <span>{{ o['business_name'] }}</span>
	                </view>
	    	              </view>
	  	              <view class="item-row " v-if="0 && $check_field('get', 'contact_number')">
	                <view class="label" v-if="true">
	                  <span>联系号码</span>
	                </view>
	    	                <view class="value">
	                  <span>{{ o['contact_number'] }}</span>
	                </view>
	    	              </view>
	  	              <view class="item-row " v-if="0 && $check_field('get', 'business_address')">
	                <view class="label" v-if="true">
	                  <span>商家地址</span>
	                </view>
	    	                <view class="value">
	                  <span>{{ o['business_address'] }}</span>
	                </view>
	    	              </view>
	  	  	            </view>
	  
	  	            <view class="customized-item-footer">
	    	    	              <view class="collect">
	                <text class="icon iconfont icon-shoucang"></text>
	                {{ o['collect_len'] || 0 }}
	              </view>
	    	    	              <view class="comment">
	                <text class="icon iconfont icon-pinglun"></text>
	                {{ o['comment_len'] || 0 }}
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
	</view>
</template>

<script>
import Search from '@/components/businessCp/search.vue';
import mixin from '@/libs/mixins/page.js';
import MeDropdown from '@/components/me-dropdown/index.vue';

export default {
  mixins: [mixin],
  components: {
    Search,
    MeDropdown,
  },
  data() {
    return {
      url_get_list: '~/api/origin_display/get_list?like=0',
                    // 产地类型选项列表
      list_type_of_place_of_origin: [{value:"全部",text:"全部"}],
	  placeholder_type_of_place_of_origin: "请选择产地类型",
                      // 用户列表
      list_user_farmers_merchants: [],
                        query: {
                name_of_place_of_origin: "", // 产地名称
                            type_of_place_of_origin: "", // 产地类型
                            origin_display_id: 0, // ID
        page: 1,
        size: 10,
      },
      list: [],
      count: 50,
      menuList: [
                            {
            title: '点击数',
            type: 'sort',
            command: '`hits`',
            value: 0,
        },
        {
            title: '收藏数',
            type: 'sort',
            command: '`collect_len`',
            value: 0,
        },
        {
            title: '发布时间',
            type: 'sort',
            command: '`create_time`',
            value: 0,
        }
      ],
    };
  },
  methods: {
    onConfirmDropdown(val) {
      if (val.value) {
        this.query.orderby = val.command + ' ' + val.value;
      } else {
        this.query.orderby = '';
      }
      this.search_();
    },
    onChangeDropdown(v) {},
    /**
     * 获取列表后
     * @param {Object} json
     * @param {Object} func
     */
    get_list_after(json, func) {
      let list = json.result.list;
      if (func) {
        func(json);
      }
    },
          
      
      
                    // 改变分类标签
        change_type_of_place_of_origin(val) {
          if (val === "全部" || val === "") {
            this.query.type_of_place_of_origin = "";
          }else{
            this.query.type_of_place_of_origin = val
          }
          this.search_();
        },
        
      /**
     * 获取产地类型列表
     */
    async get_list_type_of_place_of_origin() {
                          var json = await this.$get("~/api/type_of_place_of_origin/get_list?");
          if(json.result && json.result.list){
            json.result.list.map((o) => this.list_type_of_place_of_origin.push({value:o.type_of_place_of_origin,text:o.type_of_place_of_origin}));
          }
          else if(json.error){
            $.toast(json.error.message);
            console.error(json.error);
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
          
      
      
        search_() {
      this.query.page = 1;
      this.get_list();
    },
    search_cancel(key) {
      this.query[key] = '';
      this.search_();
    },
	inputValue(val, key) {
	  this.query[key] = val;
	  this.search_();
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