<template>
  <view class="diy_details diy_div_agricultural_products">
    <view v-if="Object.keys(obj).length !== 0" class="warp">
      <view class="container">
        <view class="row">
          <view v-if="$check_field('get', 'product_specifications')" class="col-12 col-md-6">
            <view class="diy_title">
              <span>产品规格:</span>
            </view>
              <view class="diy_field diy_text">
              <text>
                {{obj["product_specifications"]}}
              </text>
            </view>
            </view>
          <view v-if="$check_field('get', 'farmers_merchants')" class="col-12 col-md-6">
            <view class="diy_title">
              <span>农户商家:</span>
            </view>
              <view class="diy_field diy_uid">
              <text>
                {{ get_user_farmers_merchants(obj['farmers_merchants']) }}
              </text>
            </view>
            </view>
          <view v-if="$check_field('get', 'business_name')" class="col-12 col-md-6">
            <view class="diy_title">
              <span>商家名称:</span>
            </view>
              <view class="diy_field diy_text">
              <text>
                {{obj["business_name"]}}
              </text>
            </view>
            </view>
          <view v-if="$check_field('get', 'contact_number')" class="col-12 col-md-6">
            <view class="diy_title">
              <span>联系号码:</span>
            </view>
              <view class="diy_field diy_phone">
              <text>
                {{ obj['contact_number'] }}
              </text>
            </view>
            </view>
          <view v-if="$check_field('get', 'business_address')" class="col-12 col-md-6">
            <view class="diy_title">
              <span>商家地址:</span>
            </view>
              <view class="diy_field diy_text">
              <text>
                {{obj["business_address"]}}
              </text>
            </view>
            </view>
        </view>
      </view>
    </view>
  </view>
</template>

<script>
import mixin from '@/libs/mixins/page.js';
export default {
  mixins: [mixin],
  props: {
    obj_goods: {
      type: Object,
      default() {
        return {};
      },
    },
    query: {
      type: Object,
      default() {
        return {
          agricultural_products_id: 0,
        };
      },
    },
  },
  data() {
    return {
      obj_goods_type: {},
      obj: {},
          // 用户列表
      list_user_farmers_merchants: [],
            };
  },
  methods: {
    async get_obj_goods_type() {
      var res = await this.$get('/goods_type/get_obj', {
        name: this.obj_goods.type,
      });

      if (res.result.obj) {
        this.obj_goods_type = res.result.obj;
      } else {
        console.log('没有请求到商品分类');
      }
    },
    async get_obj_by_goods() {
      var { source_table, source_field } = this.obj_goods_type;
      var { source_id } = this.obj_goods;
      var query = {};
      query[source_field] = source_id;
      this.$get('/' + source_table + '/get_obj', {}, (res) => {
        if (res.result.obj) {
          this.obj = res.result.obj;
        } else {
          console.log('没有请求到商品分类');
        }
      });
    },
    async get_obj_by_id() {
      var res = await this.$get('/agricultural_products/get_obj', {
        agricultural_products_id: this.query.agricultural_products_id,
      });

      if (res.result && res.result.obj) {
        this.obj = res.result.obj;
      } else {
        console.log('没有请求到商品分类');
      }
    },
            /**
         * 获取农户商家用户列表
         */
        async get_list_user_farmers_merchants() {
          var json = await this.$get('/user/get_list?user_group=农户商家');
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
  async onLoad() {
    if (Object.keys(this.obj_goods).length !== 0) {
      await this.get_obj_goods_type();
      await this.get_obj_by_goods();
    } else if (this.query['agricultural_products_id'] !== 0) {
      await this.get_obj_by_id();
    }
  },
};
</script>
<style lang="scss" scoped>
  @import 'styles/components/index.scss';
</style>