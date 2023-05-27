package com.posco.hanmadang.controller.web;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.posco.hanmadang.common.Constant;
import com.posco.hanmadang.common.Constant.ServiceResult;
import com.posco.hanmadang.controller.CommonController;
import com.posco.hanmadang.model.ClassDate;
import com.posco.hanmadang.model.ClassInfo;
import com.posco.hanmadang.model.ClassUser;
import com.posco.hanmadang.model.Employee;
import com.posco.hanmadang.security.PasswordEncoding;
import com.posco.hanmadang.service.ClassService;
import com.posco.hanmadang.service.EmployeeService;
import com.posco.hanmadang.util.Util;

@Controller
@RequestMapping("/lecture")
public class LectureController extends CommonController{

	@Autowired
	private ClassService classService;
	
	@Autowired
	private EmployeeService employeeService;
	
	/**
	 * 수강신청안내
	 * @return
	 */
	@RequestMapping(value="/info", method=RequestMethod.GET)
	public String info(Model model){
		return "web/lecture/lecture_info";
	}
	
	/**
	 * 온라인결제 안내
	 * @return
	 */
	@RequestMapping(value="/pay", method=RequestMethod.GET)
	public String pay(Model model){
		return "web/lecture/lecture_pay";
	}
	
	/**
	 * 수강신청안내
	 * @return
	 */
	@RequestMapping(value="/type", method=RequestMethod.GET)
	public String member_type(){
		return "web/lecture/lecture_type";
	}
	
	/**
	 * 수강신청
	 * @return
	 */
	@RequestMapping(value="/member/select", method=RequestMethod.GET)
	public String member_select(Model model, 
			@RequestParam(value="cates", defaultValue="") String cates,
			@RequestParam(value="keyword", defaultValue="") String keyword){
		List<ClassInfo> mainList = classService.getMainClass();
		model.addAttribute("mainList", mainList);
		
		model.addAttribute("keyword", keyword);
		
		List<ClassInfo> subList = classService.findActiveSubClass(null, null);
		model.addAttribute("subList", subList);
		
		return "web/lecture/lecture_member_select";
	}
	
	@RequestMapping(value = "/member/class/save", method = RequestMethod.POST)
	public @ResponseBody String member_class_save(HttpSession session, 
			@RequestParam(value="c_num", defaultValue="0") int c_num) throws Exception{
		try{
			if(c_num <= 0)
				return ServiceResult.INVALID_PARAM.name();
			
			ClassDate classDate = classService.getActiveClassDate();
			if(classDate == null)
				return ServiceResult.INVALID_ACCESS.name();
			
			if(!Util.isBetween(classDate.getStartdate().substring(0, 10), classDate.getEnddate().substring(0, 10)))
				return ServiceResult.INVALID_ACCESS.name();
			
//			Member member = (Member)session.getAttribute(Constant.MEMBER_SESSION);
//			ClassMember cmember = new ClassMember();
//			cmember.setMem_type("01");
//			cmember.setO_name(member.getMember_name());
//			cmember.setE_name(member.getMember_name());
//			cmember.setE_name(member.getMember_name());
			
			return ServiceResult.SUCCESS.name();
		}catch(Exception e){
			logger.error(e.getMessage());
			return ServiceResult.FAIL.name();
		}
	}
	/**
	 * 수강신청완료
	 * @return
	 */
	@RequestMapping(value="/member/result", method=RequestMethod.GET)
	public String member_result(@RequestParam(value="type", defaultValue="2") int type){
		return "web/lecture/lecture_member_result";
	}
	
	@RequestMapping(value="/status")
	public String lecture_status(Model model, HttpSession session, HttpServletResponse response){
		
		ClassDate classDate = classService.getActiveClassDate();
		if(classDate == null || 
				!Util.isBetween(classDate.getStartdate().substring(0, 10), classDate.getEnddate().substring(0, 10))){
			response.setContentType("text/html; charset=UTF-8");
	        PrintWriter out;
			try { 
				out = response.getWriter();
				out.println("<script>alert('수강신청 기간이 아닙니다.'); history.go(-1);</script>");
			    out.flush();
			} catch (IOException e) {
				logger.error(e.getMessage());
			}
			
			return null;
		}
		
		// 클래스 항목 그룹
		List<ClassInfo> mainList = classService.getMainClass();
		model.addAttribute("mainList", mainList);
		
		// 상세 클래스 항목
		List<ClassInfo> subList = classService.findActiveSubClass(null, null);
		model.addAttribute("subList", subList);
		
		return "web/lecture/lecture_user_status";
	}
	
	@RequestMapping(value="/user/terms")
	public String user_terms(HttpSession session, HttpServletResponse response){
		session.setAttribute(Constant.LECTURE_SESSION, null);
		session.removeAttribute(Constant.LECTURE_SESSION);
		
		ClassDate classDate = classService.getActiveClassDate();
		if(classDate == null || 
				!Util.isBetween(classDate.getStartdate().substring(0, 10), classDate.getEnddate().substring(0, 10))){
			response.setContentType("text/html; charset=UTF-8");
	        PrintWriter out;
			try { 
				out = response.getWriter();
				out.println("<script>alert('수강신청 기간이 아닙니다.'); history.go(-1);</script>");
			    out.flush();
			} catch (IOException e) {
				logger.error(e.getMessage());
			}
			
			return null;
		}

		return "web/lecture/lecture_user_terms";
	}
	
	/**
	 * @param session
	 * @param em_type 
	 * @param reload
	 * @return
	 */
	@RequestMapping(value="/user/type", method=RequestMethod.GET)
	public String user_type(HttpSession session){
		return "web/lecture/lecture_user_type";
	}

	@RequestMapping(value="/user/type2", method=RequestMethod.GET)
	public String user_type2(Model model, HttpSession session,
			@RequestParam(value="em_type", defaultValue="") String em_type){
		model.addAttribute("em_type", em_type);
		
		return "web/lecture/lecture_user_type2";
	}
	
	/**
	 * @param em_type 01 포스코 직원 및 가족(정회원), 02 포스코 ob 및 패밀리 가족 (준회원), 03 지역 및 일반주민(일반회원)
	 * @return
	 */
	@RequestMapping(value="/user/input", method=RequestMethod.GET)
	public String user_input(Model model, HttpSession session,
			@RequestParam(value="em_type", defaultValue="") String em_type,
			@RequestParam(value="em_type2", defaultValue="") String em_type2){
		
//		model.addAttribute("em_type2", em_type2);
		
		ClassUser member = (ClassUser)session.getAttribute(Constant.LECTURE_SESSION);
		if(StringUtils.isEmpty(em_type) && member != null)
			em_type = member.getEm_type();
			
		if(member == null) // page reload, 1 = back reload
			member = new ClassUser();
			
		member.setEm_type(em_type);
		member.setEm_type2(em_type2);
		member.setStep(1);
		
		if(StringUtils.isEmpty(em_type))
			return "redirect:/lecture/user/type";
		
		session.setAttribute(Constant.LECTURE_SESSION, member);
		
		if(em_type.equals("01"))
			return "web/lecture/lecture_user_form_regular";
		else if(em_type.equals("02"))
			return "web/lecture/lecture_user_form_associate";
		else
			return "web/lecture/lecture_user_form_general";
	}
	
	@RequestMapping(value = "/user/input/check", method = RequestMethod.POST)
	public @ResponseBody String user_input_check(HttpSession session,
			@ModelAttribute(value="classMember") ClassUser member) throws Exception{
		try{
			logger.info("member {}", member);
			
			ClassUser smember = (ClassUser)session.getAttribute(Constant.LECTURE_SESSION);
			if( smember == null)
				return ServiceResult.INVALID_ACCESS.name();
			
			if(smember.getStep() != 1)
				return ServiceResult.INVALID_ACCESS2.name();
			
			logger.info("member {}", member);
			
			member.setRem_type(Constant.YesNoStatus.N.name());
			
			if(!"03".equals(member.getEm_type())){ // 일반회원은 체크하지 않음
				Employee employee = employeeService.find(member.getE_no());
				if(employee == null){
					// 정회원 확인
					if("01".equals(member.getEm_type()))
						return ServiceResult.NOT_FOUND.name(); // 정회원 아님
				}else{
					// 정회원 확인
					if("01".equals(member.getEm_type()) && 
							!Constant.YesNoStatus.Y.name().equals(employee.getEm_type()))
						return ServiceResult.INVALID_TYPE.name(); //미등록, 회원구분 오류
					
					if("01".equals(member.getEm_type()) && 
							!member.getE_name().equals(employee.getEm_name()))
						return ServiceResult.NOT_FOUND.name(); //직원명 불일치
					
//					if("02".equals(member.getEm_type()))
//						return ServiceResult.INVALID_PARAM.name(); // 재직자, 회원구분 오류
					
					member.setRem_type(employee.getEm_type());
				}
			}
			
			ClassDate classDate = classService.getActiveClassDate();
			if(classDate == null)
				return ServiceResult.INVALID_ACCESS.name();
			
			if(!Util.isBetween(classDate.getStartdate().substring(0, 10), classDate.getEnddate().substring(0, 10)))
				return ServiceResult.INVALID_ACCESS.name();
			
			member.setDidx(classDate.getIdx_no());
			
			String year = classDate.getStartdate().substring(0, 4);
			String month = classDate.getStartdate().substring(5, 7);
			
			member.setClass_year(year);
			member.setClass_month(month);
			member.setClass_yn(Constant.YesNoStatus.N.name());
			
			if(!"03".equals(member.getEm_type())) {
				member.setPartname(member.getPartname() + " / " + member.getPartname1());
				
				//정직원, 준회원 본인인 경우
				if("본인".equals(member.getMem_type()))
					member.setO_name(member.getE_name());
			}
			
			ClassUser user = classService.findAppliedOneUser(member);
			if(user != null) {
				if(user.getIdx_no() == -1 && !"본인".equals(member.getMem_type()))
					return ServiceResult.DUPLICATE2.name(); // 이미 동일명 등록 등록
				
				return ServiceResult.DUPLICATE.name(); // 이미 등록
			}
			member.setStep(2);
			member.setTel(member.getHp());
			
			session.setAttribute(Constant.LECTURE_SESSION, member);
			
			return ServiceResult.SUCCESS.name();
		}catch(Exception e){
			logger.error(e.getMessage());
			return ServiceResult.FAIL.name();
		}
	}
	
	@RequestMapping(value="/user/select")
	public String user_select(Model model, HttpSession session,
			@RequestParam(value="cates", defaultValue="") String cates,
			@RequestParam(value="keyword", defaultValue="") String keyword){
		ClassUser member = (ClassUser)session.getAttribute(Constant.LECTURE_SESSION);
		if( member == null)
			return "redirect:/lecture/user/type";
		
		if(StringUtils.isEmpty(member.getEm_type()))
			return "redirect:/lecture/user/type";
		
		if(member.getStep() < 2)
			return "redirect:/lecture/user/input";
		
		member.setStep(3);
		
//		session.setAttribute(Constant.LECTURE_SESSION, member);
		
		// 클래스 항목 그룹
		List<ClassInfo> mainList = classService.getMainClass();
		model.addAttribute("mainList", mainList);
		
		model.addAttribute("keyword", keyword);
		
		// 상세 클래스 항목
		List<ClassInfo> subList = classService.findActiveSubClass(null, null);
		model.addAttribute("subList", subList);
		
		return "web/lecture/lecture_user_select";
	}
	
	
	@RequestMapping(value = "/user/select/check", method = RequestMethod.POST)
	public @ResponseBody String user_select_check(HttpSession session,
			@RequestParam(value="c_idx", defaultValue="") String c_idx) throws Exception{
		try{
			
			ClassUser member = (ClassUser)session.getAttribute(Constant.LECTURE_SESSION);
			if( member == null)
				return ServiceResult.INVALID_ACCESS.name();
			
			if(member.getStep() != 3)
				return ServiceResult.INVALID_ACCESS.name();
			
//			member.setRem_type(Constant.YesNoStatus.N.name());
//			
//			if(!"03".equals(member.getEm_type())){ // 일반회원은 체크하지 않음
//				Employee employee = employeeService.find(member.getE_no());
//				if(employee == null){
//					// 정회원 확인
//					if("01".equals(member.getEm_type()))
//						return ServiceResult.NOT_FOUND.name(); // 정회원 아님
//				}else{
//					// 정회원 확인
//					if("01".equals(member.getEm_type()) && 
//							!Constant.YesNoStatus.Y.name().equals(employee.getEm_type()))
//						return ServiceResult.INVALID_TYPE.name(); //미등록, 회원구분 오류
//					
//					if("02".equals(member.getEm_type()))
//						return ServiceResult.INVALID_PARAM.name(); // 재직자, 회원구분 오류
//					
//					member.setRem_type(employee.getEm_type());
//				}
//			}
//			
//			ClassDate classDate = classService.getActiveClassDate();
//			if(classDate == null)
//				return ServiceResult.INVALID_ACCESS.name();
//			
//			if(!Util.isBetween(classDate.getStartdate().substring(0, 10), classDate.getEnddate().substring(0, 10)))
//				return ServiceResult.INVALID_ACCESS.name();
//			
//			member.setDidx(classDate.getIdx_no());
//			
//			String year = classDate.getStartdate().substring(0, 4);
//			String month = classDate.getStartdate().substring(5, 7);
//			
//			member.setClass_year(year);
//			member.setClass_month(month);
//			member.setClass_yn(Constant.YesNoStatus.N.name());
//			
//			//정직원에 본인인 경우
//			if("01".equals(member.getEm_type()) && "본인".equals(member.getMem_type()))
//				member.setO_name(member.getE_name());
//			
//			member.setPartname(member.getPartname() + " / " + member.getPartname1());
//			
//			ClassUser user = classService.findAppliedOneUser(member);
//			if(user != null)
//				return ServiceResult.DUPLICATE.name(); // 이미 등록
//			
			member.setStep(4);
			member.setC_idx(c_idx);
			
//			session.setAttribute(Constant.LECTURE_SESSION, member);
			
			return ServiceResult.SUCCESS.name();
		}catch(Exception e){
			logger.error(e.getMessage());
			return ServiceResult.FAIL.name();
		}
	}
	
	@RequestMapping(value="/user/pw", method=RequestMethod.GET)
	public String user_pw(HttpSession session){
		
		ClassUser member = (ClassUser)session.getAttribute(Constant.LECTURE_SESSION);
		if( member == null)
			return "redirect:/lecture/user/type";
		
		if(StringUtils.isEmpty(member.getEm_type()))
			return "redirect:/lecture/user/type";
		
		if(member.getStep() < 4)
			return "redirect:/lecture/user/select";
		
		member.setStep(5);
		
		return "web/lecture/lecture_user_pw";
	}
	
	@RequestMapping(value = "/user/save", method = RequestMethod.POST)
	public @ResponseBody String user_input_save(HttpSession session,
			@RequestParam(value="pass", defaultValue="") String pass) throws Exception{
		try{
			if(StringUtils.isEmpty(pass))
				return ServiceResult.INVALID_PARAM.name();
			
			ClassUser member = (ClassUser)session.getAttribute(Constant.LECTURE_SESSION);
			if( member == null)
				return ServiceResult.INVALID_ACCESS.name();
			
			if(StringUtils.isEmpty(member.getEm_type()))
				return ServiceResult.INVALID_TYPE.name();
			
			if(member.getStep() != 5)
				return ServiceResult.INVALID_ACCESS.name();
			
			member.setPass(pass);
			
			PasswordEncoder passwordEncoding = new PasswordEncoding();
			String encodePass = passwordEncoding.encode(member.getPass());
			member.setPass(encodePass);
			
			ServiceResult result = classService.addAppliedUser(member);
			logger.info("classService.addAppliedUser member {}", member);
			
			if(result == ServiceResult.SUCCESS) {
				session.setAttribute(Constant.LECTURE_SESSION, null);
				session.removeAttribute(Constant.LECTURE_SESSION);
			}
			
			return result.name();
		}catch(Exception e){
			logger.error(e.getMessage());
			return ServiceResult.FAIL.name();
		}
	}
	
	@RequestMapping(value="/user/result", method=RequestMethod.GET)
	public String user_result(HttpSession session){
		session.setAttribute(Constant.LECTURE_SESSION, null);
		session.removeAttribute(Constant.LECTURE_SESSION);
		
		return "web/lecture/lecture_user_result";
	}
	
	/**
	 * 수강신청내역조회
	 * @return
	 */
	@RequestMapping(value="/list")
	public String class_list(HttpSession session, Model model,
			@RequestParam(value="hp", defaultValue="") String hp,
			@RequestParam(value="pass", defaultValue="") String pass,
			@RequestParam(value="success", defaultValue="0") String success,
			HttpServletResponse response){
		
		session.setAttribute(Constant.LECTURE_RESULT_SESSION, null);
		
		ClassDate classDate = classService.getActiveClassDate();
		if(classDate == null || 
				!Util.isBetween(classDate.getStartdate().substring(0, 10), classDate.getEnddate().substring(0, 10))){
			response.setContentType("text/html; charset=UTF-8");
	        PrintWriter out;
			try { 
				out = response.getWriter();
				out.println("<script>alert('수강신청 기간이 아닙니다.'); history.go(-1);</script>");
			    out.flush();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				System.out.println(e.getMessage());
			}
			
			return null;
		}
		
		model.addAttribute("hp", hp);
		model.addAttribute("pass", pass);
		
		if(!StringUtils.isEmpty(pass) && !StringUtils.isEmpty(hp)){
			PasswordEncoder passwordEncoding = new PasswordEncoding();
			List<ClassUser> list = classService.findAppliedUser(hp, null);
			
			List<ClassUser> matchList = new ArrayList<ClassUser>();
			for(ClassUser user : list){
				if(passwordEncoding.matches(pass, user.getPass()))
					matchList.add(user);
			}
			
			model.addAttribute("list", matchList);
			session.setAttribute(Constant.LECTURE_RESULT_SESSION, list);
			
			if(list.size() > 0 && matchList.size() <= 0)
				model.addAttribute("result", Constant.ServiceResult.NOT_MATCHE.name());
		}
		
		if(classDate == null || 
				!Util.isBetween(classDate.getStartdate().substring(0, 10), classDate.getEnddate().substring(0, 10)))
			model.addAttribute("classDate", null);
		else
			model.addAttribute("classDate", classDate);
		
		model.addAttribute("success", success);
		
		return "web/lecture/lecture_class";
	}
	
	@RequestMapping(value = "/user/delete", method = RequestMethod.POST)
	public @ResponseBody String user_delete(HttpSession session,
			@RequestParam(value="idx_no", defaultValue="0") long idx_no) throws Exception{
		try{
			
			@SuppressWarnings("unchecked")
			List<ClassUser> list = (List<ClassUser>)session.getAttribute(Constant.LECTURE_RESULT_SESSION);
			if( list == null)
				return ServiceResult.INVALID_ACCESS.name();
			
			boolean isActive = false;
			for(ClassUser user : list){
				if(user.getIdx_no() == idx_no){
					isActive = true;
					break;
				}
			}
			
			if(!isActive)
				return ServiceResult.INVALID_ACCESS.name();
			
			ServiceResult result = classService.removeAppliedUser(idx_no);
			return result.name();
			
		}catch(Exception e){
			System.out.println(e.getMessage());
			return ServiceResult.FAIL.name();
		}
	}
	
	/**
	 * 선정자 발표
	 * @return
	 */
	@RequestMapping(value="/result")
	public String class_reuslt(Model model, @RequestParam(value="hp", defaultValue="") String hp,
			@RequestParam(value="pass", defaultValue="") String pass,
			HttpServletResponse response){
		
		int view_cnt = classService.countDrawView();
		if(dev_mode) {} else {
			if(view_cnt <= 0) {
				response.setContentType("text/html; charset=UTF-8");
		        PrintWriter out;
				try { 
					out = response.getWriter();
					out.println("<script>alert('선정자 발표 기간이 아닙니다.'); history.go(-1);</script>");
				    out.flush();
				} catch (IOException e) {
					// TODO Auto-generated catch block
					System.out.println(e.getMessage());
				}
				return null;
			}
		}
		
		model.addAttribute("hp", hp);
		model.addAttribute("pass", pass);
		
		if(!StringUtils.isEmpty(pass) && !StringUtils.isEmpty(hp)){
			PasswordEncoder passwordEncoding = new PasswordEncoding();
			List<ClassUser> list = classService.findAppliedUser(hp, Constant.YesNoStatus.Y.name());
			
			List<ClassUser> matchList = new ArrayList<ClassUser>();
			for(ClassUser user : list){
				if(passwordEncoding.matches(pass, user.getPass()) || dev_mode)
					matchList.add(user);
			}
			model.addAttribute("list", matchList);
			
			if(list.size() > 0 && matchList.size() <= 0)
				model.addAttribute("result", Constant.ServiceResult.NOT_MATCHE.name());
		}
		model.addAttribute("invalid", 0);
		
		return "web/lecture/lecture_class_list";
	}
	
	
}
