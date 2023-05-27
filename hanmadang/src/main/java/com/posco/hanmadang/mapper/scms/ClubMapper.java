package com.posco.hanmadang.mapper.scms;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.posco.hanmadang.model.Club;

@Mapper
public interface ClubMapper {
	Club select(@Param("cl_num") int cl_num);
	Club selectId(@Param("cl_id") String cl_id);
	List<Club> listAll();
	List<Club> listPaged(@Param("firstOffset") int firstOffset,@Param("lastOffset") int lastOffset,
			@Param("befor1month") String befor1month,
			@Param("after14days") String after14days);
	int countPaged();
	
	int insert(Club club);
	int update(Club club);
	int delete(@Param("cl_num") int cl_num);
}
