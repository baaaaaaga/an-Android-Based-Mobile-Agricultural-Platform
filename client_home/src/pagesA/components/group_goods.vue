<template>
  <view class="group_goods" v-if="groupOrder.length">
    <view class="header">参与团购</view>
    <view class="goods-main">
      <view v-for="item in groupOrder" :key="item.group_order_number">
        <view class="img_box">
          <!-- 拼团中的头像和昵称才显示 -->
          <view class="left-view">
            <view class="img_view_avatar ellipsis">
              <img v-for="o in item" :key="'id' + o.order_number" class="icon"
                :src="$fullUrl(o.avatar) || '@/static/img/avatar.jpg'" />
            </view>
            <view class="nickname_and_timer">
              <view class="img_view_nickname ellipsis">
                {{ showNickname(item) }}
              </view>
              <countdownTimer :deadline="item[0].order_time" :orderList="item" :maxTime="maxTime" @refresh="refresh"/>
            </view>
          </view>
          <!-- 团购人数满了隐藏按钮 -->
          <view class="right-view">
            <view class="order_btn_div">
              <button class="order_btn me-btn" @click="add_order(item[0], 'group_buy')"
                :disabled="!showBtn(item)">参与团购</button>
            </view>
          </view>
        </view>
      </view>
    </view>
  </view>
</template>

<script>
import mixin from '@/libs/mixins/page.js';
import countdownTimer from "@/pagesA/components/countdownTimer.vue";
export default {
  mixins: [mixin],
  props: {
    objA: {
      type: Object,
      default: () => ({}),
    },
  },
  components: {
    countdownTimer,
  },
  data() {
    return {
      userList: [],
      groupOrder: [],
      timerArr: [],
      maxTime: 24, // 配置订单的团购时间，单位：小时，比如半个小时应该写0.5
    };
  },
  created() {
    setTimeout(() => {
      this.get_group_order();
    }, 500);
  },
  methods: {
	// 刷新组件
	  refresh(){
		  this.get_group_order();
	  },
    // 显示昵称
    showNickname(info) {
      const arr = info.map((item) => item.nickname) || [];
      return arr.join("、");
    },
    // 判断是否显示按钮
    showBtn(info) {
      var user_id = this.userInfo.user_id;
      console.log('.user.user_id', this.userInfo.user_id)
      const isUser = info.some((item) => item.user_id === user_id);
      return user_id && !isUser && info.length < this.$props.objA.group_people;
    },
    // 获取用户头像和昵称,拼接到订单上
    async get_user_info(item) {
      const json = await this.$get("~/api/user/get_obj?user_id=" + item.user_id);
      return json.result?.obj
        ? {
          ...item,
          avatar: json.result.obj.avatar,
          nickname: json.result.obj.nickname,
        }
        : item;
    },

    // 获取所有拼团中的订单
    async get_group_order() {
      // 第一步，获取所有拼团中的订单
      const order_json = await this.$get("~/api/order/get_list", { goods_id: this.$props.objA.goods_id, state: "已付款", group_status: "拼团中" });
      if (order_json.result?.list) {
        const list = order_json.result.list;
        // 第二步，根据当前订单获取用户头像、昵称信息
        const userPromises = list.map((item) => this.get_user_info(item));
        const users = await Promise.all(userPromises);
        // 第三步，根据团购单号分组
        const grouped = Object.values(
          users.reduce((acc, curr) => {
            acc[curr.group_order_number] = acc[curr.group_order_number] || [];
            acc[curr.group_order_number].push(curr);
            return acc;
          }, {})
        );
        // 第四步，对每个分组找到最早的 create_time，并为每个对象添加 order_time
        const newGroup = Object.values(grouped).map((group) => {
          // 找到该组中最早的 create_time
          const earliestTime = group.reduce((earliest, item) => {
            return !earliest || new Date(item.create_time) < new Date(earliest.create_time) ? item : earliest;
          }, null).create_time;
          return group.map((item) => ({
            ...item,
            order_time: earliestTime,
          }));
        });
        // 第五步，判断拼团状态
        this.groupOrder = this.setGroupOrder(newGroup);
      }
    },
    // 判断，判断是拼团成功、拼团失败，还是拼团中
    setGroupOrder(grouped) {
      let filteredGroup = [];
      grouped.forEach((item) => {
        const now = new Date();
        const orderTime = new Date(item[0].order_time);
        const end = new Date(orderTime.getTime() + this.maxTime * 60 * 60 * 1000); // 加24小时
        const timeLeft = end - now;
        if (timeLeft <= 0) {
          // 超时了，拼团失败
          this.setOrderStatus(item, "拼团失败");
        } else if (item.length >= this.$props.objA.group_people) {
          // 人数够了，拼团成功
          this.setOrderStatus(item, "拼团成功");
        } else {
          // 剩下的，拼团中
          filteredGroup.push(item);
        }
      });
      return filteredGroup;
    },
    // 修改订单状态的请求
    setOrderStatus(orders, group_status) {
      orders.forEach((order) => {
        try {
          let params = { group_status };
          if (group_status === "拼团失败") {
            params.state = "已取消";
          }
          this.$post("~/api/order/set?order_number=" + order.order_number, params, (res) => {
            console.log(order.order_number + ":" + group_status);
          });
        } catch (error) {
          this.$toast(order.order_number + "， 订单状态修改失败！", "error");
        }
      });
    },

    /**
     * 根据当前时间和随机数生成流水号
     */
    order_code() {
      var orderCode = '';
      for (
        var i = 0;
        i < 6;
        i++ //6位随机数，用以加在时间戳后面。
      ) {
        orderCode += Math.floor(Math.random() * 10);
      }
      orderCode = new Date().getTime() + orderCode; //时间戳，用来生成订单号。
      return orderCode;
    },
    /**
     * 添加跳转到订单详情
     * data: 当前团购单
     * buyType: 订单类型
     */
    async add_order(data, buyType = null) {
      //库存不足直接返回
      if (this.$props.objA.inventory < 1) {
        this.$toast('库存不足');
        return;
      }
      var { title, img, price, price_ago, description, goods_id, type, num_buy: num } = this.$props.objA;
      var user_id = this.userInfo.user_id;
      if (buyType === "group_buy") {
        // 如果是团购的，走团购价
        price = this.$props.objA.group_price || price;
      }
      //获取用户地址数据
      var address_promise = new Promise((resolve, reject) => {
        this.$get(
          '~/api/address/get_obj',
          {
            user_id,
            default: 1,
          },
          (res) => {
            if (res.result && res.result.obj) {
              resolve(res.result.obj);
            } else {
              this.$toast('地址未添加');
              return;
            }
          }
        );
      }).catch((e) => { });
      var {
        name: contact_name,
        phone: contact_phone,
        address: contact_address,
        postcode: postal_code,
      } = await address_promise;
      let price_count = price;
      if (this.vip_discount > 0) {
        price_count = price_count * this.vip_discount;
      }
      // 生成订单号
      var order_number = this.order_code();
      var body = {
        order_number,
        goods_id,
        title,
        type,
        img,
        price,
        price_ago: price_ago,
        price_count: price_count,
        num: 1,
        contact_name,
        contact_phone,
        contact_address,
        postal_code,
        user_id,
        description,
        merchant_id: this.obj.user_id,
      };
      if (buyType === "group_buy" && data.group_order_number) {
        body.group_order_number = data.group_order_number;
        body.group_status = "拼团未支付";
      }
      this.$post('~/api/order/add?', body, (res) => {
        this.$toast('加入订单成功');
        this.$nav(`/pagesA/order/details?order_number=${order_number}&group_order_number=${body.group_order_number}`);
      });
    },
  },
  beforeDestroy() {
    this.timerArr.forEach((item) => {
      clearInterval(item); // 防止内存泄露
    });
  },
};
</script>
<style scoped>
.group_goods {
  width: 100%;
  height: 100%;
  padding: 0 30rpx;
}

.header {
  padding-top: 20rpx;
  font-weight: bold;
}

.goods-main {
  padding: 20rpx 0;
}

.ellipsis {
  white-space: nowrap;
  overflow: hidden;
  text-overflow: ellipsis;
  width: 240rpx;
}

.img_box {
  display: flex;
  align-items: center;
  justify-content: space-between;
  height: 80rpx;
}

.left-view {
  flex: 1;
  overflow: hidden;
  display: flex;
  align-items: center;
}

.right-view {
  display: flex;
  align-items: center;
}


.img_view_avatar {
  padding-left: 20rpx;
  width: 240rpx;
}

.icon {
  width: 60rpx;
  height: 60rpx;
  border-radius: 50%;
  margin-left: -20rpx !important;
  border: 1px solid;
}

.nickname_and_timer {
  margin-left: 10rpx;
  font-size: 14px;
}

.img_view_nickname {
  /* margin-left: 20px; */
}

.order_btn {
  width: 160rpx;
  height: 50rpx;
  font-size: 12px;
}
</style>
