import { RouterMount, createRouter } from 'uni-simple-router';
import store from '../store';
// console.log(ROUTES);
const router = createRouter({
  platform: process.env.VUE_APP_PLATFORM,
  routes: [...ROUTES],
});
//全局路由前置守卫
router.beforeEach((to, from, next) => {
  if (to.meta?.noAuth) {
    if (!store.state.app.token) {
      store.dispatch('auth/getUserAuth').then(() => {
        next();
      });
    } else {
      store
        .dispatch('auth/getUserInfo')
        .then(() => {
          next();
        })
        .catch(() => {
          store.dispatch('auth/logOut');
          next({
            path: '/pagesB/account/login',
          });
        });
    }
  } else {
    if (store.state.app.token) {
      store
        .dispatch('auth/getUserInfo')
        .then(() => {
          next();
        })
        .catch(() => {
          store.dispatch('auth/logOut');
          next({
            path: '/pagesB/account/login',
          });
        });
    } else {
      next({
        path: '/pagesB/account/login',
      });
    }
  }
});
// 全局路由后置守卫
router.afterEach((to, from) => {
  console.log('跳转结束');
});

export { router, RouterMount };
