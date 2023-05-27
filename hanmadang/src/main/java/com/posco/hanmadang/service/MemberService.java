package com.posco.hanmadang.service;

import java.util.List;

import com.posco.hanmadang.common.Constant.ServiceResult;
import com.posco.hanmadang.model.Member;

public interface MemberService{
	Member find(String member_id);
	Member findIdPwd(String member_id, String member_pw);
	Member find(String name, String hp);
	ServiceResult updatPassword(Member member, boolean onlyDt);
	ServiceResult updatLastLogin(String member_code);
	
	ServiceResult updatePwdMissStatus(String member_code, int pw_miss_cnt);
	ServiceResult setDormantActive(String member_code);
	
	ServiceResult leave(String member_code);
//	ServiceResult leave(List<String> member_codes);
}
