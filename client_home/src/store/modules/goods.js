export default {
  namespaced: true,
  state() {
    return {
	  goods: []
    };
  },
  mutations: {
	SET_GOODS(state, data){
		state.goods = data;
	}
  },
  actions: {
    setGoods({ commit }, data) {
      commit('SET_GOODS', data);
    },
  },
};
