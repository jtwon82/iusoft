package com.posco.hanmadang.scheduler;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;

import org.apache.commons.lang3.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Async;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import com.posco.hanmadang.mapper.scms.RentMapper;
import com.posco.hanmadang.model.RentReserve;
import com.posco.hanmadang.model.RentReserveCnt;
import com.posco.hanmadang.util.Util;

@Component
public class RentBatchScheduler {

	public Logger logger = Logger.getLogger(getClass());
	
	@Autowired RentMapper rentMapper;
	
//	@Value("${batch.active.mode}")
//    private boolean isActive;
	
	String courtUsed ="";
	
	@Async
	public void auto(){
		doProc();
	}
	
	public void manual(){
		doProc();
	}
	
	public void doProc() { 
		try{
			String part_cd = "15";
			String failed_clnum = "";
			
			SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMdd");
			Calendar cal = Calendar.getInstance();
			String nowdate  = formatter.format(cal.getTime());
			
			cal.add(Calendar.DAY_OF_MONTH, 13);
			String after14days  = formatter.format(cal.getTime());
			
			cal.add(Calendar.DAY_OF_MONTH, -30);
			String oneMonthAgo  = formatter.format(cal.getTime());
			
			String[] rentTime = new String[]{"0500","0700","0900","1100","1300","1500",
					"1700","1800","1830","2030","2230","2330"};
			
			String beforeTime = "";
			
			List<RentReserve> fixedReserve = null;
			
			List<RentReserve> reTimes = rentMapper.listReRentTime(after14days);
			for(RentReserve reTime : reTimes){
				/*

				- 추첨 후 코트는 회사,동호회 예약 코트에 한해 랜덤으로 배분
				- 신청 시 코트 수 제한 없음(동호인 예약 최대 6코트까지 신청 가능)
				- 신청 코트에 한해 나누어 배분
				 ex) 총 6코트 : -신청건이 6팀 일 때 1코트씩 나누어 배분
								  -신청건이 6팀 초과일 때 한 코트씩 추첨하여 배분
								  -신청건이 6팀 미만일 때 신청 동호회 1코트씩 배분 후 남은코트 1코트 이상 신청한 동호회 추첨 하여 추가 배분 실시
				- 단, 총 6코트 중 [회사행사] 예약 코트 배제 후 남은 코트 추첨/배분
				- 코트 배분 : 1코트 배분 시 : 랜덤 배분
							  2코트 배분 시 : 5번,6번 / 7번,8번 / 9번,10번  -> 8,9 / 10,11 / 7,12
							  3코트 배분 시 : 7번,8번,9번 / 5번,6번,10번 -> 8,9,10 / 7,11,12
							  4코트 배분 시 : 7번,8번,9번,10번 -> 8,9,10,11
							  5코트 배분 시 : 6번,7번,8번,9번,10번 -> 8,9,10,11,12


				*/
				courtUsed = "";
				String ticket_date = reTime.getRe_date();
				String stime		= reTime.getRt_stime();
				String etime		= reTime.getRt_etime();
				
				String use_days = Util.getYoil(ticket_date);
				
				String rentCourt = null;
				String rentSTime = null;
				String rentETime = null;
				String rentCnt   = null;
				String rentCourtCnt   = null;
				
				if(fixedReserve == null)
					fixedReserve = rentMapper.listFixedReserve(Integer.parseInt(part_cd), use_days, ticket_date);
				
				for(RentReserve fixedTime : fixedReserve){
					String mycom_nm = fixedTime.getRe_title();
					String myetc = fixedTime.getRt_court();
					String myreserve_date = fixedTime.getRt_stime();
					String myret_date = fixedTime.getRt_etime();

					String mySTime = myreserve_date;
					String myETime = myret_date;
					
					//사용시간구분
					if(Integer.parseInt(mySTime)<Integer.parseInt(etime) && Integer.parseInt(myETime)>Integer.parseInt(stime) ){
						//사용코트 구분
						for(int j=7; j <= 12; j++){
							if(myetc.contains("전체") || myetc.contains(j + "코트")){

								if(!courtUsed.contains(j + "c")) courtUsed += !StringUtils.isEmpty(courtUsed) ? "," + j + "c" : j + "c";

							}
						}
					}
				}
				
				logger.info("기존프로그램 예약코트: " + courtUsed);
				
				// 현프로그램에서 회사행사 예약정보
				List<RentReserve> existReserve = rentMapper.listExistReserve(Integer.parseInt(part_cd), ticket_date, stime, etime);
				
				for(RentReserve existTime : existReserve){
					String mycom_nm = existTime.getCl_name() != null ? existTime.getCl_name() : existTime.getRe_name();
					String myetc = existTime.getRt_court();

					String mySTime = existTime.getRt_stime();
					String myETime = existTime.getRt_etime();
					
					//사용코트 구분
					for(int j=7; j <= 12; j++){
						if(myetc.contains("전체") || myetc.contains(j + "코트")){
							if(!courtUsed.contains(j + "c")) courtUsed += !StringUtils.isEmpty(courtUsed) ? "," + j + "c" : j + "c";
						}
					}
					
				}
				
				logger.info("신규프로그램 예약코트: " + courtUsed);
				
				logger.info("###################################################################################################################<br>");

				logger.info("예약날짜:" + ticket_date);
				logger.info("종목구분:" + part_cd);
				logger.info("시작시간:" + stime);
				logger.info("종료시간:" + etime);
				logger.info("예약된코트:" + courtUsed);
				
				String[] tmparr = new String[]{};
				if(!StringUtils.isEmpty(courtUsed)) tmparr = courtUsed.split(",");
				
				int leftCourtCnt = 6 - tmparr.length;
				logger.info("leftCourtCnt: " + leftCourtCnt);
				
				// 이번시간대의 총 예약 동호회수를 구한다. 6개 초과이면 추첨, 6개 이하이면 배정.
				boolean resave = false;
				int cnt = rentMapper.cntTargetReserve(Integer.parseInt(part_cd), ticket_date, stime, etime);
				if (cnt > leftCourtCnt)
					resave=true;
				else
					resave=false;
				
				logger.info("result save : " + resave);
				logger.info("team no : " + cnt);
				
				//남은 코트가 있을때
				if(leftCourtCnt > 0) {
					
					String tmp_rand="";
					int totalReqCourt = 0;
					List<RentReserveCnt> tmpCourt= new ArrayList<RentReserveCnt>();
					List<Integer> tmp_clnum= null;
					int j=0;
					//String oneMonthAgo 
					
					/* 1. 오늘 당첨되지 않은 동호회를 우선 배정 */	
					List<RentReserveCnt> reserveCnt = rentMapper.listDrawReserve(Integer.parseInt(part_cd), ticket_date, stime, etime, oneMonthAgo, beforeTime, "");
					failed_clnum = "";
					List<Integer> success_clnum = new ArrayList<Integer>();
					
					tmp_clnum = new ArrayList<Integer>();
					
					for(RentReserveCnt reCnt : reserveCnt){
						if(leftCourtCnt==0){
							if (!StringUtils.isEmpty(failed_clnum)) failed_clnum += ",";
							
							failed_clnum += String.valueOf(reCnt.getCl_num());
						} else{
							logger.info(reCnt.getCl_num() + "= " + reCnt.getUsedcnt() + "번" + reCnt.getBtdc());
							
							tmp_clnum.add(reCnt.getCl_num());
							
							reCnt.setReq(reCnt.getRt_court_cnt());
							reCnt.setDang(1);
							reCnt.setCourt("");
							
							tmpCourt.add(reCnt);
							
							leftCourtCnt--;
							totalReqCourt += reCnt.getRt_court_cnt();
							totalReqCourt--;
							logger.info(leftCourtCnt + "= " + totalReqCourt);
							success_clnum.add(reCnt.getCl_num());

							j++;
						}
					}
					
					logger.info("totalReqCourt=" + totalReqCourt);	
					logger.info("FailedClub=" + failed_clnum);	
					logger.info("당첨된 동호회 번호:" + tmp_clnum);	
					
					
					if(success_clnum.size() > 0)
						reserveCnt = rentMapper.listDrawReserve(Integer.parseInt(part_cd), ticket_date, stime, etime, oneMonthAgo, beforeTime, success_clnum);
					else
						reserveCnt = rentMapper.listDrawReserve(Integer.parseInt(part_cd), ticket_date, stime, etime, oneMonthAgo, beforeTime);
					
					for(RentReserveCnt reCnt : reserveCnt){
						if(leftCourtCnt==0){
							if (!StringUtils.isEmpty(failed_clnum)) failed_clnum += ",";
							
							failed_clnum += String.valueOf(reCnt.getCl_num());
						} else{
							logger.info(reCnt.getCl_num() + "= " + reCnt.getUsedcnt() + "번" + reCnt.getBtdc());
							
							tmp_clnum.add(reCnt.getCl_num());
							
							reCnt.setReq(reCnt.getRt_court_cnt());
							reCnt.setDang(1);
							reCnt.setCourt("");
							
							tmpCourt.add(reCnt);
							
							leftCourtCnt--;
							totalReqCourt += reCnt.getRt_court_cnt();
							totalReqCourt--;
							logger.info(leftCourtCnt + "= " + totalReqCourt);
							success_clnum.add(reCnt.getCl_num());

							j++;
						}
					}
					
					logger.info("totalReqCourt=" + totalReqCourt);	
					logger.info("FailedClub=" + failed_clnum);	
					logger.info("당첨된 동호회 번호:" + tmp_clnum);	
					
					
					//코트가 남거나, 신청코트수가 다 찰때까지

					int aa= 0;
					int bb= 0;

					int vv=0;
					while(leftCourtCnt>0 && totalReqCourt>0){

						//shuffle($tmp_rand);

						//필요한 코트수가 충족하는지 검사
						
						for(int j1=0; j1< tmpCourt.size();j1++){
							
							if(leftCourtCnt<=0) break;
							if(totalReqCourt<=0) break;

							//$vv = $tmpCourt[$j]['req']; // 신청 번호

							aa=tmpCourt.get(j1).getReq();
							bb=tmpCourt.get(j1).getDang();

							if(aa > bb){

								leftCourtCnt--;
								totalReqCourt--;
								bb++;
							}
							
							tmpCourt.get(j1).setDang(bb);


						}
						if(leftCourtCnt<=0) break;
						if(totalReqCourt<=0) break;

						//$vv++;

					}
					
					Collections.shuffle(tmpCourt);
					Collections.sort(tmpCourt, new Comparator<RentReserveCnt>(){
					  public int compare(RentReserveCnt o1, RentReserveCnt o2){
					    // TODO Auto-generated method stub
						  return (o1.getDang() > o2.getDang()) ? -1: (o1.getDang() > o2.getDang()) ? 1:0 ;
					  }
					});
					
					//당첨된 코트수
					for(int j2=0;j2<tmpCourt.size();j2++){
						vv=tmpCourt.get(j2).getRt_num();  //예약번호
						int clnum =  tmpCourt.get(j2).getCl_num();
						logger.info(clnum + "번의 신청코트수 : " + tmpCourt.get(j2).getReq());
						logger.info(clnum + "번의 당첨코트수 : " + tmpCourt.get(j2).getDang());
						
//						fwrite($fp, $clnum.'번의 신청코트수 : '.$tmpCourt[$j]['req'].PHP_EOL);
//						fwrite($fp, $clnum.'번의 당첨코트수 : '.$tmpCourt[$j]['dang'].PHP_EOL);
					}
					
//					fwrite($fp, '추첨후 남은 코트수:'.$leftCourtCnt.PHP_EOL);
//					fwrite($fp, '추첨후 필요한 코트수:'.$totalReqCourt.PHP_EOL);
					//sortByField($tmp_rand, 'dang'); // Sort by oldest first
					//echo "sizeof(tmp_rand)=".sizeof($tmp_rand)."<br>";
					
					// 많이 당첨된 코드를 우선 배정.
					//////////////////////////////////////////////////////////////////////////////
					// 6개 ~ 1개
					// 이전 시간에 당첨된 동호회를 우선적으로 배분한다.
					for(int i = 6; i > 0 ; --i){
						for(RentReserveCnt tmpcrt : tmpCourt){
							vv=tmpcrt.getRt_num();  //예약번호
							int clnum =  tmpcrt.getCl_num() ;
							int dang = tmpcrt.getDang();
							String dangCourt="";
							if (dang==i)
							{
								if (!StringUtils.isEmpty(tmpcrt.getBtdc()))
								{
									logger.info("동호회의 당일 전시간대 당첨된 코트=" + tmpcrt.getBtdc());	
	
									String beforeTimeDangCourt = tmpcrt.getBtdc();
									/*
									//당첨코트가 7개인 경우 전체사용
									if($dang==7){
										if(!strstr($courtUsed,'4c')&&!strstr($courtUsed,'5c')&&!strstr($courtUsed,'6c')&&!strstr($courtUsed,'7c')&&!strstr($courtUsed,'8c')&&!strstr($courtUsed,'9c')&&!strstr($courtUsed,'10c')){
											$dangCourt = "4코트,5코트,6코트,7코트,8코트,9코트,10코트";
											$courtUsed = "4c,5c,6c,7c,8c,9c,10c";
											$dang -= 7;
										}
									}
									*/
	
									dangCourt = getDang(dang, beforeTimeDangCourt) ;
	
									//당첨결과를 저장
									tmpcrt.setCourt(dangCourt);
	
	//								fwrite($fp, "courtUsed :".$courtUsed.PHP_EOL);
	//								fwrite($fp, $clnum."동호회의 당첨코트 = ".$dangCourt.PHP_EOL);
									logger.info("동호회의 당첨코트 = " + dangCourt);
	
									//당첨처리
									int result_save = rentMapper.updateDraw(vv, dangCourt);
				
									if (result_save <= 0)
									{
										dang = tmpcrt.getDang();
										rentMapper.insertDraw(ticket_date, clnum, dang, stime);
									}
								}
							}
	
						}
						
						for(RentReserveCnt tmpcrt : tmpCourt){
							vv=tmpcrt.getRt_num();  //예약번호
							int clnum =  tmpcrt.getCl_num() ;
							int dang = tmpcrt.getDang();
							String dangCourt="";
							if (dang==i)
							{
								if (StringUtils.isEmpty(tmpcrt.getCourt()))
								{
									logger.info("동호회의 당일 전시간대 당첨된 코트=" + tmpcrt.getBtdc());	
	
									String beforeTimeDangCourt = tmpcrt.getBtdc();
									/*
									//당첨코트가 7개인 경우 전체사용
									if($dang==7){
										if(!strstr($courtUsed,'4c')&&!strstr($courtUsed,'5c')&&!strstr($courtUsed,'6c')&&!strstr($courtUsed,'7c')&&!strstr($courtUsed,'8c')&&!strstr($courtUsed,'9c')&&!strstr($courtUsed,'10c')){
											$dangCourt = "4코트,5코트,6코트,7코트,8코트,9코트,10코트";
											$courtUsed = "4c,5c,6c,7c,8c,9c,10c";
											$dang -= 7;
										}
									}
									*/
	
									dangCourt = getDang(dang, beforeTimeDangCourt) ;
	
									//당첨결과를 저장
									tmpcrt.setCourt(dangCourt);
	
	//								fwrite($fp, "courtUsed :".$courtUsed.PHP_EOL);
	//								fwrite($fp, $clnum."동호회의 당첨코트 = ".$dangCourt.PHP_EOL);
									logger.info("동호회의 당첨코트 = " + dangCourt);
	
									//당첨처리
									int result_save = rentMapper.updateDraw(vv, dangCourt);
				
									if (result_save >= 1)
									{
										dang = tmpcrt.getDang();
										rentMapper.insertDraw(ticket_date, clnum, dang, stime);
									}
								}
							}
	
						}
					}
					rentMapper.updateFailedDraw(Integer.parseInt(part_cd), ticket_date, stime, etime);
				}
				
				beforeTime=stime;
			}
			
		}catch(Exception e){
			logger.info(e.getMessage());
		}
	}
	
	String getDang(int dang, String beforeTimeDangCourt) {
		String dangCourt = "";
		
		if(beforeTimeDangCourt == null)
			beforeTimeDangCourt = "";
		
		//당첨코트가 6개인 경우 전체사용
		if(dang>=6){
			if(!courtUsed.contains("7c")
					&&!courtUsed.contains("8c")
					&&!courtUsed.contains("9c")
					&&!courtUsed.contains("10c")
					&&!courtUsed.contains("11c")
					&&!courtUsed.contains("12c")){
				dangCourt = "7코트,8코트,9코트,10코트,11코트,12코트";
				courtUsed += !StringUtils.isEmpty(courtUsed) ? ",7c,8c,9c,10c,11c,12c" : "7c,8c,9c,10c,11c,12c";
				dang -= 6;
			}
		}
		//당첨코트가 5개인 경우
		if(dang>=5){
			if(!courtUsed.contains("8c")
					&&!courtUsed.contains("9c")
					&&!courtUsed.contains("10c")
					&&!courtUsed.contains("11c")
					&&!courtUsed.contains("12c")){
				dangCourt = "8코트,9코트,10코트,11코트,12코트";
				courtUsed += !StringUtils.isEmpty(courtUsed) ? ",8c,9c,10c,11c,12c" : "8c,9c,10c,11c,12c";
				dang -= 5;
			}
		}
		
		//당첨코트가 4개인 경우
		if(dang>=4){
			if(!courtUsed.contains("8c")
					&&!courtUsed.contains("9c")
					&&!courtUsed.contains("10c")
					&&!courtUsed.contains("11c")){
				dangCourt = "8코트,9코트,10코트,11코트";
				courtUsed += !StringUtils.isEmpty(courtUsed) ? ",8c,9c,10c,11c" : "8c,9c,10c,11c";
				dang -= 4;
			}
		}
		
		//당첨코트가 3개인 경우
		if(dang>=3){
			//7c,8c,9c
			//5c,6c,10c

			//7c,8c,9c 가 전시간 당첨된 코트에 있는경우 먼저검사
			if( (!courtUsed.contains("8c") &&!courtUsed.contains("9c") &&!courtUsed.contains("10c")) && 
					(beforeTimeDangCourt.contains("9코트")||beforeTimeDangCourt.contains("10코트")||beforeTimeDangCourt.contains("11코트")) ){
				dangCourt += !StringUtils.isEmpty(dangCourt) ? ",8코트,9코트,10코트" : "8코트,9코트,10코트";
				courtUsed += !StringUtils.isEmpty(courtUsed) ? ",8c,9c,10c" : "8c,9c,10c";
				dang -= 3;
			}
			//5c,6c,10c 가 전시간 당첨된 코트에 있는경우 먼저검사
			if( (!courtUsed.contains("7c") &&!courtUsed.contains("11c") &&!courtUsed.contains("12c")) && 
					(beforeTimeDangCourt.contains("7코트")||beforeTimeDangCourt.contains("8코트")||beforeTimeDangCourt.contains("12코트")) ){
				dangCourt += !StringUtils.isEmpty(dangCourt) ? ",7코트,11코트,12코트" : "7코트,11코트,12코트";
				courtUsed += !StringUtils.isEmpty(courtUsed) ? ",7c,11c,12c" : "7c,11c,12c";
				dang -= 3;
			}else if(!courtUsed.contains("8c") &&!courtUsed.contains("9c") &&!courtUsed.contains("10c")){
				dangCourt += !StringUtils.isEmpty(dangCourt) ? ",8코트,9코트,10코트" : "8코트,9코트,10코트";
				courtUsed += !StringUtils.isEmpty(courtUsed) ? ",8c,9c,10c" : "8c,9c,10c";
				dang -= 3;
			}else if(!courtUsed.contains("7c") &&!courtUsed.contains("1c") &&!courtUsed.contains("12c")) {
				dangCourt += !StringUtils.isEmpty(dangCourt) ? ",7코트,11코트,12코트" : "7코트,11코트,12코트";
				courtUsed += !StringUtils.isEmpty(courtUsed) ? ",7c,11c,12c" : "7c,11c,12c";
				dang -= 3;
			}
		}
		//당첨코트가 2개인 경우
		if(dang>=2){
			//5c,6c
			//7c,8c
			//9c,10c

			//9c,10c 가 전시간 당첨된 코트에 있는경우 먼저검사
			if( (!courtUsed.contains("7c") &&!courtUsed.contains("12c")) && 
					(beforeTimeDangCourt.contains("7코트")||beforeTimeDangCourt.contains("12코트")) ) {
				logger.info("2할당");
				dangCourt += !StringUtils.isEmpty(dangCourt) ? ",7코트,12코트" : "7코트,12코트";
				courtUsed += !StringUtils.isEmpty(courtUsed) ? ",7c,12c" : "7c,12c";
				dang -= 2;
			}
			//5c,6c 가 전시간 당첨된 코트에 있는경우 먼저검사
			else if( (!courtUsed.contains("8c") &&!courtUsed.contains("9c")) && 
					(beforeTimeDangCourt.contains("8코트")||beforeTimeDangCourt.contains("9코트")) ){
				logger.info("2할당");
				dangCourt += !StringUtils.isEmpty(dangCourt) ? ",8코트,9코트" : "8코트,9코트";
				courtUsed += !StringUtils.isEmpty(courtUsed) ? ",8c,9c" : "8c,9c";
				dang -= 2;
			}
			//7c,8c 가 전시간 당첨된 코트에 있는경우 먼저검사
			else if( (!courtUsed.contains("10c") &&!courtUsed.contains("11c")) && 
					(beforeTimeDangCourt.contains("10코트")||beforeTimeDangCourt.contains("11코트")) ){
				logger.info("2할당");
				dangCourt += !StringUtils.isEmpty(dangCourt) ? ",10코트,11코트" : "10코트,11코트";
				courtUsed += !StringUtils.isEmpty(courtUsed) ? ",10c,11c" : "10c,11c";
				dang -= 2;
			}else if( (!courtUsed.contains("7c") &&!courtUsed.contains("12c"))){
				logger.info("2할당");
				dangCourt += !StringUtils.isEmpty(dangCourt) ? ",7코트,12코트" : "7코트,12코트";
				courtUsed += !StringUtils.isEmpty(courtUsed) ? ",7c,12c" : "7c,12c";
				dang -= 2;
			}else if( (!courtUsed.contains("8c") &&!courtUsed.contains("9c"))){
				logger.info("2할당");
				dangCourt += !StringUtils.isEmpty(dangCourt) ? ",8코트,9코트" : "8코트,9코트";
				courtUsed += !StringUtils.isEmpty(courtUsed) ? ",8c,9c" : "8c,9c";
				dang -= 2;
			}else if( (!courtUsed.contains("10c") &&!courtUsed.contains("11c"))){
				logger.info("2할당");
				dangCourt += !StringUtils.isEmpty(dangCourt) ? ",10코트,11코트" : "10코트,11코트";
				courtUsed += !StringUtils.isEmpty(courtUsed) ? ",10c,11c" : "10c,11c";
				dang -= 2;
			}
		}

		//코트 할당을 하였으나, 묶음할당이 되지 않은경우
		/*
		if($dang>0&&!strstr($courtUsed,'4c')){
			$dangCourt .= $dangCourt ? ",4코트" : "4코트";
			$courtUsed .= $courtUsed ? ",4c" : "4c";
			$dang--;
		}
		*/
		//5c 가 전시간 당첨된 코트에 있는경우 먼저검사
		if(dang>0&&!courtUsed.contains("7c")&&beforeTimeDangCourt.contains("7코트")){
			dangCourt += !StringUtils.isEmpty(dangCourt) ? ",7코트" : "7코트";
			courtUsed += !StringUtils.isEmpty(courtUsed) ? ",7c" : "7c";
			dang--;
		}
		//6c 가 전시간 당첨된 코트에 있는경우 먼저검사
		if(dang>0&&!courtUsed.contains("8c")&&beforeTimeDangCourt.contains("8코트")){
			dangCourt += !StringUtils.isEmpty(dangCourt) ? ",8코트" : "8코트";
			courtUsed += !StringUtils.isEmpty(courtUsed) ? ",8c" : "8c";
			dang--;
		}
		//7c 가 전시간 당첨된 코트에 있는경우 먼저검사
		if(dang>0&&!courtUsed.contains("9c")&&beforeTimeDangCourt.contains("9코트")){
			dangCourt += !StringUtils.isEmpty(dangCourt) ? ",9코트" : "9코트";
			courtUsed += !StringUtils.isEmpty(courtUsed) ? ",9c" : "9c";
			dang--;
		}
		//8c 가 전시간 당첨된 코트에 있는경우 먼저검사
		if(dang>0&&!courtUsed.contains("10c")&&beforeTimeDangCourt.contains("10코트")){
			dangCourt += !StringUtils.isEmpty(dangCourt) ? ",10코트" : "10코트";
			courtUsed += !StringUtils.isEmpty(courtUsed) ? ",10c" : "10c";
			dang--;
		}
		//10c 가 전시간 당첨된 코트에 있는경우 먼저검사
		if(dang>0&&!courtUsed.contains("12c")&&beforeTimeDangCourt.contains("12코트")){
			dangCourt += !StringUtils.isEmpty(dangCourt) ? ",12코트" : "12코트";
			courtUsed += !StringUtils.isEmpty(courtUsed) ? ",12c" : "12c";
			dang--;
		}
		//9c 가 전시간 당첨된 코트에 있는경우 먼저검사
		if(dang>0&&!courtUsed.contains("11c")&&beforeTimeDangCourt.contains("11코트")){
			dangCourt += !StringUtils.isEmpty(dangCourt) ? ",11코트" : "11코트";
			courtUsed += !StringUtils.isEmpty(courtUsed) ? ",11c" : "11c";
			dang--;
		}

		if(dang>0&&!courtUsed.contains("7c")){
			dangCourt += !StringUtils.isEmpty(dangCourt) ? ",7코트" : "7코트";
			courtUsed += !StringUtils.isEmpty(courtUsed) ? ",7c" : "7c";
			dang--;
		}

		if(dang>0&&!courtUsed.contains("8c")){
			dangCourt += !StringUtils.isEmpty(dangCourt) ? ",8코트" : "8코트";
			courtUsed += !StringUtils.isEmpty(courtUsed) ? ",8c" : "8c";
			dang--;
		}
		if(dang>0&&!courtUsed.contains("9c")){
			dangCourt += !StringUtils.isEmpty(dangCourt) ? ",9코트" : "9코트";
			courtUsed += !StringUtils.isEmpty(courtUsed) ? ",9c" : "9c";
			dang--;
		}
		if(dang>0&&!courtUsed.contains("10c")){
			dangCourt += !StringUtils.isEmpty(dangCourt) ? ",10코트" : "10코트";
			courtUsed += !StringUtils.isEmpty(courtUsed) ? ",10c" : "10c";
			dang--;
		}
		if(dang>0&&!courtUsed.contains("11c")){
			dangCourt += !StringUtils.isEmpty(dangCourt) ? ",11코트" : "11코트";
			courtUsed += !StringUtils.isEmpty(courtUsed) ? ",11c" : "11c";
			dang--;
		}
		if(dang>0&&!courtUsed.contains("12c")){
			dangCourt += !StringUtils.isEmpty(dangCourt) ? ",12코트" : "12코트";
			courtUsed += !StringUtils.isEmpty(courtUsed) ? ",12c" : "12c";
			dang--;
		}

		return dangCourt;		
	}
	
	public void doProc2() { 
		try{
			String part_cd = "15";
			String failed_clnum = "";
			
			SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMdd");
			Calendar cal = Calendar.getInstance();
			
			cal.add(Calendar.DAY_OF_MONTH, 13);
			String after14days  = formatter.format(cal.getTime());
			
			cal.add(Calendar.DAY_OF_MONTH, -30);
			String oneMonthAgo  = formatter.format(cal.getTime());
			
			String beforeTime = "";
			
			List<RentReserve> fixedReserve = null;
			
			List<RentReserve> reTimes = rentMapper.listReRentTime(after14days);
			for(RentReserve reTime : reTimes){
				/*

				- 추첨 후 코트는 회사,동호회 예약 코트에 한해 랜덤으로 배분
				- 신청 시 코트 수 제한 없음(동호인 예약 최대 6코트까지 신청 가능)
				- 신청 코트에 한해 나누어 배분
				 ex) 총 6코트 : -신청건이 6팀 일 때 1코트씩 나누어 배분
								  -신청건이 6팀 초과일 때 한 코트씩 추첨하여 배분
								  -신청건이 6팀 미만일 때 신청 동호회 1코트씩 배분 후 남은코트 1코트 이상 신청한 동호회 추첨 하여 추가 배분 실시
				- 단, 총 6코트 중 [회사행사] 예약 코트 배제 후 남은 코트 추첨/배분
				- 코트 배분 : 1코트 배분 시 : 랜덤 배분
							  2코트 배분 시 : 5번,6번 / 7번,8번 / 9번,10번   -> 7,8 / 9,10
							  3코트 배분 시 : 7번,8번,9번 / 5번,6번,10번     -> 6,7,8
							  4코트 배분 시 : 7번,8번,9번,10번              -> 7,8,9,10
							  5코트 배분 시 : 6번,7번,8번,9번,10번           -> 6,7,8,9,10


				*/
				courtUsed = "";
				String ticket_date = reTime.getRe_date();
				String stime		= reTime.getRt_stime();
				String etime		= reTime.getRt_etime();
				
				String use_days = Util.getYoil(ticket_date);

				if(fixedReserve == null)
					fixedReserve = rentMapper.listFixedReserve(Integer.parseInt(part_cd), use_days, ticket_date);
				
				for(RentReserve fixedTime : fixedReserve){
					String myetc = fixedTime.getRt_court();
					String myreserve_date = fixedTime.getRt_stime();
					String myret_date = fixedTime.getRt_etime();

					String mySTime = myreserve_date;
					String myETime = myret_date;
					
					//사용시간구분
					if(Integer.parseInt(mySTime) < Integer.parseInt(etime) && 
							Integer.parseInt(myETime) > Integer.parseInt(stime) ){
						//사용코트 구분
						for(int j=6; j <= 10; j++){
							if(myetc.contains("전체") || myetc.contains(j + "코트")){
								if(!courtUsed.contains(j + "c")) courtUsed += !StringUtils.isEmpty(courtUsed) ? "," + j + "c" : j + "c";

							}
						}
					}
				}
				
				logger.info("기존프로그램 예약코트: " + courtUsed);
				
				// 현프로그램에서 회사행사 예약정보
				List<RentReserve> existReserve = rentMapper.listExistReserve(Integer.parseInt(part_cd), ticket_date, stime, etime);
				
				for(RentReserve existTime : existReserve){
					String myetc = existTime.getRt_court();
					
					//사용코트 구분
					for(int j=6; j <= 10; j++){
						if(myetc.contains("전체") || myetc.contains(j + "코트")){
							if(!courtUsed.contains(j + "c")) courtUsed += !StringUtils.isEmpty(courtUsed) ? "," + j + "c" : j + "c";
						}
					}
					
				}
				
				logger.info("신규프로그램 예약코트: " + courtUsed);
				
				logger.info("###################################################################################################################<br>");

				logger.info("예약날짜:" + ticket_date);
				logger.info("종목구분:" + part_cd);
				logger.info("시작시간:" + stime);
				logger.info("종료시간:" + etime);
				logger.info("예약된코트:" + courtUsed);
				
				String[] tmparr = new String[]{};
				if(!StringUtils.isEmpty(courtUsed)) 
					tmparr = courtUsed.split(",");
				
				int leftCourtCnt = 5 - tmparr.length;
				logger.info("leftCourtCnt: " + leftCourtCnt);
				
				// 이번시간대의 총 예약 동호회수를 구한다. 5개 초과이면 추첨, 5개 이하이면 배정.
				boolean resave = false;
				int cnt = rentMapper.cntTargetReserve(Integer.parseInt(part_cd), ticket_date, stime, etime);
				if (cnt > leftCourtCnt)
					resave = true;
				else
					resave = false;
				
				logger.info("result save : " + resave);
				logger.info("team no : " + cnt);
				
				//남은 코트가 있을때
				if(leftCourtCnt > 0) {
					int totalReqCourt = 0;
					List<RentReserveCnt> tmpCourt= new ArrayList<RentReserveCnt>();
					List<Integer> tmp_clnum= null;
					
					/* 1. 오늘 당첨되지 않은 동호회를 우선 배정 */	
					List<RentReserveCnt> reserveCnt = rentMapper.listDrawReserve(Integer.parseInt(part_cd), ticket_date, stime, etime, oneMonthAgo, beforeTime, "");
					failed_clnum = "";
					List<Integer> success_clnum = new ArrayList<Integer>();
					
					tmp_clnum = new ArrayList<Integer>();
					
					for(RentReserveCnt reCnt : reserveCnt){
						if(leftCourtCnt==0){
							if (!StringUtils.isEmpty(failed_clnum)) failed_clnum += ",";
							
							failed_clnum += String.valueOf(reCnt.getCl_num());
						} else{
							logger.info(reCnt.getCl_num() + "= " + reCnt.getUsedcnt() + "번" + reCnt.getBtdc());
							
							tmp_clnum.add(reCnt.getCl_num());
							
							reCnt.setReq(reCnt.getRt_court_cnt());
							reCnt.setDang(1);
							reCnt.setCourt("");
							
							tmpCourt.add(reCnt);
							
							leftCourtCnt--;
							totalReqCourt += reCnt.getRt_court_cnt();
							totalReqCourt--;
							logger.info(leftCourtCnt + "= " + totalReqCourt);
							success_clnum.add(reCnt.getCl_num());
						}
					}
					
					logger.info("totalReqCourt=" + totalReqCourt);	
					logger.info("FailedClub=" + failed_clnum);	
					logger.info("당첨된 동호회 번호:" + tmp_clnum);	
					
					
					if(success_clnum.size() > 0)
						reserveCnt = rentMapper.listDrawReserve(Integer.parseInt(part_cd), ticket_date, stime, etime, oneMonthAgo, beforeTime, success_clnum);
					else
						reserveCnt = rentMapper.listDrawReserve(Integer.parseInt(part_cd), ticket_date, stime, etime, oneMonthAgo, beforeTime);
					
					for(RentReserveCnt reCnt : reserveCnt){
						if(leftCourtCnt==0){
							if (!StringUtils.isEmpty(failed_clnum)) failed_clnum += ",";
							
							failed_clnum += String.valueOf(reCnt.getCl_num());
						} else{
							logger.info(reCnt.getCl_num() + "= " + reCnt.getUsedcnt() + "번" + reCnt.getBtdc());
							
							tmp_clnum.add(reCnt.getCl_num());
							
							reCnt.setReq(reCnt.getRt_court_cnt());
							reCnt.setDang(1);
							reCnt.setCourt("");
							
							tmpCourt.add(reCnt);
							
							leftCourtCnt--;
							totalReqCourt += reCnt.getRt_court_cnt();
							totalReqCourt--;
							logger.info(leftCourtCnt + "= " + totalReqCourt);
							success_clnum.add(reCnt.getCl_num());
						}
					}
					
					logger.info("totalReqCourt=" + totalReqCourt);	
					logger.info("FailedClub=" + failed_clnum);	
					logger.info("당첨된 동호회 번호:" + tmp_clnum);	
					
					
					//코트가 남거나, 신청코트수가 다 찰때까지

					int aa= 0;
					int bb= 0;

					int vv=0;
					while(leftCourtCnt>0 && totalReqCourt>0){

						//shuffle($tmp_rand);

						//필요한 코트수가 충족하는지 검사
						
						for(int j1=0; j1< tmpCourt.size();j1++){
							
							if(leftCourtCnt<=0) break;
							if(totalReqCourt<=0) break;

							//$vv = $tmpCourt[$j]['req']; // 신청 번호

							aa=tmpCourt.get(j1).getReq();
							bb=tmpCourt.get(j1).getDang();

							if(aa > bb){

								leftCourtCnt--;
								totalReqCourt--;
								bb++;
							}
							
							tmpCourt.get(j1).setDang(bb);


						}
						if(leftCourtCnt<=0) break;
						if(totalReqCourt<=0) break;

						//$vv++;

					}
					
					Collections.shuffle(tmpCourt);
					Collections.sort(tmpCourt, new Comparator<RentReserveCnt>(){
					  public int compare(RentReserveCnt o1, RentReserveCnt o2){
					    // TODO Auto-generated method stub
						  return (o1.getDang() > o2.getDang()) ? -1: (o1.getDang() > o2.getDang()) ? 1:0 ;
					  }
					});
					
					//당첨된 코트수
					for(int j2=0;j2<tmpCourt.size();j2++){
						vv=tmpCourt.get(j2).getRt_num();  //예약번호
						int clnum =  tmpCourt.get(j2).getCl_num();
						logger.info(clnum + "번의 신청코트수 : " + tmpCourt.get(j2).getReq());
						logger.info(clnum + "번의 당첨코트수 : " + tmpCourt.get(j2).getDang());
						
//						fwrite($fp, $clnum.'번의 신청코트수 : '.$tmpCourt[$j]['req'].PHP_EOL);
//						fwrite($fp, $clnum.'번의 당첨코트수 : '.$tmpCourt[$j]['dang'].PHP_EOL);
					}
					
//					fwrite($fp, '추첨후 남은 코트수:'.$leftCourtCnt.PHP_EOL);
//					fwrite($fp, '추첨후 필요한 코트수:'.$totalReqCourt.PHP_EOL);
					//sortByField($tmp_rand, 'dang'); // Sort by oldest first
					//echo "sizeof(tmp_rand)=".sizeof($tmp_rand)."<br>";
					
					// 많이 당첨된 코드를 우선 배정.
					//////////////////////////////////////////////////////////////////////////////
					// 6개 ~ 1개
					// 이전 시간에 당첨된 동호회를 우선적으로 배분한다.
					for(int i = 5; i > 0 ; --i){
						for(RentReserveCnt tmpcrt : tmpCourt){
							vv=tmpcrt.getRt_num();  //예약번호
							int clnum =  tmpcrt.getCl_num() ;
							int dang = tmpcrt.getDang();
							String dangCourt="";
							if (dang==i)
							{
								if (!StringUtils.isEmpty(tmpcrt.getBtdc()))
								{
									logger.info("동호회의 당일 전시간대 당첨된 코트=" + tmpcrt.getBtdc());	
	
									String beforeTimeDangCourt = tmpcrt.getBtdc();
									/*
									//당첨코트가 7개인 경우 전체사용
									if($dang==7){
										if(!strstr($courtUsed,'4c')&&!strstr($courtUsed,'5c')&&!strstr($courtUsed,'6c')&&!strstr($courtUsed,'7c')&&!strstr($courtUsed,'8c')&&!strstr($courtUsed,'9c')&&!strstr($courtUsed,'10c')){
											$dangCourt = "4코트,5코트,6코트,7코트,8코트,9코트,10코트";
											$courtUsed = "4c,5c,6c,7c,8c,9c,10c";
											$dang -= 7;
										}
									}
									*/
	
									dangCourt = getDang(dang, beforeTimeDangCourt) ;
	
									//당첨결과를 저장
									tmpcrt.setCourt(dangCourt);
	
	//								fwrite($fp, "courtUsed :".$courtUsed.PHP_EOL);
	//								fwrite($fp, $clnum."동호회의 당첨코트 = ".$dangCourt.PHP_EOL);
									logger.info("동호회의 당첨코트 = " + dangCourt);
	
									//당첨처리
									int result_save = rentMapper.updateDraw(vv, dangCourt);
				
									if (result_save <= 0)
									{
										dang = tmpcrt.getDang();
										rentMapper.insertDraw(ticket_date, clnum, dang, stime);
									}
								}
							}
	
						}
						
						for(RentReserveCnt tmpcrt : tmpCourt){
							vv=tmpcrt.getRt_num();  //예약번호
							int clnum =  tmpcrt.getCl_num() ;
							int dang = tmpcrt.getDang();
							String dangCourt="";
							if (dang==i)
							{
								if (StringUtils.isEmpty(tmpcrt.getCourt()))
								{
									logger.info("동호회의 당일 전시간대 당첨된 코트=" + tmpcrt.getBtdc());	
	
									String beforeTimeDangCourt = tmpcrt.getBtdc();
									/*
									//당첨코트가 7개인 경우 전체사용
									if($dang==7){
										if(!strstr($courtUsed,'4c')&&!strstr($courtUsed,'5c')&&!strstr($courtUsed,'6c')&&!strstr($courtUsed,'7c')&&!strstr($courtUsed,'8c')&&!strstr($courtUsed,'9c')&&!strstr($courtUsed,'10c')){
											$dangCourt = "4코트,5코트,6코트,7코트,8코트,9코트,10코트";
											$courtUsed = "4c,5c,6c,7c,8c,9c,10c";
											$dang -= 7;
										}
									}
									*/
	
									dangCourt = getDang(dang, beforeTimeDangCourt) ;
	
									//당첨결과를 저장
									tmpcrt.setCourt(dangCourt);
	
	//								fwrite($fp, "courtUsed :".$courtUsed.PHP_EOL);
	//								fwrite($fp, $clnum."동호회의 당첨코트 = ".$dangCourt.PHP_EOL);
									logger.info("동호회의 당첨코트 = " + dangCourt);
	
									//당첨처리
									int result_save = rentMapper.updateDraw(vv, dangCourt);
				
									if (result_save >= 1)
									{
										dang = tmpcrt.getDang();
										rentMapper.insertDraw(ticket_date, clnum, dang, stime);
									}
								}
							}
	
						}
					}
					rentMapper.updateFailedDraw(Integer.parseInt(part_cd), ticket_date, stime, etime);
				}
				
				beforeTime=stime;
			}
			
		}catch(Exception e){
			logger.info(e.getMessage());
		}
	}
	
	String getDang2(int dang, String beforeTimeDangCourt) {
		String dangCourt = "";
		
		if(beforeTimeDangCourt == null)
			beforeTimeDangCourt = "";
		
		//당첨코트가 6개인 경우 전체사용
//		if(dang>=6){
//			if(!courtUsed.contains("5c")
//					&&!courtUsed.contains("6c")
//					&&!courtUsed.contains("7c")
//					&&!courtUsed.contains("8c")
//					&&!courtUsed.contains("9c")
//					&&!courtUsed.contains("10c")){
//				dangCourt = "5코트,6코트,7코트,8코트,9코트,10코트";
//				courtUsed += !StringUtils.isEmpty(courtUsed) ? ",5c,6c,7c,8c,9c,10c" : "5c,6c,7c,8c,9c,10c";
//				dang -= 6;
//			}
//		}
		//당첨코트가 5개인 경우
		if(dang>=5){
			if(!courtUsed.contains("6c")
					&&!courtUsed.contains("7c")
					&&!courtUsed.contains("8c")
					&&!courtUsed.contains("9c")
					&&!courtUsed.contains("10c")){
				dangCourt = "6코트,7코트,8코트,9코트,10코트";
				courtUsed += !StringUtils.isEmpty(courtUsed) ? ",6c,7c,8c,9c,10c" : "6c,7c,8c,9c,10c";
				dang -= 5;
			}
		}
		
		//당첨코트가 4개인 경우
		if(dang>=4){
			if(!courtUsed.contains("7c")
					&&!courtUsed.contains("8c")
					&&!courtUsed.contains("9c")
					&&!courtUsed.contains("10c")){
				dangCourt = "7코트,8코트,9코트,10코트";
				courtUsed += !StringUtils.isEmpty(courtUsed) ? ",7c,8c,9c,10c" : "7c,8c,9c,10c";
				dang -= 4;
			}
		}
		
		//당첨코트가 3개인 경우
		if(dang>=3){
			//7c,8c,9c
			if(!courtUsed.contains("6c") &&!courtUsed.contains("7c") &&!courtUsed.contains("8c")){
				dangCourt += !StringUtils.isEmpty(dangCourt) ? ",6코트,7코트,8코트" : "6코트,7코트,8코트";
				courtUsed += !StringUtils.isEmpty(courtUsed) ? ",6c,7c,8c" : "6c,7c,8c";
				dang -= 3;
			}
			
			//7c,8c,9c
			//5c,6c,10c
			//7c,8c,9c 가 전시간 당첨된 코트에 있는경우 먼저검사
//			if( (!courtUsed.contains("7c") &&!courtUsed.contains("8c") &&!courtUsed.contains("9c")) && 
//					(beforeTimeDangCourt.contains("7코트")||beforeTimeDangCourt.contains("8코트")||beforeTimeDangCourt.contains("9코트")) ){
//				dangCourt += !StringUtils.isEmpty(dangCourt) ? ",7코트,8코트,9코트" : "7코트,8코트,9코트";
//				courtUsed += !StringUtils.isEmpty(courtUsed) ? ",7c,8c,9c" : "7c,8c,9c";
//				dang -= 3;
//			}
			//5c,6c,10c 가 전시간 당첨된 코트에 있는경우 먼저검사
//			if( (!courtUsed.contains("5c") &&!courtUsed.contains("6c") &&!courtUsed.contains("10c")) && 
//					(beforeTimeDangCourt.contains("5코트")||beforeTimeDangCourt.contains("6코트")||beforeTimeDangCourt.contains("10코트")) ){
//				dangCourt += !StringUtils.isEmpty(dangCourt) ? ",5코트,6코트,10코트" : "5코트,6코트,10코트";
//				courtUsed += !StringUtils.isEmpty(courtUsed) ? ",5c,6c,10c" : "5c,6c,10c";
//				dang -= 3;
//			}else if(!courtUsed.contains("7c") &&!courtUsed.contains("8c") &&!courtUsed.contains("9c")){
//				dangCourt += !StringUtils.isEmpty(dangCourt) ? ",7코트,8코트,9코트" : "7코트,8코트,9코트";
//				courtUsed += !StringUtils.isEmpty(courtUsed) ? ",7c,8c,9c" : "7c,8c,9c";
//				dang -= 3;
//			}
//			else if(!courtUsed.contains("5c") &&!courtUsed.contains("6c") &&!courtUsed.contains("10c")) {
//				dangCourt += !StringUtils.isEmpty(dangCourt) ? ",5코트,6코트,10코트" : "5코트,6코트,10코트";
//				courtUsed += !StringUtils.isEmpty(courtUsed) ? ",5c,6c,10c" : "5c,6c,10c";
//				dang -= 3;
//			}
		}
		//당첨코트가 2개인 경우
		if(dang>=2){
			//5c,6c
			//7c,8c
			//9c,10c

			//9c,10c 가 전시간 당첨된 코트에 있는경우 먼저검사
			if( (!courtUsed.contains("9c") &&!courtUsed.contains("10c")) && 
					(beforeTimeDangCourt.contains("9코트")||beforeTimeDangCourt.contains("10코트")) ) {
				logger.info("2할당");
				dangCourt += !StringUtils.isEmpty(dangCourt) ? ",9코트,10코트" : "9코트,10코트";
				courtUsed += !StringUtils.isEmpty(courtUsed) ? ",9c,10c" : "9c,10c";
				dang -= 2;
			}
			//7c,8c 가 전시간 당첨된 코트에 있는경우 먼저검사
			else if( (!courtUsed.contains("7c") &&!courtUsed.contains("8c")) && 
					(beforeTimeDangCourt.contains("7코트")||beforeTimeDangCourt.contains("8코트")) ){
				logger.info("2할당");
				dangCourt += !StringUtils.isEmpty(dangCourt) ? ",7코트,8코트" : "7코트,8코트";
				courtUsed += !StringUtils.isEmpty(courtUsed) ? ",7c,8c" : "7c,8c";
				dang -= 2;
			}else if( (!courtUsed.contains("9c") &&!courtUsed.contains("10c"))){
				logger.info("2할당");
				dangCourt += !StringUtils.isEmpty(dangCourt) ? ",9코트,10코트" : "9코트,10코트";
				courtUsed += !StringUtils.isEmpty(courtUsed) ? ",9c,10c" : "9c,10c";
				dang -= 2;
			}
			else if( (!courtUsed.contains("7c") &&!courtUsed.contains("8c"))){
				logger.info("2할당");
				dangCourt += !StringUtils.isEmpty(dangCourt) ? ",7코트,8코트" : "7코트,8코트";
				courtUsed += !StringUtils.isEmpty(courtUsed) ? ",7c,8c" : "7c,8c";
				dang -= 2;
			}
		}

		//코트 할당을 하였으나, 묶음할당이 되지 않은경우
		//6c 가 전시간 당첨된 코트에 있는경우 먼저검사
		if(dang>0&&!courtUsed.contains("6c")&&beforeTimeDangCourt.contains("6코트")){
			dangCourt += !StringUtils.isEmpty(dangCourt) ? ",6코트" : "6코트";
			courtUsed += !StringUtils.isEmpty(courtUsed) ? ",6c" : "6c";
			dang--;
		}
		//7c 가 전시간 당첨된 코트에 있는경우 먼저검사
		if(dang>0&&!courtUsed.contains("7c")&&beforeTimeDangCourt.contains("7코트")){
			dangCourt += !StringUtils.isEmpty(dangCourt) ? ",7코트" : "7코트";
			courtUsed += !StringUtils.isEmpty(courtUsed) ? ",7c" : "7c";
			dang--;
		}
		//8c 가 전시간 당첨된 코트에 있는경우 먼저검사
		if(dang>0&&!courtUsed.contains("8c")&&beforeTimeDangCourt.contains("8코트")){
			dangCourt += !StringUtils.isEmpty(dangCourt) ? ",8코트" : "8코트";
			courtUsed += !StringUtils.isEmpty(courtUsed) ? ",8c" : "8c";
			dang--;
		}
		
		//9c 가 전시간 당첨된 코트에 있는경우 먼저검사
		if(dang>0&&!courtUsed.contains("9c")&&beforeTimeDangCourt.contains("9코트")){
			dangCourt += !StringUtils.isEmpty(dangCourt) ? ",9코트" : "9코트";
			courtUsed += !StringUtils.isEmpty(courtUsed) ? ",9c" : "9c";
			dang--;
		}
				
		//10c 가 전시간 당첨된 코트에 있는경우 먼저검사
		if(dang>0&&!courtUsed.contains("10c")&&beforeTimeDangCourt.contains("10코트")){
			dangCourt += !StringUtils.isEmpty(dangCourt) ? ",10코트" : "10코트";
			courtUsed += !StringUtils.isEmpty(courtUsed) ? ",10c" : "10c";
			dang--;
		}
		
		if(dang>0&&!courtUsed.contains("6c")){
			dangCourt += !StringUtils.isEmpty(dangCourt) ? ",6코트" : "6코트";
			courtUsed += !StringUtils.isEmpty(courtUsed) ? ",6c" : "6c";
			dang--;
		}
		if(dang>0&&!courtUsed.contains("7c")){
			dangCourt += !StringUtils.isEmpty(dangCourt) ? ",7코트" : "7코트";
			courtUsed += !StringUtils.isEmpty(courtUsed) ? ",7c" : "7c";
			dang--;
		}
		if(dang>0&&!courtUsed.contains("8c")){
			dangCourt += !StringUtils.isEmpty(dangCourt) ? ",8코트" : "8코트";
			courtUsed += !StringUtils.isEmpty(courtUsed) ? ",8c" : "8c";
			dang--;
		}
		if(dang>0&&!courtUsed.contains("9c")){
			dangCourt += !StringUtils.isEmpty(dangCourt) ? ",9코트" : "9코트";
			courtUsed += !StringUtils.isEmpty(courtUsed) ? ",9c" : "9c";
			dang--;
		}
		if(dang>0&&!courtUsed.contains("10c")){
			dangCourt += !StringUtils.isEmpty(dangCourt) ? ",10코트" : "10코트";
			courtUsed += !StringUtils.isEmpty(courtUsed) ? ",10c" : "10c";
			dang--;
		}
		
		return dangCourt;		
	}
	
	public void doProc1() { 
		try{
			String part_cd = "15";
			String failed_clnum = "";
			
			SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMdd");
			Calendar cal = Calendar.getInstance();
			String nowdate  = formatter.format(cal.getTime());
			
			cal.add(Calendar.DAY_OF_MONTH, 13);
			String after14days  = formatter.format(cal.getTime());
			
			cal.add(Calendar.DAY_OF_MONTH, -30);
			String oneMonthAgo  = formatter.format(cal.getTime());
			
			String[] rentTime = new String[]{"0500","0700","0900","1100","1300","1500",
					"1700","1800","1830","2030","2230","2330"};
			
			String beforeTime = "";
			
			List<RentReserve> fixedReserve = null;
			
			List<RentReserve> reTimes = rentMapper.listReRentTime(after14days);
			for(RentReserve reTime : reTimes){
				/*

				- 추첨 후 코트는 회사,동호회 예약 코트에 한해 랜덤으로 배분
				- 신청 시 코트 수 제한 없음(동호인 예약 최대 6코트까지 신청 가능)
				- 신청 코트에 한해 나누어 배분
				 ex) 총 6코트 : -신청건이 6팀 일 때 1코트씩 나누어 배분
								  -신청건이 6팀 초과일 때 한 코트씩 추첨하여 배분
								  -신청건이 6팀 미만일 때 신청 동호회 1코트씩 배분 후 남은코트 1코트 이상 신청한 동호회 추첨 하여 추가 배분 실시
				- 단, 총 6코트 중 [회사행사] 예약 코트 배제 후 남은 코트 추첨/배분
				- 코트 배분 : 1코트 배분 시 : 랜덤 배분
							  2코트 배분 시 : 5번,6번 / 7번,8번 / 9번,10번
							  3코트 배분 시 : 7번,8번,9번 / 5번,6번,10번
							  4코트 배분 시 : 7번,8번,9번,10번
							  5코트 배분 시 : 6번,7번,8번,9번,10번


				*/
				courtUsed = "";
				String ticket_date = reTime.getRe_date();
				String stime		= reTime.getRt_stime();
				String etime		= reTime.getRt_etime();
				
				String use_days = Util.getYoil(ticket_date);
				
				String rentCourt = null;
				String rentSTime = null;
				String rentETime = null;
				String rentCnt   = null;
				String rentCourtCnt   = null;
				
				if(fixedReserve == null)
					fixedReserve = rentMapper.listFixedReserve(Integer.parseInt(part_cd), use_days, ticket_date);
				
				for(RentReserve fixedTime : fixedReserve){
					String mycom_nm = fixedTime.getRe_title();
					String myetc = fixedTime.getRt_court();
					String myreserve_date = fixedTime.getRt_stime();
					String myret_date = fixedTime.getRt_etime();

					String mySTime = myreserve_date;
					String myETime = myret_date;
					
					//사용시간구분
					if(Integer.parseInt(mySTime)<Integer.parseInt(etime) && Integer.parseInt(myETime)>Integer.parseInt(stime) ){
						//사용코트 구분
						for(int j=5; j <= 10; j++){
							if(myetc.contains("전체") || myetc.contains(j + "코트")){

								if(!courtUsed.contains(j + "c")) courtUsed += !StringUtils.isEmpty(courtUsed) ? "," + j + "c" : j + "c";

							}
						}
					}
				}
				
				logger.info("기존프로그램 예약코트: " + courtUsed);
				
				// 현프로그램에서 회사행사 예약정보
				List<RentReserve> existReserve = rentMapper.listExistReserve(Integer.parseInt(part_cd), ticket_date, stime, etime);
				
				for(RentReserve existTime : existReserve){
					String mycom_nm = existTime.getCl_name() != null ? existTime.getCl_name() : existTime.getRe_name();
					String myetc = existTime.getRt_court();

					String mySTime = existTime.getRt_stime();
					String myETime = existTime.getRt_etime();
					
					//사용코트 구분
					for(int j=5; j <= 10; j++){
						if(myetc.contains("전체") || myetc.contains(j + "코트")){
							if(!courtUsed.contains(j + "c")) courtUsed += !StringUtils.isEmpty(courtUsed) ? "," + j + "c" : j + "c";
						}
					}
					
				}
				
				logger.info("신규프로그램 예약코트: " + courtUsed);
				
				logger.info("###################################################################################################################<br>");

				logger.info("예약날짜:" + ticket_date);
				logger.info("종목구분:" + part_cd);
				logger.info("시작시간:" + stime);
				logger.info("종료시간:" + etime);
				logger.info("예약된코트:" + courtUsed);
				
				String[] tmparr = new String[]{};
				if(!StringUtils.isEmpty(courtUsed)) tmparr = courtUsed.split(",");
				
				int leftCourtCnt = 6 - tmparr.length;
				logger.info("leftCourtCnt: " + leftCourtCnt);
				
				// 이번시간대의 총 예약 동호회수를 구한다. 6개 초과이면 추첨, 6개 이하이면 배정.
				boolean resave = false;
				int cnt = rentMapper.cntTargetReserve(Integer.parseInt(part_cd), ticket_date, stime, etime);
				if (cnt > leftCourtCnt)
					resave=true;
				else
					resave=false;
				
				logger.info("result save : " + resave);
				logger.info("team no : " + cnt);
				
				//남은 코트가 있을때
				if(leftCourtCnt > 0) {
					
					String tmp_rand="";
					int totalReqCourt = 0;
					List<RentReserveCnt> tmpCourt= new ArrayList<RentReserveCnt>();
					List<Integer> tmp_clnum= null;
					int j=0;
					//String oneMonthAgo 
					
					/* 1. 오늘 당첨되지 않은 동호회를 우선 배정 */	
					List<RentReserveCnt> reserveCnt = rentMapper.listDrawReserve(Integer.parseInt(part_cd), ticket_date, stime, etime, oneMonthAgo, beforeTime, "");
					failed_clnum = "";
					List<Integer> success_clnum = new ArrayList<Integer>();
					
					tmp_clnum = new ArrayList<Integer>();
					
					for(RentReserveCnt reCnt : reserveCnt){
						if(leftCourtCnt==0){
							if (!StringUtils.isEmpty(failed_clnum)) failed_clnum += ",";
							
							failed_clnum += String.valueOf(reCnt.getCl_num());
						} else{
							logger.info(reCnt.getCl_num() + "= " + reCnt.getUsedcnt() + "번" + reCnt.getBtdc());
							
							tmp_clnum.add(reCnt.getCl_num());
							
							reCnt.setReq(reCnt.getRt_court_cnt());
							reCnt.setDang(1);
							reCnt.setCourt("");
							
							tmpCourt.add(reCnt);
							
							leftCourtCnt--;
							totalReqCourt += reCnt.getRt_court_cnt();
							totalReqCourt--;
							logger.info(leftCourtCnt + "= " + totalReqCourt);
							success_clnum.add(reCnt.getCl_num());

							j++;
						}
					}
					
					logger.info("totalReqCourt=" + totalReqCourt);	
					logger.info("FailedClub=" + failed_clnum);	
					logger.info("당첨된 동호회 번호:" + tmp_clnum);	
					
					
					if(success_clnum.size() > 0)
						reserveCnt = rentMapper.listDrawReserve(Integer.parseInt(part_cd), ticket_date, stime, etime, oneMonthAgo, beforeTime, success_clnum);
					else
						reserveCnt = rentMapper.listDrawReserve(Integer.parseInt(part_cd), ticket_date, stime, etime, oneMonthAgo, beforeTime);
					
					for(RentReserveCnt reCnt : reserveCnt){
						if(leftCourtCnt==0){
							if (!StringUtils.isEmpty(failed_clnum)) failed_clnum += ",";
							
							failed_clnum += String.valueOf(reCnt.getCl_num());
						} else{
							logger.info(reCnt.getCl_num() + "= " + reCnt.getUsedcnt() + "번" + reCnt.getBtdc());
							
							tmp_clnum.add(reCnt.getCl_num());
							
							reCnt.setReq(reCnt.getRt_court_cnt());
							reCnt.setDang(1);
							reCnt.setCourt("");
							
							tmpCourt.add(reCnt);
							
							leftCourtCnt--;
							totalReqCourt += reCnt.getRt_court_cnt();
							totalReqCourt--;
							logger.info(leftCourtCnt + "= " + totalReqCourt);
							success_clnum.add(reCnt.getCl_num());

							j++;
						}
					}
					
					logger.info("totalReqCourt=" + totalReqCourt);	
					logger.info("FailedClub=" + failed_clnum);	
					logger.info("당첨된 동호회 번호:" + tmp_clnum);	
					
					
					//코트가 남거나, 신청코트수가 다 찰때까지

					int aa= 0;
					int bb= 0;

					int vv=0;
					while(leftCourtCnt>0 && totalReqCourt>0){

						//shuffle($tmp_rand);

						//필요한 코트수가 충족하는지 검사
						
						for(int j1=0; j1< tmpCourt.size();j1++){
							
							if(leftCourtCnt<=0) break;
							if(totalReqCourt<=0) break;

							//$vv = $tmpCourt[$j]['req']; // 신청 번호

							aa=tmpCourt.get(j1).getReq();
							bb=tmpCourt.get(j1).getDang();

							if(aa > bb){

								leftCourtCnt--;
								totalReqCourt--;
								bb++;
							}
							
							tmpCourt.get(j1).setDang(bb);


						}
						if(leftCourtCnt<=0) break;
						if(totalReqCourt<=0) break;

						//$vv++;

					}
					
					Collections.shuffle(tmpCourt);
					Collections.sort(tmpCourt, new Comparator<RentReserveCnt>(){
					  public int compare(RentReserveCnt o1, RentReserveCnt o2){
					    // TODO Auto-generated method stub
						  return (o1.getDang() > o2.getDang()) ? -1: (o1.getDang() > o2.getDang()) ? 1:0 ;
					  }
					});
					
					//당첨된 코트수
					for(int j2=0;j2<tmpCourt.size();j2++){
						vv=tmpCourt.get(j2).getRt_num();  //예약번호
						int clnum =  tmpCourt.get(j2).getCl_num();
						logger.info(clnum + "번의 신청코트수 : " + tmpCourt.get(j2).getReq());
						logger.info(clnum + "번의 당첨코트수 : " + tmpCourt.get(j2).getDang());
						
//						fwrite($fp, $clnum.'번의 신청코트수 : '.$tmpCourt[$j]['req'].PHP_EOL);
//						fwrite($fp, $clnum.'번의 당첨코트수 : '.$tmpCourt[$j]['dang'].PHP_EOL);
					}
					
//					fwrite($fp, '추첨후 남은 코트수:'.$leftCourtCnt.PHP_EOL);
//					fwrite($fp, '추첨후 필요한 코트수:'.$totalReqCourt.PHP_EOL);
					//sortByField($tmp_rand, 'dang'); // Sort by oldest first
					//echo "sizeof(tmp_rand)=".sizeof($tmp_rand)."<br>";
					
					// 많이 당첨된 코드를 우선 배정.
					//////////////////////////////////////////////////////////////////////////////
					// 6개 ~ 1개
					// 이전 시간에 당첨된 동호회를 우선적으로 배분한다.
					for(int i = 6; i > 0 ; --i){
						for(RentReserveCnt tmpcrt : tmpCourt){
							vv=tmpcrt.getRt_num();  //예약번호
							int clnum =  tmpcrt.getCl_num() ;
							int dang = tmpcrt.getDang();
							String dangCourt="";
							if (dang==i)
							{
								if (!StringUtils.isEmpty(tmpcrt.getBtdc()))
								{
									logger.info("동호회의 당일 전시간대 당첨된 코트=" + tmpcrt.getBtdc());	
	
									String beforeTimeDangCourt = tmpcrt.getBtdc();
									/*
									//당첨코트가 7개인 경우 전체사용
									if($dang==7){
										if(!strstr($courtUsed,'4c')&&!strstr($courtUsed,'5c')&&!strstr($courtUsed,'6c')&&!strstr($courtUsed,'7c')&&!strstr($courtUsed,'8c')&&!strstr($courtUsed,'9c')&&!strstr($courtUsed,'10c')){
											$dangCourt = "4코트,5코트,6코트,7코트,8코트,9코트,10코트";
											$courtUsed = "4c,5c,6c,7c,8c,9c,10c";
											$dang -= 7;
										}
									}
									*/
	
									dangCourt = getDang(dang, beforeTimeDangCourt) ;
	
									//당첨결과를 저장
									tmpcrt.setCourt(dangCourt);
	
	//								fwrite($fp, "courtUsed :".$courtUsed.PHP_EOL);
	//								fwrite($fp, $clnum."동호회의 당첨코트 = ".$dangCourt.PHP_EOL);
									logger.info("동호회의 당첨코트 = " + dangCourt);
	
									//당첨처리
									int result_save = rentMapper.updateDraw(vv, dangCourt);
				
									if (result_save <= 0)
									{
										dang = tmpcrt.getDang();
										rentMapper.insertDraw(ticket_date, clnum, dang, stime);
									}
								}
							}
	
						}
						
						for(RentReserveCnt tmpcrt : tmpCourt){
							vv=tmpcrt.getRt_num();  //예약번호
							int clnum =  tmpcrt.getCl_num() ;
							int dang = tmpcrt.getDang();
							String dangCourt="";
							if (dang==i)
							{
								if (StringUtils.isEmpty(tmpcrt.getCourt()))
								{
									logger.info("동호회의 당일 전시간대 당첨된 코트=" + tmpcrt.getBtdc());	
	
									String beforeTimeDangCourt = tmpcrt.getBtdc();
									/*
									//당첨코트가 7개인 경우 전체사용
									if($dang==7){
										if(!strstr($courtUsed,'4c')&&!strstr($courtUsed,'5c')&&!strstr($courtUsed,'6c')&&!strstr($courtUsed,'7c')&&!strstr($courtUsed,'8c')&&!strstr($courtUsed,'9c')&&!strstr($courtUsed,'10c')){
											$dangCourt = "4코트,5코트,6코트,7코트,8코트,9코트,10코트";
											$courtUsed = "4c,5c,6c,7c,8c,9c,10c";
											$dang -= 7;
										}
									}
									*/
	
									dangCourt = getDang(dang, beforeTimeDangCourt) ;
	
									//당첨결과를 저장
									tmpcrt.setCourt(dangCourt);
	
	//								fwrite($fp, "courtUsed :".$courtUsed.PHP_EOL);
	//								fwrite($fp, $clnum."동호회의 당첨코트 = ".$dangCourt.PHP_EOL);
									logger.info("동호회의 당첨코트 = " + dangCourt);
	
									//당첨처리
									int result_save = rentMapper.updateDraw(vv, dangCourt);
				
									if (result_save >= 1)
									{
										dang = tmpcrt.getDang();
										rentMapper.insertDraw(ticket_date, clnum, dang, stime);
									}
								}
							}
	
						}
					}
					rentMapper.updateFailedDraw(Integer.parseInt(part_cd), ticket_date, stime, etime);
				}
				
				beforeTime=stime;
			}
			
		}catch(Exception e){
			logger.info(e.getMessage());
		}
	}
	
	String getDang1(int dang, String beforeTimeDangCourt) {
		String dangCourt = "";
		
		if(beforeTimeDangCourt == null)
			beforeTimeDangCourt = "";
		
		//당첨코트가 6개인 경우 전체사용
		if(dang>=6){
			if(!courtUsed.contains("5c")
					&&!courtUsed.contains("6c")
					&&!courtUsed.contains("7c")
					&&!courtUsed.contains("8c")
					&&!courtUsed.contains("9c")
					&&!courtUsed.contains("10c")){
				dangCourt = "5코트,6코트,7코트,8코트,9코트,10코트";
				courtUsed += !StringUtils.isEmpty(courtUsed) ? ",5c,6c,7c,8c,9c,10c" : "5c,6c,7c,8c,9c,10c";
				dang -= 6;
			}
		}
		//당첨코트가 5개인 경우
		if(dang>=5){
			if(!courtUsed.contains("6c")
					&&!courtUsed.contains("7c")
					&&!courtUsed.contains("8c")
					&&!courtUsed.contains("9c")
					&&!courtUsed.contains("10c")){
				dangCourt = "6코트,7코트,8코트,9코트,10코트";
				courtUsed += !StringUtils.isEmpty(courtUsed) ? ",6c,7c,8c,9c,10c" : "6c,7c,8c,9c,10c";
				dang -= 5;
			}
		}
		
		//당첨코트가 4개인 경우
		if(dang>=4){
			if(!courtUsed.contains("7c")
					&&!courtUsed.contains("8c")
					&&!courtUsed.contains("9c")
					&&!courtUsed.contains("10c")){
				dangCourt = "7코트,8코트,9코트,10코트";
				courtUsed += !StringUtils.isEmpty(courtUsed) ? ",7c,8c,9c,10c" : "7c,8c,9c,10c";
				dang -= 4;
			}
		}
		
		//당첨코트가 3개인 경우
		if(dang>=3){
			//7c,8c,9c
			//5c,6c,10c

			//7c,8c,9c 가 전시간 당첨된 코트에 있는경우 먼저검사
			if( (!courtUsed.contains("7c") &&!courtUsed.contains("8c") &&!courtUsed.contains("9c")) && 
					(beforeTimeDangCourt.contains("7코트")||beforeTimeDangCourt.contains("8코트")||beforeTimeDangCourt.contains("9코트")) ){
				dangCourt += !StringUtils.isEmpty(dangCourt) ? ",7코트,8코트,9코트" : "7코트,8코트,9코트";
				courtUsed += !StringUtils.isEmpty(courtUsed) ? ",7c,8c,9c" : "7c,8c,9c";
				dang -= 3;
			}
			//5c,6c,10c 가 전시간 당첨된 코트에 있는경우 먼저검사
			if( (!courtUsed.contains("5c") &&!courtUsed.contains("6c") &&!courtUsed.contains("10c")) && 
					(beforeTimeDangCourt.contains("5코트")||beforeTimeDangCourt.contains("6코트")||beforeTimeDangCourt.contains("10코트")) ){
				dangCourt += !StringUtils.isEmpty(dangCourt) ? ",5코트,6코트,10코트" : "5코트,6코트,10코트";
				courtUsed += !StringUtils.isEmpty(courtUsed) ? ",5c,6c,10c" : "5c,6c,10c";
				dang -= 3;
			}else if(!courtUsed.contains("7c") &&!courtUsed.contains("8c") &&!courtUsed.contains("9c")){
				dangCourt += !StringUtils.isEmpty(dangCourt) ? ",7코트,8코트,9코트" : "7코트,8코트,9코트";
				courtUsed += !StringUtils.isEmpty(courtUsed) ? ",7c,8c,9c" : "7c,8c,9c";
				dang -= 3;
			}else if(!courtUsed.contains("5c") &&!courtUsed.contains("6c") &&!courtUsed.contains("10c")) {
				dangCourt += !StringUtils.isEmpty(dangCourt) ? ",5코트,6코트,10코트" : "5코트,6코트,10코트";
				courtUsed += !StringUtils.isEmpty(courtUsed) ? ",5c,6c,10c" : "5c,6c,10c";
				dang -= 3;
			}
		}
		//당첨코트가 2개인 경우
		if(dang>=2){
			//5c,6c
			//7c,8c
			//9c,10c

			//9c,10c 가 전시간 당첨된 코트에 있는경우 먼저검사
			if( (!courtUsed.contains("9c") &&!courtUsed.contains("10c")) && 
					(beforeTimeDangCourt.contains("9코트")||beforeTimeDangCourt.contains("10코트")) ) {
				logger.info("2할당");
				dangCourt += !StringUtils.isEmpty(dangCourt) ? ",9코트,10코트" : "9코트,10코트";
				courtUsed += !StringUtils.isEmpty(courtUsed) ? ",9c,10c" : "9c,10c";
				dang -= 2;
			}
			//5c,6c 가 전시간 당첨된 코트에 있는경우 먼저검사
			else if( (!courtUsed.contains("5c") &&!courtUsed.contains("6c")) && 
					(beforeTimeDangCourt.contains("5코트")||beforeTimeDangCourt.contains("6코트")) ){
				logger.info("2할당");
				dangCourt += !StringUtils.isEmpty(dangCourt) ? ",5코트,6코트" : "5코트,6코트";
				courtUsed += !StringUtils.isEmpty(courtUsed) ? ",5c,6c" : "5c,6c";
				dang -= 2;
			}
			//7c,8c 가 전시간 당첨된 코트에 있는경우 먼저검사
			else if( (!courtUsed.contains("7c") &&!courtUsed.contains("8c")) && 
					(beforeTimeDangCourt.contains("7코트")||beforeTimeDangCourt.contains("8코트")) ){
				logger.info("2할당");
				dangCourt += !StringUtils.isEmpty(dangCourt) ? ",7코트,8코트" : "7코트,8코트";
				courtUsed += !StringUtils.isEmpty(courtUsed) ? ",7c,8c" : "7c,8c";
				dang -= 2;
			}else if( (!courtUsed.contains("9c") &&!courtUsed.contains("10c"))){
				logger.info("2할당");
				dangCourt += !StringUtils.isEmpty(dangCourt) ? ",9코트,10코트" : "9코트,10코트";
				courtUsed += !StringUtils.isEmpty(courtUsed) ? ",9c,10c" : "9c,10c";
				dang -= 2;
			}else if( (!courtUsed.contains("5c") &&!courtUsed.contains("6c"))){
				logger.info("2할당");
				dangCourt += !StringUtils.isEmpty(dangCourt) ? ",5코트,6코트" : "5코트,6코트";
				courtUsed += !StringUtils.isEmpty(courtUsed) ? ",5c,6c" : "5c,6c";
				dang -= 2;
			}else if( (!courtUsed.contains("7c") &&!courtUsed.contains("8c"))){
				logger.info("2할당");
				dangCourt += !StringUtils.isEmpty(dangCourt) ? ",7코트,8코트" : "7코트,8코트";
				courtUsed += !StringUtils.isEmpty(courtUsed) ? ",7c,8c" : "7c,8c";
				dang -= 2;
			}
		}

		//코트 할당을 하였으나, 묶음할당이 되지 않은경우
		/*
		if($dang>0&&!strstr($courtUsed,'4c')){
			$dangCourt .= $dangCourt ? ",4코트" : "4코트";
			$courtUsed .= $courtUsed ? ",4c" : "4c";
			$dang--;
		}
		*/
		//5c 가 전시간 당첨된 코트에 있는경우 먼저검사
		if(dang>0&&!courtUsed.contains("5c")&&beforeTimeDangCourt.contains("5코트")){
			dangCourt += !StringUtils.isEmpty(dangCourt) ? ",5코트" : "5코트";
			courtUsed += !StringUtils.isEmpty(courtUsed) ? ",5c" : "5c";
			dang--;
		}
		//6c 가 전시간 당첨된 코트에 있는경우 먼저검사
		if(dang>0&&!courtUsed.contains("6c")&&beforeTimeDangCourt.contains("6코트")){
			dangCourt += !StringUtils.isEmpty(dangCourt) ? ",6코트" : "6코트";
			courtUsed += !StringUtils.isEmpty(courtUsed) ? ",6c" : "6c";
			dang--;
		}
		//7c 가 전시간 당첨된 코트에 있는경우 먼저검사
		if(dang>0&&!courtUsed.contains("7c")&&beforeTimeDangCourt.contains("7코트")){
			dangCourt += !StringUtils.isEmpty(dangCourt) ? ",7코트" : "7코트";
			courtUsed += !StringUtils.isEmpty(courtUsed) ? ",7c" : "7c";
			dang--;
		}
		//8c 가 전시간 당첨된 코트에 있는경우 먼저검사
		if(dang>0&&!courtUsed.contains("8c")&&beforeTimeDangCourt.contains("8코트")){
			dangCourt += !StringUtils.isEmpty(dangCourt) ? ",8코트" : "8코트";
			courtUsed += !StringUtils.isEmpty(courtUsed) ? ",8c" : "8c";
			dang--;
		}
		//10c 가 전시간 당첨된 코트에 있는경우 먼저검사
		if(dang>0&&!courtUsed.contains("10c")&&beforeTimeDangCourt.contains("10코트")){
			dangCourt += !StringUtils.isEmpty(dangCourt) ? ",10코트" : "10코트";
			courtUsed += !StringUtils.isEmpty(courtUsed) ? ",10c" : "10c";
			dang--;
		}
		//9c 가 전시간 당첨된 코트에 있는경우 먼저검사
		if(dang>0&&!courtUsed.contains("9c")&&beforeTimeDangCourt.contains("9코트")){
			dangCourt += !StringUtils.isEmpty(dangCourt) ? ",9코트" : "9코트";
			courtUsed += !StringUtils.isEmpty(courtUsed) ? ",9c" : "9c";
			dang--;
		}

		if(dang>0&&!courtUsed.contains("5c")){
			dangCourt += !StringUtils.isEmpty(dangCourt) ? ",5코트" : "5코트";
			courtUsed += !StringUtils.isEmpty(courtUsed) ? ",5c" : "5c";
			dang--;
		}

		if(dang>0&&!courtUsed.contains("6c")){
			dangCourt += !StringUtils.isEmpty(dangCourt) ? ",6코트" : "6코트";
			courtUsed += !StringUtils.isEmpty(courtUsed) ? ",6c" : "6c";
			dang--;
		}
		if(dang>0&&!courtUsed.contains("7c")){
			dangCourt += !StringUtils.isEmpty(dangCourt) ? ",7코트" : "7코트";
			courtUsed += !StringUtils.isEmpty(courtUsed) ? ",7c" : "7c";
			dang--;
		}
		if(dang>0&&!courtUsed.contains("8c")){
			dangCourt += !StringUtils.isEmpty(dangCourt) ? ",8코트" : "8코트";
			courtUsed += !StringUtils.isEmpty(courtUsed) ? ",8c" : "8c";
			dang--;
		}
		if(dang>0&&!courtUsed.contains("9c")){
			dangCourt += !StringUtils.isEmpty(dangCourt) ? ",9코트" : "9코트";
			courtUsed += !StringUtils.isEmpty(courtUsed) ? ",9c" : "9c";
			dang--;
		}
		if(dang>0&&!courtUsed.contains("10c")){
			dangCourt += !StringUtils.isEmpty(dangCourt) ? ",10코트" : "10코트";
			courtUsed += !StringUtils.isEmpty(courtUsed) ? ",10c" : "10c";
			dang--;
		}

		return dangCourt;		
	}

	//  초    |   분   |   시   |   일   |   월   |  요일  |   연도
	// 0~59 | 0~59 | 0~23 | 1~31 | 1~12 |  0~6 | 생략가능
	@Scheduled(cron = "0 50 12 * * *") 
//	@Scheduled(fixedDelayString = "120000")
	public void batch() { 
		doProc();
	}
	
	
}

	