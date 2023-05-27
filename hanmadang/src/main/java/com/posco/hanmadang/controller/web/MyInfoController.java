package com.posco.hanmadang.controller.web;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.List;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
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
import com.posco.hanmadang.model.CardReceipt;
import com.posco.hanmadang.model.MainPay;
import com.posco.hanmadang.model.Member;
import com.posco.hanmadang.model.OrderNo;
import com.posco.hanmadang.model.Program;
import com.posco.hanmadang.model.ProgramDetail;
import com.posco.hanmadang.service.MemberService;
import com.posco.hanmadang.service.ProgramService;
import com.posco.hanmadang.util.SignatureUtil;

@Controller
@RequestMapping("/my")
public class MyInfoController extends CommonController{

	private final Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Autowired
	private ProgramService programService;
	@Autowired
	private MemberService memberService;

	@Value("${dev.mode}")
	private boolean dev_mode= false;
	
	/**
	 * 마이페이지 로그인
	 * @return
	 */
	@RequestMapping(value="/login", method=RequestMethod.GET)
	public String login(HttpSession session, Model model){
		session.setAttribute(Constant.MEMBER_ID_SESSION, null);
		session.removeAttribute(Constant.MEMBER_ID_SESSION);
		
		return "web/my/my_login";
	}
	
	/**
	 * 스마트짐
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/smart", method=RequestMethod.GET)
	public String smart(Model model){
		return "web/my/my_smart";
	}
	
	/**
	 * 건강 캘린더
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/smart/calendar", method=RequestMethod.GET)
	public String smart_calendar(Model model){
		return "web/my/my_smart_calendar";
	}
	
	/**
	 * 신체 측정기록
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/smart/body", method=RequestMethod.GET)
	public String smart_body(Model model){
		return "web/my/my_smart_body";
	}
	
	/**
	 * 신체 측정기록
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/smart/recipe", method=RequestMethod.GET)
	public String smart_recipe(Model model){
		return "web/my/my_smart_recipe";
	}
	
	/**
	 * 운동기록
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/smart/athlete", method=RequestMethod.GET)
	public String smart_athlete(Model model){
		return "web/my/my_smart_athlete";
	}
	
	/**
	 * 식사 일기
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/smart/meal", method=RequestMethod.GET)
	public String smart_meal(Model model){
		return "web/my/my_smart_meal";
	}
	
	/**
	 * 수강신청 결제 콜백
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/lecture/pay/return")
	public @ResponseBody String lecture_retrun(Model model, @ModelAttribute(value="payInfo") MainPay payInfo,
			HttpServletResponse response) throws Exception{
		try {
			logger.debug("lecture_retrun ##########################################################");
			logger.debug(payInfo.toString());
			
			OrderNo orderNo = programService.findOrderNo(payInfo.getOid());
			if(orderNo == null)
				return "{\"rescode\":\"99\"}";
			
			ProgramDetail program = programService.findProgram(orderNo.getProgram_code());
			if(program == null)
				return "{\"rescode\":\"99\"}";
			
			if("00".equals(payInfo.getRstCode()) || "0000".equals(payInfo.getRstCode())) {
				payInfo.setSales_amount((Integer.parseInt(payInfo.getSalesPrice()) * 10) / 11);
				payInfo.setVat_amount(Integer.parseInt(payInfo.getSalesPrice()) - payInfo.getSales_amount());
				orderNo.setPay(payInfo);
				
				programService.procPay(orderNo, program);
				programService.updateOrderNoStatus(orderNo.getOrder_no(), Constant.YesNoStatus.Y.name());
				
				logger.debug("##########################################################1");
				
				return "{\"rescode\":\"00\"}";

			}
			
			logger.debug("##########################################################2");
			
			return "{\"rescode\":\"99\"}";
		}catch (Exception e) {
			logger.error(e.getMessage());
			return "{\"rescode\":\"99\"}";
		}
		
//		com.posco.hanmadang.model.MainPay@72fd8858[mbrId=100011,rstCode=00,rstMsg=정상,salesPrice=1000,payKind=1,oid=12345678901234567811,payType=ISP,authType=auth,cardTradeNo=0306C0570038,cardApproveDate=<null>,cardApproveTime=<null>,cardName=KB국민,cardCode=17,installNo=00]
	}
	
	/**
	 * 수강신청 결제 콜백
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/lecture/pay/callback")
	public String lecture_pay_callback(HttpServletResponse response,  Model model, @ModelAttribute(value="payInfo") MainPay payInfo){
		logger.debug("callback ##########################################################");
		logger.debug(payInfo.toString());
		logger.debug("##########################################################");
		
		String msg = "결제가 정상적으로 처리되지 않았습니다.";
		
		if(payInfo != null) {
			if(("00".equals(payInfo.getRstCode()) || "0000".equals(payInfo.getRstCode()))) 
				msg = "결제가 완료되었습니다.";
			else if(!StringUtils.isEmpty(payInfo.getRstCode()))
					msg = "결제가 정상적으로 처리되지 않았습니다. code : " + payInfo.getRstCode();
		}
		
		response.setContentType("text/html; charset=UTF-8");
        PrintWriter out;
		try { 
			out = response.getWriter();
			msg = msg.replaceAll("<","&lt;");
			msg = msg.replaceAll(">","&gt;");
			out.println("<script>alert('" + msg + "'); window.close();window.opener.location.reload(true);</script>");
		    out.flush();
		} catch (IOException e) {
			logger.error(e.getMessage());
		}
		
		return null;
	}
	
	/**
	 * 수강신청 결제 취소
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/lecture/pay/cancel")
	public String lecture_pay_cancel(HttpServletResponse response,  Model model){
		logger.debug("cancel ##########################################################");

		response.setContentType("text/html; charset=UTF-8");
        PrintWriter out;
		try { 
			out = response.getWriter();
			out.println("<script>alert('결제가 취소되었습니다.'); window.close();window.opener.location.reload(true);</script>");
		    out.flush();
		} catch (IOException e) {
			logger.error(e.getMessage());
		}
		
		return null;
	}
	
	/**
	 * 수강신청 내역
	 * @param model
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value="/lecture/pay/open", method=RequestMethod.GET)
	public String lecture_pay_open(HttpSession session, Model model,
			@RequestParam(value="code", defaultValue="") String program_code) throws Exception{
		
		Member member = (Member)session.getAttribute(Constant.MEMBER_SESSION);
		if(member == null)
			return null;
		
		ProgramDetail program = programService.findProgram(program_code);
		if(program == null)
			return null;
		
		model.addAttribute("program", program);
		
		SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMddHHmmss");
		Calendar cal = Calendar.getInstance();
		String timestamp = formatter.format(cal.getTime());
		
		OrderNo orderNo = new OrderNo();
		orderNo.setMember_code(member.getMember_code());
		orderNo.setOrder_no(programService.getReceiptSeq());
		orderNo.setProgram_code(program_code);
		orderNo.setServer_yn(Constant.YesNoStatus.N.name());

		String hash = SignatureUtil.hash("100011", program.getUnit_price(), orderNo.getOrder_no(), timestamp);
		
		orderNo.setHash(hash);
		
		logger.debug("###########order_no : " + orderNo.getOrder_no());
		logger.debug("###########hash : " + hash);
		
		model.addAttribute("orderNo", orderNo);
		
		programService.updateOrderNo(orderNo);
		
		return "web/my/my_lecture_pay";
	}
	
	/**
	 * 수강신청 내역
	 * @param model
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value="/lecture", method=RequestMethod.GET)
	public String lecture(HttpSession session, Model model, @RequestParam(value="code", defaultValue="") String code) throws Exception{
		List<Program> proList = programService.getProgram();
		model.addAttribute("proList", proList);
		if(proList.size() > 0 && StringUtils.isEmpty(code))
			code = proList.get(0).getDetail_code();

		if(!StringUtils.isEmpty(code)){
			List<ProgramDetail> list = programService.getDetailProgram(code);
			model.addAttribute("list", list);
		}
		
		model.addAttribute("code", code);

		Member member = (Member)session.getAttribute(Constant.MEMBER_SESSION);
		if(member != null) {
			List<CardReceipt> reList = programService.getAllReceipt(member.getMember_code());
			model.addAttribute("receipt", reList);
			model.addAttribute("member", member);
		}
		
		Calendar cal = Calendar.getInstance();
		int mon = cal.get(Calendar.MONTH) + 1;
		int hour = cal.get(Calendar.HOUR_OF_DAY);
		int day = cal.get(Calendar.DAY_OF_MONTH);
		
		if(mon % 3 == 0 && day >= 22 && day <= 26 ) {
//		if( day >= 22 && day <= 26 ) {
			if((day == 22 && hour < 11) || (day == 26 && hour >= 21)) {
				model.addAttribute("pay_active", 0);
			}else{
				model.addAttribute("pay_active", 1);
			}
		}else {
			model.addAttribute("pay_active", 0);
		}
//		model.addAttribute("pay_active", 0);
		
		if( ",posco1".indexOf(String.format(",%s", member.getMember_id()))>-1 ) {
			model.addAttribute("pay_active", 1);
		}
		
		
		return "web/my/my_lecture_list";
	}
	
	/**
	 * 시설예약 현황
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/facility", method=RequestMethod.GET)
	public String facility(Model model){
		return "web/my/my_facility_list";
	}
	
	/**
	 * 비밀번호 변경
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/pw/change", method=RequestMethod.GET)
	public String pw(Model model){
		return "web/my/my_pw_change";
	}
	
	@RequestMapping(value = "/pw/change/save", method = RequestMethod.POST)
	public @ResponseBody String pw_save(HttpSession session, 
			@RequestParam(value="pwd", defaultValue="") String pwd,
			@RequestParam(value="new-pwd", defaultValue="") String new_pwd) throws Exception{
		try{
			if(StringUtils.isEmpty(pwd) || StringUtils.isEmpty(new_pwd))
				return ServiceResult.INVALID_PARAM.name();
			
			Member member = (Member)session.getAttribute(Constant.MEMBER_SESSION);
			if(member == null)
				return ServiceResult.INVALID_ACCESS.name();
			
			if(dev_mode) {
			}else {
				Member existMem = memberService.findIdPwd(member.getMember_id(), pwd);
				if(existMem == null)
					return ServiceResult.NOT_MATCHE.name();
			}
			
			member.setMember_pw(new_pwd);
		    ServiceResult result = memberService.updatPassword(member, false);
		    
		    if(result == ServiceResult.SUCCESS)
		    	session.setAttribute(Constant.MEMBER_SESSION, member);
		    else
		    	member.setMember_pw(pwd);
		    
			return result.name();
			
		}catch(Exception e){
			logger.error(e.getMessage());
			return ServiceResult.FAIL.name();
		}
	}
	
	/**
	 * 비밀번호 변경 완료
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/pw/result", method=RequestMethod.GET)
	public String pw_end(Model model){
		return "web/my/my_pw_result";
	}
	
	@RequestMapping(value="/leave", method=RequestMethod.GET)
	public String leave(Model model){
		return "web/my/my_leave";
	}
	
	@RequestMapping(value = "/leave/proc", method = RequestMethod.POST)
	public @ResponseBody String leave_proc(HttpSession session) throws Exception{
		try{
			Member member = (Member)session.getAttribute(Constant.MEMBER_SESSION);
			if(member == null)
				return ServiceResult.INVALID_ACCESS.name();
			
			//todo
			//탈퇴처리
			ServiceResult result = memberService.leave(member.getMember_code());
			return result.name();
		}catch(Exception e){
			logger.error(e.getMessage());
			return ServiceResult.FAIL.name();
		}
	}
}
