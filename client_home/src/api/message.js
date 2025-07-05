import http from '@/utils/http2';

/**
 * 获取在线留言列表列表
 */
export const getMessageListApi = (params) => {
  return http.request({
    url: `/message/get_list`,
    method: 'GET',
    custom: {
      isDeduplication: false,
      isLoading: true,
    },
    params,
  });
};

/**
 * 删除在线留言
 */
export const deleteMessageApi = (params) => {
  return http.request({
    url: `/message/del`,
    method: 'GET',
    custom: {
      isDeduplication: false,
      isLoading: false,
    },
    params,
  });
};

/**
 * 修改在线留言
 */
export const setMessageApi = (params, data) => {
  return http.request({
    url: `/message/set`,
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
