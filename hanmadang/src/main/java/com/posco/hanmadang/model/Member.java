package com.posco.hanmadang.model;

import org.apache.commons.lang3.builder.ToStringBuilder;

public class Member extends Vo {
	private String center_id;
    private String member_code;
    private String member_name;
    private String birth;
    private String sex;
    private String cellular;
    private String email;
    private String member_id;
    private String member_pw;
    private String insert_date;
    
    private String smsAuthNum;
    private boolean authOk;
    
    private String login_date;
    private int pw_miss_cnt;
    private String pw_miss_dt;
    private String pw_last_dt;
    
    private String sms_send;
    private String state;
	
	public String getCenter_id() {
		return center_id;
	}
	public void setCenter_id(String center_id) {
		this.center_id = center_id;
	}
	public String getMember_code() {
		return member_code;
	}
	public void setMember_code(String member_code) {
		this.member_code = member_code;
	}
	public String getMember_name() {
		return member_name;
	}
	public void setMember_name(String member_name) {
		this.member_name = member_name;
	}
	public String getBirth() {
		return birth.trim();
	}
	public void setBirth(String birth) {
		this.birth = birth;
	}
	public String getSex() {
		return sex;
	}
	public void setSex(String sex) {
		this.sex = sex;
	}
	public String getCellular() {
		return cellular.trim();
	}
	public void setCellular(String cellular) {
		this.cellular = cellular;
	}
	public String getMember_id() {
		return member_id;
	}
	public void setMember_id(String member_id) {
		this.member_id = member_id;
	}
	public String getMember_pw() {
		return member_pw;
	}
	public String getInsert_date() {
		return insert_date;
	}
	public void setInsert_date(String insert_date) {
		this.insert_date = insert_date;
	}
	public void setMember_pw(String member_pw) {
		this.member_pw = member_pw;
	}
	public String getSmsAuthNum() {
		return smsAuthNum;
	}
	public void setSmsAuthNum(String smsAuthNum) {
		this.smsAuthNum = smsAuthNum;
	}
	public boolean isAuthOk() {
		return authOk;
	}
	public void setAuthOk(boolean authOk) {
		this.authOk = authOk;
	}
	public String getLogin_date() {
		return login_date;
	}
	public void setLogin_date(String login_date) {
		this.login_date = login_date;
	}
	public int getPw_miss_cnt() {
		return pw_miss_cnt;
	}
	public void setPw_miss_cnt(int pw_miss_cnt) {
		this.pw_miss_cnt = pw_miss_cnt;
	}
	public String getPw_miss_dt() {
		return pw_miss_dt;
	}
	public void setPw_miss_dt(String pw_miss_dt) {
		this.pw_miss_dt = pw_miss_dt;
	}
	public String getPw_last_dt() {
		return pw_last_dt;
	}
	public void setPw_last_dt(String pw_last_dt) {
		this.pw_last_dt = pw_last_dt;
	}
	public String getSms_send() {
		return sms_send;
	}
	public void setSms_send(String sms_send) {
		this.sms_send = sms_send;
	}
	public String getState() {
		return state;
	}
	public void setState(String state) {
		this.state = state;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}
}
