package com.posco.hanmadang.mapper.scms;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.posco.hanmadang.model.ProgramDetail;
import com.posco.hanmadang.model.CardReceipt;
import com.posco.hanmadang.model.OrderNo;
import com.posco.hanmadang.model.Program;

@Mapper
public interface LectureMapper {
	List<Program> list();
	List<ProgramDetail> listDetail(@Param("detail_code") String detail_code);
	ProgramDetail select(@Param("program_code") String program_code);
	
	int selectReceiptSeq(@Param("seq_date") String seq_date);
	int insertReceiptSeq(@Param("seq_date") String seq_date, @Param("li_seq") int li_seq);
	int updateReceiptSeq(@Param("seq_date") String seq_date, @Param("li_seq") int li_seq);
	
	int insertReceipt(@Param("trs_no") String trs_no
			,@Param("sales_date") String sales_date
			,@Param("member_code") String member_code
			,@Param("amount") int amount);
	
	
	int insertReceiptDetail(@Param("order") OrderNo order, @Param("program") ProgramDetail program);
	
	int selectTrainingReceiptSeq(@Param("member_code") String member_code);
	
	int insertTrainingReceipt(@Param("member_seq") int member_seq, 
			@Param("order") OrderNo order, @Param("program") ProgramDetail program);
	
	int insertTrainingReceiptLink(@Param("member_seq") int member_seq, @Param("order") OrderNo order);
	
	int selectCardReceiptSeq(@Param("sales_date") String sales_date);
	
	int insertCardReceipt(@Param("sales_seq") int sales_seq, @Param("order") OrderNo order);
	
	List<CardReceipt> listCardReceipt(@Param("member_code") String member_code);
	
}
