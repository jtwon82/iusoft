package com.posco.hanmadang.mapper.posco;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.posco.hanmadang.model.Notice;

@Mapper
public interface NoticeMapper {
	Notice select(@Param("idx") long idx);
	
	List<Notice> listPaged(@Param("firstOffset") int firstOffset,@Param("lastOffset") int lastOffset);
	int countPaged();
	
	int insert(Notice notice);
	int update(Notice notice);
	int updateHit(@Param("idx") long idx);
	
	int delete(@Param("idx") long idx);
}
