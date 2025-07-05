import http from '@/utils/http2';

/**
 * 获取购物车列表
 */
export const getCartListApi = (params) => {
  return http.request({
    url: `/cart/get_list`,
    method: 'GET',
    custom: {
      isDeduplication: false,
      isLoading: true,
    },
    params,
  });
};

/**
 * 设置购物车商品数量
 */
export const setCartApi = (cart_id, data) => {
  return http.request({
    url: `/cart/set?cart_id=${cart_id}`,
    method: 'POST',
	header: {
	    'content-type': 'application/json'
	},
    custom: {
      isDeduplication: false,
      isLoading: true,
    },
    data,
  });
};

/**
 * 设置删除购物车商品
 */
export const deleteCartGoodsNumberApi = (cart_id) => {
  const params = {
    cart_id,
  };
  return http.request({
    url: `/cart/del`,
    method: 'GET',
    custom: {
      isDeduplication: false,
      isLoading: true,
    },
    params,
  });
};

/**
 * 加入购物车
 */
export const addCartApi = (data) => {
  return http.request({
    url: `/cart/add`,
    method: 'POST',
	header: {
	    'content-type': 'application/json'
	},
    custom: {
      isDeduplication: false,
      isLoading: true,
    },
    data,
  });
};

/**
 * 创建订单
 */
export const createOrderApi = (data) => {
  return http.request({
    url: `/order/add`,
    method: 'POST',
	header: {
	    'content-type': 'application/json'
	},
    custom: {
      isDeduplication: false,
      isLoading: true,
    },
    data,
  });
};

/**
 * 删除购物车全部商品
 */
export const deleteCartApi = (cart_id) => {
  const params = {
    cart_id,
  };
  return http.request({
    url: `/cart/del`,
    method: 'GET',
    custom: {
      isDeduplication: false,
      isLoading: true,
    },
    params,
  });
};
