import Vue from 'vue';
import App from './App';
import store from './store';
import './filters';
import plugins from './plugins'; // plugins
import { router, RouterMount } from './router/index';
import TuniaoUI from 'tuniao-ui';
// import './router/routeIntercept.js';

Vue.config.productionTip = false;
App.mpType = 'app';

Vue.use(router);
// vuex简写方法
let vuexStore = require('@/store/$u.mixin.js');
Vue.use(plugins);
Vue.use(TuniaoUI);
Vue.mixin(vuexStore);

const app = new Vue({
  store,
  ...App,
});
//v1.3.5起 H5端 你应该去除原有的app.$mount();使用路由自带的渲染方式
// #ifdef H5
RouterMount(app, router, '#app');
// #endif

// #ifndef H5
app.$mount(); //为了兼容小程序及app端必须这样写才有效果
// #endif
