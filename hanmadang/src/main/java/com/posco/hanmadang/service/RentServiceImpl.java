package com.posco.hanmadang.service;


import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.posco.hanmadang.common.Constant;
import com.posco.hanmadang.common.Constant.ServiceResult;
import com.posco.hanmadang.mapper.scms.RentMapper;
import com.posco.hanmadang.model.KeyValueObject;
import com.posco.hanmadang.model.OffDay;
import com.posco.hanmadang.model.RentCode;
import com.posco.hanmadang.model.RentCount;
import com.posco.hanmadang.model.RentReserve;
import com.posco.hanmadang.model.RentReserveTime;
import com.posco.hanmadang.model.RentState;

@Service("rentService")
public class RentServiceImpl implements RentService {
	
	@Autowired RentMapper rentMapper;
	
	@Transactional(readOnly=true)
	public List<OffDay> getBlock(String year_month){
		return rentMapper.listBlock(year_month);
	}
	
	@Transactional
	public ServiceResult addBlock(OffDay day){
		if(day.getBl_num() > 0)
			rentMapper.updateBlock(day);
		else
			rentMapper.insertBlock(day);
		return ServiceResult.SUCCESS;
	}
	
	@Transactional
	public ServiceResult removeBlock(int bl_num){
		rentMapper.deleteBlock(bl_num);
		return ServiceResult.SUCCESS;
	}
	
	@Transactional(readOnly=true)
	public List<RentCode> getRentCodes(){
		return rentMapper.listRentCode();
	}
	
	@Transactional(readOnly=true)
	public List<RentCount> getReRentCount(int detail_code, String year_month){
		return rentMapper.listRentCount(detail_code, year_month);
	}
	
	@Transactional(readOnly=true)
	public List<RentReserve> getReserve(int detail_code, String re_yoil, String re_date){
		return rentMapper.listReserve(detail_code, re_yoil, re_date);
	}

	@Transactional(readOnly=true)
	public List<RentReserve> getFixedClassReserve(int detail_code, String re_yoil, String re_date){
		return rentMapper.listFixedClass(detail_code, re_yoil, re_date);
	}
	
	@Transactional
	public ServiceResult addExceptDate(long rt_num, String excep_date){
		rentMapper.insertExptFixedClass(rt_num, excep_date);
		return ServiceResult.SUCCESS;
	}
	
	@Transactional(readOnly=true)
	public List<RentReserve> getCurState(int detail_code, String re_yoil, String nowtime, String nowdate){
		return rentMapper.listCurState(detail_code, re_yoil, nowtime, nowdate);
	}
	
	@Transactional(readOnly=true)
	public List<RentReserve> getDrawRentRe(int detail_code, String re_date){
		return rentMapper.listDrawRent(detail_code, re_date);
	}
	
	@Transactional(readOnly=true)
	public List<RentReserve> getDetailDrawRent(int detail_code, String befor1month, String after14days, String date, String stime){
		return rentMapper.listDetailDrawRent(detail_code, befor1month, after14days, date, stime);
	}
	
	@Transactional(readOnly=true)
	public List<RentReserve> searchReserve(String cl_num, String re_code){
		return rentMapper.listEachReserve(cl_num, re_code);
	}
	
	@Transactional
	public ServiceResult setReserveTimeStat(long rt_num, String rt_stat){
		rentMapper.updateTimeStat(rt_num, rt_stat);
		return ServiceResult.SUCCESS;
	}

	@Transactional
	public ServiceResult setReserveTimeStat(List<String> rt_nums, String rt_stat){
		rentMapper.updateStats(rt_nums, rt_stat);
		return ServiceResult.SUCCESS;
	}
	
	@Transactional
	public ServiceResult addReserve(RentReserve reserve){
		if(reserve.getRe_type().equals(String.valueOf(Constant.RentReserveType.employee.ordinal()))){
			int cnt = rentMapper.cntEmployeeReserve(Integer.parseInt(reserve.getRe_part()), reserve.getRe_code(), reserve.getRe_date());
			if(cnt > 0)
				return ServiceResult.DUPLICATE;
			
			for(RentReserveTime rt : reserve.getReserveTimes()){
				if(rt.getRt_court().equals("1코트") || rt.getRt_court().equals("2코트")) //11, 12코트도 인식 방지 예외처리
					cnt = rentMapper.cntNormalReserve2(Integer.parseInt(reserve.getRe_part()), reserve.getRe_date(), rt.getRt_stime(), rt.getRt_etime(), rt.getRt_court());
				else
					cnt = rentMapper.cntNormalReserve(Integer.parseInt(reserve.getRe_part()), reserve.getRe_date(), rt.getRt_stime(), rt.getRt_etime(), rt.getRt_court());
				
				if(cnt > 0)
					return ServiceResult.DUPLICATE;
			}
			
		}else if(reserve.getRe_type().equals(String.valueOf(Constant.RentReserveType.team.ordinal()))){
			for(RentReserveTime rt : reserve.getReserveTimes()){
				int cnt = 0;
				if(rt.getRt_court().equals("1코트") || rt.getRt_court().equals("2코트")) //11, 12코트도 인식 방지 예외처리
					cnt = rentMapper.cntNormalReserve2(Integer.parseInt(reserve.getRe_part()), reserve.getRe_date(), rt.getRt_stime(), rt.getRt_etime(), rt.getRt_court());
				else
					cnt = rentMapper.cntNormalReserve(Integer.parseInt(reserve.getRe_part()), reserve.getRe_date(), rt.getRt_stime(), rt.getRt_etime(), rt.getRt_court());
				if(cnt > 0) 
					return ServiceResult.DUPLICATE;
			}
		}else if(reserve.getRe_type().equals(String.valueOf(Constant.RentReserveType.draw.ordinal()))){
			for(RentReserveTime rt : reserve.getReserveTimes()){
				int cnt = rentMapper.cntDrawReserve(reserve.getCl_num(), reserve.getRe_date(), rt.getRt_stime(), rt.getRt_etime());
				if(cnt > 0)
					return ServiceResult.DUPLICATE;
			}
		}else if(reserve.getRe_type().equals(String.valueOf(Constant.RentReserveType.company.ordinal()))){
			
		}else if(reserve.getRe_type().equals(String.valueOf(Constant.RentReserveType.lecture.ordinal()))){
			
		}else{
			return ServiceResult.INVALID_PARAM;
		}
		
		int ret = rentMapper.insertReserve(reserve);
		if(reserve.getRe_num() > 0 && reserve.getReserveTimes().size() > 0){
			rentMapper.insertReserveTime(reserve.getReserveTimes(), reserve.getRe_num());
		}
		
		return ServiceResult.SUCCESS;
	}
	
	@Transactional(readOnly=true)
	public List<RentState> getAllRentStats(String sdate, String edate){
		return rentMapper.listAllStats(sdate, edate);
	}
	
	@Transactional(readOnly=true)
	public List<RentState> getTeamAllStats(String sdate, String edate){
		return rentMapper.listTeamAllStats(sdate, edate);
	}
	
	@Transactional(readOnly=true)
	public List<RentState> getTeamTimeStats(String sdate, String edate, String stime){
		return rentMapper.listTeamTimeStats(sdate, edate, stime);
	}
	
	@Transactional(readOnly=true)
	public List<KeyValueObject<List<RentState>>> getStatsByTeam(String sdate, String edate){
		List<KeyValueObject<List<RentState>>> list = new ArrayList<KeyValueObject<List<RentState>>>();
		List<RentState> dateList = rentMapper.listVaildTeamDate(sdate, edate);
		for(RentState rs : dateList){
			KeyValueObject<List<RentState>> tmp = new KeyValueObject<List<RentState>>();
			tmp.setKey(rs.getRe_date());
			List<RentState> rsList =  rentMapper.listStatsByTeam(rs.getRe_date());
			tmp.setValue(rsList);
			
			list.add(tmp);
		}
		return list;
	}
}
