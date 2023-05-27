package com.posco.hanmadang.scheduler;


import java.io.IOException;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

import org.apache.commons.lang3.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import com.posco.hanmadang.mapper.posco.ClassMapper;
import com.posco.hanmadang.mapper.scms.MemberMapper;
import com.posco.hanmadang.model.Member;
import com.posco.hanmadang.sms.SMSComponent;
@Component
public class BatchScheduler {
	public Logger logger = Logger.getLogger(getClass());

	@Autowired MemberMapper memberMapper;
	@Autowired ClassMapper classMapper;
	
	@Value("${dev.mode}")
	private boolean dev_mode = false;
	
	// 휴면계정 SMS 발송
//		@Scheduled(cron = "0 0 10 * * *") 
//		@Scheduled(fixedDelayString = "60000")
//		public void batch0() { 
//
//
//				String[] list = new String[]{"01025840070", "01065656856"};
//
//				
//				SMSComponent smsc = new SMSComponent();
//				String strMsg ="";
//				try {
//					smsc.connect();
//
//					for(String mem : list) {
//						
//						String strData = "[포스코한마당]정보통신망 이용촉진 및 정보보호 등에 관한 법률, 개정에 따라 1년 이상 서비스 이용 내역이 없는 회원은 휴면계정으로 별도 저장, 관리 할 예정입니다. 포스코한마당 체육관 방문 또는 홈페이지 방문을 하여 주시기 바랍니다. www.poscohanmadang.co.kr";
//						strMsg = smsc.SendMsg(new String[]{mem.replace("-", "")}, "0220518835","", "", strData, 1);
//					
//					}
//				
//					smsc.disconnect();
//					
//				} catch(IOException e) {
//					strMsg = "발송할 수 없습니다.";
//				} catch (Exception e) {
//					// TODO Auto-generated catch block
//					strMsg = "SMS Server 통신에 실패했습니다.";
//				}
//		}
		
	// 휴면계정 SMS 발송
//	@Scheduled(cron = "0 0 10 * * *") 
//	@Scheduled(fixedDelayString = "60000")
	public void batch1() { 
		if(dev_mode)
			return;
		
		int firstOffset = 1;
		int lastOffset = 1000;
		while(true) {
			List<Member> list = memberMapper.listDormant(firstOffset, lastOffset);
			List<Member> validList = new ArrayList<Member>();
			
			if(list == null || list.size() == 0)
				break;
			
			SMSComponent smsc = new SMSComponent();
			String strMsg ="";
			try {
				smsc.connect();

				for(Member mem : list) {
					
					if(!StringUtils.isEmpty(mem.getCellular()) && 
							(StringUtils.isEmpty(mem.getSms_send()) || "N".equals(mem.getSms_send()))) {
						String strData = "[포스코한마당]정보통신망 이용촉진 및 정보보호 등에 관한 법률, 개정에 따라 1년 이상 서비스 이용 내역이 없는 회원은 휴면계정으로 별도 저장, 관리 할 예정입니다. 포스코한마당 체육관 방문 또는 홈페이지 방문을 하여 주시기 바랍니다. www.poscohanmadang.co.kr";
						strMsg = smsc.SendMsg(new String[]{mem.getCellular().replace("-", "")}, "0220518835","", "", strData, 1);
						validList.add(mem);
					}
				}
			
				smsc.disconnect();
				
			} catch(IOException e) {
				strMsg = "발송할 수 없습니다.";
			} catch (Exception e) {
				// TODO Auto-generated catch block
				strMsg = "SMS Server 통신에 실패했습니다.";
			}
			
			logger.info("batch1 : " + strMsg + " size : " + list.size());

//			firstOffset += 1000;
//			lastOffset += 1000;
			
			if(validList.size() > 0)
				memberMapper.updateSmsState(validList);
		}
	}

	// 수강신청 내역 삭제		초 분 시 일 월 주 (년)
	@Scheduled(cron =  "0 10 0 5 * *") 
//	@Scheduled(fixedDelayString = "60000")
	public void batch2() { 
		if(dev_mode)
			return;
		
		Calendar cal = Calendar.getInstance();
		int mon = cal.get(Calendar.MONTH) + 1;
		
		if(mon % 3 != 0) {   // 수강신청 달 제외 후 삭제 처리
			classMapper.truncateTempClassMember();
			classMapper.deleteClassMember();
		}
		
	}
}



	