import http from '@/utils/http2';
// 文章API

/**
 * 获取文章列表
 */
export const getArticleListApi = (params = {}) => {
  return http.request({
    url: `/article/get_list`,
    method: 'GET',
    custom: {
      isDeduplication: false,
      isLoading: true,
    },
    params,
  });
};
/**
 * 获取文章类型列表
 */
export const getArticleTypeListApi = (params = {}) => {
  return http.request({
    url: `/article_type/get_list`,
    method: 'GET',
    custom: {
      isDeduplication: false,
      isLoading: true,
    },
    params,
  });
};

/**
 * 修改文章
 */
export const setArticleApi = (article_id, data) => {
  return http.request({
    url: `/article/set?article_id=${article_id}`,
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
