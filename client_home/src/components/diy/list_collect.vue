<template>
  <view class="list_collect">
    <view class="item_collect" v-for="(o, i) in list" :key="i">
      <view @click="navHandle(o)" class="collect_box">
        <view class="left_block">
          <image
            style="width: 3rem; height: 3rem"
            :src="$fullImgUrl(o[vm.img]) || '/static/img/avatar.jpg'"
          ></image>
        </view>
        <view class="right_block">
          <view class="top_comment">
            <view class="title">
              {{ o[vm.title] }}
            </view>
          </view>
        </view>
      </view>
      <view class="me-btn btn_del" @click="del_collect(o[vm.collect_id], i)"> 删除 </view>
      <view class="time">
        {{ $toTime(o[vm.create_time], 'yyyy-MM-dd hh:mm:ss') }}
      </view>
    </view>
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
    vm: {
      type: Object,
      default: function () {
        return {
          img: 'img',
          title: 'title',
          create_time: 'create_time',
          collect_id: 'collect_id',
          source_table: 'source_table',
          source_field: 'source_field',
          source_id: 'source_id',
        };
      },
    },
  },
  methods: {
    del_collect(collect_id, index) {
      this.$get(
        '~/api/collect/del',
        {
          collect_id,
        },
        (res) => {
          this.list.splice(index, 1);
        }
      );
    },
    navHandle(o) {
      let basePath = '/pages/';
      if (o[this.vm.source_table] == 'forum') {
        basePath = '/pagesA/';
      }else if (o[this.vm.source_table] == 'article') {
        basePath = '/pages/';
      }else if (o[this.vm.source_table] == 'goods') {
        basePath = '/pagesA/';
      }else {
        basePath = '/pagesC/';
      }

      this.$navTo(
        basePath +
          o[this.vm.source_table] +
          '/details?' +
          o[this.vm.source_field] +
          '=' +
          o[this.vm.source_id]
      );
    },
  },
};
</script>

<style lang="scss" scoped>
@import 'styles/components/index.scss';
</style>
