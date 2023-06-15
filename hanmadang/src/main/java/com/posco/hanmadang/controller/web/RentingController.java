package com.posco.hanmadang.controller.web;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.posco.hanmadang.common.Constant;
import com.posco.hanmadang.common.Constant.RentReserveType;
import com.posco.hanmadang.common.Constant.RentingType;
import com.posco.hanmadang.common.Constant.ServiceResult;
import com.posco.hanmadang.controller.CommonController;
import com.posco.hanmadang.model.Club;
import com.posco.hanmadang.model.Employee;
import com.posco.hanmadang.model.KeyValueObject;
import com.posco.hanmadang.model.OffDay;
import com.posco.hanmadang.model.RentCount;
import com.posco.hanmadang.model.RentReserve;
import com.posco.hanmadang.model.RentReserveTime;
import com.posco.hanmadang.service.ClubService;
import com.posco.hanmadang.service.EmployeeService;
import com.posco.hanmadang.service.RentService;
import com.posco.hanmadang.util.DateUtil;
import com.posco.hanmadang.util.HolidayUtil;
import com.posco.hanmadang.util.RentDataUtil;
import com.posco.hanmadang.util.Util;

import jj.play.ns.nl.captcha.Captcha;

@Controller
@RequestMapping("/rent")
public class RentingController extends CommonController{

	@Autowired
	private RentService rentService;
	@Autowired
	private EmployeeService employeeService;
	@Autowired
	private ClubService clubService;
	
	/**
	 * 대관신청 예약현황 캘린더
	 * @return
	 */
	@RequestMapping(value="/main", method=RequestMethod.GET)
	public String info(Model model, @RequestParam(value="code", defaultValue="15") int detail_code,
			@RequestParam(value="year_month", defaultValue="") String year_month){
		
//		List<RentCode> rentCodes = rentService.getRentCodes();
//		model.addAttribute("rentCodes", rentCodes);
		
//		if(StringUtils.isEmpty(type) && rentCodes.size() > 0)
//			type = rentCodes.get(0).getDetail_code();
		
		model.addAttribute("code", detail_code);
		
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
		Calendar cal = Calendar.getInstance();
		
		// 일자별 예약 카운트 가져오기
		if(StringUtils.isEmpty(year_month)){
			SimpleDateFormat refomatter = new SimpleDateFormat("yyyyMM");
			year_month = refomatter.format(cal.getTime());
		}
		
		model.addAttribute("year_month", year_month);
		
		List<RentCount> reCounts = rentService.getReRentCount(detail_code, year_month);
		
		String targetYear = year_month.substring(0, 4);
		String targetMonth = year_month.substring(4, 6);
		
		String off1 = Util.getDate(Integer.parseInt(targetYear), Integer.parseInt(targetMonth), 1, Calendar.MONDAY);
		String off2 = Util.getDate(Integer.parseInt(targetYear), Integer.parseInt(targetMonth), 3, Calendar.MONDAY);
		if(!off1.substring(4, 6).equals(targetMonth)){
			off1 = Util.getDate(Integer.parseInt(targetYear), Integer.parseInt(targetMonth), 2, Calendar.MONDAY);
			off2 = Util.getDate(Integer.parseInt(targetYear), Integer.parseInt(targetMonth), 4, Calendar.MONDAY);
		}
		
		model.addAttribute("off1", off1);
		model.addAttribute("off2", off2);
		
		//빈날짜 체크
		Calendar cal1 = Calendar.getInstance();
        cal1.set(Calendar.YEAR, Integer.parseInt(targetYear));
        cal1.set(Calendar.MONTH, Integer.parseInt(targetMonth) - 1);
        int lastDay = cal1.getActualMaximum(Calendar.DAY_OF_MONTH);
        for(int i = 1; i <= lastDay; ++i){
	        	String day = String.format("%02d", i);
	        	boolean isExist = false;
	        	for(RentCount reCount : reCounts){
	        		if(reCount.getRe_date().equals(targetYear + targetMonth+day))
	        			isExist = true;
	        	}
	        	
	        	if(!isExist){
	        		RentCount newRentCount = new RentCount();
	        		newRentCount.setCnt("0");
	        		newRentCount.setRe_date(targetYear + targetMonth+day);
	        		reCounts.add(newRentCount);
	        	}
        }
        
        reCounts = checkAfter30Day(reCounts);
        model.addAttribute("recounts", reCounts);
        
        ArrayList<String> personAvailDays = new ArrayList<String>();
        ArrayList<String> teamAvailDays = new ArrayList<String>();
		RentDataUtil.buildAvailDays(personAvailDays, teamAvailDays, "");
		
//		// 12시 기준으로 예약일 판단
//		// 직원은 1일전 가능
//		// 동호회는 현재 날짜 +2 다음부터 15일 전 가능
//		
//		int hour = cal.get(Calendar.HOUR_OF_DAY);
//		if(hour > 12){
//			String pSDate = formatter.format(cal.getTime());
//			personAvailDays.add(pSDate);
//			
//			cal.add(Calendar.DAY_OF_MONTH, 1);
//			String pEDate = formatter.format(cal.getTime());
//			personAvailDays.add(pEDate);
//			
//			for(int i = 1; i < 14; ++i){
//				cal.add(Calendar.DAY_OF_MONTH, 1);
//				String strDate = formatter.format(cal.getTime());
//				teamAvailDays.add(strDate);
//			}
//		}else{
//			String pSDate = formatter.format(cal.getTime());
//			personAvailDays.add(pSDate);
//			
//			// 추첨 전이라 하루 건너띔
//			cal.add(Calendar.DAY_OF_MONTH, 1);
//			
//			int maxDay = 13;
//			if(hour > 11) // 추첨 진행중 경우 추첨 신청 받지 않음!
//				maxDay = 12;
//				
//			for(int i = 1; i < maxDay; ++i){
//				cal.add(Calendar.DAY_OF_MONTH, 1);
//				String strDate = formatter.format(cal.getTime());
//				teamAvailDays.add(strDate);
//			}
//		}
		
		model.addAttribute("pdate", personAvailDays);
		model.addAttribute("tdate", teamAvailDays);
		
		model.addAttribute("pdate1", makeMinMaxDateInMonth(year_month.substring(4, 6), personAvailDays));
		model.addAttribute("tdate1", makeMinMaxDateInMonth(year_month.substring(4, 6), teamAvailDays));
		
		List<OffDay> offList = rentService.getBlock(year_month);
		model.addAttribute("offList", offList);
		
		return "web/reserve/reserve_calendar";
	}
	
	private List<String> makeMinMaxDateInMonth(String month, List<String> dateList){
		List<String> list = new ArrayList<String>();
		for(String date : dateList) {
			if(Integer.parseInt(date.substring(5, 7)) == Integer.parseInt(month))
				list.add(date);
		}
		
		return list;
	}
	
	private List<RentCount> checkAfter30Day(List<RentCount> dateList){
		SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMdd");
		Calendar cal = Calendar.getInstance();
		cal.add(Calendar.DAY_OF_MONTH, 29);
		String after30 = formatter.format(cal.getTime());
		
		List<RentCount> list = new ArrayList<RentCount>();
		for(RentCount date : dateList) {
			if(Integer.parseInt(date.getRe_date()) <= Integer.parseInt(after30))
				list.add(date);
		}
		
		return list;
	}
	
	
	/**
	 * 배드민턴장 예약시간표
	 * @return
	 */
	@RequestMapping(value="/time/{code}", method=RequestMethod.GET)
	public String time_badminton(HttpServletResponse response, Model model, @PathVariable("code") int code,
			@RequestParam(value="date", defaultValue="") String date,
			@RequestParam(value="success", defaultValue="0") String success){
		model.addAttribute("code", code);
		
		int after2hourTime = 0;
		Calendar cal = Calendar.getInstance();
		String toDay = DateUtil.getDateToStr("yyyy-MM-dd", DateUtil.getStrToDate("yyyyMMdd", date));
		
		SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMdd");
		String today = formatter.format(cal.getTime());
		int curHour = cal.get(Calendar.HOUR_OF_DAY);

		Map<String,String> ableFlag = RentDataUtil.buildAvailDays(new ArrayList<String>(), new ArrayList<String>(), toDay);
		model.addAttribute("personAbleDay", ableFlag.get("personAbleDay"));
		model.addAttribute("teamAbleDay", ableFlag.get("teamAbleDay"));
		
		if(StringUtils.isEmpty(date))
			date = today;
		
		if(date.equals(today)){
			int after2hour = cal.get(Calendar.HOUR_OF_DAY) + 2;
			after2hourTime = after2hour * 100;
			if(after2hour >= 18)
				after2hourTime += cal.get(Calendar.MINUTE);
				
			model.addAttribute("after2hourTime", after2hourTime);
			logger.info("after2hourTime {}", after2hourTime);
			
		}else{
			model.addAttribute("after2hourTime", "0000");
		}
		
		String yoil = Util.getYoil(date);
		
		List<RentReserve> list = rentService.getReserve(code, yoil, date);	// 15 4 20200319
		logger.info("list {}", list.toString());
		model.addAttribute("list", list);
		model.addAttribute("date", date);
		model.addAttribute("dday", Util.getDDaysFromCurrent(date));
		
		
		int rentReserveType = RentDataUtil.checkReType(date);
		if(rentReserveType == Constant.RentReserveType.draw.ordinal()){
			if(curHour == 12){
				response.setContentType("text/html; charset=UTF-8");
			    PrintWriter out;
				try { 
					out = response.getWriter();
					out.println("<script>alert('추첨 진행중입니다.'); history.go(-1);</script>");
				    out.flush();
				} catch (IOException e) {
					logger.error(e.getMessage());
				}
				
				return null;
			}
		}
		
		model.addAttribute("type", rentReserveType);
		model.addAttribute("success", success);
		
		String[] yoilstr = new String[]{"월요일", "화요일", "수요일", "목요일", "금요일", "토요일", "일요일"}; 
		model.addAttribute("yoil", yoilstr[Integer.parseInt(yoil) - 1]);
		model.addAttribute("team_cort_size", 6); // HolidayUtil.isHoliday(date)? 4:6 ); // 휴일은 5~12코트 else 7~12코트
		
		logger.info("type={}, yoil={}, yoilstr[]={}", rentReserveType, yoil, yoilstr[Integer.parseInt(yoil) - 1]);
		
		if(code == RentingType.pingpong.getValue()){
			List<KeyValueObject<List<RentReserve>>> data = RentDataUtil.makeArrayPingpong(list, date, yoil);
			model.addAttribute("data", data);
			//model.addAttribute("indexList", RentDataUtil.makeArrayAbleCortPingpong());
			return "web/reserve/reserve_time_pingpong";
			
		}else if(code == RentingType.billiards.getValue()){
			List<KeyValueObject<List<RentReserve>>> data = RentDataUtil.makeArrayBilliards(list, date, yoil);
			model.addAttribute("data", data);
			//model.addAttribute("indexList", RentDataUtil.makeArrayAbleCortBilliards());
			return "web/reserve/reserve_time_billiards";
			
		}else{
			List<KeyValueObject<List<RentReserve>>> data = RentDataUtil.makeArrayBadminton(list, date, yoil, rentReserveType);
			model.addAttribute("data", data);
			//model.addAttribute("indexList", RentDataUtil.makeArrayAbleCortBadminton());
			
			if(rentReserveType == Constant.RentReserveType.draw.ordinal())
				return "web/reserve/reserve_time_draw";
			
			Calendar cal2= Calendar.getInstance();
			
			String tmpH= String.format("%s%s", today, cal2.getTime().getHours());
			
			logger.info("date {}, today {}", date, tmpH );
			
			if(20220701<=Integer.parseInt(date)) {
				return "web/reserve/reserve_time_badminton";
			} else {
				return "web/reserve/reserve_time_badminton_06";
			}
		}
	}
	
	@RequestMapping(value = "/time/captcha", method = RequestMethod.GET)
	public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
		 
        try {
            // 200 * 50 에해당하는 이미지 사이즈를 지정하고, 자동가입방지 문자 길이를 설정한다.
            Captcha captcha= new Captcha.Builder(250, 60)
                                    .addText()
                                    .addBackground()
                                    .addNoise()
                                    .addBorder()
                                    .build();
            
            // 세션에 자동가입방지 문자를 저장한다.
            request.getSession().setAttribute("correctAnswer", captcha.getAnswer());
            logger.info("captcha 자동가입방지 문자 : " + captcha.getAnswer());
 
            response.setHeader("Cache-Control", "no-store");
            response.setHeader("Pragma", "no-cache");
            // 캐쉬를 지우기 위해 헤더값을 설정
            response.setDateHeader("Expires", 0);
            // 리턴값을 image형태로 설정
            response.setContentType("image/jpeg");
            // Image를 write 한다
            Util.writeImage(response, captcha.getImage());
        } catch (Exception e) {
        	logger.error(e.getMessage());
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            return;
        }
    }
	
	@RequestMapping(value = "/time/save", method = RequestMethod.POST)
	public @ResponseBody String re_save(HttpServletRequest request, HttpSession session, 
			@ModelAttribute(value="reserve") RentReserve reserve,
			@RequestParam(value="re_times", defaultValue="") String re_times,
			@RequestParam(value="captcha", defaultValue="") String captcha) throws Exception{
		try{
			String se_captcha = (String)session.getAttribute("correctAnswer");
			if(StringUtils.isEmpty(se_captcha))
				return ServiceResult.INVALID_PARAM.name();
			
			if(!se_captcha.equals(captcha))
				return ServiceResult.UNAUTHORIZED.name();
			
			if(StringUtils.isEmpty(re_times))
				return ServiceResult.INVALID_PARAM.name();
			
			String[] times = re_times.split("#");
			if(times.length <= 0)
				return ServiceResult.INVALID_PARAM.name();
			
			/*if(StringUtils.isEmpty(reserve.getId())
					|| StringUtils.isEmpty(reserve.getEmployee_no())
					|| StringUtils.isEmpty(reserve.getRe_tel())
					) {
				return ServiceResult.INVALID_PARAM.name();
			}*/
			
			int after2hourTime = 0;
			
			Calendar cal = Calendar.getInstance();
			SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMdd");
			String today = formatter.format(cal.getTime());
			if(today.equals(reserve.getRe_date())){
				int after2hour = cal.get(Calendar.HOUR_OF_DAY) + 2;
				after2hourTime = after2hour * 100;
				if(after2hour >= 18)
					after2hourTime += cal.get(Calendar.MINUTE);
			}
			
			List<RentReserveTime> reserveTimes = new ArrayList<RentReserveTime>();
			for(String time : times){
				String[] court = time.split("\\|");
				if(court != null && court.length == 2){
					RentReserveTime res = new RentReserveTime();
					res.setRt_stime(court[0].replace(":", "").substring(0, 4));
					if(Integer.parseInt(res.getRt_stime() ) <= after2hourTime ){
						return ServiceResult.INVALID_ACCESS.name();
					}
					
					res.setRt_etime(court[0].replace(":", "").substring(7, 11));
					res.setRt_court(court[1]);
					res.setRt_stat(Constant.YesNoStatus.Y.name());
					res.setRt_court_cnt(0);
					
					reserveTimes.add(res);
				}
			}
			
			if(reserveTimes.size() <= 0)
				return ServiceResult.INVALID_PARAM.name();
			
			reserve.setReserveTimes(reserveTimes);
			
			Calendar calendar = Calendar.getInstance();
			long wtime = calendar.getTimeInMillis() / 1000;
			reserve.setRe_wdate(String.valueOf(wtime));
			
			if(String.valueOf(RentReserveType.employee.ordinal()).equals(reserve.getRe_type())){
				if(StringUtils.isEmpty(reserve.getId()) || StringUtils.isEmpty(reserve.getEmployee_no()))
					return ServiceResult.INVALID_PARAM.name();
				
				Employee employee = employeeService.find(reserve.getEmployee_no());
				logger.info("employee {}", employee);
//				if(employee == null)
//					return ServiceResult.NOT_FOUND.name();
//				
//				if(!employee.getEm_name().equals(reserve.getId()))
//					return ServiceResult.NOT_MATCHE.name();

				reserve.setRe_part(reserve.getRe_code());
				if(employee==null) {
					reserve.setRe_code(reserve.getEmployee_no());
					reserve.setRe_name(reserve.getId());
				}
				else {
					reserve.setRe_code(employee.getEm_no());
					reserve.setRe_name(employee.getEm_name());
				}
				reserve.setRe_partname(reserve.getRe_partname());
//				reserve.setRe_code(employee.getEm_no());
				
				logger.info("reserve {}", reserve);
				
				ServiceResult result = rentService.addReserve(reserve);
				return result.name();
				
			}else if(String.valueOf(RentReserveType.team.ordinal()).equals(reserve.getRe_type())){
				if(StringUtils.isEmpty(reserve.getTeam_id()) || StringUtils.isEmpty(reserve.getTeam_pwd()))
					return ServiceResult.INVALID_PARAM.name();
				
				Club club = clubService.findById(reserve.getTeam_id());
				if(club == null)
					return ServiceResult.NOT_FOUND.name();
				
				if(!club.getCl_passwd().equals(reserve.getTeam_pwd()))
					return ServiceResult.NOT_MATCHE.name();
				
				reserve.setCl_num(club.getCl_num());
				reserve.setRe_part(reserve.getRe_code());
				reserve.setRe_code(null);
				
				ServiceResult result = rentService.addReserve(reserve);
				return result.name();
			}
			
			return ServiceResult.FAIL.name();
		}catch(Exception e){
			logger.error(e.getMessage());
			return ServiceResult.FAIL.name();
		}
	}
	
	/**
	 * 추첨 예약 코트 등록
	 * @param session
	 * @param reserve
	 * @param re_times
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/time/draw/save", method = RequestMethod.POST)
	public @ResponseBody String re_draw_save(HttpSession session, 
			@ModelAttribute(value="reserve") RentReserve reserve,
			@RequestParam(value="re_times", defaultValue="") String re_times) throws Exception{
		try{
			if(StringUtils.isEmpty(re_times))
				return ServiceResult.INVALID_PARAM.name();
			
			String[] times = re_times.split("#");
			if(times.length <= 0)
				return ServiceResult.INVALID_PARAM.name();
			
			int rentReserveType = RentDataUtil.checkReType(reserve.getRe_date());
			if(Constant.RentReserveType.draw.ordinal() != rentReserveType)
				return ServiceResult.INVALID_ACCESS.name();
			
			List<RentReserveTime> reserveTimes = new ArrayList<RentReserveTime>();
			for(String time : times){
				String[] court = time.split("\\|");
				if(court != null && court.length == 2){
					RentReserveTime res = new RentReserveTime();
					res.setRt_stime(court[0].replace(":", "").substring(0, 4));
					res.setRt_etime(court[0].replace(":", "").substring(7, 11));
					res.setRt_court_cnt(Integer.parseInt(court[1]));
					res.setRt_stat(Constant.YesNoStatus.N.name());
					
					reserveTimes.add(res);
				}
			}
			
			if(reserveTimes.size() <= 0)
				return ServiceResult.INVALID_PARAM.name();
			
			reserve.setReserveTimes(reserveTimes);
			
			Calendar calendar = Calendar.getInstance();
			long wtime = calendar.getTimeInMillis() / 1000;
			reserve.setRe_wdate(String.valueOf(wtime));
			
			if(StringUtils.isEmpty(reserve.getTeam_id()) || StringUtils.isEmpty(reserve.getTeam_pwd()))
				return ServiceResult.INVALID_PARAM.name();
			
			Club club = clubService.findById(reserve.getTeam_id());
			if(club == null)
				return ServiceResult.NOT_FOUND.name();
			
			if(!club.getCl_passwd().equals(reserve.getTeam_pwd()))
				return ServiceResult.NOT_MATCHE.name();
			
			reserve.setCl_num(club.getCl_num());
			reserve.setRe_part(reserve.getRe_code());
			reserve.setRe_code(null);
			
			ServiceResult result = rentService.addReserve(reserve);
			return result.name();
		}catch(Exception e){
			logger.error(e.getMessage());
			return ServiceResult.FAIL.name();
		}
	}
	
	/**
	 * 탁구장 예약시간표
	 * @return
	 */
	@RequestMapping(value="/time/pingpong", method=RequestMethod.GET)
	public String time_pingpong(Model model){
		model.addAttribute("type", RentingType.pingpong.name());
		return "web/reserve/reserve_time_pingpong";
	}
	
	/**
	 * 당구장 예약시간표
	 * @return
	 */
	@RequestMapping(value="/time/billiards", method=RequestMethod.GET)
	public String time_billiards(Model model){
		model.addAttribute("type", RentingType.billiards.name());
		return "web/reserve/reserve_time_billiards";
	}
	
	/**
	 * 	예약확인 및 취소
	 * @return
	 */
	@RequestMapping(value="/confirm")
	public String confirm(Model model, HttpSession session,
			@ModelAttribute(value="reserve") RentReserve reserve){
		
		session.setAttribute(Constant.EMPLOYEE_SESSION, null);
		session.setAttribute(Constant.TEAM_SESSION, null);
		session.setAttribute(Constant.TEAM_LOGIN_SESSION, null);
		
		Calendar cal = Calendar.getInstance();
		SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMdd");
		String curday = formatter.format(cal.getTime());
		model.addAttribute("curday", curday);
		
		cal.add(Calendar.DAY_OF_MONTH, 2);
		String after3day = formatter.format(cal.getTime());
		model.addAttribute("after3day", after3day);
		
		int after2hour = cal.get(Calendar.HOUR_OF_DAY) + 2;
		int after2hourTime = after2hour * 100;
		if(after2hour >= 18)
			after2hourTime += cal.get(Calendar.MINUTE);
		
		model.addAttribute("after2hourTime", after2hourTime);
		
		if(reserve.getRe_type() == null)
			reserve.setRe_type(String.valueOf(Constant.RentReserveType.employee.ordinal()));
		
		if(!String.valueOf(Constant.RentReserveType.employee.ordinal()).equals(reserve.getRe_type()) &&
				!String.valueOf(Constant.RentReserveType.team.ordinal()).equals(reserve.getRe_type())){
			return "error";
		}
		
		model.addAttribute("reserve", reserve);
		
		if(!StringUtils.isEmpty(reserve.getRe_type())){
			if(String.valueOf(Constant.RentReserveType.employee.ordinal()).equals(reserve.getRe_type())){
				if(!StringUtils.isEmpty(reserve.getRe_name())){
					Employee employee = employeeService.find(reserve.getEmployee_no());
					if(employee != null){
						if(!employee.getEm_name().equals(reserve.getRe_name())){
							model.addAttribute("error_result", ServiceResult.NOT_MATCHE.name());
						}else{
							List<RentReserve> list = rentService.searchReserve(null, employee.getEm_no());
							model.addAttribute("list", list);
							session.setAttribute(Constant.EMPLOYEE_SESSION, list);
						}
					}else{
						//model.addAttribute("error_result", ServiceResult.NOT_FOUND.name());
						List<RentReserve> list = rentService.searchReserve(null, reserve.getEmployee_no());
						model.addAttribute("list", list);
						session.setAttribute(Constant.EMPLOYEE_SESSION, list);
					}
						
					model.addAttribute("type", Constant.RentReserveType.employee.ordinal());
				}
			}else if(String.valueOf(Constant.RentReserveType.team.ordinal()).equals(reserve.getRe_type())){
				if(!StringUtils.isEmpty(reserve.getTeam_id())){
					Club club = clubService.findById(reserve.getTeam_id());
					if(club != null){
						if(!club.getCl_passwd().equals(reserve.getTeam_pwd())){
							model.addAttribute("error_result", ServiceResult.NOT_MATCHE.name());
						}else{
							List<RentReserve> list = rentService.searchReserve(String.valueOf(club.getCl_num()), null);
							model.addAttribute("list", list);
							session.setAttribute(Constant.TEAM_SESSION, list);
							session.setAttribute(Constant.TEAM_LOGIN_SESSION, club);
						}
					}else{
						model.addAttribute("error_result", ServiceResult.NOT_FOUND.name());
					}
					model.addAttribute("type", Constant.RentReserveType.team.ordinal());
				}
			}
		}
		return "web/reserve/reserve_confirm";
	}
	
	@RequestMapping(value = "/confirm/cancel", method = RequestMethod.POST)
	public @ResponseBody String re_cancel(HttpSession session, 
			@RequestParam(value="type", defaultValue="0") int type,
			@RequestParam(value="rt_num", defaultValue="0") long rt_num) throws Exception{
		try{
			
			Calendar cal = Calendar.getInstance();
			SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMdd");
			String today = formatter.format(cal.getTime());
			
			if(Constant.RentReserveType.employee.ordinal() == type){
				@SuppressWarnings("unchecked")
				List<RentReserve> list = (List<RentReserve>)session.getAttribute(Constant.EMPLOYEE_SESSION);
				if(list == null)
					return ServiceResult.UNAUTHORIZED.name();
				
				for(RentReserve rr : list){
					if(rr.getRt_num() == rt_num){
						int after2hourTime = 0;
						
						if(today.equals(rr.getRe_date())){
							int after2hour = cal.get(Calendar.HOUR_OF_DAY) + 2;
							after2hourTime = after2hour * 100;
							if(after2hour >= 18)
								after2hourTime += cal.get(Calendar.MINUTE);
						}
						
						if(Integer.parseInt(rr.getRt_stime() ) <= after2hourTime ){
							return ServiceResult.INVALID_ACCESS.name();
						}
						
						ServiceResult result = rentService.setReserveTimeStat(rt_num, Constant.YesNoStatus.C.name());
						return result.name();
					}
				}
			}else if(Constant.RentReserveType.team.ordinal() == type){
				@SuppressWarnings("unchecked")
				List<RentReserve> list = (List<RentReserve>)session.getAttribute(Constant.TEAM_SESSION);
				if(list == null)
					return ServiceResult.UNAUTHORIZED.name();
				
				for(RentReserve rr : list){
					if(rr.getRt_num() == rt_num){
						ServiceResult result = rentService.setReserveTimeStat(rt_num, Constant.YesNoStatus.C.name());
						return result.name();
					}
				}
			}else{
				return ServiceResult.UNAUTHORIZED.name();
			}
			
		
			return ServiceResult.NOT_FOUND.name();
		}catch(Exception e){
			logger.error(e.getMessage());
			return ServiceResult.FAIL.name();
		}
	}
	
	@RequestMapping(value = "/confirm/team/pass", method = RequestMethod.POST)
	public @ResponseBody String re_team_pass(HttpSession session, 
			@RequestParam(value="pwd", defaultValue="") String pwd,
			@RequestParam(value="new_pwd", defaultValue="") String new_pwd) throws Exception{
		try{
			
			Club club = (Club)session.getAttribute(Constant.TEAM_LOGIN_SESSION);
			if(club == null)
				return ServiceResult.INVALID_ACCESS.name();
			
			if(!club.getCl_passwd().equals(pwd))
				return ServiceResult.NOT_MATCHE.name();
				
			club.setCl_passwd(new_pwd);
			
			ServiceResult result = clubService.add(club);
			if(result != ServiceResult.SUCCESS)
				club.setCl_passwd(pwd);
			
			return result.name();
			
		}catch(Exception e){
			logger.error(e.getMessage());
			return ServiceResult.FAIL.name();
		}
	}
	
	/**
	 * 이용규정
	 * @return
	 */
	@RequestMapping(value="/rule", method=RequestMethod.GET)
	public String rule(Model model){
		return "web/reserve/reserve_rule";
	}
	
//	//일요일 오전
//	$tf1 = (($rentTime[$i]=='0700'||$rentTime[$i]=='0900' )&&$use_days=='0') ? true : false;
//	//수요일 오전
//	$tf2 = (($rentTime[$i]=='1830'||$rentTime[$i]=='2030' )&&$use_days=='3') ? true : false;
//
//	//주말 13시 이후
//	$tf3 = ( $rentTime[$i]>='1300' && ($use_days=='0' || $use_days=='6') ) ? true : false;
//
//	<?} else if( ($kk=='R' ||$kk=='D') && ($tf1 || $tf2 )) {?>
//    <tr>
//		  <td style="color:white;"><?=substr($rentTime[$i],0,2)?>:<?=substr($rentTime[$i],-2)?>~<?=substr($rentTime[($i+1)],0,2)?>:<?=substr($rentTime[($i+1)],-2)?></td>
//		  <td>|</td>
//          <td colspan=25 style="background:#121212;color:white;">구기종목의 날</td>				  
//    </tr>
//	<?} else if( ($kk=='R' ||$kk=='D') && $tf3 ) {?>
//    <tr>
//		  <td style="color:white;"><?=substr($rentTime[$i],0,2)?>:<?=substr($rentTime[$i],-2)?>~<?=substr($rentTime[($i+1)],0,2)?>:<?=substr($rentTime[($i+1)],-2)?></td>
//		  <td>|</td>
//          <td colspan=25 style="background:#121212;color:white;">&nbsp;</td>				 
          
	
//	f(cnt>2){
//		alert('2시간 까지만 예약가능합니다.');
//		return;
//	}
//	if(courtDouble==true){
//		alert('1개코트만 사용가능합니다.');
//		return;
//	}
//	if(timeDiscontinue==true){
//		alert('1개코트에 연속된 시간만 사용가능합니다.');
//		return;
//	}
	
}
