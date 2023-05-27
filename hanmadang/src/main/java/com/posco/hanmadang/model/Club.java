package com.posco.hanmadang.model;

public class Club extends Vo{
	private int cl_num;
    private String cl_name;
    private String cl_wdate;
    private String cl_id;
    private String cl_passwd;
    private String cl_stat;
    
    private String cnt;
    private String real_cnt;
    
	public int getCl_num() {
		return cl_num;
	}
	public void setCl_num(int cl_num) {
		this.cl_num = cl_num;
	}
	public String getCl_name() {
		return cl_name;
	}
	public void setCl_name(String cl_name) {
		this.cl_name = cl_name;
	}
	public String getCl_wdate() {
		return cl_wdate;
	}
	public void setCl_wdate(String cl_wdate) {
		this.cl_wdate = cl_wdate;
	}
	public String getCl_id() {
		return cl_id;
	}
	public void setCl_id(String cl_id) {
		this.cl_id = cl_id;
	}
	public String getCl_passwd() {
		return cl_passwd;
	}
	public void setCl_passwd(String cl_passwd) {
		this.cl_passwd = cl_passwd;
	}
	public String getCl_stat() {
		return cl_stat;
	}
	public void setCl_stat(String cl_stat) {
		this.cl_stat = cl_stat;
	}
	public String getCnt() {
		return cnt;
	}
	public void setCnt(String cnt) {
		this.cnt = cnt;
	}
	public String getReal_cnt() {
		return real_cnt;
	}
	public void setReal_cnt(String real_cnt) {
		this.real_cnt = real_cnt;
	}
}
