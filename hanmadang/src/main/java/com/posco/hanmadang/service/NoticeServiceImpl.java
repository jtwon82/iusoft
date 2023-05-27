package com.posco.hanmadang.service;


import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.posco.hanmadang.common.Constant.ServiceResult;
import com.posco.hanmadang.mapper.posco.NoticeMapper;
import com.posco.hanmadang.model.Notice;
import com.posco.hanmadang.model.NoticePagedList;
import com.posco.hanmadang.util.Paging;

@Service("noticeService")
public class NoticeServiceImpl implements NoticeService {
	
	private static int ADMIN_ENTRY_COUNT_PER_ONE_PAGE = 10;
	private static int ADMIN_PAGE_COUNT_PER_PAGE_GROUP = 10;
	
	@Autowired NoticeMapper noticeMapper;
	
	@Transactional(readOnly=true)
	public Notice find(long seq){
		return noticeMapper.select(seq);
	}
	
	@Transactional(readOnly=true)
	public NoticePagedList getPagedList(int pageNumber){
		Paging paging = new Paging(pageNumber, ADMIN_ENTRY_COUNT_PER_ONE_PAGE, ADMIN_PAGE_COUNT_PER_PAGE_GROUP);
		List<Notice> list = noticeMapper.listPaged(paging.getFirstOffset(), paging.getLastOffset());
		NoticePagedList pagedList = new NoticePagedList();
		pagedList.setList(list);
		if(pagedList != null){
			pagedList.setPaging(paging);
		
			int count = noticeMapper.countPaged();
			pagedList.setTotalEntryCount(count);
		}
		
		return pagedList;
	}
	
	@Transactional
	public ServiceResult add(Notice notice){
		if(notice.getIdx() > 0){
			int ret = noticeMapper.update(notice);
			if(ret > 0)
				return ServiceResult.SUCCESS;
			else
				return ServiceResult.NOT_FOUND;
		}else{
			noticeMapper.insert(notice);
		}
		return ServiceResult.SUCCESS;
	}
	
	@Transactional
	public ServiceResult incHit(long idx){
		int ret = noticeMapper.updateHit(idx);
		if(ret > 0)
			return ServiceResult.SUCCESS;
		else
			return ServiceResult.NOT_FOUND;
	}
	
	@Transactional
	public ServiceResult remove(long idx_no){
		noticeMapper.delete(idx_no);
		return ServiceResult.SUCCESS;
	}
	
}
