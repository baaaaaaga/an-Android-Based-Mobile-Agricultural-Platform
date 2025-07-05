const toast = (text) => {
  uni.showToast({
    title: text,
    icon: 'none',
    duration: 2000,
  });
};

export default toast;
