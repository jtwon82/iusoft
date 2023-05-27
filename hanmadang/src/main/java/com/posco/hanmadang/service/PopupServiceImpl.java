package com.posco.hanmadang.service;


import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.posco.hanmadang.common.Constant;
import com.posco.hanmadang.common.Constant.ServiceResult;
import com.posco.hanmadang.mapper.posco.PopupMapper;
import com.posco.hanmadang.model.Popup;

@Service("popupService")
public class PopupServiceImpl implements PopupService {
	
	@Autowired PopupMapper popupMapper;
	
	@Transactional(readOnly=true)
	public Popup get(long idx_no){
		return popupMapper.select(idx_no);
	}
	
	@Transactional(readOnly=true)
	public List<Popup> getList(boolean isActive){
		if(isActive)
			return popupMapper.listActive();
		else
			return popupMapper.list();
	}
	
	@Transactional
	public ServiceResult add(Popup popup){
		if(popup.getIdx_no() > 0){
			int ret = popupMapper.update(popup);
			if(ret > 0)
				return ServiceResult.SUCCESS;
			else
				return ServiceResult.NOT_FOUND;
		}else{
			popupMapper.insert(popup);
		}
		return ServiceResult.SUCCESS;
	}
	
	@Transactional
	public ServiceResult remove(long idx_no){
		popupMapper.delete(idx_no);
		return ServiceResult.SUCCESS;
	}
	
	@Transactional
	public ServiceResult onOffPopup(long idx_no, String onoff_yn){
//		if(Constant.YesNoStatus.Y.name().equals(onoff_yn))
//			popupMapper.updateOnOff(Constant.YesNoStatus.N.name());
		
		popupMapper.updateOnOff(idx_no, onoff_yn);
		
		return ServiceResult.SUCCESS;
	}
}
