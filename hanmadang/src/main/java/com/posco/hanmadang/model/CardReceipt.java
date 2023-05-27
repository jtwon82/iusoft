package com.posco.hanmadang.model;

public class CardReceipt extends Vo{
	private String program_name;
    private String start_date;
    private String last_end_date;
    private String receive_amount;
    private String approval_no;
    private String trs_no;
    private String sales_date;
    private String approval_date;
    private String cancel_yn;
    private String deal_no;
    private String deal_type;
    private String purchase_code;
    
	public String getProgram_name() {
		return program_name;
	}
	public void setProgram_name(String program_name) {
		this.program_name = program_name;
	}
	public String getStart_date() {
		return start_date;
	}
	public void setStart_date(String start_date) {
		this.start_date = start_date;
	}
	public String getLast_end_date() {
		return last_end_date;
	}
	public void setLast_end_date(String last_end_date) {
		this.last_end_date = last_end_date;
	}
	public String getReceive_amount() {
		return receive_amount;
	}
	public void setReceive_amount(String receive_amount) {
		this.receive_amount = receive_amount;
	}
	public String getApproval_no() {
		return approval_no;
	}
	public void setApproval_no(String approval_no) {
		this.approval_no = approval_no;
	}
	public String getTrs_no() {
		return trs_no;
	}
	public void setTrs_no(String trs_no) {
		this.trs_no = trs_no;
	}
	public String getSales_date() {
		return sales_date;
	}
	public void setSales_date(String sales_date) {
		this.sales_date = sales_date;
	}
	public String getApproval_date() {
		return approval_date;
	}
	public void setApproval_date(String approval_date) {
		this.approval_date = approval_date;
	}
	public String getCancel_yn() {
		return cancel_yn;
	}
	public void setCancel_yn(String cancel_yn) {
		this.cancel_yn = cancel_yn;
	}
	public String getDeal_no() {
		return deal_no;
	}
	public void setDeal_no(String deal_no) {
		this.deal_no = deal_no;
	}
	public String getDeal_type() {
		return deal_type;
	}
	public void setDeal_type(String deal_type) {
		this.deal_type = deal_type;
	}
	public String getPurchase_code() {
		return purchase_code;
	}
	public void setPurchase_code(String purchase_code) {
		this.purchase_code = purchase_code;
	}
}
