package com.posco.hanmadang.model;

public class OrderNo extends Vo{
    private String member_code;
    private String program_code;
    private String order_no;
    private String server_yn;
    private String lastdate;
    private String hash;
    
    private String timestamp;
    private String trs_no;
    
    private MainPay pay;
    
	public String getMember_code() {
		return member_code;
	}
	public void setMember_code(String member_code) {
		this.member_code = member_code;
	}
	public String getProgram_code() {
		return program_code;
	}
	public void setProgram_code(String program_code) {
		this.program_code = program_code;
	}
	public String getOrder_no() {
		return order_no;
	}
	public void setOrder_no(String order_no) {
		this.order_no = order_no;
	}
	public String getServer_yn() {
		return server_yn;
	}
	public void setServer_yn(String server_yn) {
		this.server_yn = server_yn;
	}
	public String getLastdate() {
		return lastdate;
	}
	public void setLastdate(String lastdate) {
		this.lastdate = lastdate;
	}
	public String getHash() {
		return hash;
	}
	public void setHash(String hash) {
		this.hash = hash;
	}
	public String getTimestamp() {
		return timestamp;
	}
	public void setTimestamp(String timestamp) {
		this.timestamp = timestamp;
	}
	public String getTrs_no() {
		return trs_no;
	}
	public void setTrs_no(String trs_no) {
		this.trs_no = trs_no;
	}
	public MainPay getPay() {
		return pay;
	}
	public void setPay(MainPay pay) {
		this.pay = pay;
	}
}
