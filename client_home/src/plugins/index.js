import db from './storage';
import http from './http';
import { getBaseImgUrl, toTime, setRichTextImage, toUrl } from './base';
import router from './route';
import queryParams from './func/queryParams';
import deepClone from './func/deepClone';
import deepMerge from './func/deepMerge';
import debounce from './func/debounce';
import throttle from './func/throttle';
// 时间格式化
import timeFormat from './func/timeFormat';
import auth from './auth';
import './sdk.js';
import './expand.js';
import component from './component.js';
const $u = {
  http,
  router,
  queryParams,
  deepClone,
  deepMerge,
  debounce,
  throttle,
  timeFormat,
};
uni.$u = $u;
uni.db = db;
export default {
  install(Vue, options) {
    Vue.prototype.$u = $u;
    Vue.prototype.$auth = auth;
    Vue.use(component, options);
    Vue.filter('timeFormat', (timestamp, format) => {
      return timeFormat(timestamp, format);
    });
  },
};
