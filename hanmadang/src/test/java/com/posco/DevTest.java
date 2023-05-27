package com.posco;

import java.io.IOException;
import java.util.Calendar;

import com.posco.hanmadang.sms.SMSComponent;

public class DevTest {

	public static void main(String[] args) throws Exception {

//		DevTest.smsTest();
		for(int i=0; i<12; i++) {

			Calendar cal = Calendar.getInstance();
			int mon = cal.get(i) + 1;
			System.out.println(mon);
		}
	}
	
	public static void smsTest() throws Exception{
//    	String result = DateUtil.getDateParse("yyyy-MM-dd", "20200320");
//    	System.out.println(result);
//		System.out.println(DateUtil.getDate2("yyyy-MM-dd", DateUtil.getDate("yyyyMMdd", "20200321")));
//		System.out.println(DateUtil.getDateToStr("yyyy-MM-dd", DateUtil.getStrToDate("yyyyMMdd", "20200321")));

		SMSComponent smsc = new SMSComponent();
		String strMsg ="";
		try {
			smsc.connect();
		} catch(Exception e) {
			strMsg = "SMS Server 연결에 실패했습니다.";
		} //catch


		try {
			String strData = String.format("인증번호 : [%s]를 입력하신 후 인증확인 버튼을 클릭하세요.-포스코한마당-", "test");
			strMsg = smsc.SendMsg(new String[]{"01068270903"}, "0220518835","", "", strData, 1);
			strMsg = "문자 발송을 완료했습니다.\n" + strMsg;
			strMsg = strMsg.replaceAll("\n", "<br>");
		} catch(IOException e) {
			strMsg = "발송할 수 없습니다.";
		}

		smsc.disconnect();
	}

}
