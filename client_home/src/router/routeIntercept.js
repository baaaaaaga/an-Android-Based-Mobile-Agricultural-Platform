/*
 * @Description: routeIntercept
 * @Version: v1.0
 * @Author: LANI
 * @Date: 2024-01-27 13:01
 */
let needLogin = ['/pages/sys/login/index', '/pages/sys/workbench/index'];
let list = ['navigateTo', 'redirectTo', 'reLaunch', 'switchTab'];
list.forEach((item) => {
  //用遍历的方式分别为,uni.navigateTo,uni.redirectTo,uni.reLaunch,uni.switchTab这4个路由方法添加拦截器
  console.log(item, 'router list item');
  uni.addInterceptor(item, {
    invoke(e) {
      // 调用前拦截
      //获取用户的token
      console.log(e, '|-调用前拦截,routerjs invoke');
      const token = localStorage.getItem('token');
      //获取当前页面路径（即url去掉"?"和"?"后的参数）
      console.log(token, '|-调用前拦截,如果token为空就拦截，不允许访问router index token');
      const url = e.url.split('?')[0];
      console.log(url, '|-调用前拦截,router index url');
      console.log(needLogin.includes(url));
      if (needLogin.includes(url) && token == '') {
        uni.showToast({
          title: '请先登录',
          icon: 'none',
        });
        uni.navigateTo({
          url: '/pages/login/login',
        });
        return false;
      }

      return true;
    },
    fail(err) {
      // 失败回调拦截
      console.log(err);
    },
  });
});
