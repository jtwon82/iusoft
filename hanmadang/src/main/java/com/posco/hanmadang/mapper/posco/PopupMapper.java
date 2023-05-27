package com.posco.hanmadang.mapper.posco;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.posco.hanmadang.model.Popup;

@Mapper
public interface PopupMapper {
	Popup select(@Param("idx_no") long idx_no);
	List<Popup> list();
	List<Popup> listActive();
	int insert(Popup banner);
	int update(Popup banner);
	int delete(@Param("idx_no") long idx_no);
	
	int updateOnOff(@Param("b_open_yn") String b_open_yn);
	int updateOnOff(@Param("idx_no") long idx_no, @Param("b_open_yn") String b_open_yn);
}
