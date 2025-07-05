import http from '@/utils/http2';
// 交流论坛API

/**
 * 获取帖子列表
 */
export const getForumListApi = (params = {}) => {
  return http.request({
    url: `/forum_type/get_list`,
    method: 'GET',
    custom: {
      isDeduplication: false,
      isLoading: true,
    },
    params,
  });
};

/**
 * 修改帖子
 */
export const setForumApi = (forum_id, data) => {
  return http.request({
    url: `/forum/set?forum_id=${forum_id}`,
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
