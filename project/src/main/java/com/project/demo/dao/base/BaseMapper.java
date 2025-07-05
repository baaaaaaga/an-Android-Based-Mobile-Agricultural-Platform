package com.project.demo.dao.base;


import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

@Mapper
public interface BaseMapper<E> extends com.baomidou.mybatisplus.core.mapper.BaseMapper<E> {

    List<Map<String,Object>> selectBaseList(@Param("select") String select);

    Integer selectBaseCount(@Param("count") String count);

    Object selectBaseOne(@Param("select") String select);

    int updateBaseSql(@Param("sql") String sql);

    int deleteBaseSql(@Param("sql") String sql);
}
