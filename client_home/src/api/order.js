import http from '@/utils/http2';

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
 * 获取订单列表
 */
export const getOrderListApi = (params = {}) => {
  return http.request({
    url: `/order/get_list`,
    method: 'GET',
    custom: {
      isDeduplication: false,
      isLoading: false,
    },
    params,
  });
};
