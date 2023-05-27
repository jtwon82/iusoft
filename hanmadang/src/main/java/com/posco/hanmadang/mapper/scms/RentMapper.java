package com.posco.hanmadang.mapper.scms;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.posco.hanmadang.model.OffDay;
import com.posco.hanmadang.model.RentCode;
import com.posco.hanmadang.model.RentCount;
import com.posco.hanmadang.model.RentReserve;
import com.posco.hanmadang.model.RentReserveCnt;
import com.posco.hanmadang.model.RentReserveTime;
import com.posco.hanmadang.model.RentState;

@Mapper
public interface RentMapper {
	List<OffDay> listBlock(@Param("year_month") String year_month);
	int updateBlock(OffDay offday);
	int insertBlock(OffDay offday);
	int deleteBlock(@Param("bl_num") int bl_num);
	
	List<RentCode> listRentCode();
	List<RentCount> listRentCount(@Param("detail_code") int detail_code, @Param("year_month") String year_month);
	List<RentReserve> listReserve(@Param("detail_code") int detail_code 
			,@Param("re_yoil") String re_yoil
			,@Param("date") String re_date);
	
	List<RentReserve> listEachReserve(@Param("cl_num") String cl_num, @Param("re_code") String re_code);
	int updateTimeStat(@Param("rt_num") long rt_num, @Param("rt_stat") String rt_stat);
	int updateStats(@Param("rt_nums") List<String> rt_nums, @Param("rt_stat") String rt_stat);
	
	int insertReserve(RentReserve reserve);
	int insertReserveTime(@Param("list") List<RentReserveTime> list, @Param("re_num") long re_num);
	
	int cntNormalReserve(@Param("part_cd") int detail_code 
			,@Param("ticket_date") String re_date
			,@Param("stime") String stime
			,@Param("etime") String etime
			,@Param("court") String court);
	
	int cntNormalReserve2(@Param("part_cd") int detail_code 
			,@Param("ticket_date") String re_date
			,@Param("stime") String stime
			,@Param("etime") String etime
			,@Param("court") String court);
	
	int cntDrawReserve(@Param("cl_num") int cl_num 
			,@Param("ticket_date") String re_date
			,@Param("stime") String stime
			,@Param("etime") String etime);
	
	int cntEmployeeReserve(@Param("part_cd") int detail_code 
			,@Param("re_code") String re_code
			,@Param("ticket_date") String re_date);
	
	List<RentReserve> listFixedClass(@Param("re_part") int re_part, @Param("re_yoil") String re_yoil, @Param("ticket_date") String re_date);
	int insertExptFixedClass(@Param("rt_num") long rt_num, @Param("excep_date") String excep_date);
	List<RentReserve> listCurState(@Param("part_cd") int part_cd, @Param("re_yoil") String re_yoil, @Param("nowtime") String nowtime, @Param("nowdate") String nowdate);
	
	List<RentReserve> listDrawRent(@Param("part_cd") int part_cd, @Param("date") String date);
	List<RentReserve> listDetailDrawRent(@Param("part_cd") int part_cd, @Param("befor1month") String befor1month,
			@Param("after14days") String after14days, 
			@Param("date") String date
			,@Param("stime") String stime);
	
	
	//추첨
	List<RentReserve> listReRentTime(@Param("after14day") String after14day);
	List<RentReserve> listFixedReserve(@Param("detail_code") int detail_code 
			,@Param("re_yoil") String re_yoil
			,@Param("date") String re_date);
	
	List<RentReserve> listExistReserve(@Param("detail_code") int detail_code 
			,@Param("date") String re_date
			,@Param("stime") String stime
			,@Param("etime") String etime);
	
	int cntTargetReserve(@Param("detail_code") int detail_code 
			,@Param("date") String re_date
			,@Param("stime") String stime
			,@Param("etime") String etime);
	
	List<RentReserveCnt> listDrawReserve(@Param("detail_code") int detail_code 
			,@Param("date") String re_date
			,@Param("stime") String stime
			,@Param("etime") String etime
			,@Param("one_month_ago") String one_month_ago
			,@Param("befor_time") String befor_time);
	
	List<RentReserveCnt> listDrawReserve(@Param("detail_code") int detail_code 
			,@Param("date") String re_date
			,@Param("stime") String stime
			,@Param("etime") String etime
			,@Param("one_month_ago") String one_month_ago
			,@Param("befor_time") String befor_time
			,@Param("not_today") String not_today);
	
	List<RentReserveCnt> listDrawReserve(@Param("detail_code") int detail_code 
			,@Param("date") String re_date
			,@Param("stime") String stime
			,@Param("etime") String etime
			,@Param("one_month_ago") String one_month_ago
			,@Param("befor_time") String befor_time
			,@Param("success_list") List<Integer> success_list);
	
	int updateDraw(@Param("vv") long vv, @Param("dang_court") String dang_court);
	
	int insertDraw(@Param("ticket_date") String ticket_date
			,@Param("clnum") int clnum 
			,@Param("dang") int dang
			,@Param("stime") String stime);
	
	int updateFailedDraw(@Param("detail_code") int detail_code
			,@Param("date") String re_date
			,@Param("stime") String stime
			,@Param("etime") String etime);
	
	//통계
	List<RentState> listAllStats(@Param("sdate") String sdate ,@Param("edate") String edate);
	List<RentState> listTeamAllStats(@Param("sdate") String sdate ,@Param("edate") String edate);
	List<RentState> listTeamTimeStats(@Param("sdate") String sdate ,@Param("edate") String edate, @Param("stime") String stime);
	List<RentState> listVaildTeamDate(@Param("sdate") String sdate ,@Param("edate") String edate);
	List<RentState> listStatsByTeam(@Param("date") String date);
}
