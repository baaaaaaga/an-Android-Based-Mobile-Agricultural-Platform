import tabbar from '@/libs/mixins/tabbar';

export default {
  namespaced: true,
  state() {
    return {
      tabbarList: [],
      tabbarIndex: 0,
    };
  },
  mutations: {
    SET_TABBAR_INDEX(state, data) {
      state.tabbarIndex = data;
    },
  },
  actions: {
    setTabbarIndex({ commit }, data) {
      commit('SET_TABBAR_INDEX', data);
    },
  },
};
