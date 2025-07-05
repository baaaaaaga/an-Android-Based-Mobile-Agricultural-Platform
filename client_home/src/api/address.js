import http from '@/utils/http2';

/**
 * 获取用户收货地址
 */
export const getUserAddressApi = (params) => {
  return http.request({
    url: `/address/get_obj`,
    method: 'GET',
    custom: {
      isLoading: true,
    },
    params,
  });
};

/**
 * 获取用户收货地址列表
 */
export const getUserAddressListApi = (params) => {
  return http.request({
    url: `/address/get_list`,
    method: 'GET',
    custom: {
      isDeduplication: false,
      isLoading: true,
    },
    params,
  });
};

/**
 * 删除用户收货地址
 */
export const deleteUserAddressApi = (params) => {
  return http.request({
    url: `/address/del`,
    method: 'GET',
    custom: {
      isDeduplication: false,
      isLoading: false,
    },
    params,
  });
};

/**
 * 修改用户收货地址
 */
export const setUserAddressApi = (params, data) => {
  return http.request({
    url: `/address/set`,
    method: 'POST',
	header: {
	    'content-type': 'application/json'
	},
    custom: {
      isDeduplication: false,
      isLoading: false,
    },
    params,
    data,
  });
};
