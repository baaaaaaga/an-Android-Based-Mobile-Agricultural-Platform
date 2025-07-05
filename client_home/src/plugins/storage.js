export default {
  get(key) {
    var value;
    try {
      value = uni.getStorageSync(key);
    } catch (e) {
      console.log('读取失败！');
    }
    return value;
  },
  set(key, value) {
    try {
      uni.setStorageSync(key, value);
    } catch (e) {
      console.log('保存失败！');
      value = null;
    }
    return value;
  },
  del(key) {
    try {
      uni.removeStorageSync(key);
    } catch (e) {
      console.log('读取失败！');
    }
  },
};
