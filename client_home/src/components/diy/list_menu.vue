<template>
  <!-- <view class="menu_list">
    <view v-for="(o, i) in list" :key="i" class="item_menu">
      <view @click="$navTo('/pages' + o[vm.url])" class="menu" hover-class="hover">
        <image class="image" src="/static/img/tab_1.png" mode="widthFix"></image>
        <text class="name">{{ o[vm.name] }}</text>
      </view>
    </view>
  </view> -->
  <view class="list_menu">
    <tn-grid :col="gridCol" :align="align">
      <block v-for="(item, index) in list" :key="index" v-if="$check_action(item[vm.url],'get') || item[vm.url] == '/webview/urlview' || item[vm.url] == '/chat/index'">
		<!-- #ifndef MP-WEIXIN -->
		<tn-grid-item class="menu-items">
		  <view @click="clickMore(item[vm.url])" class="menu-item" hover-class="hover">
		    <image class="image" :src="getIconPath(item[vm.url])" mode="widthFix"></image>
		    <text class="name">{{ item[vm.name] }}</text>
		  </view>
		</tn-grid-item>
		<!-- #endif-->
		<!-- #ifdef MP-WEIXIN -->
		<tn-grid-item class="menu-items" :style="{ width: gridItemWidth }">
		  <view @click="clickMore(item[vm.url])" class="menu-item" hover-class="hover">
		    <image class="image" :src="getIconPath(item[vm.url])" mode="widthFix"></image>
		    <text class="name">{{ item[vm.name] }}</text>
		  </view>
		</tn-grid-item>
		<!-- #endif-->
      </block>
    </tn-grid>
  </view>

  <!-- <view class="grid col-3 padding-sm">
    <view class="padding-sm" v-for="(item, index) in list" :key="index">
      <view class="padding radius text-center shadow-blur">
        <view class="text-lg">{{ item.title }}</view>
        <view class="margin-top-sm text-Abc">{{ item[vm.name] }}</view>
      </view>
    </view>
  </view> -->
</template>

<script>
import mixin from '@/libs/mixins/component.js';
export default {
  mixins: [mixin],
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
          name: 'mod_name',
          url: 'path'
        };
      },
    },
  },
  data() {
    return {
      gridCol: 5,
      iconList: {
        '/chat/index': '/static/img/tab_1.png', //在线留言
        '/message/list': '/static/img/tab_4.png', //在线留言
        '/exam_subject/list': '/static/img/tab_2.png', //自动组卷
        '/exam/list': '/static/img/tab_9.png', // 在线考试
        '/evaluation/list': '/static/img/tab_9.png', // 在线考试
        '/webview/urlview': '/static/img/tab_7.png', //天气预报
        '/goods/list': '/static/img/tab_8.png', //商城中心
      },
	  align: "center",
    };
  },
  created() {
    console.log('menu====>', this.list);
  },
  methods: {
    getIconPath(path) {
      console.log(path);
      if (path) {
        const icon = this.iconList[path];
        if (icon) {
          return icon;
        }
      }
      return '/static/img/tab_1.png';
    },
    getFullPath(path) {
      if (path) {
        const fullPath = this.pathList[path];
        console.log('fullPath', fullPath)
        if (fullPath) {
          return fullPath + path;
        } else {
          return '/pagesC' + path;
        }
      }
      return '';
    },
	clickMore(url){
		if(url == "/article/index" || url == "/forum/index"){
			this.$navToTab(this.getFullPath(url))
		}else{
			this.$navTo(this.getFullPath(url))
		}
	}
  },
  computed: {
    // 兼容小程序
    gridItemWidth() {
      return 100 / this.gridCol + '%';
    },
  },
};
</script>

<style lang="scss" scoped>
@import 'styles/components/index.scss';
</style>
