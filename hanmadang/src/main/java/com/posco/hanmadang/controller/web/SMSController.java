package com.posco.hanmadang.controller.web;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.posco.hanmadang.common.Constant.ServiceResult;
import com.posco.hanmadang.controller.CommonController;
import com.posco.hanmadang.mapper.scms.SMSMapper;
import com.posco.hanmadang.sms.SMSComponent;

@Controller
public class SMSController extends CommonController{

	@Autowired SMSMapper SMSMapper;
	
	@RequestMapping(value = "/ajax/sendSms", method = RequestMethod.GET)
	public @ResponseBody String ajax_sendSms(HttpSession session 
			, @RequestParam(value="title", defaultValue="") String title
			, @RequestParam(value="pno", defaultValue="") String pno
			, @RequestParam(value="msg", defaultValue="") String msg
			) throws Exception{
		try{
			if( "".equals(title) || "".equals(pno) || "".equals(msg) ) {
				return ServiceResult.FAIL.name();
			}
			
			SMSComponent smsc = new SMSComponent();
			String strMsg ="";
			try {
				smsc.connect();
			} catch(Exception e) {
				strMsg = "SMS Server 연결에 실패했습니다.";
				return ServiceResult.FAIL.name();
			}

			String strData = String.format("%s\n-포스코한마당-", msg);
			try {
				strMsg = smsc.SendMsg(new String[]{pno}, "0220518835", title, "", strData, 1);
				strMsg = "문자 발송을 완료했습니다.\n" + strMsg;
				strMsg = strMsg.replaceAll("\n", "<br>");
				
			} catch(Exception e) {
				return ServiceResult.FAIL.name();
			}
			smsc.disconnect();

			try {
				SMSMapper.insertSendSms(title, strData, strMsg, pno);
			}catch(Exception e) {
				System.out.println(String.format("err45 %s", e ));
				logger.error(String.format("err %s", e));
			}
			
			return ServiceResult.SUCCESS.name();
				
		}catch(Exception e){
			return ServiceResult.FAIL.name();
		}
	}
}
