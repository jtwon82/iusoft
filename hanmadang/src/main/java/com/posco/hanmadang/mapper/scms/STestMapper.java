package com.posco.hanmadang.mapper.scms;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.posco.hanmadang.model.Test;

@Mapper
public interface STestMapper {
	Test selectEmail(@Param("email") String email);
}
