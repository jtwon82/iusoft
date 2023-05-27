package com.posco.hanmadang.service.admin;


import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.posco.hanmadang.common.Constant.ServiceResult;
import com.posco.hanmadang.mapper.posco.AdminMapper;
import com.posco.hanmadang.model.admin.Admin;
import com.posco.hanmadang.model.admin.AdminLog;
import com.posco.hanmadang.model.admin.AdminLogPagedList;
import com.posco.hanmadang.model.admin.AdminPagedList;
import com.posco.hanmadang.util.Paging;

@Service("adminService")
public class AdminServiceImpl implements AdminService {
	
	private static int ADMIN_ENTRY_COUNT_PER_ONE_PAGE = 10;
	private static int ADMIN_PAGE_COUNT_PER_PAGE_GROUP = 10;
	
	@Autowired AdminMapper adminMapper;
	
	@Transactional(readOnly=true)
	public Admin find(String id){
		return adminMapper.select(id);
	}
	
	@Transactional(readOnly=true)
	public Admin find(int idx){
		return adminMapper.selectByIdx(idx);
	}
	
	@Transactional(readOnly=true)
	public AdminPagedList getPagedList(int pageNumber){
		Paging paging = new Paging(pageNumber, ADMIN_ENTRY_COUNT_PER_ONE_PAGE, ADMIN_PAGE_COUNT_PER_PAGE_GROUP);
		List<Admin> list = adminMapper.listPaged(paging.getFirstOffset(), paging.getLastOffset());
		AdminPagedList pagedList = new AdminPagedList();
		pagedList.setList(list);
		if(pagedList != null){
			pagedList.setPaging(paging);
		
			int count = adminMapper.countPaged();
			pagedList.setTotalEntryCount(count);
		}
		
		return pagedList;
	}
	
	@Transactional
	public ServiceResult add(Admin admin){
		if(admin.getIdx() > 0){
			int ret = adminMapper.update(admin);
			if(ret > 0)
				return ServiceResult.SUCCESS;
			else
				return ServiceResult.NOT_FOUND;
		}else{
			adminMapper.insert(admin);
		}
		return ServiceResult.SUCCESS;
	}
	
	@Transactional
	public ServiceResult updateLoginLog(long idx){
		int ret = adminMapper.updateLoginLog(idx);
		if(ret > 0)
			return ServiceResult.SUCCESS;
		else
			return ServiceResult.NOT_FOUND;
	}
	
	@Transactional
	public ServiceResult updateMissCnt(long idx){
		adminMapper.updateMissCnt(idx);
		return ServiceResult.SUCCESS;
	}
	
	@Transactional
	public ServiceResult remove(long idx){
		adminMapper.delete(idx);
		return ServiceResult.SUCCESS;
	}
	
	@Transactional
	public ServiceResult addLog(Admin admin, String action){
		AdminLog log = new AdminLog();
		log.setId(admin.getId());
		log.setIp(admin.getIp());
		log.setName(admin.getName());
		log.setAction(action);
		adminMapper.insertLog(log);
		return ServiceResult.SUCCESS;
	}
	
	@Transactional(readOnly=true)
	public AdminLogPagedList getLogPagedList(int pageNumber){
		Paging paging = new Paging(pageNumber, ADMIN_ENTRY_COUNT_PER_ONE_PAGE, ADMIN_PAGE_COUNT_PER_PAGE_GROUP);
		List<AdminLog> list = adminMapper.listLogPaged(paging.getFirstOffset(), paging.getLastOffset());
		AdminLogPagedList pagedList = new AdminLogPagedList();
		pagedList.setList(list);
		if(pagedList != null){
			pagedList.setPaging(paging);
		
			int count = adminMapper.countLogPaged();
			pagedList.setTotalEntryCount(count);
		}
		
		return pagedList;
	}
	
	@Transactional(readOnly=true)
	public List<AdminLog> getLogAllList(String date){
		return adminMapper.listLogAll(date);
	}
	
}
