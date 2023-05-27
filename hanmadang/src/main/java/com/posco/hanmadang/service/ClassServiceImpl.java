package com.posco.hanmadang.service;


import java.util.ArrayList;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.posco.hanmadang.common.Constant;
import com.posco.hanmadang.common.Constant.ServiceResult;
import com.posco.hanmadang.mapper.posco.ClassMapper;
import com.posco.hanmadang.model.ClassDate;
import com.posco.hanmadang.model.ClassDrawFactor;
import com.posco.hanmadang.model.ClassInfo;
import com.posco.hanmadang.model.ClassUser;
import com.posco.hanmadang.model.ClassUserPagedList;
import com.posco.hanmadang.model.admin.SearchParam;
import com.posco.hanmadang.model.admin.VIPMember;
import com.posco.hanmadang.util.Paging;

@Service("classService")
public class ClassServiceImpl implements ClassService {
	private final Logger logger = LoggerFactory.getLogger(this.getClass());
	
	private static int ADMIN_ENTRY_COUNT_PER_ONE_PAGE = 100;
	private static int ADMIN_PAGE_COUNT_PER_PAGE_GROUP = 10;
	
	@Autowired ClassMapper classMapper;
	
	@Transactional
	public ServiceResult addClassDate(String startdate, String enddate){
		classMapper.updateHideAllClassDate();
		classMapper.insertClassDate(startdate, enddate);
		return ServiceResult.SUCCESS;
	}
	
	@Transactional(readOnly=true)
	public ClassDate getActiveClassDate(){
		return classMapper.selectActiveDate();
	}
	
	@Transactional(readOnly=true)
	public List<ClassDate> getAllClassDate(){
		return classMapper.listClassDate();
	}
	
	@Transactional(readOnly=true)
	public ClassInfo findClass(long idx_no){
		return classMapper.selectClass(idx_no);
	}
	
	@Transactional(readOnly=true)
	public List<ClassInfo> getMainClass(){
		return classMapper.listMainClass();
	}
	
	@Transactional(readOnly=true)
	public List<ClassInfo> findActiveSubClass(List<String> cates, String keyword){
		return classMapper.listActiveSubClass(cates, keyword);
	}
	
	@Transactional(readOnly=true)
	public List<ClassInfo> getAllSubClass(){
		return classMapper.listAllSubClass();
	}
	
	@Transactional(readOnly=true)
	public ClassUser findAppliedOneUser(ClassUser cmember){
		if("01".equals(cmember.getEm_type()) || "02".equals(cmember.getEm_type())){
			ClassUser user = classMapper.selectAppliedUser(cmember.getClass_year(), cmember.getClass_month(), 
					null, cmember.getO_name(), cmember.getE_no(), null, null);
			
			if(user == null) {
				user = classMapper.selectAppliedUser(cmember.getClass_year(), cmember.getClass_month(), 
						null, null, cmember.getE_no(), cmember.getMem_type(), null);
				
				if(user == null) {
					user = classMapper.selectAppliedUser(cmember.getClass_year(), cmember.getClass_month(), 
							cmember.getHp(), cmember.getO_name(), null, cmember.getMem_type(), null);
					
					if(user == null && "02".equals(cmember.getEm_type())) {
						return classMapper.selectAppliedUser(cmember.getClass_year(), cmember.getClass_month(), 
								cmember.getHp(), cmember.getO_name(), null, null, null);
					}
				}

			}
			else {
				user.setIdx_no(-1); // 직번, 신청자명 동일 존재
			}
			
			return user;
		}else {
			return classMapper.selectAppliedUser(cmember.getClass_year(), cmember.getClass_month(), cmember.getHp(), null, null, null, null);
		}
		
//		if("02".equals(cmember.getEm_type()) || "03".equals(cmember.getEm_type())){
//			return classMapper.selectAppliedUser(cmember.getClass_year(), cmember.getClass_month(), cmember.getHp(), null, null, null, null);
//		}else if("01".equals(cmember.getEm_type())){
//			ClassUser user =  classMapper.selectAppliedUser(cmember.getClass_year(), cmember.getClass_month(), 
//					null, cmember.getO_name(), cmember.getE_no(), null, null);
//			
//			if(user != null)
//				return user;
//		}
//		
//		return classMapper.selectAppliedUser(cmember.getClass_year(), cmember.getClass_month(), 
//				null, null, cmember.getE_no(), cmember.getMem_type(), cmember.getE_name());
	}
	
	@Transactional(readOnly=true)
	public List<ClassUser> findAppliedUser(String hp, String viewyn){
		return classMapper.listAppliedUser(hp, viewyn);
	}
	
	@Transactional
	public ServiceResult addAppliedUser(ClassUser cmember){
		classMapper.insertAppliedUser(cmember);
		return ServiceResult.SUCCESS;
	}
	
	@Transactional
	public ServiceResult removeAppliedUser(long idx_no){
		classMapper.deleteAppliedUser(idx_no);
		return ServiceResult.SUCCESS;
	}
	
	@Transactional
	public ServiceResult addMainCate(ClassInfo classInfo){
		if(classInfo.getIdx_no() > 0){
			classMapper.updateMainClass(classInfo);
		}else{
			ClassInfo top1Cate = classMapper.selectCateTop1();
			if(top1Cate == null)
				classInfo.setB_cate("01");
			else
				classInfo.setB_cate(String.format("%02d", Integer.parseInt(top1Cate.getB_cate()) + 1));
			classMapper.insertMainClass(classInfo);
		}
		
		return ServiceResult.SUCCESS;
	}
	
	@Transactional
	public ServiceResult removeClass(long idx_no){
		classMapper.deleteClass(idx_no);
		return ServiceResult.SUCCESS;
	}
	
	@Transactional
	public ServiceResult addSubClass(ClassInfo classInfo){
		ClassInfo top1Cate = classMapper.selectSubCateTop1(classInfo.getB_cate());
		if(top1Cate == null)
			classInfo.setM_cate("01");
		else
			classInfo.setM_cate(String.format("%02d", Integer.parseInt(top1Cate.getM_cate()) + 1));
		
		if(classInfo.getIdx_no() > 0){
			classMapper.updateSubClass(classInfo);
		}else{
			classMapper.insertSubClass(classInfo);
		}
		
		return ServiceResult.SUCCESS;
	}
	
	@Transactional
	public ServiceResult changDrawFactor(ClassInfo classInfo){
		classMapper.updateSubClassRate(classInfo);
		return ServiceResult.SUCCESS;
	}
	
	@Transactional
	public ServiceResult setClassShow(long idx_no, String view_yn){
		classMapper.updateClassView(idx_no, view_yn);
		return ServiceResult.SUCCESS;
	}
	
	@Transactional(readOnly=true)
	public List<ClassUser> getClassUserList(String mode, SearchParam param){
		return classMapper.listClassUser(mode, param);
	}
	
	@Transactional(readOnly=true)
	public List<ClassUser> getClassUserList1(String mode, SearchParam param){
		return classMapper.listClassUser1(mode, param);
	}
	
	@Transactional(readOnly=true)
	public ClassUserPagedList getClassUserPagedList(int pageNumber, String mode, SearchParam param){
		Paging paging = new Paging(pageNumber, ADMIN_ENTRY_COUNT_PER_ONE_PAGE, ADMIN_PAGE_COUNT_PER_PAGE_GROUP);
		List<ClassUser> list = classMapper.listClassPaged(paging.getFirstOffset(), paging.getLastOffset(), mode, param);
		ClassUserPagedList pagedList = new ClassUserPagedList();
		pagedList.setList(list);
		if(pagedList != null){
			pagedList.setPaging(paging);
		
			int count = classMapper.countClassPaged(mode, param);
			pagedList.setTotalEntryCount(count);
		}
		
		return pagedList;
	}
	
	@Transactional
	public ServiceResult setVipUser(List<VIPMember> list){
		classMapper.updateVip(Constant.YesNoStatus.N.name());
		for(VIPMember mem : list){
			classMapper.updateVip(Constant.YesNoStatus.Y.name(), mem.getName(), mem.getEm_name(), mem.getPhone().replace("-", ""), mem.getEm_type());
		}
		
		return ServiceResult.SUCCESS;
	}
	
	@Transactional
	public ServiceResult setDrawStatus(List<Integer> target, String class_yn){
		if(target.size() > 0)
			classMapper.updateDrawStatus(target, class_yn);
		
		return ServiceResult.SUCCESS;
	}
	
//	@Transactional(readOnly=true)
//	public List<ClassDrawFactor> getDrawFactor(){
//		return classMapper.listDrawFactor();
//	}
//	
//	@Transactional
//	public ServiceResult addDrawFactor(ClassDrawFactor factor){
//		classMapper.insertDrawFactor(factor);
//		return ServiceResult.SUCCESS;
//	}
//	
//	@Transactional
//	public ServiceResult updateDrawFactor(ClassDrawFactor factor){
//		classMapper.updateDrawFactor(factor);
//		return ServiceResult.SUCCESS;
//	}
	
	@Transactional(readOnly=true)
	public List<ClassUser> getBeforeClassList(String mode, SearchParam param){
		return classMapper.listBeforeClass(mode, param);
	}
	
	@Transactional(readOnly=true)
	public ClassUserPagedList getBeforeClassUserPagedList(int pageNumber, String mode, SearchParam param){
		Paging paging = new Paging(pageNumber, ADMIN_ENTRY_COUNT_PER_ONE_PAGE, ADMIN_PAGE_COUNT_PER_PAGE_GROUP);
		List<ClassUser> list = classMapper.listBeforeClassPaged(paging.getFirstOffset(), paging.getLastOffset(), mode, param);
		ClassUserPagedList pagedList = new ClassUserPagedList();
		pagedList.setList(list);
		if(pagedList != null){
			pagedList.setPaging(paging);
		
			int count = classMapper.countBeforeClassPaged(mode, param);
			pagedList.setTotalEntryCount(count);
		}
		
		return pagedList;
	}
	
	@Transactional
	public ServiceResult procDraw(int idx){
		
		classMapper.updateDrawReset();
		
		List<ClassDrawFactor> factorList = classMapper.listDrawFactorDetail();
		for(ClassDrawFactor factor : factorList){
			int all_vip = 0;
			int regular_cnt = 0;
			int associate_cnt = 0;
			int general_cnt = 0;
			int regular_man_cnt = 0;
			int associate_man_cnt = 0;
			int general_man_cnt = 0;
			int regular_women_cnt = 0;
			int associate_women_cnt = 0;
			int general_women_cnt = 0;
			
			//vip 인원 산정
			List<ClassUser> vipList = classMapper.listVipUser();
			for(ClassUser user : vipList){
				if(factor.getIdx_no() == Integer.parseInt(user.getC_idx())){
					if("01".equals(user.getEm_type())){  // 정회원
						if("1".equals(user.getGender())) // 여자
							regular_women_cnt++;
						else
							regular_man_cnt++;
						
						regular_cnt++;
						all_vip++;
					}
					else if("02".equals(user.getEm_type())){  // 준회원
						if("1".equals(user.getGender())) // 여자
							associate_women_cnt++;
						else
							associate_man_cnt++;
						
						associate_cnt++;
						all_vip++;
					}
					else if("03".equals(user.getEm_type())){  // 일반회원
						if("1".equals(user.getGender())) // 여자
							general_women_cnt++;
						else
							general_man_cnt++;
						
						general_cnt++;
						all_vip++;
					}
				}
			}
			
			//추첨비율
			
			int total = factor.getTotal();
			int mt = 0;
			int wt = 0;
			
			if(total < (factor.getGeneral_cnt() + factor.getAssociate_cnt() + factor.getRegular_cnt())){
				if(factor.getWomen() > 0 || factor.getMan() > 0){
					wt = (factor.getWomen() * total ) / 100;
					mt = total - wt;
					
					logger.debug("############### DRAW wt : " + wt);
					logger.debug("############### DRAW mt : " + mt);
					
					
					// 정, 준, 일 추가 비율 적용
					if(factor.getClass_a_count() > 0 || factor.getClass_b_count() > 0 || factor.getClass_c_count() > 0){
						int gwcnt = (factor.getClass_c_count() * factor.getWomen() ) / 100;
						int gmcnt = factor.getClass_c_count() - gwcnt - general_man_cnt;
						gwcnt -= general_women_cnt;
						
						logger.debug("############### DRAW gwcnt : " + gwcnt);
						logger.debug("############### DRAW gmcnt : " + gmcnt);
						
						int awcnt = (factor.getClass_b_count() * factor.getWomen()) / 100;
						int amcnt = factor.getClass_b_count() - awcnt - associate_man_cnt;
						awcnt -= associate_women_cnt;
						
						logger.debug("############### DRAW awcnt : " + awcnt);
						logger.debug("############### DRAW amcnt : " + amcnt);
						
						
						int rwcnt = (factor.getClass_a_count() * factor.getWomen()) / 100;
						int rmcnt = factor.getClass_a_count() - rwcnt - regular_man_cnt;
						rwcnt -= regular_women_cnt;
						
						logger.debug("############### DRAW rwcnt : " + rwcnt);
						logger.debug("############### DRAW rmcnt : " + rmcnt);
						
						int t_rwcnt = factor.getRegular_women_cnt() - regular_women_cnt;
						int t_rmcnt = factor.getRegular_man_cnt() - regular_man_cnt;
						int t_awcnt = factor.getAssociate_women_cnt() - associate_women_cnt;
						int t_amcnt = factor.getAssociate_man_cnt() - associate_man_cnt;
						int t_gwcnt = factor.getGeneral_women_cnt() - general_women_cnt;
						int t_gmcnt = factor.getGeneral_man_cnt() - general_man_cnt;
						
						logger.debug("############### DRAW t_rwcnt : " + t_rwcnt + "," + t_rmcnt+ "," + t_awcnt+ "," + t_amcnt+ "," + t_gwcnt+ "," + t_gmcnt);
						
						int twgar = gwcnt + awcnt + rwcnt;
						int tmgar = gmcnt + amcnt + rmcnt;
						
						int t_twgar = t_rwcnt + t_awcnt + t_gwcnt;
						int t_tmgar = t_rmcnt + t_amcnt + t_gmcnt;
						
						logger.debug("############### DRAW twgar : " + twgar + "," + tmgar+ "," + t_twgar+ "," + t_tmgar);
						
						
						if(tmgar > t_tmgar){
							int rr = tmgar - t_tmgar;
//							rwcnt +=  tmgar - t_tmgar;
							
							int r_g = ( factor.getClass_c_count() * rr ) / total;
							int r_a = ( factor.getClass_b_count() * rr ) / total;
							int r_r = rr - r_g - r_a;
							
							rwcnt += r_r;
							awcnt += r_a;
							gwcnt += r_g;
						}
						
						logger.debug("############### DRAW rwcnt : " + rwcnt + "," + awcnt+ "," + gwcnt);
						
						if(twgar > t_twgar){
							int rr = twgar - t_twgar;
//							rmcnt +=  twgar - t_twgar;
							
							int r_g = ( factor.getClass_c_count() * rr ) / total;
							int r_a = ( factor.getClass_b_count() * rr ) / total;
							int r_r = rr - r_g - r_a;
							
							rmcnt += r_r;
							amcnt += r_a;
							gmcnt += r_g;
						}
						
						logger.debug("############### DRAW rmcnt : " + rmcnt + "," + amcnt+ "," + gmcnt);
						///
						
						if(t_rwcnt < rwcnt)
							awcnt += rwcnt - t_rwcnt;
						
						if(t_awcnt < awcnt)
							gwcnt += awcnt - t_awcnt;
						
						if(t_gwcnt < gwcnt )
							awcnt += gwcnt - t_gwcnt;
						
						if(t_awcnt < awcnt)
							rwcnt += awcnt - t_awcnt;
						
						logger.debug("############### DRAW rwcnt1 : " + rwcnt + "," + awcnt+ "," + gwcnt);
						
						///
						
						if(t_rmcnt < rmcnt)
							amcnt += rmcnt - t_rmcnt;
						
						if(t_amcnt < amcnt)
							gmcnt += amcnt - t_amcnt;
						
						if(gmcnt > t_gmcnt)
							amcnt += gmcnt - t_gmcnt;
						
						if(t_amcnt < amcnt)
							rmcnt += amcnt - t_amcnt;
						
						logger.debug("############### DRAW rmcnt2 : " + rmcnt + "," + amcnt+ "," + gmcnt);
						
						if(gmcnt > 0) {
//							classMapper.updateRandDrawStatus(gmcnt, factor.getIdx_no(), "03", 0);
							List<ClassUser> list = classMapper.selectRandDrawStatus(factor.getIdx_no(), "03", 0);
							List<ClassUser> list1 = new ArrayList<ClassUser>(list.subList(0, Math.min(gmcnt, list.size())));
							if(list1.size() > 0)
								classMapper.updateRandDrawStatus(factor.getIdx_no(), list1);
						}
						
						if(amcnt > 0) {
//							classMapper.updateRandDrawStatus(amcnt, factor.getIdx_no(), "02", 0);
							List<ClassUser> list = classMapper.selectRandDrawStatus(factor.getIdx_no(), "02", 0);
							List<ClassUser> list1 = new ArrayList<ClassUser>(list.subList(0, Math.min(amcnt, list.size())));
							if(list1.size() > 0)
								classMapper.updateRandDrawStatus(factor.getIdx_no(), list1);
						}
						if(rmcnt > 0) {
//							classMapper.updateRandDrawStatus(rmcnt, factor.getIdx_no(), "01", 0);
							List<ClassUser> list = classMapper.selectRandDrawStatus(factor.getIdx_no(), "01", 0);
							List<ClassUser> list1 = new ArrayList<ClassUser>(list.subList(0, Math.min(rmcnt, list.size())));
							if(list1.size() > 0)
								classMapper.updateRandDrawStatus(factor.getIdx_no(), list1);
						}
						if(gwcnt > 0){
//							classMapper.updateRandDrawStatus(gwcnt, factor.getIdx_no(), "03", 1);
							List<ClassUser> list = classMapper.selectRandDrawStatus(factor.getIdx_no(), "03", 1);
							List<ClassUser> list1 = new ArrayList<ClassUser>(list.subList(0, Math.min(gwcnt, list.size())));
							if(list1.size() > 0)
								classMapper.updateRandDrawStatus(factor.getIdx_no(), list1);
						}
						if(awcnt > 0) {
//							classMapper.updateRandDrawStatus(awcnt, factor.getIdx_no(), "02", 1);
							List<ClassUser> list = classMapper.selectRandDrawStatus(factor.getIdx_no(), "02", 1);
							List<ClassUser> list1 = new ArrayList<ClassUser>(list.subList(0, Math.min(awcnt, list.size())));
							if(list1.size() > 0)
								classMapper.updateRandDrawStatus(factor.getIdx_no(), list1);
						}
						if(rwcnt > 0) {
//							classMapper.updateRandDrawStatus(rwcnt, factor.getIdx_no(), "01", 1);
							List<ClassUser> list = classMapper.selectRandDrawStatus(factor.getIdx_no(), "01", 1);
							List<ClassUser> list1 = new ArrayList<ClassUser>(list.subList(0, Math.min(rwcnt, list.size())));
							if(list1.size() > 0)
								classMapper.updateRandDrawStatus(factor.getIdx_no(), list1);
						}
						
						int drawResultCnt = classMapper.cntDrawResult(factor.getIdx_no());
						logger.debug("############### DRAW drawResultCnt : " + drawResultCnt);
						
						if(drawResultCnt < total) {
//							classMapper.updateRandDrawStatus(total - drawResultCnt, factor.getIdx_no());
							
							List<ClassUser> list = classMapper.selectRandDrawStatus(factor.getIdx_no());
							List<ClassUser> list1 = new ArrayList<ClassUser>(list.subList(0, Math.min(total - drawResultCnt, list.size())));
							if(list1.size() > 0)
								classMapper.updateRandDrawStatus(factor.getIdx_no(), list1);
							
						}
						
					}else{ // 남여 비율만 적용
						wt = wt - regular_women_cnt - associate_women_cnt - general_women_cnt;
						if(wt < 0){
							mt += wt;
							wt = 0;
						}
						
						mt = mt - regular_man_cnt - associate_man_cnt - general_man_cnt;
						
						int wt_t = factor.getGeneral_women_cnt() + factor.getAssociate_women_cnt() + factor.getRegular_women_cnt() 
									- regular_women_cnt - associate_women_cnt - general_women_cnt;
						
						int mt_t = factor.getGeneral_man_cnt() + factor.getAssociate_man_cnt() + factor.getRegular_man_cnt() 
						- regular_man_cnt - associate_man_cnt - general_man_cnt;
						
						
						if(mt_t < mt)
							wt += mt - mt_t;
						
						if(wt_t < wt)
							mt += wt - wt_t;
						
						if(mt > 0) {
//							classMapper.updateRandDrawStatus(mt, factor.getIdx_no(), 0);
							
							List<ClassUser> list = classMapper.selectRandDrawStatus(factor.getIdx_no(), 0);
							List<ClassUser> list1 = new ArrayList<ClassUser>(list.subList(0, Math.min(mt, list.size())));
							if(list1.size() > 0)
								classMapper.updateRandDrawStatus(factor.getIdx_no(), list1);
							
						}
						if(wt > 0) {
//							classMapper.updateRandDrawStatus(wt, factor.getIdx_no(), 1);
							
							List<ClassUser> list = classMapper.selectRandDrawStatus(factor.getIdx_no(), 1);
							List<ClassUser> list1 = new ArrayList<ClassUser>(list.subList(0, Math.min(wt, list.size())));
							if(list1.size() > 0)
								classMapper.updateRandDrawStatus(factor.getIdx_no(), list1);
						}
					}
					
				}else{ // 남, 여 비율이 없는 경우
					boolean chking=false;
					if(chking) {
						
						int class_a = factor.getClass_a_count();
						int class_b = factor.getClass_b_count();
						int class_c = factor.getClass_c_count();
						
						int acnt = factor.getRegular_cnt();
						int bcnt = factor.getAssociate_cnt();
						int ccnt = factor.getGeneral_cnt();

						if(bcnt < class_b)
							class_a += class_b - bcnt;
						
						if(acnt < class_a)
							class_b += class_a - acnt;
						
						{
							List<ClassUser> list = classMapper.selectRandDrawStatus(factor.getIdx_no(), "01");
							List<ClassUser> list1 = new ArrayList<ClassUser>(list.subList(0, Math.min(class_a, list.size())));
							if(list1.size() > 0)
								classMapper.updateRandDrawStatus(factor.getIdx_no(), list1);
						}
						{
							List<ClassUser> list = classMapper.selectRandDrawStatus(factor.getIdx_no(), "02");
							List<ClassUser> list1 = new ArrayList<ClassUser>(list.subList(0, Math.min(class_b, list.size())));
							if(list1.size() > 0)
								classMapper.updateRandDrawStatus(factor.getIdx_no(), list1);
						}
						{
							List<ClassUser> list = classMapper.selectRandDrawStatus(factor.getIdx_no(), "03");
							List<ClassUser> list1 = new ArrayList<ClassUser>(list.subList(0, Math.min(class_c, list.size())));
							if(list1.size() > 0)
								classMapper.updateRandDrawStatus(factor.getIdx_no(), list1);
						}
						
						
					}else if(factor.getClass_a_count() > 0 || factor.getClass_b_count() > 0 || factor.getClass_c_count() > 0){
						logger.info("}else{ // 남, 여 비율이 없는 경우");
						
						int gcnt = factor.getClass_c_count() - general_cnt;
						int acnt = factor.getClass_b_count() - associate_cnt;
						int rcnt = factor.getClass_a_count() - regular_cnt;
						
						//vip 제외
						if(gcnt < 0 ){
							acnt += gcnt;
							gcnt = 0;
						}
						
						if(acnt < 0){
							rcnt += acnt;
							acnt = 0;
						}

						int t_rcnt = factor.getRegular_cnt() - regular_cnt;
						int t_acnt = factor.getAssociate_cnt() - associate_cnt;
						int t_gcnt = factor.getGeneral_cnt() - general_cnt;
	
						if(t_rcnt < rcnt)
							acnt += rcnt - t_rcnt;
						
						if(t_acnt < acnt)
							gcnt += acnt - t_acnt;
						
						if(t_gcnt < gcnt )
							acnt += gcnt - t_gcnt;
						
						if(t_acnt < acnt)
							rcnt += acnt - t_acnt;
						
						if(rcnt > 0) {
//							classMapper.updateRandDrawStatus(rcnt, factor.getIdx_no(), "01");
							
							List<ClassUser> list = classMapper.selectRandDrawStatus(factor.getIdx_no(), "01");
							List<ClassUser> list1 = new ArrayList<ClassUser>(list.subList(0, Math.min(rcnt, list.size())));
							if(list1.size() > 0)
								classMapper.updateRandDrawStatus(factor.getIdx_no(), list1);
							
						}
						if(acnt > 0) {
//							classMapper.updateRandDrawStatus(acnt, factor.getIdx_no(), "02");
							
							List<ClassUser> list = classMapper.selectRandDrawStatus(factor.getIdx_no(), "02");
							List<ClassUser> list1 = new ArrayList<ClassUser>(list.subList(0, Math.min(acnt, list.size())));
							if(list1.size() > 0)
								classMapper.updateRandDrawStatus(factor.getIdx_no(), list1);
						}
						if(gcnt > 0) {
//							classMapper.updateRandDrawStatus(gcnt, factor.getIdx_no(), "03");
							
							List<ClassUser> list = classMapper.selectRandDrawStatus(factor.getIdx_no(), "03");
							List<ClassUser> list1 = new ArrayList<ClassUser>(list.subList(0, Math.min(gcnt, list.size())));
							if(list1.size() > 0)
								classMapper.updateRandDrawStatus(factor.getIdx_no(), list1);
						}
						
					}else{
						//비율 적용 하지 않음
						// 랜덤합격
//						classMapper.updateRandDrawStatus(total - all_vip, factor.getIdx_no());
						
						List<ClassUser> list = classMapper.selectRandDrawStatus(factor.getIdx_no());
						List<ClassUser> list1 = new ArrayList<ClassUser>(list.subList(0, Math.min(total - all_vip, list.size())));
						if(list1.size() > 0)
							classMapper.updateRandDrawStatus(factor.getIdx_no(), list1);
						
						
					}
				}
				
				//대기자 랜덤 추첨
				if(factor.getClass_standby_count() > 0) {
//					classMapper.updateRandDrawWaitStatus(factor.getClass_standby_count(), factor.getIdx_no());
					
					List<ClassUser> list = classMapper.selectRandDrawWaitStatus(factor.getIdx_no());
					List<ClassUser> list1 = new ArrayList<ClassUser>(list.subList(0, Math.min(factor.getClass_standby_count(), list.size())));
					classMapper.updateRandDrawWaitStatus(factor.getIdx_no(), list1);
					
				}
			}else{
				// 전체 합격
				classMapper.updateRandDrawStatus(factor.getIdx_no());
			}
		}
		
		return ServiceResult.SUCCESS;
	}
	
//	@Transactional
//	public ServiceResult procDraw(int idx){
//		
//		List<ClassDrawFactor> factorList = classMapper.listDrawFactorDetail();
//		for(ClassDrawFactor factor : factorList){
//			int all_vip = 0;
//			int regular_cnt = 0;
//			int associate_cnt = 0;
//			int general_cnt = 0;
//			int regular_man_cnt = 0;
//			int associate_man_cnt = 0;
//			int general_man_cnt = 0;
//			int regular_women_cnt = 0;
//			int associate_women_cnt = 0;
//			int general_women_cnt = 0;
//			
//			//vip 인원 산정
//			List<ClassUser> vipList = classMapper.listVipUser();
//			for(ClassUser user : vipList){
//				if(factor.getIdx_no() == Integer.parseInt(user.getC_idx())){
//					if("01".equals(user.getEm_type())){  // 정회원
//						if("1".equals(user.getGender())) // 여자
//							regular_women_cnt++;
//						else
//							regular_man_cnt++;
//						
//						regular_cnt++;
//						all_vip++;
//					}
//					else if("02".equals(user.getEm_type())){  // 준회원
//						if("1".equals(user.getGender())) // 여자
//							associate_women_cnt++;
//						else
//							associate_man_cnt++;
//						
//						associate_cnt++;
//						all_vip++;
//					}
//					else if("03".equals(user.getEm_type())){  // 일반회원
//						if("1".equals(user.getGender())) // 여자
//							general_women_cnt++;
//						else
//							general_man_cnt++;
//						
//						general_cnt++;
//						all_vip++;
//					}
//				}
//			}
//			
//			//추첨비율
//			
//			int total = factor.getTotal();
//			int mt = 0;
//			int wt = 0;
//			
//			if(total < (factor.getGeneral_cnt() + factor.getAssociate_cnt() + factor.getRegular_cnt())){
//				if(factor.getWomen() > 0 || factor.getMan() > 0){
//					wt = (factor.getWomen() * total ) / 100;
//					mt = total - wt;
//					
//					// 정, 준, 일 추가 비율 적용
//					if(factor.getClass_a_count() > 0 || factor.getClass_b_count() > 0 || factor.getClass_c_count() > 0){
//						int gwcnt = (factor.getGeneral() * wt ) / 100 - general_women_cnt;
//						int gmcnt = (factor.getGeneral() * mt ) / 100 - general_man_cnt;
//						
//						int awcnt = (factor.getAssociate() * wt) / 100 - associate_women_cnt;
//						int amcnt = (factor.getAssociate() * mt) / 100 - associate_man_cnt;
//						
//						int rwcnt = wt - gwcnt - awcnt - regular_women_cnt - associate_women_cnt - general_women_cnt;
//						int rmcnt = mt - gmcnt - amcnt - regular_man_cnt - associate_man_cnt - general_man_cnt;
//						
//						int t_rwcnt = factor.getRegular_women_cnt() - regular_women_cnt;
//						int t_rmcnt = factor.getRegular_man_cnt() - regular_man_cnt;
//						int t_awcnt = factor.getAssociate_women_cnt() - associate_women_cnt;
//						int t_amcnt = factor.getAssociate_man_cnt() - associate_man_cnt;
//						int t_gwcnt = factor.getGeneral_women_cnt() - general_women_cnt;
//						int t_gmcnt = factor.getGeneral_man_cnt() - general_man_cnt;
//						
//						int twgar = gwcnt + awcnt + rwcnt;
//						int tmgar = gmcnt + amcnt + rmcnt;
//						
//						int t_twgar = t_rwcnt + t_awcnt + t_gwcnt;
//						int t_tmgar = t_rmcnt + t_amcnt + t_gmcnt;
//						
//						
//						if(tmgar > t_tmgar){
//							int rr = tmgar - t_tmgar;
////							rwcnt +=  tmgar - t_tmgar;
//							
//							int r_g = (factor.getGeneral() * rr ) / 100;
//							int r_a = (factor.getAssociate() * rr) / 100;
//							int r_r = rr - r_g - r_a;
//							
//							rwcnt += r_r;
//							awcnt += r_a;
//							gwcnt += r_g;
//						}
//						
//						if(twgar > t_twgar){
//							int rr = twgar - t_twgar;
////							rmcnt +=  twgar - t_twgar;
//							
//							int r_g = (factor.getGeneral() * rr ) / 100;
//							int r_a = (factor.getAssociate() * rr) / 100;
//							int r_r = rr - r_g - r_a;
//							
//							rmcnt += r_r;
//							amcnt += r_a;
//							gmcnt += r_g;
//						}
//						
//						///
//						
//						if(t_rwcnt < rwcnt)
//							awcnt += rwcnt - t_rwcnt;
//						
//						if(t_awcnt < awcnt)
//							gwcnt += awcnt - t_awcnt;
//						
//						if(t_gwcnt < gwcnt )
//							awcnt += gwcnt - t_gwcnt;
//						
//						if(t_awcnt < awcnt)
//							rwcnt += awcnt - t_awcnt;
//						
//						///
//						
//						if(t_rmcnt < rmcnt)
//							amcnt += rmcnt - t_rmcnt;
//						
//						if(t_amcnt < amcnt)
//							gmcnt += amcnt - t_amcnt;
//						
//						if(gmcnt > t_gmcnt)
//							amcnt += gmcnt - t_gmcnt;
//						
//						if(t_amcnt < amcnt)
//							rmcnt += amcnt - t_amcnt;
//						
//						if(gmcnt > 0)
//							classMapper.updateRandDrawStatus(gmcnt, factor.getIdx_no(), "03", 0);
//						if(amcnt > 0)
//							classMapper.updateRandDrawStatus(amcnt, factor.getIdx_no(), "02", 0);
//						if(rmcnt > 0)
//							classMapper.updateRandDrawStatus(rmcnt, factor.getIdx_no(), "01", 0);
//						if(gwcnt > 0)
//							classMapper.updateRandDrawStatus(gwcnt, factor.getIdx_no(), "03", 1);
//						if(awcnt > 0)
//							classMapper.updateRandDrawStatus(awcnt, factor.getIdx_no(), "02", 1);
//						if(rwcnt > 0)
//							classMapper.updateRandDrawStatus(rwcnt, factor.getIdx_no(), "01", 1);
//						
//					}else{ // 남여 비율만 적용
//						wt = wt - regular_women_cnt - associate_women_cnt - general_women_cnt;
//						if(wt < 0){
//							mt += wt;
//							wt = 0;
//						}
//						
//						mt = mt - regular_man_cnt - associate_man_cnt - general_man_cnt;
//						
//						int wt_t = factor.getGeneral_women_cnt() + factor.getAssociate_women_cnt() + factor.getRegular_women_cnt() 
//									- regular_women_cnt - associate_women_cnt - general_women_cnt;
//						
//						int mt_t = factor.getGeneral_man_cnt() + factor.getAssociate_man_cnt() + factor.getRegular_man_cnt() 
//						- regular_man_cnt - associate_man_cnt - general_man_cnt;
//						
//						
//						if(mt_t < mt)
//							wt += mt - mt_t;
//						
//						if(wt_t < wt)
//							mt += wt - wt_t;
//						
//						if(mt > 0)
//							classMapper.updateRandDrawStatus(mt, factor.getIdx_no(), 0);
//						if(wt > 0)
//							classMapper.updateRandDrawStatus(wt, factor.getIdx_no(), 1);
//					}
//					
//				}else{ // 남, 여 비율이 없는 경우
//					if(factor.getGeneral() > 0 || factor.getAssociate() > 0 || factor.getRegular() > 0){
//						int gcnt = (factor.getGeneral() * total ) / 100 - general_cnt;
//						int acnt = (factor.getAssociate() * total ) / 100 - associate_cnt;
//						int rcnt = total - gcnt - acnt - regular_cnt - general_cnt - associate_cnt;
//						
//						//vip 제외
//						if(gcnt < 0 ){
//							acnt += gcnt;
//							gcnt = 0;
//						}
//						
//						if(acnt < 0){
//							rcnt += acnt;
//							acnt = 0;
//						}
//
//						int t_rcnt = factor.getRegular_cnt() - regular_cnt;
//						int t_acnt = factor.getAssociate_cnt() - associate_cnt;
//						int t_gcnt = factor.getGeneral_cnt() - general_cnt;
//	
//						if(t_rcnt < rcnt)
//							acnt += rcnt - t_rcnt;
//						
//						if(t_acnt < acnt)
//							gcnt += acnt - t_acnt;
//						
//						if(t_gcnt < gcnt )
//							acnt += gcnt - t_gcnt;
//						
//						if(t_acnt < acnt)
//							rcnt += acnt - t_acnt;
//						
//						if(rcnt > 0)
//							classMapper.updateRandDrawStatus(rcnt, factor.getIdx_no(), "01");
//						if(acnt > 0)
//							classMapper.updateRandDrawStatus(acnt, factor.getIdx_no(), "02");
//						if(gcnt > 0)
//							classMapper.updateRandDrawStatus(gcnt, factor.getIdx_no(), "03");
//						
//					}else{
//						//비율 적용 하지 않음
//						// 랜덤합격
//						classMapper.updateRandDrawStatus(total - all_vip, factor.getIdx_no());
//						
//					}
//				}
//				
//				//대기자 랜덤 추첨
//				if(factor.getClass_standby_count() > 0)
//					classMapper.updateRandDrawWaitStatus(factor.getClass_standby_count(), factor.getIdx_no());
//			}else{
//				// 전체 합격
//				classMapper.updateRandDrawStatus(factor.getIdx_no());
//			}
//		}
//		
//		return ServiceResult.SUCCESS;
//	}
	@Transactional
	public ServiceResult openDrawResult(){
		classMapper.updateDrawOpen();
		return ServiceResult.SUCCESS;
	}
	
	@Transactional
	public ServiceResult resetDrawResult(){
		classMapper.updateDrawDefault();
		return ServiceResult.SUCCESS;
	}
	
	@Transactional
	public ServiceResult procCompletClass(){
		classMapper.insertCompletClass();
		classMapper.deleteTempClassMember();
		return ServiceResult.SUCCESS;
	}
	
	@Transactional(readOnly=true)
	public int countPreDrawEnd(){
		return classMapper.cntPreDrawEnd();
	}
	
	@Transactional(readOnly=true)
	public int countDrawView(){
		return classMapper.cntDrawView();
	}
}
