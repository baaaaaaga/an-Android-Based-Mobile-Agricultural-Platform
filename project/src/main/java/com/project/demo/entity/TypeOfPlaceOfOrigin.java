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
 * 产地类型：(TypeOfPlaceOfOrigin)表实体类
 *
 */
@TableName("`type_of_place_of_origin`")
@Data
@EqualsAndHashCode(callSuper = false)
public class TypeOfPlaceOfOrigin implements Serializable {

    // TypeOfPlaceOfOrigin编号
    @TableId(value = "type_of_place_of_origin_id", type = IdType.AUTO)
    private Integer type_of_place_of_origin_id;

    // 产地类型
    @TableField(value = "`type_of_place_of_origin`")
    private String type_of_place_of_origin;




















		


	// 更新时间
    @TableField(value = "update_time")
    private Timestamp update_time;

    // 创建时间
    @TableField(value = "create_time")
    private Timestamp create_time;

}
