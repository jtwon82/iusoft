package com.posco.hanmadang.service;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.posco.hanmadang.common.Constant.ServiceResult;
import com.posco.hanmadang.mapper.posco.ProgramMapper;
import com.posco.hanmadang.mapper.scms.LectureMapper;
import com.posco.hanmadang.model.CardReceipt;
import com.posco.hanmadang.model.Member;
import com.posco.hanmadang.model.OrderNo;
import com.posco.hanmadang.model.Program;
import com.posco.hanmadang.model.ProgramDetail;
import com.posco.hanmadang.model.ProgramTimeInfo;

@Service("programService")
public class ProgramServiceImpl implements ProgramService {
	
	@Autowired ProgramMapper programMapper;
	@Autowired LectureMapper lectureMapper;
	
	@Transactional(readOnly=true)
	public ProgramTimeInfo get(int type){
		return programMapper.select(type);
	}
	
	@Transactional
	public ServiceResult update(ProgramTimeInfo info){
		programMapper.insert(info);
		return ServiceResult.SUCCESS;
	}
	
	@Transactional(readOnly=true)
	public List<Program> getProgram(){
		return lectureMapper.list();
	}
	
	@Transactional(readOnly=true)
	public List<ProgramDetail> getDetailProgram(String detail_code){
		return lectureMapper.listDetail(detail_code);
	}
	
	@Transactional(readOnly=true)
	public ProgramDetail findProgram(String program_code) {
		return lectureMapper.select(program_code);
	}
	
	@Transactional
	public ServiceResult updateOrderNo(OrderNo orderNo) {
		programMapper.insertOrerNo(orderNo);
		return ServiceResult.SUCCESS;
	}
	
	@Transactional
	public ServiceResult updateOrderNoStatus(String order_no, String status) {
		programMapper.updateOrderNo(order_no, status);
		return ServiceResult.SUCCESS;
	}
	
	@Transactional(readOnly=true)
	public OrderNo findOrderNo(String order_no) {
		return programMapper.selectOrderNo(order_no);
	}
	
	@Transactional
	public String getReceiptSeq() {
		SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMdd");
		Calendar cal = Calendar.getInstance();
		String seq_date = formatter.format(cal.getTime());
		
		int li_seq = lectureMapper.selectReceiptSeq(seq_date);
		if(li_seq == 0) 
			lectureMapper.insertReceiptSeq(seq_date, li_seq + 1);
		else 
			lectureMapper.updateReceiptSeq(seq_date, li_seq + 1);
		
		return String.format("%s%04d", seq_date, li_seq + 1);
	}
	
	@Transactional
	public ServiceResult procPay(OrderNo orderNo, ProgramDetail program) {
		//(1) 영수번호 채번
		SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMdd");
		Calendar cal = Calendar.getInstance();
		String seq_date = formatter.format(cal.getTime());
		orderNo.setTimestamp(seq_date);
		
//		int li_seq = lectureMapper.selectReceiptSeq(seq_date);
//		if(li_seq == 0) 
//			lectureMapper.insertReceiptSeq(seq_date, li_seq + 1);
//		else 
//			lectureMapper.updateReceiptSeq(seq_date, li_seq + 1);
		
//		String trs_no = String.format("%s%04d", seq_date, li_seq + 1);
		String trs_no = orderNo.getOrder_no();
		orderNo.setTrs_no(trs_no);
		
	    //(2) 영수마스터 Insert
		lectureMapper.insertReceipt(trs_no, orderNo.getTimestamp(), orderNo.getMember_code(), 
				Integer.parseInt(orderNo.getPay().getSalesPrice()));
		
	    //(3) 나머지 테이블 LOOP 처리
	     //  For i = 1 TO (프로그램 신청갯수)
		//  - 영수디테일
		//  - 강습영수 연결
	   //    NEXT
		String program_time = String.format("%s:%s ~ %s:%s", program.getStart_time().substring(0, 2), 
				program.getStart_time().substring(2, 4),
				program.getEnd_time().substring(0, 2),
				program.getEnd_time().substring(2, 4));
			
		program.setProgram_time(program_time);
		
		SimpleDateFormat formatter1 = new SimpleDateFormat("yyyyMM");
		
		cal.add(Calendar.MONTH, 1);
		String start_date = formatter1.format(cal.getTime());
		start_date += "01";
		program.setStart_date(start_date);
		
		cal.add(Calendar.MONTH, Integer.parseInt(program.getMonth_qty()) - 1);
		String end_date = formatter1.format(cal.getTime());
		int lastDay = cal.getActualMaximum(Calendar.DAY_OF_MONTH);
		end_date += String.valueOf(lastDay);
		program.setEnd_date(end_date);
		
		lectureMapper.insertReceiptDetail(orderNo, program);
		
		int li_member_seq = lectureMapper.selectTrainingReceiptSeq(orderNo.getMember_code());
		++li_member_seq;
		lectureMapper.insertTrainingReceipt(li_member_seq, orderNo, program);
		lectureMapper.insertTrainingReceiptLink(li_member_seq, orderNo);
		
	   // (4) 신용카드 승인정보 Insert
		int sales_seq = lectureMapper.selectCardReceiptSeq(orderNo.getTimestamp());
		++sales_seq;
		lectureMapper.insertCardReceipt(sales_seq, orderNo);
		
		return ServiceResult.SUCCESS;
	}
	
	@Transactional(readOnly=true)
	public List<CardReceipt> getAllReceipt(String member_code){
		return lectureMapper.listCardReceipt(member_code);
	}
}
