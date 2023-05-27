package com.posco.hanmadang.service;

import java.util.List;

import com.posco.hanmadang.common.Constant.ServiceResult;
import com.posco.hanmadang.model.ClassDate;
import com.posco.hanmadang.model.ClassDrawFactor;
import com.posco.hanmadang.model.ClassInfo;
import com.posco.hanmadang.model.ClassUser;
import com.posco.hanmadang.model.ClassUserPagedList;
import com.posco.hanmadang.model.admin.SearchParam;
import com.posco.hanmadang.model.admin.VIPMember;

public interface ClassService{
	ServiceResult addClassDate(String startdate, String enddate);
	ClassDate getActiveClassDate();
	List<ClassDate> getAllClassDate();
	ClassInfo findClass(long idx_no);
	
	List<ClassInfo> getMainClass();
	List<ClassInfo> findActiveSubClass(List<String> cates, String keyword);
	List<ClassInfo> getAllSubClass();
	
	ClassUser findAppliedOneUser(ClassUser cmember); 
	
	List<ClassUser> findAppliedUser(String hp, String viewyn);
	ServiceResult addAppliedUser(ClassUser cmember);
	
	ServiceResult removeAppliedUser(long idx_no);
	
	ServiceResult addMainCate(ClassInfo classInfo);
	ServiceResult removeClass(long idx_no);
	
	ServiceResult addSubClass(ClassInfo classInfo);
	ServiceResult changDrawFactor(ClassInfo classInfo);
	
	ServiceResult setClassShow(long idx_no, String view_yn);
	
	List<ClassUser> getClassUserList(String mode, SearchParam param);
	List<ClassUser> getClassUserList1(String mode, SearchParam param);
	
	ClassUserPagedList getClassUserPagedList(int pageNumber, String mode, SearchParam param);
	
	ServiceResult setVipUser(List<VIPMember> list);
	ServiceResult setDrawStatus(List<Integer> target, String class_yn);
	
//	List<ClassDrawFactor> getDrawFactor();
//	ServiceResult addDrawFactor(ClassDrawFactor factor);
//	ServiceResult updateDrawFactor(ClassDrawFactor factor);
	
	List<ClassUser> getBeforeClassList(String mode, SearchParam param);
	ClassUserPagedList getBeforeClassUserPagedList(int pageNumber, String mode, SearchParam param);
	
	ServiceResult procDraw(int idx);
	ServiceResult openDrawResult();
	ServiceResult resetDrawResult();
	ServiceResult procCompletClass();
	
	int countPreDrawEnd();
	int countDrawView();
	
}
