import Request from 'luch-request';
import store from '@/store';
import Qs from 'qs';
const baseUrl = process.env.VUE_APP_BASE_HOST + process.env.VUE_APP_BASE_API;
const http = new Request({
  baseURL: baseUrl,
  timeout: 8000,
  header: {
    'content-type': 'application/json;charset=UTF-8',
  },
  paramsSerializer: (params) => {
    for (const key in params) {
      if (params[key] === null || params[key] === undefined || params[key] === '') {
        delete params[key];
      }
    }
    return Qs.stringify(params);
  },
});
let loadingCount = 0;
let queue = {}; // 请求队列,防止重复点击
//请求拦截器
http.interceptors.request.use(
  (config) => {
    // 可使用async await 做异步操作
    const custom = config.custom;
    let reqUniqueKey = '';
    if (custom.isDeduplication) {
      let paramsStr = '';
      if (config.method === 'GET') {
        paramsStr = JSON.stringify(config.params || {});
      } else {
        paramsStr = JSON.stringify(config.data || {});
      }
      // 确定唯一性(路由+接口地址+请求方式)
      reqUniqueKey = `${config.method}${config.url}${paramsStr}`.toLocaleUpperCase();
      custom['reqUniqueKey'] = reqUniqueKey;
      if (queue[reqUniqueKey]) {
        // throw 'EXCEPTION:REPEATCLICK';
        throw {
          config: {
            custom: {
              reqUniqueKey,
            },
          },
          statusCode: 900,
          errMsg: '正在处理中，请勿重复操作',
        };
      } else {
        queue[reqUniqueKey] = reqUniqueKey;
      }
    }
    if (custom.isLoading) {
      loadingCount++;
      let title = '加载中...';
      if (custom.loadingText) {
        title = custom.loadingText;
      }
      uni.showLoading({
        title: title,
      });
    }

    // if (custom.isCancelReq) {
    //     // config.cancelToken = new axios.CancelToken((cancel: Canceler) => {
    //     //     const queueStore = useQueueStore();
    //     //     queueStore.updateQueue(cancel);
    //     // });
    // }
    custom['requestTime'] = new Date().getTime();

    if (!custom.noAuth) {
      const token = store.state.app.token;
      if (token) {
        config.header['X-Auth-Token'] = token;
      }
    }

    return config;
  },
  (error) => {
    return Promise.resolve(error);
  }
);

http.interceptors.response.use(
  (response) => {
    const config = response.config;
    const custom = config.custom;
    if (custom.isDeduplication) {
      delete queue[custom.reqUniqueKey];
    }
    const requestTime = custom.requestTime;
    const requestDuration = ((new Date().getTime() - requestTime) / 1000).toFixed(2);
    if (custom.isLoading) {
      loadingCount--;
      if (loadingCount === 0) {
        if (Number(requestDuration) < 3) {
          setTimeout(() => {
            uni.hideLoading();
          }, 500);
        } else {
          uni.hideLoading();
        }
      }
    }

    if (response.statusCode === 200) {
      if (response.data.result) {
        return response.data;
      } else if (response.data.error) {
        if (Number(requestDuration) < 3 && custom.isToast) {
          setTimeout(() => {
            uni.showToast({
              title: response.data.error.message,
              duration: 3000,
              icon: 'none',
            });
          }, 1000);
        }
      }
      return Promise.reject(response.data);
    }
  },
  (error) => {
    const config = error.config;
    const custom = config.custom;
    if (custom.isDeduplication) {
      delete queue[custom.reqUniqueKey];
    }
    loadingCount = 0;
    uni.hideLoading();

    //未登录时清空缓存跳转
    if (error.errMsg === 'request:fail') {
      uni.showToast({
        title: '请求失败,请稍后重试！',
        duration: 3000,
        icon: 'none',
      });
    }

    if (error.errMsg === 'request:fail timeout') {
      uni.showToast({
        title: '请求超时,请稍后重试！',
        duration: 3000,
        icon: 'none',
      });
    }

    delete queue[custom.reqUniqueKey];
    return Promise.reject(error);
  }
);

// /**
//  * @description: get 请求方法
//  * @param {string} url 请求地址
//  * @param {Params} params 请求参数
//  * @return {*}
//  */
// export const GET = async (url, params, custom) => {
//   return http.request({
//     url: url,
//     method: 'GET',
//     custom: {
//       isDeduplication: false,
//       isLoading: true,
//     },
//     params,
//   });
// };
// /**
//  * @description: post请求方法
//  * @param {any} url
//  * @param {any} params
//  * @return {any}
//  */
// export const POST = async (url, params) => {
//   return http.request({
//     url: url,
//     method: 'GET',
//     custom: {
//       isDeduplication: false,
//       isLoading: true,
//     },
//     params,
//   });
// }

export default {
  http,
};
