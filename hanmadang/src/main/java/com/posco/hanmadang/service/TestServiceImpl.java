package com.posco.hanmadang.service;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.posco.hanmadang.mapper.posco.PTestMapper;
import com.posco.hanmadang.mapper.scms.STestMapper;
import com.posco.hanmadang.model.Test;

@Service("testService")
public class TestServiceImpl implements TestService {
	
	@Autowired PTestMapper pTestMapper;
	@Autowired STestMapper sTestMapper;
	
	@Transactional(readOnly=true)
	public Test find(String user_id){
		return pTestMapper.select(user_id);
	}
	
	@Transactional(readOnly=true)
	public Test findEmail(String email){
		return sTestMapper.selectEmail(email);
	}
}
