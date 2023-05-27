package com.posco.hanmadang.service;

import java.util.List;

import com.posco.hanmadang.common.Constant.ServiceResult;
import com.posco.hanmadang.model.CardReceipt;
import com.posco.hanmadang.model.OrderNo;
import com.posco.hanmadang.model.Program;
import com.posco.hanmadang.model.ProgramDetail;
import com.posco.hanmadang.model.ProgramTimeInfo;

public interface ProgramService{
	ProgramTimeInfo get(int type);
	ServiceResult update(ProgramTimeInfo info);
	
	List<Program> getProgram();
	List<ProgramDetail> getDetailProgram(String detail_code);
	ProgramDetail findProgram(String program_code);
	
	ServiceResult updateOrderNo(OrderNo orderNo);
	ServiceResult updateOrderNoStatus(String order_no, String status);
	OrderNo findOrderNo(String order_no);
	
	String getReceiptSeq();
	ServiceResult procPay(OrderNo orderNo, ProgramDetail program);
	
	List<CardReceipt> getAllReceipt(String member_code);
}
