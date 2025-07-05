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
 * 生产计划：(ProductionPlanning)表实体类
 *
 */
@TableName("`production_planning`")
@Data
@EqualsAndHashCode(callSuper = false)
public class ProductionPlanning implements Serializable {

    // ProductionPlanning编号
    @TableId(value = "production_planning_id", type = IdType.AUTO)
    private Integer production_planning_id;

    // 计划编号
    @TableField(value = "`plan_no`")
    private String plan_no;
    // 计划标题
    @TableField(value = "`schedule_title`")
    private String schedule_title;
    // 计划日期
    @TableField(value = "`planned_date`")
    private Timestamp planned_date;
    // 计划内容
    @TableField(value = "`plan_content`")
    private String plan_content;
    // 农户商家
    @TableField(value = "`farmers_merchants`")
    private Integer farmers_merchants;




















		


	// 更新时间
    @TableField(value = "update_time")
    private Timestamp update_time;

    // 创建时间
    @TableField(value = "create_time")
    private Timestamp create_time;

}
