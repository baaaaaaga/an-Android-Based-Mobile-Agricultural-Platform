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
 * 分享类型：(ShareType)表实体类
 *
 */
@TableName("`share_type`")
@Data
@EqualsAndHashCode(callSuper = false)
public class ShareType implements Serializable {

    // ShareType编号
    @TableId(value = "share_type_id", type = IdType.AUTO)
    private Integer share_type_id;

    // 分享类型
    @TableField(value = "`share_type`")
    private String share_type;




















		


	// 更新时间
    @TableField(value = "update_time")
    private Timestamp update_time;

    // 创建时间
    @TableField(value = "create_time")
    private Timestamp create_time;

}
