package com.posco.hanmadang.service;


import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.posco.hanmadang.common.Constant.ServiceResult;
import com.posco.hanmadang.mapper.posco.BannerMapper;
import com.posco.hanmadang.model.Banner;

@Service("bannerService")
public class BannerServiceImpl implements BannerService {
	
	@Autowired BannerMapper bannerMapper;
	
	@Transactional(readOnly=true)
	public List<Banner> getList(){
		List<Banner> list = bannerMapper.list();
		return list;
	}
	
	@Transactional
	public ServiceResult add(Banner banner){
		if(banner.getIdx_no() > 0){
			int ret = bannerMapper.update(banner);
			if(ret > 0)
				return ServiceResult.SUCCESS;
			else
				return ServiceResult.NOT_FOUND;
		}else{
			bannerMapper.insert(banner);
		}
		return ServiceResult.SUCCESS;
	}
	
	@Transactional
	public ServiceResult remove(long idx_no){
		bannerMapper.delete(idx_no);
		return ServiceResult.SUCCESS;
	}
}
