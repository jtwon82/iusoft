package com.posco.hanmadang.model;

public class RentReserveTime extends Vo{
	private long rt_num;
    private long re_num;
    private String rt_stime;
    private String rt_etime;
    private String rt_court;
    private int rt_court_cnt;
    private String rt_stat;
	public long getRt_num() {
		return rt_num;
	}
	public void setRt_num(long rt_num) {
		this.rt_num = rt_num;
	}
	public long getRe_num() {
		return re_num;
	}
	public void setRe_num(long re_num) {
		this.re_num = re_num;
	}
	public String getRt_stime() {
		return rt_stime;
	}
	public void setRt_stime(String rt_stime) {
		this.rt_stime = rt_stime;
	}
	public String getRt_etime() {
		return rt_etime;
	}
	public void setRt_etime(String rt_etime) {
		this.rt_etime = rt_etime;
	}
	public String getRt_court() {
		return rt_court;
	}
	public void setRt_court(String rt_court) {
		this.rt_court = rt_court;
	}
	public int getRt_court_cnt() {
		return rt_court_cnt;
	}
	public void setRt_court_cnt(int rt_court_cnt) {
		this.rt_court_cnt = rt_court_cnt;
	}
	public String getRt_stat() {
		return rt_stat;
	}
	public void setRt_stat(String rt_stat) {
		this.rt_stat = rt_stat;
	}

	
	
	
}
