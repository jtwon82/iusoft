package com.posco.hanmadang.service;

import java.util.List;

import com.posco.hanmadang.common.Constant.ServiceResult;
import com.posco.hanmadang.model.Popup;

public interface PopupService{
	Popup get(long idx_no);
	List<Popup> getList(boolean isActive);
	ServiceResult add(Popup banner);
	ServiceResult remove(long idx_no);
	ServiceResult onOffPopup(long idx_no, String onoff_yn);
}
