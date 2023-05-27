package com.posco.hanmadang.model;

import org.apache.commons.lang3.builder.ToStringBuilder;

public class ClassUser extends Vo{
	private long idx_no;
    private String mem_type;
    private String o_name;
    private String e_name;
    private String e_no;
    private String partname;
    private String partname1;
    private String tel;
    private String hp;
    private String pass;
    private String regidate;
    private String class_year;
    private String class_month;
    private String class_yn;
    private String class_ok; // vip 여부
    private String c_idx;
    private String em_type;
    private String em_type2;
    private String rem_type;
    private String class_update;
    private String upday;
    private String viewyn;
    private int didx;
    private String m_type;
    private String enc_pass;
    private String gender; // 0 : 남성, 1 : 여성
    private int step;
    private int rownum;
    private int rank;
    private int randomNo=(int) (Math.random()*100)+1;
	private ClassInfo classInfo;
    
	public long getIdx_no() {
		return idx_no;
	}
	public void setIdx_no(long idx_no) {
		this.idx_no = idx_no;
	}
	public String getMem_type() {
		return mem_type;
	}
	public void setMem_type(String mem_type) {
		this.mem_type = mem_type;
	}
	public String getO_name() {
		return o_name;
	}
	public void setO_name(String o_name) {
		this.o_name = o_name;
	}
	public String getE_name() {
		return e_name;
	}
	public void setE_name(String e_name) {
		this.e_name = e_name;
	}
	public String getE_no() {
		return e_no;
	}
	public void setE_no(String e_no) {
		this.e_no = e_no;
	}
	public String getPartname() {
		return partname;
	}
	public void setPartname(String partname) {
		this.partname = partname;
	}
	public String getPartname1() {
		return partname1;
	}
	public void setPartname1(String partname1) {
		this.partname1 = partname1;
	}
	public String getTel() {
		return tel;
	}
	public void setTel(String tel) {
		this.tel = tel;
	}
	public String getHp() {
		return hp;
	}
	public void setHp(String hp) {
		this.hp = hp;
	}
	public String getPass() {
		return pass;
	}
	public void setPass(String pass) {
		this.pass = pass;
	}
	public String getRegidate() {
		return regidate;
	}
	public void setRegidate(String regidate) {
		this.regidate = regidate;
	}
	public String getClass_year() {
		return class_year;
	}
	public void setClass_year(String class_year) {
		this.class_year = class_year;
	}
	public String getClass_month() {
		return class_month;
	}
	public void setClass_month(String class_month) {
		this.class_month = class_month;
	}
	public String getClass_yn() {
		return class_yn;
	}
	public void setClass_yn(String class_yn) {
		this.class_yn = class_yn;
	}
	public String getClass_ok() {
		return class_ok;
	}
	public void setClass_ok(String class_ok) {
		this.class_ok = class_ok;
	}
	public String getC_idx() {
		return c_idx;
	}
	public void setC_idx(String c_idx) {
		this.c_idx = c_idx;
	}
	public String getEm_type() {
		return em_type;
	}
	public String getEm_typeStr() {
		String result = "";
		switch(getEm_type()) {
		case "01":	result="포스코패밀리";	break;
		case "02":	result="포스코패밀리";	break;
		default:	result="일반회원";	break;
		}
		return result;
	}
	public void setEm_type(String em_type) {
		this.em_type = em_type;
	}
	public String getRem_type() {
		return rem_type;
	}
	public void setRem_type(String rem_type) {
		this.rem_type = rem_type;
	}
	public String getClass_update() {
		return class_update;
	}
	public void setClass_update(String class_update) {
		this.class_update = class_update;
	}
	public String getUpday() {
		return upday;
	}
	public void setUpday(String upday) {
		this.upday = upday;
	}
	public String getViewyn() {
		return viewyn;
	}
	public void setViewyn(String viewyn) {
		this.viewyn = viewyn;
	}
	public int getDidx() {
		return didx;
	}
	public void setDidx(int didx) {
		this.didx = didx;
	}
	public String getM_type() {
		return m_type;
	}
	public void setM_type(String m_type) {
		this.m_type = m_type;
	}
	public String getEnc_pass() {
		return enc_pass;
	}
	public void setEnc_pass(String enc_pass) {
		this.enc_pass = enc_pass;
	}
	public String getGender() {
		return gender;
	}
	public void setGender(String gender) {
		this.gender = gender;
	}
	public int getStep() {
		return step;
	}
	public void setStep(int step) {
		this.step = step;
	}
	public int getRownum() {
		return rownum;
	}
	public void setRownum(int rownum) {
		this.rownum = rownum;
	}
	public ClassInfo getClassInfo() {
		return classInfo;
	}
	public void setClassInfo(ClassInfo classInfo) {
		this.classInfo = classInfo;
	}
	public int getRank() {
		return rank;
	}
	public void setRank(int rank) {
		this.rank = rank;
	}
	public String getRankFormat() {
		return String.format("%03d", getRank());
	}
	public int getRandomNo() {
		return randomNo;
	}
	public void setRandomNo(int randomNo) {
		this.randomNo = randomNo;
	}
	public String getEm_type2() {
		return em_type2;
	}
	public void setEm_type2(String em_type2) {
		this.em_type2 = em_type2;
	}
	
}
