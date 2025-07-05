import http from '@/utils/http2';

/**
 * 获取商品信息
 */
export const getGoodsInfoApi = (goods_id) => {
  const params = {
    goods_id,
  };
  return http.request({
    url: `/goods/get_obj`,
    method: 'GET',
    custom: {
      isDeduplication: false,
      isLoading: true,
    },
    params,
  });
};
/**
 * 修改商品
 */
export const setGoodsApi = (goods_id, data) => {
  return http.request({
    url: `/goods/set?goods_id=${goods_id}`,
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
