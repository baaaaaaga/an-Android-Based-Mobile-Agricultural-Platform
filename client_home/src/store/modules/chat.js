export default {
  namespaced: true,
  state() {
    return {
      friendList: [],
      groupList: [],
      mergeList: [],
      currentChatObj: null,
      websocket: null,
      recordList: [],
      groupChatUser: [],
    };
  },

  mutations: {
    set_friendList(state, obj) {
      state.friendList = obj;
    },
    set_groupList(state, obj) {
      state.groupList = obj;
    },
    set_mergeList(state, obj) {
      state.mergeList = obj;
    },
    set_currentChatObj(state, obj) {
      state.currentChatObj = obj;
    },
    set_websocket(state, obj) {
      state.websocket = obj;
    },
    set_recordList(state, obj) {
      state.recordList = obj;
    },
    set_groupChatUser(state, obj) {
      state.groupChatUser = obj;
    },
  },

  actions: {},
};
