import http from '@/utils/http2';
// 点赞API

/**
 * 获取点赞
 */
export const getPraiseCountApi = (params = {}) => {
  return http.request({
    url: `/praise/count`,
    method: 'GET',
    custom: {
      isDeduplication: false,
      isLoading: true,
    },
    params,
  });
};

/**
 * 增加点赞
 */
export const addPraiseApi = (data) => {
  return http.request({
    url: `/praise/add`,
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
 * 设置点赞
 */
export const setPraiseApi = (forum_id, data) => {
  return http.request({
    url: `/praise/set?forum_id=${forum_id}`,
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

export const delPraiseApi = (params = {}) => {
  return http.request({
    url: `/praise/del`,
    method: 'GET',
    custom: {
      isDeduplication: false,
      isLoading: true,
    },
    params,
  });
};
