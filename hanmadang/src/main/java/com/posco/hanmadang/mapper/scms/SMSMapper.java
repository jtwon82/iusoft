package com.posco.hanmadang.mapper.scms;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;


@Mapper
public interface SMSMapper {
	List selectSendSms();
	int insertSendSms(@Param("title") String title
			,@Param("msg") String msg
			,@Param("result") String result
			,@Param("pno") String pno);
}
