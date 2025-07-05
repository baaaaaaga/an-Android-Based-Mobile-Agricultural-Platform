package com.project.demo.entity;


import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.*;

import java.io.Serializable;
import java.sql.Timestamp;


/**
 * 留言板：(Message)表实体类
 *
 * @author xxx
 *@since 202X-XX-XX
 */
@TableName("message")
@Data
@EqualsAndHashCode(callSuper = false)
public class Message implements Serializable {

    private static final long serialVersionUID = -82776916612349826L;

    /**
     * 留言板ID:
     */
    @TableId(value = "message_id", type = IdType.AUTO)
    private Integer messageId;

    /**
     * 用户ID:
     */
    @TableField(value = "user_id")
    private Integer userId;

    /**
     * 标题:
     */
    @TableField(value = "title")
    private String title;

    /**
     * 内容:
     */
    @TableField(value = "content")
    private String content;

    /**
     * 昵称:
     */
    @TableField(value = "nickname")
    private String nickname;

    /**
     * 头像:
     */
    @TableField(value = "avatar")
    private String avatar;

    /**
     * 留言者邮箱
     */
    @TableField(value = "email")
    private String email;

    /**
     * 留言者手机号码
     */
    @TableField(value = "phone")
    private String phone;

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

    /**
     * 回复
     */
    @TableField(value = "reply")
    private String reply;

    /**
     * 回复状态
     */
    @TableField(value = "reply_state")
    private Integer replyState;

}

