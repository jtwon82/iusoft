package com.posco.hanmadang.controller.web;

import java.io.IOException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;

import javax.servlet.http.HttpSession;

import org.apache.commons.lang3.RandomStringUtils;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.posco.hanmadang.common.Constant;
import com.posco.hanmadang.common.Constant.ServiceResult;
import com.posco.hanmadang.controller.CommonController;
import com.posco.hanmadang.model.Member;
import com.posco.hanmadang.service.MemberService;
import com.posco.hanmadang.sms.SMSComponent;
import com.posco.hanmadang.util.DateUtil;

@Controller
@RequestMapping("/login")
public class LoginController extends CommonController{

	@Autowired
	private MemberService memberService;

	@Value("${dev.mode}")
	private boolean dev_mode = false;
	
	@RequestMapping(value = "/member/check", method = RequestMethod.POST)
	public @ResponseBody String check(HttpSession session, 
			@RequestParam(value="id", defaultValue="") String id,
			@RequestParam(value="pwd", defaultValue="") String pwd) throws Exception{
		try{
			if(StringUtils.isEmpty(id) || StringUtils.isEmpty(pwd))
				return ServiceResult.INVALID_PARAM.name();
			
			Member member = memberService.find(id);
			logger.info(String.format("member:%s", member));
			if(member == null)
				return ServiceResult.NOT_FOUND.name();
			
			DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd H:mm:ss.SSS");
			Calendar cal = Calendar.getInstance();
			//비밀번호 5회 체크
			if(member.getPw_miss_cnt() >= 5) {
				//5분 체크
				int min = DateUtil.minutesDiff(dateFormat.parse(member.getPw_miss_dt()), cal.getTime());
				if(min <= 5)
					return ServiceResult.PWD_5MLOCK.name();
			}
			
			if(!dev_mode) {
				// password check
				Member member_pwd = memberService.findIdPwd(id, pwd);
				if(member_pwd == null) {
					memberService.updatePwdMissStatus(member.getMember_code(), member.getPw_miss_cnt() + 1);
					if(member.getPw_miss_cnt() >= 4) // 5회실패 5분락 처리
						return ServiceResult.PWD_LOCK.name();
					
					return ServiceResult.NOT_FOUND.name();
				}else {
					memberService.updatePwdMissStatus(member.getMember_code(), 0);
				}
			}
			
			//휴면 체크
		    if("9".equals(member.getState()))
		    		return ServiceResult.SUCCESS_DOR.name();
		    
		    session.setAttribute(Constant.MEMBER_SESSION, member);
		    
		    memberService.updatLastLogin(member.getMember_code());
		    
		    //패스워드 3개월 체크
		    if(StringUtils.isEmpty(member.getPw_last_dt()))
		    		return ServiceResult.SUCCESS_CHG.name();
		    
			int day = DateUtil.daysDiff(dateFormat.parse(member.getPw_last_dt()), cal.getTime());
			if(day >= 91) 
				return ServiceResult.SUCCESS_CHG.name();
			
				// 최근 비번 변경 일자가 없으면 오늘도 셋팅
//				memberService.updatPassword(member, true);
			
			logger.info(String.format("id:%s, pwd:%s", id, pwd));

			return ServiceResult.SUCCESS.name();
		}catch(Exception e){
			logger.info(e.getMessage());
			return ServiceResult.FAIL.name();
		}
	}
	
	/**
	 * 로그아웃
	 * @return
	 */
	@RequestMapping(value="/member/logout", method=RequestMethod.GET)
	public String login(Model model, HttpSession session){
		session.setAttribute(Constant.MEMBER_SESSION, null);
		session.removeAttribute(Constant.MEMBER_SESSION);
		
		return "redirect:/";
	}
	
	
	
	@RequestMapping(value = "/find/id", method = RequestMethod.POST)
	public @ResponseBody String find_id(HttpSession session, 
			@RequestParam(value="name", defaultValue="") String name,
			@RequestParam(value="hp", defaultValue="") String hp) throws Exception{
		try{
			if(StringUtils.isEmpty(name) || StringUtils.isEmpty(hp))
				return ServiceResult.INVALID_PARAM.name();
			
			Member member = memberService.find(name, hp.replace("-", ""));
			if(member == null)
				return ServiceResult.NOT_FOUND.name();
		    
			session.setAttribute(Constant.MEMBER_ID_SESSION, member);
			
			String randStr = RandomStringUtils.random(6, false, true);
			
			if(!dev_mode) {
				SMSComponent smsc = new SMSComponent();
				String strMsg ="";
				try {
					smsc.connect();
				} catch(Exception e) {
					strMsg = "SMS Server 연결에 실패했습니다.";
					return ServiceResult.FAIL.name();
				} //catch
	
	
				try {
					String strData = String.format("인증번호 : [%s]를 입력하신 후 인증확인 버튼을 클릭하세요.-포스코한마당-", randStr);
					strMsg = smsc.SendMsg(new String[]{hp.replace("-", "")}, "0220518835","", "", strData, 1);
					strMsg = "문자 발송을 완료했습니다.\n" + strMsg;
					strMsg = strMsg.replaceAll("\n", "<br>");
				} catch(IOException e) {
					strMsg = "발송할 수 없습니다.";
					return ServiceResult.FAIL.name();
				}
	
				smsc.disconnect();
			}
			
			//auth send
			member.setSmsAuthNum(randStr);
			member.setAuthOk(false);
			
		    
			return ServiceResult.SUCCESS.name();
		}catch(Exception e){
			logger.error(e.getMessage());
			return ServiceResult.FAIL.name();
		}
	}
	
	@RequestMapping(value = "/find/id/auth", method = RequestMethod.POST)
	public @ResponseBody String auth_id(HttpSession session, 
			@RequestParam(value="auth", defaultValue="") String auth) throws Exception{
		try{
			String ret = ServiceResult.FAIL.name();
			
			if(!StringUtils.isEmpty(auth)){
				Member member = (Member)session.getAttribute(Constant.MEMBER_ID_SESSION);
				if(member != null){
					// 20221222 문자안되서 임시로
//					if(!auth.equals("") ||
					if(dev_mode || member.getSmsAuthNum().equals(auth)){
						member.setAuthOk(true);
						return String.format(Constant.ServiceResultJsonValue, ServiceResult.SUCCESS.name(), member.getMember_id(), member.getInsert_date());
					}else{
						ret = ServiceResult.NOT_MATCHE.name();
					}
				}else{
					ret = ServiceResult.INVALID_ACCESS.name();
				}
			}else{
				ret = ServiceResult.INVALID_PARAM.name();
			}
			
			return String.format(Constant.ServiceResultJsonValue, ret, "", "");
				
		}catch(Exception e){
			logger.error(e.getMessage());
			return ServiceResult.FAIL.name();
		}
	}
	
	@RequestMapping(value = "/find/pw/change", method = RequestMethod.POST)
	public @ResponseBody String pw_save(HttpSession session, 
			@RequestParam(value="pwd", defaultValue="") String new_pwd) throws Exception{
		try{
			if(StringUtils.isEmpty(new_pwd))
				return ServiceResult.INVALID_PARAM.name();
			
			Member member = (Member)session.getAttribute(Constant.MEMBER_ID_SESSION);
			if(member == null || !member.isAuthOk())
				return ServiceResult.INVALID_ACCESS.name();
			
			String oldpwd = member.getMember_pw();
			
			member.setMember_pw(new_pwd);
		    ServiceResult result = memberService.updatPassword(member, false);
		    
		    if(result != ServiceResult.SUCCESS) {
		    		member.setMember_pw(oldpwd);
		    } else { 
		    		memberService.updatLastLogin(member.getMember_code());
		    		
		    		// 휴면해제
//		    		if("9".equals(member.getState()))
//		    			memberService.setDormantActive(member.getMember_code());
		    }
		    
			return result.name();
			
		}catch(Exception e){
			logger.error(e.getMessage());
			return ServiceResult.FAIL.name();
		}
	}
	
	
	//	휴면계정 처리
	@RequestMapping(value="/dormant", method=RequestMethod.GET)
	public String dormant(Model model, HttpSession session){
		return "web/my/my_dor_auth";
	}
	
	@RequestMapping(value = "/dormant/id", method = RequestMethod.POST)
	public @ResponseBody String dormant_id(HttpSession session, 
			@RequestParam(value="name", defaultValue="") String name,
			@RequestParam(value="hp", defaultValue="") String hp) throws Exception{
		try{
			if(StringUtils.isEmpty(name) || StringUtils.isEmpty(hp))
				return ServiceResult.INVALID_PARAM.name();
			
			Member member = memberService.find(name, hp.replace("-", ""));
			if(member == null)
				return ServiceResult.NOT_FOUND.name();
			
			if(!"9".equals(member.getState()))
				return ServiceResult.NOT_FOUND.name();
			
			session.setAttribute(Constant.MEMBER_DOR_SESSION, member);
			
			String randStr = RandomStringUtils.random(6, false, true);
			
			if(!dev_mode) {
				SMSComponent smsc = new SMSComponent();
				String strMsg ="";
				try {
					smsc.connect();
				} catch(Exception e) {
					strMsg = "SMS Server 연결에 실패했습니다.";
					return ServiceResult.FAIL.name();
				} //catch
	
	
				try {
					String strData = String.format("인증번호 : [%s]를 입력하신 후 인증확인 버튼을 클릭하세요.-포스코한마당-", randStr);
					strMsg = smsc.SendMsg(new String[]{hp.replace("-", "")}, "0220518835","", "", strData, 1);
					strMsg = "문자 발송을 완료했습니다.\n" + strMsg;
					strMsg = strMsg.replaceAll("\n", "<br>");
				} catch(IOException e) {
					strMsg = "발송할 수 없습니다.";
					return ServiceResult.FAIL.name();
				}
	
				smsc.disconnect();
			}
			
			//auth send
			member.setSmsAuthNum(randStr);
			member.setAuthOk(false);
			
		    
			return ServiceResult.SUCCESS.name();
		}catch(Exception e){
			logger.error(e.getMessage());
			return ServiceResult.FAIL.name();
		}
	}
	
	@RequestMapping(value = "/dormant/id/auth", method = RequestMethod.POST)
	public @ResponseBody String dormant_auth_id(HttpSession session, 
			@RequestParam(value="auth", defaultValue="") String auth) throws Exception{
		try{
			if(!StringUtils.isEmpty(auth)){
				Member member = (Member)session.getAttribute(Constant.MEMBER_DOR_SESSION);
				if(member != null){
					if(dev_mode || member.getSmsAuthNum().equals(auth)){
						member.setAuthOk(true);
						return ServiceResult.SUCCESS.name();
					}else{
						return ServiceResult.NOT_MATCHE.name();
					}
				}else{
					return ServiceResult.INVALID_ACCESS.name();
				}
			}else{
				return ServiceResult.INVALID_PARAM.name();
			}
				
		}catch(Exception e){
			logger.error(e.getMessage());
			return ServiceResult.FAIL.name();
		}
	}
	
	@RequestMapping(value="/dormant/pwd", method=RequestMethod.GET)
	public String dormant_pwd(Model model, HttpSession session){
		Member member = (Member)session.getAttribute(Constant.MEMBER_DOR_SESSION);
		if(member == null || !member.isAuthOk())
			return "redirect:/";
		
		return "web/my/my_dor_pwd";
	}
	
	@RequestMapping(value = "/dormant/pwd/change", method = RequestMethod.POST)
	public @ResponseBody String dormant_pw_save(HttpSession session, 
			@RequestParam(value="new-pwd", defaultValue="") String new_pwd) throws Exception{
		try{
			if(StringUtils.isEmpty(new_pwd))
				return ServiceResult.INVALID_PARAM.name();
			
			Member member = (Member)session.getAttribute(Constant.MEMBER_DOR_SESSION);
			if(member == null || !member.isAuthOk())
				return ServiceResult.INVALID_ACCESS.name();
			
			String oldpwd = member.getMember_pw();
			
			member.setMember_pw(new_pwd);
		    
		    ServiceResult result = dev_mode ? ServiceResult.SUCCESS : memberService.updatPassword(member, false);
		    
		    if(result != ServiceResult.SUCCESS) {
		    		member.setMember_pw(oldpwd);
		    } else { // 휴면해제
		    		memberService.updatLastLogin(member.getMember_code());
		    		memberService.setDormantActive(member.getMember_code());
		    }
		    
			return result.name();
			
		}catch(Exception e){
			logger.error(e.getMessage());
			return ServiceResult.FAIL.name();
		}
	}
}
