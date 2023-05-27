package com.posco.hanmadang.service;


import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.posco.hanmadang.common.Constant.ServiceResult;
import com.posco.hanmadang.mapper.scms.ClubMapper;
import com.posco.hanmadang.model.Club;
import com.posco.hanmadang.model.ClubPagedList;
import com.posco.hanmadang.util.Paging;

@Service("clubService")
public class ClubServiceImpl implements ClubService {
	
	private static int ADMIN_ENTRY_COUNT_PER_ONE_PAGE = 10;
	private static int ADMIN_PAGE_COUNT_PER_PAGE_GROUP = 10;
	
	@Autowired ClubMapper clubMapper;
	
	@Transactional(readOnly=true)
	public Club find(int club_seq){
		return clubMapper.select(club_seq);
	}
	
	@Transactional(readOnly=true)
	public Club findById(String club_id){
		return clubMapper.selectId(club_id);
	}
	
	@Transactional(readOnly=true)
	public List<Club> findAll(){
		return clubMapper.listAll();
	}
	
	@Transactional(readOnly=true)
	public ClubPagedList getPagedList(int pageNumber, String oneMonth, String after14){
		Paging paging = new Paging(pageNumber, ADMIN_ENTRY_COUNT_PER_ONE_PAGE, ADMIN_PAGE_COUNT_PER_PAGE_GROUP);
		List<Club> list = clubMapper.listPaged(paging.getFirstOffset(), paging.getLastOffset(), oneMonth, after14);
		ClubPagedList pagedList = new ClubPagedList();
		pagedList.setList(list);
		if(pagedList != null){
			pagedList.setPaging(paging);
		
			int count = clubMapper.countPaged();
			pagedList.setTotalEntryCount(count);
		}
		
		return pagedList;
	}
	
	@Transactional
	public ServiceResult add(Club club){
		if(club.getCl_num() > 0){
			int ret = clubMapper.update(club);
			if(ret > 0)
				return ServiceResult.SUCCESS;
			else
				return ServiceResult.NOT_FOUND;
		}else{
			clubMapper.insert(club);
		}
		return ServiceResult.SUCCESS;
	}

	
	@Transactional
	public ServiceResult remove(int club_seq){
		clubMapper.delete(club_seq);
		return ServiceResult.SUCCESS;
	}
	
}
