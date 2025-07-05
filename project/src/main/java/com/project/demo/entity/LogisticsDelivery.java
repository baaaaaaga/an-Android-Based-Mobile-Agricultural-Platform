package com.project.demo.entity;


import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;
import lombok.EqualsAndHashCode;

import java.io.Serializable;
import java.sql.Timestamp;


/**
 * 物流
 */
@TableName("logistics_delivery")
@Data
@EqualsAndHashCode(callSuper = false)
public class LogisticsDelivery implements Serializable {

    private static final long serialVersionUID = -89845695959527153L;

    /**
     * 物流配送ID：[0,10000]
     */
    @TableId(value = "exam_question_id", type = IdType.AUTO)
    private Integer logistics_delivery_id;

    /**
     * 订单号
     */
    @TableField(value = "order_number")
    private String order_number;

    /**
     * 商品名称
     */
    @TableField(value = "product_name")
    private String product_name;

    /**
     * 购买数量
     */
    @TableField(value = "purchase_quantity")
    private String purchase_quantity;

    /**
     * 交易总额
     */
    @TableField(value = "total_transaction_amount")
    private Double total_transaction_amount;

    /**
     * 发货日期
     */
    @TableField(value = "the_date_of_issuance")
    private Timestamp the_date_of_issuance;

    /**
     * 配送订单
     */
    @TableField(value = "delivery_number")
    private String delivery_number;

    /**
     * 普通用户
     */
    @TableField(value = "ordinary_users")
    private Integer ordinary_users;

    /**
     * 收货地址
     */
    @TableField(value = "shipping_address")
    private String shipping_address;

    /**
     * 配送状态
     */
    @TableField(value = "delivery_status")
    private String delivery_status;

    /**
     * 签收状态
     */
    @TableField(value = "signing_status")
    private String signing_status;

    /**
     * 智能推荐
     */
    @TableField(value = "recommend")
    private Integer recommend;

    /**
     * 联系人名字
     */
    @TableField(value = "contact_name")
    private String contact_name;

    /**
     * 商家id
     */
    @TableField(value = "merchant_id")
    private Integer merchant_id;

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

