package com.project.demo.entity;


import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.*;

import java.io.Serializable;
import java.sql.Timestamp;


/**
 * (coupon)表实体类
 *
 * @author xxx
 *@since 202X-XX-XX
 */
@TableName("coupon")
@Data
@EqualsAndHashCode(callSuper = false)
public class Coupon implements Serializable {

    private static final long serialVersionUID = 552913649360581184L;

    /**
     * 优惠券id
     */
    @TableId(value = "coupon_id", type = IdType.AUTO)
    private Integer coupon_id;

    /**
     * 优惠券用户id
     */
    @TableField(value = "coupon_user_id")
    private Integer coupon_user_id;

    /**
     * 优惠券用户
     */
    @TableField(value = "coupon_user_auth")
    private String coupon_user_auth;

    /**
     * 优惠券名称
     */
    @TableField(value = "coupon_name")
    private String coupon_name;

    /**
     * 优惠券价格
     */
    @TableField(value = "coupon_price")
    private Integer coupon_price;

    /**
     * 优惠券券后价格
     */
    @TableField(value = "coupon_price1")
    private Integer coupon_price1;

    /**
     * 优惠券时间
     */
    @TableField(value = "coupon_time")
    private String coupon_time;

    /**
     * 优惠券类型
     */
    @TableField(value = "coupon_type")
    private String coupon_type;

    /**
     * 创建时间：
     */
    @TableField(value = "create_time")
    private Timestamp createTime;

    /**
     * 更新时间：
     */
    @TableField(value = "update_time")
    private Timestamp updateTime;

}

