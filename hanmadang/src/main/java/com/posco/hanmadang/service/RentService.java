package com.posco.hanmadang.service;

import java.util.List;

import com.posco.hanmadang.common.Constant.ServiceResult;
import com.posco.hanmadang.model.KeyValueObject;
import com.posco.hanmadang.model.OffDay;
import com.posco.hanmadang.model.RentCode;
import com.posco.hanmadang.model.RentCount;
import com.posco.hanmadang.model.RentReserve;
import com.posco.hanmadang.model.RentState;

public interface RentService{
	List<OffDay> getBlock(String year_month);
	ServiceResult addBlock(OffDay day);
	ServiceResult removeBlock(int bl_num);
	
	List<RentCode> getRentCodes();
	List<RentCount> getReRentCount(int detail_code, String year_month);
	List<RentReserve> getReserve(int detail_code, String re_yoil, String re_date);
	
	List<RentReserve> getFixedClassReserve(int detail_code, String re_yoil, String re_date);
	ServiceResult addExceptDate(long rt_num, String excep_date);
	List<RentReserve> getCurState(int detail_code, String re_yoil, String nowtime, String nowdate);
	
	List<RentReserve> getDrawRentRe(int detail_code, String re_date);
	List<RentReserve> getDetailDrawRent(int detail_code, String befor1month, String after14days, String date, String stime);
	
	List<RentReserve> searchReserve(String cl_num, String re_code);
	ServiceResult setReserveTimeStat(long rt_num, String rt_stat);
	ServiceResult setReserveTimeStat(List<String> rt_nums, String rt_stat);
	
	ServiceResult addReserve(RentReserve reserve);
	
	//통계
	List<RentState> getAllRentStats(String sdate, String edate);
	List<RentState> getTeamAllStats(String sdate, String edate);
	List<RentState> getTeamTimeStats(String sdate, String edate, String stime);
	
	List<KeyValueObject<List<RentState>>> getStatsByTeam(String sdate, String edate);
	
}
