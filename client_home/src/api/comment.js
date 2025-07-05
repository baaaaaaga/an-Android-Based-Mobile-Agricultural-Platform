import http from '@/utils/http2';

/**
 * 获取评论列表
 */
export const getCommentListApi = (params) => {
  return http.request({
    url: `/comment/get_list`,
    method: 'GET',
    custom: {},
    params,
  });
};

/**
 * 添加评论
 */
export const addCommentApi = (data) => {
  return http.request({
    url: `/comment/add`,
    method: 'POST',
	header: {
	    'content-type': 'application/json'
	},
    custom: {},
    data,
  });
};

/**
 * 添加评论
 */
export const delCommentApi = (data) => {
  return http.request({
    url: `/comment/del`,
    method: 'get',
    custom: {},
    data,
  });
};
