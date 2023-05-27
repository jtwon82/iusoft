package com.posco.hanmadang.service;

import com.posco.hanmadang.common.Constant.ServiceResult;
import com.posco.hanmadang.model.Notice;
import com.posco.hanmadang.model.NoticePagedList;

public interface NoticeService{
	Notice find(long seq);
	NoticePagedList getPagedList(int pageNumber);
	
	ServiceResult add(Notice banner);
	ServiceResult incHit(long idx_no);
	ServiceResult remove(long idx_no);
}
