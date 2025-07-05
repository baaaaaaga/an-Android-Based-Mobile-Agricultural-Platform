package com.project.demo.entity;

import com.alibaba.fastjson.annotation.JSONField;
import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.*;

import java.io.Serializable;
import java.sql.Timestamp;


/**
 * 农户商家：(FarmersMerchants)表实体类
 *
 */
@TableName("`farmers_merchants`")
@Data
@EqualsAndHashCode(callSuper = false)
public class FarmersMerchants implements Serializable {

    // FarmersMerchants编号
    @TableId(value = "farmers_merchants_id", type = IdType.AUTO)
    private Integer farmers_merchants_id;

    // 商家名称
    @TableField(value = "`business_name`")
    private String business_name;
    // 联系号码
    @TableField(value = "`contact_number`")
    private String contact_number;
    // 商家地址
    @TableField(value = "`business_address`")
    private String business_address;
    // 营业执照
    @TableField(value = "`business_license`")
    private String business_license;
    // 认证申请
    @TableField(value = "`certification_application`")
    private String certification_application;





    // 审核状态
    @TableField(value = "examine_state")
    private String examine_state;




    // 用户编号
    @TableField(value = "user_id")
    private Integer userId;











		


	// 更新时间
    @TableField(value = "update_time")
    private Timestamp update_time;

    // 创建时间
    @TableField(value = "create_time")
    private Timestamp create_time;

}
