package com.posco.hanmadang.mapper.posco;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.posco.hanmadang.model.ClassDate;
import com.posco.hanmadang.model.ClassDrawFactor;
import com.posco.hanmadang.model.ClassInfo;
import com.posco.hanmadang.model.ClassInfo1;
import com.posco.hanmadang.model.ClassUser;
import com.posco.hanmadang.model.admin.SearchParam;

@Mapper
public interface ClassMapper {
	int updateHideAllClassDate();
	int insertClassDate(@Param("startdate") String startdate, @Param("enddate") String enddate);
	ClassDate selectActiveDate();
	
	ClassInfo selectClass(@Param("idx_no") long idx_no);
	List<ClassDate> listClassDate();
	
	List<ClassInfo> listMainClass();
	List<ClassInfo> listActiveSubClass(@Param("cates") List<String> cates, @Param("keyword") String keyword);
	List<ClassInfo> listAllSubClass();
	
	ClassUser selectAppliedUser(@Param("class_year") String class_year, @Param("class_month") String class_month 
			,@Param("hp") String hp
			,@Param("o_name") String o_name
			, @Param("e_no") String e_no
			,@Param("mem_type") String mem_type
			,@Param("e_name") String e_name);
	
	
	List<ClassUser> listAppliedUser(@Param("hp") String o_name, @Param("viewyn") String viewyn);
	
	int insertAppliedUser(ClassUser classMember);
	int deleteAppliedUser(@Param("idx_no") long idx_no);
	
	ClassInfo selectCateTop1();
	ClassInfo selectSubCateTop1(@Param("b_cate") String b_cate);
	
	int insertMainClass(ClassInfo classInfo);
	int updateMainClass(ClassInfo classInfo);
	int deleteClass(@Param("idx_no") long idx_no);
	
	int insertSubClass(ClassInfo classInfo);
	int updateSubClass(ClassInfo classInfo);
	int updateSubClassRate(ClassInfo classInfo);
	
	int updateClassView(@Param("idx_no") long idx_no, @Param("viewyn") String viewyn);
	
	//수강리스트
	List<ClassUser> listClassUser(@Param("mode") String mode, @Param("param") SearchParam param);
	List<ClassUser> listClassUser1(@Param("mode") String mode, @Param("param") SearchParam param);
	
	List<ClassUser> listClassPaged(@Param("firstOffset") int firstOffset,@Param("lastOffset") int lastOffset, 
			@Param("mode") String mode, @Param("param") SearchParam param);
	int countClassPaged(@Param("mode") String mode, @Param("param") SearchParam param);
	
	int updateVip(@Param("class_ok") String class_ok);
	int updateVip(@Param("class_ok") String class_ok,
			@Param("name") String name, 
			@Param("em_name") String em_name, 
			@Param("phone") String phone,
			@Param("em_type") String em_type);
	
	int updateDrawStatus(@Param("list") List<Integer> target, @Param("class_yn") String class_yn);
	
	
//	List<ClassDrawFactor> listDrawFactor();
//	int insertDrawFactor(ClassDrawFactor factor);
//	int updateDrawFactor(ClassDrawFactor factor);
	
	
	//지난 수강 리스트
	List<ClassUser> listBeforeClass(@Param("mode") String mode, @Param("param") SearchParam param);
	List<ClassUser> listBeforeClassPaged(@Param("firstOffset") int firstOffset,@Param("lastOffset") int lastOffset, 
			@Param("mode") String mode, @Param("param") SearchParam param);
	int countBeforeClassPaged(@Param("mode") String mode, @Param("param") SearchParam param);
	
	//추첨
	int updateDrawOpen();
	int updateDrawDefault();
	int updateDrawReset();
	int insertCompletClass();
	int truncateTempClassMember();
	int deleteTempClassMember();
	
	int deleteClassMember();
	
	int cntPreDrawEnd();
	int cntDrawView();
	
	List<ClassDrawFactor> listDrawFactorDetail();
	
	List<ClassUser> listVipUser();
	
	int updateRandDrawStatus(@Param("c_idx") int c_idx);
//	int updateRandDrawStatus(@Param("count") int count, @Param("c_idx") int c_idx);
//	int updateRandDrawStatus(@Param("count") int count, @Param("c_idx") int c_idx, @Param("em_type") String em_type);
//	int updateRandDrawStatus(@Param("count") int count, @Param("c_idx") int c_idx, @Param("gender") int gender);
//	int updateRandDrawStatus(@Param("count") int count, @Param("c_idx") int c_idx, @Param("em_type") String em_type, @Param("gender") int gender);
//	
	int updateRandDrawStatus(@Param("c_idx") int c_idx, @Param("list") List<ClassUser> list);
	
//	int updateRandDrawWaitStatus(@Param("count") int count, @Param("c_idx") int c_idx);
	int updateRandDrawWaitStatus(@Param("c_idx") int c_idx, @Param("list") List<ClassUser> list);
	
	int cntDrawResult(@Param("c_idx") int c_idx);
	
	List<ClassUser> selectRandDrawStatus(@Param("c_idx") int c_idx);
	List<ClassUser> selectRandDrawStatus(@Param("c_idx") int c_idx, @Param("em_type") String em_type);
	List<ClassUser> selectRandDrawStatus(@Param("c_idx") int c_idx, @Param("gender") int gender);
	List<ClassUser> selectRandDrawStatus(@Param("c_idx") int c_idx, @Param("em_type") String em_type, @Param("gender") int gender);
	
	List<ClassUser> selectRandDrawWaitStatus(@Param("c_idx") int c_idx);
	
//	int updatetemp1(ClassInfo1 info);
//	int updatetemp2(ClassInfo1 info);
	
}
