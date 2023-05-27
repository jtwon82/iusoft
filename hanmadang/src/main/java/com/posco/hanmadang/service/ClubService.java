package com.posco.hanmadang.service;

import java.util.List;

import com.posco.hanmadang.common.Constant.ServiceResult;
import com.posco.hanmadang.model.Club;
import com.posco.hanmadang.model.ClubPagedList;

public interface ClubService{
	Club find(int club_seq);
	Club findById(String club_id);
	List<Club> findAll();
	ClubPagedList getPagedList(int pageNumber, String oneMonth, String after14);
	
	ServiceResult add(Club club);
	ServiceResult remove(int club_seq);
}
