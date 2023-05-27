package com.posco.hanmadang.mapper.posco;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.posco.hanmadang.model.Test;

@Mapper
public interface PTestMapper {
	Test select(@Param("name") String name);
}
