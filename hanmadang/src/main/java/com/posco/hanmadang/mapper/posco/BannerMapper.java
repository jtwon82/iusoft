package com.posco.hanmadang.mapper.posco;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.posco.hanmadang.model.Banner;

@Mapper
public interface BannerMapper {
	List<Banner> list();
	int insert(Banner banner);
	int update(Banner banner);
	int delete(@Param("idx_no") long idx_no);
}
