package com.project.demo.dao;

import com.project.demo.dao.base.BaseMapper;
import com.project.demo.entity.CouponUser;
import org.apache.ibatis.annotations.Mapper;


/**
 * 用户优惠券：Mapper接口
 *
 */
@Mapper
public interface CouponUserMapper extends BaseMapper<CouponUser>
{
}
