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
 * 消费者：(Consumer)表实体类
 *
 */
@TableName("`consumer`")
@Data
@EqualsAndHashCode(callSuper = false)
public class Consumer implements Serializable {

    // Consumer编号
    @TableId(value = "consumer_id", type = IdType.AUTO)
    private Integer consumer_id;

    // 用户姓名
    @TableField(value = "`user_name`")
    private String user_name;
    // 手机号码
    @TableField(value = "`mobile_phone_number`")
    private String mobile_phone_number;









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
