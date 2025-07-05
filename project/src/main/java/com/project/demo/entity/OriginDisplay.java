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
 * 产地展示：(OriginDisplay)表实体类
 *
 */
@TableName("`origin_display`")
@Data
@EqualsAndHashCode(callSuper = false)
public class OriginDisplay implements Serializable {

    // OriginDisplay编号
    @TableId(value = "origin_display_id", type = IdType.AUTO)
    private Integer origin_display_id;

    // 产地名称
    @TableField(value = "`name_of_place_of_origin`")
    private String name_of_place_of_origin;
    // 封面图
    @TableField(value = "`cover_chart`")
    private String cover_chart;
    // 产地地址
    @TableField(value = "`place_of_origin_address`")
    private String place_of_origin_address;
    // 产地类型
    @TableField(value = "`type_of_place_of_origin`")
    private String type_of_place_of_origin;
    // 产地规模
    @TableField(value = "`scale_of_origin`")
    private String scale_of_origin;
    // 产地介绍
    @TableField(value = "`introduction_of_origin`")
    private String introduction_of_origin;
    // 农户商家
    @TableField(value = "`farmers_merchants`")
    private Integer farmers_merchants;
    // 商家名称
    @TableField(value = "`business_name`")
    private String business_name;
    // 联系号码
    @TableField(value = "`contact_number`")
    private String contact_number;
    // 商家地址
    @TableField(value = "`business_address`")
    private String business_address;

    // 点击数
    @TableField(value = "hits")
    private Integer hits;


    // 收藏数
    @TableField(value = "collect_len")
    private Integer collect_len;

    // 评论数
    @TableField(value = "comment_len")
    private Integer comment_len;















		// 咨询限制次数
	@TableField(value = "interactive_consultation_limit_times")
	private String interactive_consultation_limit_times;
	
		


	// 更新时间
    @TableField(value = "update_time")
    private Timestamp update_time;

    // 创建时间
    @TableField(value = "create_time")
    private Timestamp create_time;

}
