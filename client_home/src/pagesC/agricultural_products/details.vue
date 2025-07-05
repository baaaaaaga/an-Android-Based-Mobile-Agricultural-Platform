<template>
  <view id="page_diy_details" class="page_diy_details page_agricultural_products_details" :style="{ paddingTop: vuex_custom_bar_height + 'px', paddingBottom: vuex_safe_area_bottom + 'px',}">
    <tn-nav-bar>农产品</tn-nav-bar>
    <view class="page_diy page_agricultural_products" id="agricultural_products_details">
          
      <view class="warp info-wrapper">
        <view class="container-fluid">
          <view class="row">
              <view v-if="$check_field('get', 'product_specifications')" class="info-item  field_text ">
                <view class="diy_title">
                  <span>产品规格</span>
                </view>
                    <view class="diy_field diy_text">
                  <span>
                      {{ obj["product_specifications"] }}
                  </span>
                </view>
                </view>
                <view v-if="$check_field('get', 'farmers_merchants')" class="info-item  field_text ">
                <view class="diy_title">
                  <span>农户商家</span>
                </view>
                    <view class="diy_field diy_uid">
                  {{ get_user_farmers_merchants(obj['farmers_merchants']) }}
                </view>
                </view>
                <view v-if="$check_field('get', 'business_name')" class="info-item  field_text ">
                <view class="diy_title">
                  <span>商家名称</span>
                </view>
                    <view class="diy_field diy_text">
                  <span>
                      {{ obj["business_name"] }}
                  </span>
                </view>
                </view>
                <view v-if="$check_field('get', 'contact_number')" class="info-item  field_text ">
                <view class="diy_title">
                  <span>联系号码</span>
                </view>
                    <view class="diy_field diy_phone">
                  <span>
                      {{ obj['contact_number'] }}
                  </span>
                </view>
                </view>
                <view v-if="$check_field('get', 'business_address')" class="info-item  field_text ">
                <view class="diy_title">
                  <span>商家地址</span>
                </view>
                    <view class="diy_field diy_text">
                  <span>
                      {{ obj["business_address"] }}
                  </span>
                </view>
                </view>
            </view>
        </view>
        <view class="row count">
  
  
              <view class="hits view">
              <span>点击数</span>
              <span>{{ obj["hits"] }}</span>
            </view>
          </view>
      </view>

	<view class="kb-row">


	</view>


      <!-- 评论区列表 -->
      <view class="comment-title">评论区</view>
      <list_comment :list="list_comment" @refresh="get_comment"></list_comment>

      <view :style="'height: 100rpx'"></view>
      <view class="footer" :style="{ paddingBottom: vuex_safe_area_bottom + 'px' }">
        <view class="footer-wrap">
              <view class="go-comment" @click="goComment('/pagesB/comment/edit?source_table=agricultural_products&source_field=agricultural_products_id&source_id=' + obj['agricultural_products_id'])">
            评论点什么...
          </view>
    
              <view class="more">
        
                    <view class="more-item collect" @click="change_collect()">
              <text :class="{iconfont: true, 'icon-collect': true, 'iconfont--active': state_collect,}"></text>
              <text>收藏</text>
            </view>
        
                  </view>
            </view>
      </view>


    </view>
  </view>
</template>

<script>
  import list_comment from '@/components/diy/list_comment.vue';
  import mixin from '@/libs/mixins/page.js';

  export default {
    mixins: [mixin],
    components: {
      list_comment
    },
    data() {
      return {
        url_get_obj: '~/api/agricultural_products/get_obj?',
        field: 'agricultural_products_id',
        query: {
                agricultural_products_id: 0,
        },
        // 商品详情初始化
        obj: {
          agricultural_products_id: 0,
              product_specifications: "",
                  farmers_merchants: 0,
                  business_name: "",
                  contact_number: "",
                  business_address: "",
              hits: 0,
          collect_len: 0,
        },
        // 收藏
        collect: 0,
        // 收藏状态
        state_collect: false,
        // 评论列表初始化
        list_comment: [],
            // 用户列表
        list_user_farmers_merchants: [],
              };
    },
    methods: {
      goComment(path) {
        if (this.$check_action('/comment/list', 'add')) {
          this.$navTo(path);
        } else {
          this.$toast('暂无权限');
        }
      },
      openUrl(url) {
        uni.navigateTo({
          url: `/pages/webview/webview?url=${url}`,
        });
      },
      /**
       * 初始化收藏状态
       * @param {Object} obj
       */
      get_collect(obj) {
        var user_id = this.user.user_id;

        var query = {
          source_table: 'agricultural_products',
          source_field: 'agricultural_products_id',
          source_id: obj['agricultural_products_id'],
          user_id,
        };

        this.$get('~/api/collect/count', query, (res) => {
          if (res.result || res.result === 0) {
            var bl = res.result ? true : false;
            this.state_collect = bl;
            console.log('收藏状态：' + bl);
          } else if (res.error) {
            console.error(res.error);
          }
        });
      },

      /**
       * 改变收藏状态
       */
      change_collect() {
        if (!this.$check_action('/collect/list', 'add')) {
          this.$toast('暂无权限');
          return;
        }
        var user_id = this.user.user_id;

        var query = {
          source_table: 'agricultural_products',
          source_field: 'agricultural_products_id',
          source_id: this.obj['agricultural_products_id'],
          user_id,
        };

        // 收藏状态
		var _this = this;
        if (this.state_collect) {
          this.state_collect = false;
          this.$get('~/api/collect/del', query, (res) => {
            if (res.result) {
			  var collect_len = _this.obj.collect_len - 1;
			  this.$post('~/api/agricultural_products/set?agricultural_products_id=' + _this.obj['agricultural_products_id'],
			      {collect_len},(res) => {
			        if (res.result) {
			          _this.obj.collect_len = collect_len;
			          console.log('添加收藏数状态：', res.result);
			        } else if (res.error) {
			          console.error(res.error);
			        }
			      }
			  );
              this.$toast('取消收藏');
            } else if (res.error) {
              this.$toast(res.error.message);
              console.error(res.error);
            }
          });
        } else {
          this.state_collect = true;
                                                  this.$post('~/api/collect/add?', query, (res) => {
            if (res.result) {
			  var collect_len = _this.obj.collect_len + 1;
			  this.$post('~/api/agricultural_products/set?agricultural_products_id=' + _this.obj['agricultural_products_id'],
			      {collect_len},(res) => {
			        if (res.result) {
			          _this.obj.collect_len = collect_len;
			          console.log('添加收藏数状态：', res.result);
			        } else if (res.error) {
			          console.error(res.error);
			        }
			      }
			  );
              this.$toast('收藏成功');
            } else if (res.error) {
              this.$toast(res.error.message);
              console.error(res.error);
            }
          });
        }
      },
      /**
       * 获取评论
       * @param {Object} obj
       */
      get_comment(obj) {
		if(obj == undefined){
			obj = this.obj
		}
        var query = {
          source_table: 'agricultural_products',
          source_field: 'agricultural_products_id',
          source_id: obj['agricultural_products_id'],
          orderby: 'create_time desc',
          reply_to_id: '0',
        };
        this.$get('/comment/get_list', query, (json) => {
          if (json.result) {
            var list_comment = json.result.list;
            list_comment.map((o) => {
              o.list_reply = [];
            });
            this.add_reply(obj, list_comment).then((list) => {
              this.list_comment = list;
            });
          }
        });
      },
      /**
       * @param { Array } list 评论列表
       * 添加回复到评论列表
       */
      add_reply(obj, list) {
        return new Promise((resolve) => {
          for (let idx = 0; idx < list.length; idx++) {
            const obj = list[idx];
            this.$get('/comment/get_list',
                {
                  source_table: 'agricultural_products',
                  source_field: 'agricultural_products_id',
                  source_id: obj['agricultural_products_id'],
                  orderby: 'create_time desc',
                  reply_to_id: obj.comment_id,
                },
                (res) => {
                  if (res.result) {
                    obj.list_reply = res.result.list;
                  }
                }
            );
          }
          resolve(list);
        }).catch((e) => {
        });
      },
      /**
       * 添加访问量
       */
      add_hits(obj) {
        obj['hits'] = obj['hits'] + 1;
        var hits = obj['hits'];
        this.$post(
            '~/api/agricultural_products/set?agricultural_products_id=' + obj['agricultural_products_id'],
            {
              hits,
            },
            (res) => {
              if (res.result) {
                console.log('添加访问量状态：', res.result);
                var body = {
                  source_table: 'agricultural_products',
                  source_field: 'agricultural_products_id',
                  source_id: this.obj.agricultural_products_id,
                  user_id: this.userInfo.user_id,
                };
                this.$post('~/api/hits/add?', body, (res) => {
                  console.log(res);
                });
              } else if (res.error) {
                console.error(res.error);
              }
            }
        );
      },
      /**
       * 获取对象之后
       * @param {Object} json 结果对象
       */
      get_obj_after(json) {
        // 判断是否获取到数据
        if (this.obj) {
          var obj = this.obj;
          // 初始化收藏状态
          this.get_collect(obj);
          // 获取评论
          this.get_comment(obj);
          // 增加点击数
          this.add_hits(obj);
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
              this.get_list_user_farmers_merchants();
                    },
    onShow() {
        
    },
  };
</script>

<style lang="scss" scoped>
  @import 'styles/pagesC/index.scss';
</style>