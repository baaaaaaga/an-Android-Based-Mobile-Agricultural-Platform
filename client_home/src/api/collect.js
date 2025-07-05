import http from '@/utils/http2';
// 收藏API

/**
 * 获取收藏状态
 */
export const getCollectCountApi = (params = {}) => {
  return http.request({
    url: `/collect/count`,
    method: 'GET',
    custom: {
      isDeduplication: false,
      isLoading: true,
    },
    params,
  });
};

/**
 * 加入收藏
 */
export const addCollectApi = (data) => {
  return http.request({
    url: `/collect/add`,
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
 * 取消收藏
 */
export const delCollectApi = (params = {}) => {
  return http.request({
    url: `/collect/del`,
    method: 'GET',
    custom: {
      isDeduplication: false,
      isLoading: true,
    },
    params,
  });
};
