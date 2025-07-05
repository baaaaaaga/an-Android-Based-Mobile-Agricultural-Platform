<template>
  <view class="cp-list-wrap">
    <!-- 视图 -->
    <view class="cp-list-item" v-for="(o, i) in list" :key="i">
        <view class="item-row " v-if="1 && $check_index_field('get', 'name_of_place_of_origin', '/origin_display/list')">
        <view class="label" v-if="true">
          <span>产地名称</span>
        </view>
            <view class="value text">
          <span>{{ o['name_of_place_of_origin'] }}</span>
        </view>
          </view>
          <view class="item-row diy-image" v-if="1 && $check_index_field('get', 'cover_chart', '/origin_display/list')">
        <view class="label" v-if=" false">
          <span>封面图</span>
        </view>
            <view class="value">
          <image :src="$fullImgUrl(o['cover_chart']) || '/static/img/default.png'" mode="scaleToFill" />
        </view>
          </view>
          <view class="item-row " v-if="1 && $check_index_field('get', 'place_of_origin_address', '/origin_display/list')">
        <view class="label" v-if="true">
          <span>产地地址</span>
        </view>
            <view class="value text">
          <span>{{ o['place_of_origin_address'] }}</span>
        </view>
          </view>
          <view class="item-row " v-if="1 && $check_index_field('get', 'type_of_place_of_origin', '/origin_display/list')">
        <view class="label" v-if="true">
          <span>产地类型</span>
        </view>
            <view class="value text">
          <span>{{ o['type_of_place_of_origin'] }}</span>
        </view>
          </view>
          <view class="item-row " v-if="1 && $check_index_field('get', 'scale_of_origin', '/origin_display/list')">
        <view class="label" v-if="true">
          <span>产地规模</span>
        </view>
            <view class="value text">
          <span>{{ o['scale_of_origin'] }}</span>
        </view>
          </view>
          <view class="item-row " v-if="0 && $check_index_field('get', 'introduction_of_origin', '/origin_display/list')">
        <view class="label" v-if="true">
          <span>产地介绍</span>
        </view>
            <view class="value text">
          <span>{{ o['introduction_of_origin'] }}</span>
        </view>
          </view>
          <view class="item-row " v-if="0 && $check_index_field('get', 'farmers_merchants', '/origin_display/list')">
        <view class="label" v-if="true">
          <span>农户商家</span>
        </view>
            <view class="value time">
          <span>{{ get_user_farmers_merchants(o['farmers_merchants']) }}</span>
        </view>
          </view>
          <view class="item-row " v-if="0 && $check_index_field('get', 'business_name', '/origin_display/list')">
        <view class="label" v-if="true">
          <span>商家名称</span>
        </view>
            <view class="value text">
          <span>{{ o['business_name'] }}</span>
        </view>
          </view>
          <view class="item-row " v-if="0 && $check_index_field('get', 'contact_number', '/origin_display/list')">
        <view class="label" v-if="true">
          <span>联系号码</span>
        </view>
            <view class="value text">
          <span>{{ o['contact_number'] }}</span>
        </view>
          </view>
          <view class="item-row " v-if="0 && $check_index_field('get', 'business_address', '/origin_display/list')">
        <view class="label" v-if="true">
          <span>商家地址</span>
        </view>
            <view class="value text">
          <span>{{ o['business_address'] }}</span>
        </view>
          </view>
        <view class="content">
        <view class="item-row">
          <view class="value">
            <text class="icon iconfont icon-dianzan"></text><text>{{ o['hits'] }}</text>
          </view>
        </view>
      </view>

      <view class="item-row">
        <view class="create_time_block value number">
          <span>{{ $toTime(o.create_time, 'yyyy-MM-dd hh:mm:ss') }}</span>
        </view>
      </view>

      <view class="me-btn btn-see" @click="
          $navTo('/pagesC/origin_display/details?origin_display_id=' +
              o['origin_display_id']
          )
        "
        >查看详情</view
      >
    </view>
    <!-- /视图 -->
  </view>
</template>

<script>
export default {
  props: {
    list: {
      type: Array,
      default: function () {
        return [];
      },
    },
  },
  data() {
    return {
                    // 用户列表
      list_user_farmers_merchants: [],
            };
  },
  methods: {
                  /**
     * 获取农户商家用户列表
     */
    async get_list_user_farmers_merchants() {
      var json = await this.$get('/user/get_list', {
        user_group: '农户商家'
      });
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
@import 'styles/components/index.scss';
</style>