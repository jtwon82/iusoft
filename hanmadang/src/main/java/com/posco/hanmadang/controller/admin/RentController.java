package com.posco.hanmadang.controller.admin;


import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

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
import com.posco.hanmadang.model.ClubPagedList;
import com.posco.hanmadang.model.Employee;
import com.posco.hanmadang.model.KeyValueObject;
import com.posco.hanmadang.model.OffDay;
import com.posco.hanmadang.model.RentReserve;
import com.posco.hanmadang.model.RentReserveTime;
import com.posco.hanmadang.model.RentState;
import com.posco.hanmadang.scheduler.RentBatchScheduler;
import com.posco.hanmadang.service.ClubService;
import com.posco.hanmadang.service.EmployeeService;
import com.posco.hanmadang.service.RentService;
import com.posco.hanmadang.util.Paging;
import com.posco.hanmadang.util.RentDataUtil;
import com.posco.hanmadang.util.Util;

import uk.co.certait.htmlexporter.writer.excel.ExcelExporter;

@Controller
@RequestMapping("/rhksfl/vhtmzh/rent")
public class RentController extends CommonController{

	@Autowired
	private EmployeeService employeeService;
	@Autowired
	private ClubService clubService;
	
	@Autowired
	private RentService rentService;
	
	@Autowired
	RentBatchScheduler rentBatchScheduler;
	
	/**
	 * 동호회 리스트
	 * @return
	 */
	@RequestMapping(value="/team/list", method=RequestMethod.GET)
	public String list(Model model, HttpServletRequest request,
			@RequestParam(value="pageNumber", defaultValue="1")int pageNumber){
		
		SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMdd");
		Calendar cal = Calendar.getInstance();
		
		cal.add(Calendar.DAY_OF_MONTH, 13);
		String after14days  = formatter.format(cal.getTime());
		
		cal.add(Calendar.DAY_OF_MONTH, -30);
		String oneMonthAgo  = formatter.format(cal.getTime());
		
		ClubPagedList pagedList = clubService.getPagedList(pageNumber, oneMonthAgo, after14days);
		if(pagedList != null){
			String baseUrlFormat = Util.getPagingBaseUrl("list", request.getQueryString(), pageNumber);
			Paging paging = pagedList.getPaging();
			paging.setBaseUrlFormat(baseUrlFormat);
			
			model.addAttribute("list", pagedList.getList());
			model.addAttribute("paging", paging);
		}
		
		return "admin/rent/team-list";
	}
	
	/**
	 * 동호회 정보
	 * @return
	 */
	@RequestMapping(value="/team/item/{cl_num}", method=RequestMethod.GET)
	public String team_get(Model model, HttpServletRequest request, @PathVariable("cl_num") int cl_num){
		
		Club club = clubService.find(cl_num);
		model.addAttribute("club", club);
		return "admin/rent/team-mod-pop";
	}
	
	@RequestMapping(value="/team/save", method=RequestMethod.POST)
	public @ResponseBody String team_save(@ModelAttribute(value="club") Club club){
		try{
			club.setCl_stat(Constant.YesNoStatus.Y.name());
			ServiceResult result = clubService.add(club);
			return result.name();
		}catch(Exception e){
			logger.error(e.getMessage());
			return ServiceResult.FAIL.name();
		}
	}
	
	@RequestMapping(value="/team/delete", method=RequestMethod.POST)
	public @ResponseBody String team_delete(@RequestParam(value="cl_num", defaultValue="0") int cl_num){
		try{
			ServiceResult result = clubService.remove(cl_num);
			return result.name();
		}catch(Exception e){
			logger.error(e.getMessage());
			return ServiceResult.FAIL.name();
		}
	}
	
	/**
	 * 예약현황
	 * @return
	 */
	@RequestMapping(value="/reserve/time/{part_cd}", method=RequestMethod.GET)
	public String time(Model model, @PathVariable("part_cd") int part_cd,
			@RequestParam(value="date", defaultValue="") String date){
		model.addAttribute("part_cd", part_cd);
		
		if(StringUtils.isEmpty(date)){
			SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMdd");
			Calendar cal = Calendar.getInstance();
			date = formatter.format(cal.getTime());
		}
		
		date = date.replace(".", "");
		
		String yoil = Util.getYoil(date);
		
		List<RentReserve> list = rentService.getReserve(part_cd, yoil, date);
		model.addAttribute("list", list);
		model.addAttribute("date", date);
		model.addAttribute("dday", Util.getDDaysFromCurrent(date));
		
		
		int rentReserveType = RentDataUtil.checkReType(date);
		model.addAttribute("type", rentReserveType);
		
		String[] yoilstr = new String[]{"월요일", "화요일", "수요일", "목요일", "금요일", "토요일", "일요일"}; 
		model.addAttribute("yoil", yoilstr[Integer.parseInt(yoil) - 1]);
		
		if(part_cd == RentingType.pingpong.getValue()){
			List<KeyValueObject<List<RentReserve>>> data = RentDataUtil.makeArrayPingpong(list, date, yoil);
			model.addAttribute("data", data);
			return "admin/rent/reserve-calendar-pingpong";
		}else if(part_cd == RentingType.billiards.getValue()){
			List<KeyValueObject<List<RentReserve>>> data = RentDataUtil.makeArrayBilliards(list, date, yoil);
			model.addAttribute("data", data);
			return "admin/rent/reserve-calendar-billiards";
		}else{
			List<KeyValueObject<List<RentReserve>>> data = RentDataUtil.makeArrayBadminton(list, date, yoil, RentReserveType.employee.ordinal());
			model.addAttribute("data", data);
			
			return "admin/rent/reserve-calendar-badminton";
		}
	}
	
	/**
	 * 예약하기
	 * @return
	 */
	@RequestMapping(value="/reserve/go/{part_cd}", method=RequestMethod.GET)
	public String reserve(Model model, @PathVariable("part_cd") int part_cd,
			@RequestParam(value="date", defaultValue="") String date,
			@RequestParam(value="type", defaultValue="4") int type){
		model.addAttribute("part_cd", part_cd);
		model.addAttribute("type", type);
		
		if(type == Constant.RentReserveType.team.ordinal()){
			List<Club> clubList = clubService.findAll();
			model.addAttribute("clubList", clubList);
		}
		
		if(StringUtils.isEmpty(date)){
			SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMdd");
			Calendar cal = Calendar.getInstance();
			date = formatter.format(cal.getTime());
		}
		
		date = date.replace(".", "");
		
		String yoil = Util.getYoil(date);
		
		List<RentReserve> list = rentService.getReserve(part_cd, yoil, date);
		model.addAttribute("list", list);
		model.addAttribute("date", date);
		model.addAttribute("dday", Util.getDDaysFromCurrent(date));
		
		
//		int rentReserveType = RentDataUtil.checkReType(date);
//		model.addAttribute("type", rentReserveType);
		
		String[] yoilstr = new String[]{"월요일", "화요일", "수요일", "목요일", "금요일", "토요일", "일요일"}; 
		model.addAttribute("yoil", yoilstr[Integer.parseInt(yoil) - 1]);
		
		if(part_cd == RentingType.pingpong.getValue()){
			List<KeyValueObject<List<RentReserve>>> data = RentDataUtil.makeArrayPingpong(list, date, yoil);
			model.addAttribute("data", data);
		}else if(part_cd == RentingType.billiards.getValue()){
			List<KeyValueObject<List<RentReserve>>> data = RentDataUtil.makeArrayBilliards(list, date, yoil);
			model.addAttribute("data", data);
		}else{
			if(type == Constant.RentReserveType.team.ordinal()){
				List<KeyValueObject<List<RentReserve>>> data = RentDataUtil.makeArrayBadminton(list, date, yoil, RentReserveType.team.ordinal());
				model.addAttribute("data", data);
			}else{
				List<KeyValueObject<List<RentReserve>>> data = RentDataUtil.makeArrayBadminton(list, date, yoil, RentReserveType.employee.ordinal());
				model.addAttribute("data", data);
			}
			
		}
		
		return "admin/rent/reserve-check";
	}
	
	@RequestMapping(value = "/time/save", method = RequestMethod.POST)
	public @ResponseBody String re_save(HttpSession session, 
			@ModelAttribute(value="reserve") RentReserve reserve,
			@RequestParam(value="re_times", defaultValue="") String re_times) throws Exception{
		try{
			if(StringUtils.isEmpty(re_times))
				return ServiceResult.INVALID_PARAM.name();
			
			String[] times = re_times.split("#");
			if(times.length <= 0)
				return ServiceResult.INVALID_PARAM.name();
			
			List<RentReserveTime> reserveTimes = new ArrayList<RentReserveTime>();
			for(String time : times){
				String[] court = time.split("\\|");
				if(court != null && court.length == 2){
					RentReserveTime res = new RentReserveTime();
					res.setRt_stime(court[0].replace(":", "").substring(0, 4));
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
			
			reserve.setRe_passwd(reserve.getRe_type());
			
			if(String.valueOf(RentReserveType.employee.ordinal()).equals(reserve.getRe_type())){
				if(StringUtils.isEmpty(reserve.getRe_name()) || StringUtils.isEmpty(reserve.getRe_code()))
					return ServiceResult.INVALID_PARAM.name();
				
				Employee employee = employeeService.find(reserve.getRe_code());
				if(employee == null)
					return ServiceResult.NOT_FOUND.name();
				
				ServiceResult result = rentService.addReserve(reserve);
				return result.name();
				
			}else if(String.valueOf(RentReserveType.team.ordinal()).equals(reserve.getRe_type())){
				if(reserve.getCl_num() <= 0)
					return ServiceResult.INVALID_PARAM.name();
				
				Club club = clubService.find(reserve.getCl_num());
				if(club == null)
					return ServiceResult.NOT_FOUND.name();
				
				reserve.setRe_code(null);
				
				ServiceResult result = rentService.addReserve(reserve);
				return result.name();
			}else if(String.valueOf(RentReserveType.company.ordinal()).equals(reserve.getRe_type())){
				if(StringUtils.isEmpty(reserve.getRe_name()) || StringUtils.isEmpty(reserve.getRe_title()))
					return ServiceResult.INVALID_PARAM.name();

				reserve.setRe_code(null);
				
				ServiceResult result = rentService.addReserve(reserve);
				return result.name();
			}else if(String.valueOf(RentReserveType.lecture.ordinal()).equals(reserve.getRe_type())){
				if(StringUtils.isEmpty(reserve.getRe_yoil()) || StringUtils.isEmpty(reserve.getRe_title()))
					return ServiceResult.INVALID_PARAM.name();
				
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
	 * 취소하기
	 * @return
	 */
	@RequestMapping(value="/reserve/cancel/{part_cd}", method=RequestMethod.GET)
	public String cancel(Model model, @PathVariable("part_cd") int part_cd,
			@RequestParam(value="date", defaultValue="") String date){
		model.addAttribute("part_cd", part_cd);
		
		if(StringUtils.isEmpty(date)){
			SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMdd");
			Calendar cal = Calendar.getInstance();
			date = formatter.format(cal.getTime());
		}
		
		date = date.replace(".", "");
		
		String yoil = Util.getYoil(date);
		
		List<RentReserve> list = rentService.getReserve(part_cd, yoil, date);
		model.addAttribute("list", list);
		model.addAttribute("date", date);
		model.addAttribute("dday", Util.getDDaysFromCurrent(date));
		
		if(part_cd == RentingType.pingpong.getValue()){
			List<KeyValueObject<List<RentReserve>>> data = RentDataUtil.makeArrayPingpong(list, date, yoil);
			model.addAttribute("data", data);
		}else if(part_cd == RentingType.billiards.getValue()){
			List<KeyValueObject<List<RentReserve>>> data = RentDataUtil.makeArrayBilliards(list, date, yoil);
			model.addAttribute("data", data);
		}else{
			List<KeyValueObject<List<RentReserve>>> data = RentDataUtil.makeArrayBadminton(list, date, yoil, RentReserveType.employee.ordinal());
			model.addAttribute("data", data);
		}
		
		return "admin/rent/reserve-cancel";
	}
	
	@RequestMapping(value = "/reserve/cancel", method = RequestMethod.POST)
	public @ResponseBody String re_cancel(HttpSession session, 
			@RequestParam(value="rt_nums", defaultValue="0") String rt_nums) throws Exception{
		try{
			if(StringUtils.isEmpty(rt_nums))
				return ServiceResult.INVALID_PARAM.name();
			
			List<String> list = new ArrayList<String>();
			
			String[] tmpArray = rt_nums.split("#");
			for(String rt_num : tmpArray){
				if(!StringUtils.isEmpty(rt_num))
					if( StringUtils.isNumeric(rt_num) ){
						list.add(rt_num);
					}
			}
		
			if(list.size() > 0)
				return rentService.setReserveTimeStat(list, Constant.YesNoStatus.C.name()).name();
			
			return ServiceResult.SUCCESS.name();
			
		}catch(Exception e){
			logger.error(e.getMessage());
			return ServiceResult.FAIL.name();
		}
	}
	
	/**
	 * 고정강좌 취소하기
	 * @return
	 */
	@RequestMapping(value="/reserve/lecture/{part_cd}", method=RequestMethod.GET)
	public String lecture(Model model, @PathVariable("part_cd") int part_cd,
			@RequestParam(value="date", defaultValue="") String date){
		model.addAttribute("part_cd", part_cd);
		
		if(StringUtils.isEmpty(date)){
			SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMdd");
			Calendar cal = Calendar.getInstance();
			date = formatter.format(cal.getTime());
		}
		
		date = date.replace(".", "");
		
		String yoil = Util.getYoil(date);
		
		List<RentReserve> list = rentService.getFixedClassReserve(part_cd, yoil, date);
		model.addAttribute("list", list);
		model.addAttribute("date", date);
		
		return "admin/rent/reserve-cancel-lecture";
	}
	
	@RequestMapping(value = "/reserve/lecture/cancel", method = RequestMethod.POST)
	public @ResponseBody String lecture_cancel(HttpSession session, 
			@RequestParam(value="rt_num", defaultValue="0") long rt_num,
			@RequestParam(value="mode", defaultValue="0") int mode,
			@RequestParam(value="date", defaultValue="") String date) throws Exception{
		try{
			if(rt_num <= 0 || StringUtils.isEmpty(date))
				return ServiceResult.INVALID_PARAM.name();
			
			if(mode == 0){ // 전체취소
				return rentService.setReserveTimeStat(rt_num, Constant.YesNoStatus.C.name()).name();
			}else{ // 현재일자 취소
				return rentService.addExceptDate(rt_num, date).name();
			}
			
		}catch(Exception e){
			logger.error(e.getMessage());
			return ServiceResult.FAIL.name();
		}
	}
	
	/**
	 * 이용현황
	 * @return
	 */
	@RequestMapping(value="/state/{part_cd}", method=RequestMethod.GET)
	public String state(Model model, @PathVariable("part_cd") int part_cd){
		model.addAttribute("part_cd", part_cd);
		
		SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMdd");
		Calendar cal = Calendar.getInstance();
		String nowdate = formatter.format(cal.getTime());
		
		String curTime = String.format("%02d00", cal.get(Calendar.HOUR_OF_DAY));
		
		String yoil = Util.getYoil(nowdate);
		String[] yoilstr = new String[]{"월요일", "화요일", "수요일", "목요일", "금요일", "토요일", "일요일"}; 
//		model.addAttribute("yoil", yoilstr[Integer.parseInt(yoil) - 1]);
//		
		String dateFormat = "yyyy년 MM월 dd일 (%s) HH시 mm분";
		dateFormat = String.format(dateFormat, yoilstr[Integer.parseInt(yoil) - 1]);
		formatter = new SimpleDateFormat(dateFormat);
		String disdate = formatter.format(cal.getTime());
		model.addAttribute("date", disdate);
		
		List<RentReserve> list = rentService.getCurState(part_cd, yoil, curTime, nowdate);
		list = RentDataUtil.makeType(list);
		
		model.addAttribute("list", list);
		
		return "admin/rent/state";
	}
	
	/**
	 * 추첨관리
	 * @return
	 */
	@RequestMapping(value="/draw", method=RequestMethod.GET)
	public String draw(Model model, @RequestParam(value="date", defaultValue="") String date){
		if(StringUtils.isEmpty(date)){
			SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMdd");
			Calendar cal = Calendar.getInstance();
			cal.add(Calendar.DAY_OF_MONTH, 13);
			date  = formatter.format(cal.getTime());
		}

		date = date.replace(".", "");
		model.addAttribute("date", date);
		
		List<RentReserve> list = rentService.getDrawRentRe(Constant.RentingType.badminton.getValue(), date);
		List<KeyValueObject<RentReserve>> cntList = RentDataUtil.makeStateOnBadminton(list, Constant.RentReserveType.team.ordinal());
		logger.debug(String.format("cntList %s", cntList));
		
		model.addAttribute("cntList", cntList);
		
		return "admin/rent/draw";
	}
	
	/**
	 * 추첨관리
	 * @return
	 */
	@RequestMapping(value="/draw/detail/{idx}", method=RequestMethod.GET)
	public String draw_detail(Model model, @PathVariable("idx") int idx, @RequestParam(value="date", defaultValue="") String date){
		
		String[] times = new String[]{"0700", "0900", "1100", "1300", "1500", "1700", "1830", "2030"};
		
		SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMdd");
		Calendar cal = Calendar.getInstance();
		
		cal.add(Calendar.DAY_OF_MONTH, 13);
		String after14days  = formatter.format(cal.getTime());
		
		cal.add(Calendar.DAY_OF_MONTH, -30);
		String oneMonthAgo  = formatter.format(cal.getTime());
		
		List<RentReserve> list = rentService.getDetailDrawRent(Constant.RentingType.badminton.getValue(), oneMonthAgo, after14days, date, times[idx]);
		model.addAttribute("list", list);
		
		return "admin/rent/draw-pop";
	}
	
	@RequestMapping(value = "/draw/go", method = RequestMethod.POST)
	public @ResponseBody String draw_go(HttpSession session, @RequestParam(value="date", defaultValue="") String date) throws Exception{
		try{
			Calendar cal = Calendar.getInstance();
			int curTime = cal.get(Calendar.HOUR_OF_DAY);
			if(curTime != 12)
				return ServiceResult.INVALID_ACCESS.name();
			
			rentBatchScheduler.manual();
			
			return ServiceResult.SUCCESS.name();
			
		}catch(Exception e){
			logger.error(e.getMessage());
			return ServiceResult.FAIL.name();
		}
	}
	
	/**
	 * 휴관일 관리
	 * @return
	 */
	@RequestMapping(value="/off", method=RequestMethod.GET)
	public String off(Model model, @RequestParam(value="year_month", defaultValue="") String year_month){

		if(StringUtils.isEmpty(year_month)){
			SimpleDateFormat refomatter = new SimpleDateFormat("yyyyMM");
			Calendar cal = Calendar.getInstance();
			year_month = refomatter.format(cal.getTime());
		}
				
		model.addAttribute("year_month", year_month);
				
		List<OffDay> list = rentService.getBlock(year_month);
		model.addAttribute("list", list);
		
		return "admin/rent/off";
	}
	
	@RequestMapping(value = "/off/add", method = RequestMethod.POST)
	public @ResponseBody String draw_add(HttpSession session, 
			@ModelAttribute(value="off") OffDay offday) throws Exception{
		try{
			ServiceResult result = rentService.addBlock(offday);
			return result.name();
			
		}catch(Exception e){
			logger.error(e.getMessage());
			return ServiceResult.FAIL.name();
		}
	}
	
	@RequestMapping(value = "/off/del", method = RequestMethod.POST)
	public @ResponseBody String draw_del(HttpSession session, 
			@RequestParam(value="bl_num", defaultValue="0") int bl_num) throws Exception{
		try{
			ServiceResult result = rentService.removeBlock(bl_num);
			return result.name();
			
		}catch(Exception e){
			logger.error(e.getMessage());
			return ServiceResult.FAIL.name();
		}
	}
	
	/**
	 * 통계
	 * @return
	 */
	@RequestMapping(value="/stats/all", method=RequestMethod.GET)
	public String stats(Model model, @RequestParam(value="sdate", defaultValue="") String sdate,
			@RequestParam(value="edate", defaultValue="") String edate,
			@RequestParam(value="type", defaultValue="0") String type){
//		if(StringUtils.isEmpty(sdate)){
//			SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMdd");
//			Calendar cal = Calendar.getInstance();
//			sdate  = formatter.format(cal.getTime());
//		}

//		edate = sdate.replace(".", "");
		model.addAttribute("sdate", sdate);
		
//		if(StringUtils.isEmpty(edate))
//			edate = sdate;

		model.addAttribute("edate", edate);
		model.addAttribute("type", type);
		
		int cok = 0, cc = 0, eok = 0, ec = 0, tok = 0, td = 0, tc = 0, tf = 0;
		
		if(!StringUtils.isEmpty(sdate) && !StringUtils.isEmpty(edate)){
			List<RentState> list = rentService.getAllRentStats(sdate, edate);
			
			for(RentState rs : list){
				cok += rs.getCompany_ok();
				cc += rs.getCompany_cancel();
				eok += rs.getEmployee_ok();
				ec += rs.getEmployee_cancel();
				tok += rs.getTeam_ok();
				td += rs.getTeam_draw_ok();
				tc += rs.getTeam_cancel();
				tf += rs.getTeam_fail();
			}
			
			model.addAttribute("list", list);
		}
		
		RentState tt = new RentState();
		tt.setCompany_ok_t(cok);
		tt.setCompany_cencel_t(cc);
		tt.setEmployee_ok_t(eok);
		tt.setEmployee_cencel_t(ec);
		tt.setTeam_ok_t(tok);
		tt.setTeam_cancel_t(tc);
		tt.setTeam_draw_ok_t(td);
		tt.setTeam_fail_t(tf);
		
		model.addAttribute("total", tt);
		
		
		return "admin/rent/stats-all";
	}
	
	/**
	 * 통계
	 * @return
	 * @throws IOException 
	 */
	@RequestMapping(value="/stats/excel", method=RequestMethod.POST)
	public void stats_excel(Model model, @RequestParam(value="excel_data", defaultValue="") String excel_data,
			@RequestParam(value="file_name", defaultValue="") String file_name,
			HttpServletResponse response) throws IOException {
		if(StringUtils.isEmpty(file_name))
			return;
		
		String filtered_file_name = file_name.replaceAll("\r", "").replaceAll("\n", "");
		
		response.setHeader("Content-disposition", "attachment; filename=" + filtered_file_name + ".xlsx"); //target명을 파일명으로 작성
		model.addAttribute("excel_data", excel_data);
		new ExcelExporter().exportHtml(excel_data, response.getOutputStream());
		return;
	}
	
	/**
	 * 통계
	 * @return
	 */
	@RequestMapping(value="/stats/team", method=RequestMethod.GET)
	public String team(Model model, @RequestParam(value="sdate", defaultValue="") String sdate,
			@RequestParam(value="edate", defaultValue="") String edate,
			@RequestParam(value="type", defaultValue="0") String type){
//		if(StringUtils.isEmpty(sdate)){
//			SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMdd");
//			Calendar cal = Calendar.getInstance();
//			sdate  = formatter.format(cal.getTime());
//		}

//		edate = sdate.replace(".", "");
		model.addAttribute("sdate", sdate);
		
//		if(StringUtils.isEmpty(edate))
//			edate = sdate;

		model.addAttribute("edate", edate);
		model.addAttribute("type", type);
		
		List<RentState> allTotalList = new ArrayList<RentState>();
		
		int tok = 0, tc = 0, tf = 0;
		if(!StringUtils.isEmpty(sdate) && !StringUtils.isEmpty(edate)){
			List<RentState> list = rentService.getTeamAllStats(sdate, edate);
			for(RentState rs : list){
				tok += rs.getTeam_ok();
				tc += rs.getTeam_cancel();
				tf += rs.getTeam_fail();
			}
			
			model.addAttribute("alltime", list);
		}
		
		RentState tt = new RentState();
		tt.setTeam_ok_t(tok);
		tt.setTeam_cancel_t(tc);
		tt.setTeam_fail_t(tf);
		
		allTotalList.add(tt);
		
		String[] times = new String[]{"0700", "0900", "1100", "1300", "1500", "1700", "1830", "2030"};
		for(String time : times){
			tok = 0;tc = 0;tf = 0;
			if(!StringUtils.isEmpty(sdate) && !StringUtils.isEmpty(edate)){
				List<RentState> list = rentService.getTeamTimeStats(sdate, edate, time);
				for(RentState rs : list){
					tok += rs.getTeam_ok();
					tc += rs.getTeam_cancel();
					tf += rs.getTeam_fail();
				}
				
				model.addAttribute("t" + time, list);
			}
			
			tt = new RentState();
			tt.setTeam_ok_t(tok);
			tt.setTeam_cancel_t(tc);
			tt.setTeam_fail_t(tf);
			
			allTotalList.add(tt);
		}
		
		model.addAttribute("alltotal", allTotalList);
		
		return "admin/rent/stats-team";
	}
	
	/**
	 * 통계
	 * @return
	 */
	@RequestMapping(value="/stats/detail", method=RequestMethod.GET)
	public String detail(Model model, @RequestParam(value="sdate", defaultValue="") String sdate,
			@RequestParam(value="edate", defaultValue="") String edate,
			@RequestParam(value="type", defaultValue="0") String type){
//		if(StringUtils.isEmpty(sdate)){
//			SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMdd");
//			Calendar cal = Calendar.getInstance();
//			sdate  = formatter.format(cal.getTime());
//		}

//		edate = sdate.replace(".", "");
		model.addAttribute("sdate", sdate);
		
//		if(StringUtils.isEmpty(edate))
//			edate = sdate;

		model.addAttribute("edate", edate);
		model.addAttribute("type", type);
		
		List<Club> clubList = clubService.findAll();
		model.addAttribute("clubList", clubList);
		
		if(!StringUtils.isEmpty(sdate) && !StringUtils.isEmpty(edate)){
			List<KeyValueObject<List<RentState>>> list = rentService.getStatsByTeam(sdate, edate);
			
			model.addAttribute("list", list);
		}
		
		return "admin/rent/stats-team-detail";
	}
	
}
