package com.posco.hanmadang.service.admin;

import java.util.List;

import com.posco.hanmadang.common.Constant.ServiceResult;
import com.posco.hanmadang.model.admin.Admin;
import com.posco.hanmadang.model.admin.AdminLog;
import com.posco.hanmadang.model.admin.AdminLogPagedList;
import com.posco.hanmadang.model.admin.AdminPagedList;

public interface AdminService{
	Admin find(String id);
	Admin find(int idx);
	AdminPagedList getPagedList(int pageNumber);
	
	ServiceResult add(Admin admin);
	
	ServiceResult updateLoginLog(long idx);
	ServiceResult updateMissCnt(long idx);
	ServiceResult remove(long idx);
	
	ServiceResult addLog(Admin admin, String action);
	
	AdminLogPagedList getLogPagedList(int pageNumber);
	List<AdminLog> getLogAllList(String date);
}
