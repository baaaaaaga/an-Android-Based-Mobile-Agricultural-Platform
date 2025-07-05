<template>
  <view style="color: red;">
    <text v-if="timeLeft >= 0">{{ formattedCountdown }}</text>
    <text v-else>00:00:00</text>
  </view>
</template>

<script>
export default {
  props: {
    deadline: {
      type: String,
      required: true
    },
    orderList: {
      type: Array,
      default: []
    },
    maxTime: {
      type: Number,
      default: 24
    },
  },
  data() {
    return {
      timer: null,
      timeLeft: null
    };
  },
  computed: {
    formattedCountdown() {
      const hours = Math.floor(this.timeLeft / 1000 / 60 / 60).toString().padStart(2, '0');
      const minutes = Math.floor(this.timeLeft / 1000 / 60 % 60).toString().padStart(2, '0');
      const seconds = Math.floor(this.timeLeft / 1000 % 60).toString().padStart(2, '0');
      return `${hours}:${minutes}:${seconds}`;
    }
  },
  methods: {
    updateCountdown() {
      const now = new Date();
      const orderTime = new Date(this.deadline);
      const end = new Date(orderTime.getTime() + this.maxTime * 60 * 60 * 1000);  // 加24小时
      this.timeLeft = end - now;
      if (this.timeLeft <= 0) {
        clearInterval(this.timer);
        // 倒计时结束的时候，还没拼团成功，则取消订单，并改状态，拼团失败
        this.cancelOrder();

      }
    },
    cancelOrder() {
      this.orderList.forEach(order => {
        try {
		      const self = this;
          this.$post(
            "~/api/order/set?order_number=" + order.order_number,
            {
              state: "已取消",
              group_status: "拼团失败"
            },
            (res) => {
              console.log(order.order_number, '，订单已取消');
			        self.$emit('refresh');
            }
          );
        } catch (error) {
          this.$toast(order.order_number + '， 订单取消失败！', 'error');
        }
      })
    },
  },
  mounted() {
    this.updateCountdown();
    this.timer = setInterval(this.updateCountdown, 1000);
  },
  beforeDestroy() {
    clearInterval(this.timer);
  }
};
</script>