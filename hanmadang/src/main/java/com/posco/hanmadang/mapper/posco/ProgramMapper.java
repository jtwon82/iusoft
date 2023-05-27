package com.posco.hanmadang.mapper.posco;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.posco.hanmadang.model.OrderNo;
import com.posco.hanmadang.model.ProgramTimeInfo;

@Mapper
public interface ProgramMapper {
	ProgramTimeInfo select(@Param("type") int type);
	int insert(ProgramTimeInfo info);
	
	int insertOrerNo(OrderNo order);
	int updateOrderNo(@Param("order_no") String order_no, @Param("server_yn") String server_yn);
	OrderNo selectOrderNo(@Param("order_no") String order_no);
}
