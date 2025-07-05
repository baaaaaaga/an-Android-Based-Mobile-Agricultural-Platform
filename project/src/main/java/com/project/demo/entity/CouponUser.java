package com.project.demo.entity;


import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.*;

import java.io.Serializable;
import java.sql.Timestamp;


/**
 * (coupon_user)表实体类
 *
 * @author xxx
 *@since 202X-XX-XX
 */
@TableName("coupon_user")
@Data
@EqualsAndHashCode(callSuper = false)
public class CouponUser implements Serializable {

    private static final long serialVersionUID = 552913649360581186L;

    /**
     * id
     */
    @TableId(value = "id", type = IdType.AUTO)
    private Integer id;

    /**
     * 用户id
     */
    @TableField(value = "user_id")
    private Integer user_id;

    /**
     * 优惠券id
     */
    @TableField(value = "coupon_id")
    private Integer coupon_id;

    /**
     * 是否使用
     */
    @TableField(value = "is_use")
    private Integer is_use;
	
	/**
	 * 优惠券用户id
	 */
	@TableField(value = "coupon_user_id")
	private Integer coupon_user_id;

}

