import http from '@/utils/http2';

/**
 * 获取用户信息
 */
export const getUserInfoApi = (user_id) => {
  const params = {
    user_id,
  };
  return http.request({
    url: `/user/get_obj`,
    method: 'GET',
    custom: {
      isDeduplication: false,
      isLoading: true,
    },
    params,
  });
};

/**
 * 修改密码
 */
export const changePasswordApi = (data) => {
  return http.request({
    url: `/user/change_password`,
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
