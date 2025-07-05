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
 * 经验分享：(ExperienceSharing)表实体类
 *
 */
@TableName("`experience_sharing`")
@Data
@EqualsAndHashCode(callSuper = false)
public class ExperienceSharing implements Serializable {

    // ExperienceSharing编号
    @TableId(value = "experience_sharing_id", type = IdType.AUTO)
    private Integer experience_sharing_id;

    // 标题
    @TableField(value = "`title`")
    private String title;
    // 分享类型
    @TableField(value = "`share_type`")
    private String share_type;
    // 经验内容
    @TableField(value = "`experience_content`")
    private String experience_content;




















		


	// 更新时间
    @TableField(value = "update_time")
    private Timestamp update_time;

    // 创建时间
    @TableField(value = "create_time")
    private Timestamp create_time;

}
