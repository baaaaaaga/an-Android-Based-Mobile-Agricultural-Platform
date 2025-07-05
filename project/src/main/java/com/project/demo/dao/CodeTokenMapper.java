package com.project.demo.dao;

import com.project.demo.dao.base.BaseMapper;
import com.project.demo.entity.CodeToken;
import org.apache.ibatis.annotations.Mapper;

/**
 * 邮箱验证码Mapper接口
 *
 */
@Mapper
public interface CodeTokenMapper extends BaseMapper<CodeToken> {
}
