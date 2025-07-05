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
 * 互动咨询：(InteractiveConsultation)表实体类
 *
 */
@TableName("`interactive_consultation`")
@Data
@EqualsAndHashCode(callSuper = false)
public class InteractiveConsultation implements Serializable {

    // InteractiveConsultation编号
    @TableId(value = "interactive_consultation_id", type = IdType.AUTO)
    private Integer interactive_consultation_id;

    // 咨询编号
    @TableField(value = "`consultation_number`")
    private String consultation_number;
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
    // 咨询日期
    @TableField(value = "`date_of_consultation`")
    private Timestamp date_of_consultation;
    // 咨询用户
    @TableField(value = "`consulting_users`")
    private Integer consulting_users;
    // 咨询内容
    @TableField(value = "`consulting_content`")
    private String consulting_content;



















		// 回复限制次数
	@TableField(value = "consultation_reply_limit_times")
	private String consultation_reply_limit_times;
	
			// 来源表
	@TableField(value = "source_table")
	private String source_table;
	
	// 来源ID
	@TableField(value = "source_id")
	private Integer source_id;
	
	// 来源用户ID
	@TableField(value = "source_user_id")
	private Integer source_user_id;
	


	// 更新时间
    @TableField(value = "update_time")
    private Timestamp update_time;

    // 创建时间
    @TableField(value = "create_time")
    private Timestamp create_time;

}
