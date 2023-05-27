package com.posco.hanmadang.mapper.posco;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.posco.hanmadang.model.admin.Admin;
import com.posco.hanmadang.model.admin.AdminLog;

@Mapper
public interface AdminMapper {
	Admin select(@Param("id") String id);
	Admin selectByIdx(@Param("idx") int idx);
	
	List<Admin> listPaged(@Param("firstOffset") int firstOffset,@Param("lastOffset") int lastOffset);
	int countPaged();
	
	int insert(Admin admin);
	int update(Admin admin);
	int updateLoginLog(@Param("idx") long idx);
	int updateMissCnt(@Param("idx") long idx);
	
	int delete(@Param("idx") long idx);
	
	int insertLog(AdminLog log);
	
	List<AdminLog> listLogPaged(@Param("firstOffset") int firstOffset, @Param("lastOffset") int lastOffset);
	int countLogPaged();
	
	List<AdminLog> listLogAll(@Param("date") String date);
	
}
