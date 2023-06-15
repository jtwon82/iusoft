package com.posco.hanmadang.model;

import java.util.List;

public class RentReserve extends Vo{
	private long re_num;
	private long rt_num;
	private String re_name;
	private String re_nameMasking;
    private String re_partname;
    private int cl_num;
    private String cl_name;
    private String re_date;
    private String rt_stime;
    private String rt_etime;
    private String rt_court;
    private String re_title;
    private String re_kind;
    private String re_tel;
    private String re_passwd;
    private int rt_court_cnt;
    private int court_cnt;
    private String rt_stat;
    private String re_yoil;
    private String re_type;
    private String re_part;
    private String re_code;
    private String re_wdate;
    
    private String id;
    private String employee_no;
    private String em_no;
    private String em_name;
    private String part_name;
    private String team_id;
    private String team_pwd;
    
    private List<RentReserveTime> reserveTimes;
    
    private boolean allCourt;

	public long getRe_num() {
		return re_num;
	}
	public void setRe_num(long re_num) {
		this.re_num = re_num;
	}
	public long getRt_num() {
		return rt_num;
	}
	public void setRt_num(long rt_num) {
		this.rt_num = rt_num;
	}
	public String getRe_name() {
		return re_name;
	}
	public void setRe_name(String re_name) {
		this.re_name = re_name;
	}
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
	public String getRe_date() {
		return re_date;
	}
	public void setRe_date(String re_date) {
		this.re_date = re_date;
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
	public String getRt_stat() {
		return rt_stat;
	}
	public void setRt_stat(String rt_stat) {
		this.rt_stat = rt_stat;
	}
	public String getRe_title() {
		return re_title;
	}
	public void setRe_title(String re_title) {
		this.re_title = re_title;
	}
	public String getRe_kind() {
		return re_kind;
	}
	public void setRe_kind(String re_kind) {
		this.re_kind = re_kind;
	}
	public String getRe_tel() {
		return re_tel;
	}
	public void setRe_tel(String re_tel) {
		this.re_tel = re_tel;
	}
	public String getRe_passwd() {
		return re_passwd;
	}
	public void setRe_passwd(String re_passwd) {
		this.re_passwd = re_passwd;
	}
	public int getRt_court_cnt() {
		return rt_court_cnt;
	}
	public void setRt_court_cnt(int rt_court_cnt) {
		this.rt_court_cnt = rt_court_cnt;
	}
	public int getCourt_cnt() {
		return court_cnt;
	}
	public void setCourt_cnt(int court_cnt) {
		this.court_cnt = court_cnt;
	}
	public String getRe_yoil() {
		return re_yoil;
	}
	public void setRe_yoil(String re_yoil) {
		this.re_yoil = re_yoil;
	}
	public String getRe_type() {
		return re_type;
	}
	public void setRe_type(String re_type) {
		this.re_type = re_type;
	}
	public String getRe_code() {
		return re_code;
	}
	public void setRe_code(String re_code) {
		this.re_code = re_code;
	}
	public String getRe_wdate() {
		return re_wdate;
	}
	public void setRe_wdate(String re_wdate) {
		this.re_wdate = re_wdate;
	}
	public String getRe_part() {
		return re_part;
	}
	public void setRe_part(String re_part) {
		this.re_part = re_part;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getEmployee_no() {
		return employee_no;
	}
	public void setEmployee_no(String employee_no) {
		this.employee_no = employee_no;
	}
	public String getTeam_id() {
		return team_id;
	}
	public void setTeam_id(String team_id) {
		this.team_id = team_id;
	}
	public String getTeam_pwd() {
		return team_pwd;
	}
	public void setTeam_pwd(String team_pwd) {
		this.team_pwd = team_pwd;
	}
	public List<RentReserveTime> getReserveTimes() {
		return reserveTimes;
	}
	public void setReserveTimes(List<RentReserveTime> reserveTimes) {
		this.reserveTimes = reserveTimes;
	}
	public boolean isAllCourt() {
		return allCourt;
	}
	public void setAllCourt(boolean allCourt) {
		this.allCourt = allCourt;
	}
	public String getRe_partname() {
		return re_partname;
	}
	public void setRe_partname(String re_partname) {
		this.re_partname = re_partname;
	}
	public String getPart_name() {
		return part_name;
	}
	public void setPart_name(String part_name) {
		this.part_name = part_name;
	}
	public String getEm_name() {
		return em_name;
	}
	public void setEm_name(String em_name) {
		this.em_name = em_name;
	}
	public String getEm_no() {
		return em_no;
	}
	public void setEm_no(String em_no) {
		this.em_no = em_no;
	}

	public String getRe_nameMasking() {
		return re_nameMasking;
	}

	public void setRe_nameMasking(String re_nameMasking) {
		this.re_nameMasking = re_nameMasking;
	}
}
