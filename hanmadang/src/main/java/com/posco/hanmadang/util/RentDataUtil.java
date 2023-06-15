package com.posco.hanmadang.util;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.util.StringUtils;

import com.posco.hanmadang.common.Constant.RentReserveType;
import com.posco.hanmadang.model.KeyValueObject;
import com.posco.hanmadang.model.RentReserve;

public class RentDataUtil {
	public static Logger logger = LoggerFactory.getLogger(RentDataUtil.class);

	public static int checkReType(String checkDate){
		int iCheckDate = Integer.parseInt(checkDate);
		
		SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMdd");
		Calendar cal = Calendar.getInstance();
		
		int hour = cal.get(Calendar.HOUR_OF_DAY);
		if(hour > 12){
			int pSDate = Integer.parseInt(formatter.format(cal.getTime()));
			
			cal.add(Calendar.DAY_OF_MONTH, 1);
			int pEDate = Integer.parseInt(formatter.format(cal.getTime()));
			
			if(pSDate <= iCheckDate && iCheckDate <= pEDate)
				return RentReserveType.employee.ordinal();
			
			cal.add(Calendar.DAY_OF_MONTH, 1);
			int teamSDate = Integer.parseInt(formatter.format(cal.getTime()));
			
			cal.add(Calendar.DAY_OF_MONTH, 12);
			int teamEDate = Integer.parseInt(formatter.format(cal.getTime()));
			
			if(iCheckDate == teamEDate)
				return RentReserveType.draw.ordinal();
			
			if(teamSDate <= iCheckDate && iCheckDate <= teamEDate)
				return RentReserveType.team.ordinal();
			
//			for(int i = 1; i < 14; ++i){
//				cal.add(Calendar.DAY_OF_MONTH, 1);
//				String strDate = formatter.format(cal.getTime());
//			}
			return 0;
		}else{
			int pSDate = Integer.parseInt(formatter.format(cal.getTime()));
			
			// 추첨 전이라 하루 건너띔
			cal.add(Calendar.DAY_OF_MONTH, 1);
			if(pSDate <= iCheckDate && iCheckDate <= pSDate)
				return RentReserveType.employee.ordinal();
			
			cal.add(Calendar.DAY_OF_MONTH, 1);
			int teamSDate = Integer.parseInt(formatter.format(cal.getTime()));
			
			cal.add(Calendar.DAY_OF_MONTH, 11);
			int teamEDate = Integer.parseInt(formatter.format(cal.getTime()));
			
			if(iCheckDate == teamEDate)
				return RentReserveType.draw.ordinal();
			
			if(teamSDate <= iCheckDate && iCheckDate <= teamEDate)
				return RentReserveType.team.ordinal();
			
//			for(int i = 1; i < 13; ++i){
//				cal.add(Calendar.DAY_OF_MONTH, 1);
//				String strDate = formatter.format(cal.getTime());
//			}
			
			return 0;
		}
	}
	
	public static String[] makeArrayAbleCortBadminton() {
		return new String[] {"3","5","7","8","10","12"};
	}
	public static String[] makeArrayAbleCortPingpong() {
		return new String[] {"2","4","6","8","10","12"};
	}
	public static String[] makeArrayAbleCortBilliards() {
		return new String[] {"2","5","6","8"};
	}
	
	public static  List<KeyValueObject<List<RentReserve>>> makeArrayBadminton(List<RentReserve> list, String date, String yoil, int type){
		String[] times = null;
		
		if(type == 0 || type == RentReserveType.employee.ordinal()){
			times = new String[]{"07:00 ~ 08:00", "08:00 ~ 09:00", "09:00 ~ 10:00", "10:00 ~ 11:00", "11:00 ~ 12:00", "12:00 ~ 13:00",
					"13:00 ~ 14:00", "14:00 ~ 15:00", "15:00 ~ 16:00", "16:00 ~ 17:00", "17:00 ~ 18:00", "18:00 ~ 18:30",
					"18:30 ~ 19:30", "19:30 ~ 20:30", "20:30 ~ 21:30","21:30 ~ 22:30"};

			if( Integer.parseInt(yoil)>5 ) { // (토,일)주말일경우
				times = new String[]{"07:00 ~ 08:00", "08:00 ~ 09:00", "09:00 ~ 10:00", "10:00 ~ 11:00", "11:00 ~ 12:00", "12:00 ~ 13:00",
						"13:00 ~ 14:00", "14:00 ~ 15:00", "15:00 ~ 16:00", "16:00 ~ 17:00", "17:00 ~ 18:00", "18:00 ~ 18:30",
						"18:30 ~ 19:30", "19:30 ~ 20:30", "20:30 ~ 21:30","21:30 ~ 22:00"};
			}
		}else{
			times = new String[]{"07:00 ~ 09:00", "09:00 ~ 11:00", "11:00 ~ 13:00",
					"13:00 ~ 15:00", "15:00 ~ 17:00", "17:00 ~ 18:00", "18:00 ~ 18:30",
					"18:30 ~ 20:30", "20:30 ~ 22:30"};
			
			if( Integer.parseInt(yoil)>5 ) { // (토,일)주말일경우
				times = new String[]{"07:00 ~ 09:00", "09:00 ~ 11:00", "11:00 ~ 13:00",
						"13:00 ~ 15:00", "15:00 ~ 17:00", "17:00 ~ 18:00", "18:00 ~ 18:30",
						"18:30 ~ 20:30", "20:30 ~ 21:30"};
			}
		}
//		if( HolidayUtil.isHoliday(date) ) { // (토,일)주말일경우
//			times = new String[]{"07:00 ~ 09:00", "09:00 ~ 11:00", "11:00 ~ 13:00",
//					"13:00 ~ 15:00", "15:00 ~ 17:00", "17:00 ~ 18:00", "18:00 ~ 18:30",
//					"18:30 ~ 20:30", "20:30 ~ 21:30"};
//		}
		List<KeyValueObject<List<RentReserve>>> array = new ArrayList<KeyValueObject<List<RentReserve>>>();
		
		for(String time : times){
			List<RentReserve> tmplist = new ArrayList<RentReserve>();
			int sTime = Integer.parseInt(time.replace(":", "").substring(0, 4));
			int eTime = Integer.parseInt(time.replace(":", "").substring(7, 11));
			for(RentReserve re : list){
				if(!StringUtils.isEmpty(re.getRe_yoil()))
					re.setRe_type(RentReserveType.lecture.name());
				else if(!StringUtils.isEmpty(re.getRe_title()))
					re.setRe_type(RentReserveType.company.name());
				else if(re.getCl_num() > 0)
					re.setRe_type(RentReserveType.team.name());
				else if(re.getCl_num() < 0)
					re.setRe_type(RentReserveType.today.name());
				else
					re.setRe_type(RentReserveType.employee.name());
				
				// 이름마스킹
				if(re.getCl_num()==0){
					re.setRe_name(Util.nameMasking((re.getRe_name())));
				}
				if(Integer.parseInt(re.getRt_stime()) == sTime || Integer.parseInt(re.getRt_etime()) == eTime)
					tmplist.add(re);
				
			}
			
			//올코트 체크
			if(tmplist.size() >= 12) {
				int type_cnt = 0;
				int type_cnt1 = 0;
				int same_time_cnt = 0;
				int same_time_cnt1 = 0;
				for(RentReserve rre : tmplist) {
					
					
					if(Integer.parseInt(time.substring(0, 5).replace(":", "")) == Integer.parseInt(rre.getRt_stime())) {
						if(RentReserveType.company.name().equals(rre.getRe_type()))
							type_cnt++;
						
						same_time_cnt++;
					}
					
					if(Integer.parseInt(time.substring(8, 13).replace(":", "")) == Integer.parseInt(rre.getRt_etime())) {
						if(RentReserveType.company.name().equals(rre.getRe_type()))
							type_cnt1++;
						same_time_cnt1++;
					}
					
				}
				if((type_cnt >= 12 && same_time_cnt >= 12) || (type_cnt1 >= 12 && same_time_cnt1 >= 12))
					tmplist.get(0).setAllCourt(true);
			}
			
			KeyValueObject<List<RentReserve>> value = new KeyValueObject<List<RentReserve>>();
			value.setKey(time);
			value.setValue(tmplist);
			array.add(value);
		}
		
		return array;
	}
	
	public static  List<KeyValueObject<List<RentReserve>>> makeArrayPingpong(List<RentReserve> list, String date, String yoil){
		String[] times = new String[]{"09:00 ~ 10:00", "10:00 ~ 11:00", "11:00 ~ 12:00", "12:00 ~ 13:00",
				"13:00 ~ 14:00", "14:00 ~ 15:00", "15:00 ~ 16:00", "16:00 ~ 17:00", "17:00 ~ 18:00",
				"18:00 ~ 19:00", "19:00 ~ 20:00", "20:00 ~ 21:00","21:00 ~ 22:00","22:00 ~ 22:30"};
				
		if( Integer.parseInt(yoil)>5 || HolidayUtil.isHoliday(date) ) { // (토,일)주말일경우
			times = new String[]{"09:00 ~ 10:00", "10:00 ~ 11:00", "11:00 ~ 12:00", "12:00 ~ 13:00",
				"13:00 ~ 14:00", "14:00 ~ 15:00", "15:00 ~ 16:00", "16:00 ~ 17:00", "17:00 ~ 18:00",
				"18:00 ~ 19:00", "19:00 ~ 20:00", "20:00 ~ 21:00", "21:00 ~ 21:30"};
		}
		
		List<KeyValueObject<List<RentReserve>>> array = new ArrayList<KeyValueObject<List<RentReserve>>>();
		
		for(String time : times){
			List<RentReserve> tmplist = new ArrayList<RentReserve>();
			int sTime = Integer.parseInt(time.replace(":", "").substring(0, 4));
			int eTime = Integer.parseInt(time.replace(":", "").substring(7, 11));
			for(RentReserve re : list){
				if(Integer.parseInt(re.getRt_stime()) == sTime || Integer.parseInt(re.getRt_etime()) == eTime){
					if(!StringUtils.isEmpty(re.getRe_yoil()))
						re.setRe_type(RentReserveType.lecture.name());
					else if(!StringUtils.isEmpty(re.getRe_title()))
						re.setRe_type(RentReserveType.company.name());
					else if(re.getCl_num() > 0)
						re.setRe_type(RentReserveType.team.name());
					else
						re.setRe_type(RentReserveType.employee.name());
					
					tmplist.add(re);
				}
			}
			KeyValueObject<List<RentReserve>> value = new KeyValueObject<List<RentReserve>>();
			value.setKey(time);
			value.setValue(tmplist);
			array.add(value);
		}
		
		return array;
	}
	
	public static  List<KeyValueObject<List<RentReserve>>> makeArrayBilliards(List<RentReserve> list, String date, String yoil){
		String[] times = new String[]{"09:00 ~ 10:00", "10:00 ~ 11:00", "11:00 ~ 12:00", "12:00 ~ 13:00",
				"13:00 ~ 14:00", "14:00 ~ 15:00", "15:00 ~ 16:00", "16:00 ~ 17:00", "17:00 ~ 18:00",
				"18:00 ~ 19:00", "19:00 ~ 20:00", "20:00 ~ 21:00","21:00 ~ 22:00","22:00 ~ 22:30"};
				
		if( Integer.parseInt(yoil)>5 || HolidayUtil.isHoliday(date) ) { // (토,일)주말일경우
			times = new String[]{"09:00 ~ 10:00", "10:00 ~ 11:00", "11:00 ~ 12:00", "12:00 ~ 13:00",
				"13:00 ~ 14:00", "14:00 ~ 15:00", "15:00 ~ 16:00", "16:00 ~ 17:00", "17:00 ~ 18:00",
				"18:00 ~ 19:00", "19:00 ~ 20:00", "20:00 ~ 21:00", "21:00 ~ 21:30"};
		}
		
		List<KeyValueObject<List<RentReserve>>> array = new ArrayList<KeyValueObject<List<RentReserve>>>();
		
		for(String time : times){
			List<RentReserve> tmplist = new ArrayList<RentReserve>();
			int sTime = Integer.parseInt(time.replace(":", "").substring(0, 4));
			int eTime = Integer.parseInt(time.replace(":", "").substring(7, 11));
			for(RentReserve re : list){
				if(Integer.parseInt(re.getRt_stime()) == sTime || Integer.parseInt(re.getRt_etime()) == eTime){
					if(!StringUtils.isEmpty(re.getRe_yoil()))
						re.setRe_type(RentReserveType.lecture.name());
					else if(!StringUtils.isEmpty(re.getRe_title()))
						re.setRe_type(RentReserveType.company.name());
					else if(re.getCl_num() > 0)
						re.setRe_type(RentReserveType.team.name());
					else
						re.setRe_type(RentReserveType.employee.name());
					
					tmplist.add(re);
				}
			}
			KeyValueObject<List<RentReserve>> value = new KeyValueObject<List<RentReserve>>();
			value.setKey(time);
			value.setValue(tmplist);
			array.add(value);
		}
		
		return array;
	}
	
	public static  List<RentReserve> makeType(List<RentReserve> list){
		for(RentReserve re : list){
			if(!StringUtils.isEmpty(re.getRe_yoil()))
				re.setRe_type(RentReserveType.lecture.name());
			else if(!StringUtils.isEmpty(re.getRe_title()))
				re.setRe_type(RentReserveType.company.name());
			else if(re.getCl_num() > 0)
				re.setRe_type(RentReserveType.team.name());
			else
				re.setRe_type(RentReserveType.employee.name());
		}
		return list;
	}
	
	public static  List<KeyValueObject<RentReserve>> makeStateOnBadminton(List<RentReserve> list, int type){
		String[] times = null;
		
		if(type == RentReserveType.employee.ordinal()){
			times = new String[]{"07:00 ~ 08:00", "08:00 ~ 09:00", "09:00 ~ 10:00", "10:00 ~ 11:00", "11:00 ~ 12:00", "12:00 ~ 13:00",
					"13:00 ~ 14:00", "14:00 ~ 15:00", "15:00 ~ 16:00", "16:00 ~ 17:00", "17:00 ~ 18:00", "18:00 ~ 18:30",
					"18:30 ~ 19:30", "19:30 ~ 20:30", "20:30 ~ 21:30","21:30 ~ 22:30"};
		}else{
			times = new String[]{"07:00 ~ 09:00", "09:00 ~ 11:00", "11:00 ~ 13:00",
					"13:00 ~ 15:00", "15:00 ~ 17:00", "17:00 ~ 18:00", "18:00 ~ 18:30",
					"18:30 ~ 20:30", "20:30 ~ 22:30"};
		}
		List<KeyValueObject<RentReserve>> array = new ArrayList<KeyValueObject<RentReserve>>();
		
		for(String time : times){
			int sTime = Integer.parseInt(time.replace(":", "").substring(0, 4));
			int eTime = Integer.parseInt(time.replace(":", "").substring(7, 11));
			
			int rentCnt = 0;
			int rentCourtCnt = 0;
			
			for(RentReserve re : list){
				if(Integer.parseInt(re.getRt_stime()) == sTime || Integer.parseInt(re.getRt_etime()) == eTime){
					++rentCnt;
					rentCourtCnt += re.getRt_court_cnt();
				}
			}
			
			RentReserve tmpRe = new RentReserve();
			tmpRe.setCourt_cnt(rentCnt);
			tmpRe.setRt_court_cnt(rentCourtCnt);
			
			KeyValueObject<RentReserve> value = new KeyValueObject<RentReserve>();
			value.setKey(time);
			value.setValue(tmpRe);
			array.add(value);
		}
		
		return array;
	}
	
	public static Map<String, String> buildAvailDays(ArrayList<String> personAvailDays
			, ArrayList<String> teamAvailDays, String toDay) {

//		List<String> personAvailDays = new ArrayList<String>();
//		List<String> teamAvailDays = new ArrayList<String>();
		
		// 12시 기준으로 예약일 판단
		// 직원은 1일전 가능
		// 동호회는 현재 날짜 +2 다음부터 15일 전 가능

		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
		Calendar cal = Calendar.getInstance();
		
		int hour = cal.get(Calendar.HOUR_OF_DAY);
		if(hour > 12){
			String pSDate = formatter.format(cal.getTime());
			personAvailDays.add(pSDate);
			
			cal.add(Calendar.DAY_OF_MONTH, 1);
			String pEDate = formatter.format(cal.getTime());
			personAvailDays.add(pEDate);
			
			for(int i = 1; i < 14; ++i){
				cal.add(Calendar.DAY_OF_MONTH, 1);
				String strDate = formatter.format(cal.getTime());
				teamAvailDays.add(strDate);
			}
		}else{
			String pSDate = formatter.format(cal.getTime());
			personAvailDays.add(pSDate);
			
			// 추첨 전이라 하루 건너띔
			cal.add(Calendar.DAY_OF_MONTH, 1);
			
			int maxDay = 13;
			if(hour > 11) // 추첨 진행중 경우 추첨 신청 받지 않음!
				maxDay = 12;
				
			for(int i = 1; i < maxDay; ++i){
				cal.add(Calendar.DAY_OF_MONTH, 1);
				String strDate = formatter.format(cal.getTime());
				teamAvailDays.add(strDate);
			}
		}

		String personAbleDay="false";
		if(personAvailDays.contains(toDay)) {
			personAbleDay="true";
		}
		String teamAbleDay="false";
		if(teamAvailDays.contains(toDay)) {
			teamAbleDay="true";
		}
		Map<String,String> result = new HashMap();
		result.put("personAbleDay", personAbleDay);
		result.put("teamAbleDay", teamAbleDay);
		return result;
	}
	
}
