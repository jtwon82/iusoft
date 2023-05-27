package com.posco.hanmadang.service;


import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.posco.hanmadang.common.Constant.ServiceResult;
import com.posco.hanmadang.mapper.scms.MemberMapper;
import com.posco.hanmadang.model.Member;

@Service("memberService")
public class MemberServiceImpl implements MemberService {
	
	@Autowired MemberMapper memberMapper;
	
	@Transactional(readOnly=true)
	public Member find(String member_id){
		return memberMapper.select(member_id);
	}
	
	@Transactional(readOnly=true)
	public Member findIdPwd(String member_id, String member_pw){
		return memberMapper.selectIdPwd(member_id, member_pw);
	}
	
	@Transactional(readOnly=true)
	public Member find(String name, String hp){
		return memberMapper.select(name, hp);
	}
	
	@Transactional
	public ServiceResult updatPassword(Member member, boolean onlyDt){
		if(onlyDt) {
			int ret = memberMapper.updatePassDt(member);
			if(ret > 0)
				return ServiceResult.SUCCESS;
			else
				return ServiceResult.NOT_FOUND;
		}else {
			int ret = memberMapper.updatePass(member);
			if(ret > 0)
				return ServiceResult.SUCCESS;
			else
				return ServiceResult.NOT_FOUND;
		}
	}
	
	@Transactional
	public ServiceResult updatLastLogin(String member_code){
		int ret = memberMapper.updateLastLogin(member_code);
		if(ret > 0)
			return ServiceResult.SUCCESS;
		else
			return ServiceResult.NOT_FOUND;
	}
	
	@Transactional
	public ServiceResult updatePwdMissStatus(String member_code, int pw_miss_cnt) {
		int ret = memberMapper.updatePwdMissStatus(member_code, pw_miss_cnt);
		if(ret > 0)
			return ServiceResult.SUCCESS;
		else
			return ServiceResult.NOT_FOUND;
	}
	
	@Transactional
	public ServiceResult setDormantActive(String member_code) {
		int ret = memberMapper.updateState(member_code);
		if(ret > 0)
			return ServiceResult.SUCCESS;
		else
			return ServiceResult.NOT_FOUND;
	}
	
	@Transactional
	public ServiceResult leave(String member_code) {
		int ret = memberMapper.updateLeave(member_code);
		if(ret > 0) {
			memberMapper.deleteLeavePhoto(member_code);
			memberMapper.deleteLeaveCard(member_code);
			return ServiceResult.SUCCESS;
		}
	
		return ServiceResult.NOT_FOUND;
	}
	
//	@Transactional
//	public ServiceResult leave(List<String> member_codes) {
//		return ServiceResult.SUCCESS;
//	}
	
}
