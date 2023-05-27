package com.posco.hanmadang.mapper.scms;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.posco.hanmadang.model.Member;

@Mapper
public interface MemberMapper {
	Member select(@Param("member_id") String member_id);
	Member selectIdPwd(@Param("member_id") String member_id, @Param("member_pw") String member_pw);
	Member select(@Param("name") String name, @Param("hp") String hp);
	int updatePass(Member member);
	int updatePassDt(Member member);
	int updateLastLogin(@Param("member_code") String member_code);
	
	int updatePwdMissStatus(@Param("member_code") String member_code, @Param("pw_miss_cnt") int pw_miss_cnt);
	
	//탈퇴
	int updateLeave(@Param("member_code") String member_code);
	int deleteLeavePhoto(@Param("member_code") String member_code);
	int deleteLeaveCard(@Param("member_code") String member_code);
	
	//휴면
	int updateState(@Param("member_code") String member_code);
	int updateSmsState(@Param("list") List<Member> members);
	List<Member> listDormant(@Param("firstOffset") int firstOffset, @Param("lastOffset") int lastOffset);
	
//	int updateDormantStatus(@Param("member_code") String member_code, @Param("dormant_yn") String dormant_yn);
//	int updateDormantStatus(@Param("list") List<Member> members, @Param("dormant_yn") String dormant_yn);
//	
//	int updateSetDormant();
//	List<Member> listDormant1Year();
//	List<Member> listDormant11Mon();
}
