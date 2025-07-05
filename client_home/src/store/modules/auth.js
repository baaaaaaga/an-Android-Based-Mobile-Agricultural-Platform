import { getUserAuthApi, getUserInfoApi } from '@/api/login';
export default {
  namespaced: true,
  state() {
    return {};
  },
  mutations: {},
  actions: {
    async getUserAuth({ commit }) {
      return new Promise((resolve, reject) => {
        getUserAuthApi()
          .then(async (res) => {
            let userAuth = res.result.list;
            commit('app/setUniVuex', { name: 'userAuth', value: userAuth }, { root: true });
            resolve(userAuth);
          })
          .catch((err) => {
            reject(err);
          });
      });
    },
    // 获取用户信息及权限
    async getUserInfo({ commit }) {
      return new Promise((resolve, reject) => {
        getUserInfoApi()
          .then(async (res) => {
            let userInfo = res.result.obj || res.result;
            const authRes = await getUserAuthApi(userInfo.user_group);
            const userAuth = authRes.result.list;
            userInfo['user_auth'] = userAuth;
            commit('app/setUniVuex', { name: 'userInfo', value: userInfo }, { root: true });
            commit('app/setUniVuex', { name: 'userAuth', value: userAuth }, { root: true });
            resolve(userInfo);
          })
          .catch((err) => {
            reject(err);
          });
      });
    },
    async logOut({ commit }) {
      return new Promise((resolve) => {
        // 调用接口 暂无
        commit('app/setUniVuex', { name: 'token', value: '' }, { root: true });
        commit('app/setUniVuex', { name: 'userInfo', value: {} }, { root: true });
        commit('app/setUniVuex', { name: 'userGroup', value: '' }, { root: true });
        commit('app/setUniVuex', { name: 'userAuth', value: [] }, { root: true });
        resolve(true);
      });
    },
  },
};
