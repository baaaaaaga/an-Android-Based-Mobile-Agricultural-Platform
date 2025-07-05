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
 * 邮箱验证码(CodeToken)表实体类
 */
@TableName("code_token")
@Data
@EqualsAndHashCode(callSuper = false)
public class CodeToken implements Serializable {

    private static final long serialVersionUID = 913269304437207534L;

    /**
     * 邮箱验证码ID
     */
    @TableId(value = "code_token_id", type = IdType.AUTO)
    private Integer code_token_id;

    /**
     * 临时访问牌
     */
    @TableField(value = "token")
    private String token;

    /**
     * 验证码
     */
    @TableField(value = "code")
    private String code;

    /**
     * 失效时间
     */
    @TableField(value = "expire_time")
    private Timestamp expire_time;

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
