package com.posco.hanmadang.service;

import java.util.List;

import com.posco.hanmadang.common.Constant.ServiceResult;
import com.posco.hanmadang.model.Banner;

public interface BannerService{
	List<Banner> getList();
	ServiceResult add(Banner banner);
	ServiceResult remove(long idx_no);
}
