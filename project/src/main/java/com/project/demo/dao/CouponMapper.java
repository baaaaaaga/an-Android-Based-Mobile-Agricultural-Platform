package com.project.demo.dao;

import com.project.demo.dao.base.BaseMapper;
import com.project.demo.entity.Coupon;
import org.apache.ibatis.annotations.Mapper;

/**
 * 优惠券：Mapper接口
 *
 */
@Mapper
public interface CouponMapper extends BaseMapper<Coupon>
{
}
