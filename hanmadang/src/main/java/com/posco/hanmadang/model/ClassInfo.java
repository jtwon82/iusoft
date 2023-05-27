package com.posco.hanmadang.model;

import org.apache.commons.lang3.builder.ToStringBuilder;

public class ClassInfo extends Vo{
	private int idx_no;
    private String b_cate;
    private String b_cate_name;
    private String m_cate;
    private String m_cate_name;
    private String class_name;
    private String class_time;
    private int class_a_count;
    private int class_standby_count;
    private int class_b_count;
    private int b_sort;
    private String viewyn;
    private String regidate;
    
    private int cur_count;
    private int cnt_regular;
    private int cnt_associate;
    private int cnt_general;
    
    private int class_c_count;
    private int class_man_per;
    private int class_women_per;
	
	public int getIdx_no() {
		return idx_no;
	}
	public void setIdx_no(int idx_no) {
		this.idx_no = idx_no;
	}
	public String getB_cate() {
		return b_cate;
	}
	public void setB_cate(String b_cate) {
		this.b_cate = b_cate;
	}
	public String getB_cate_name() {
		return b_cate_name;
	}
	public void setB_cate_name(String b_cate_name) {
		this.b_cate_name = b_cate_name;
	}
	public String getM_cate() {
		return m_cate;
	}
	public void setM_cate(String m_cate) {
		this.m_cate = m_cate;
	}
	public String getM_cate_name() {
		return m_cate_name;
	}
	public void setM_cate_name(String m_cate_name) {
		this.m_cate_name = m_cate_name;
	}
	public String getClass_name() {
		return class_name;
	}
	public void setClass_name(String class_name) {
		this.class_name = class_name;
	}
	public String getClass_time() {
		return class_time;
	}
	public void setClass_time(String class_time) {
		this.class_time = class_time;
	}
	public int getClass_a_count() {
		return class_a_count;
	}
	public void setClass_a_count(int class_a_count) {
		this.class_a_count = class_a_count;
	}
	public int getClass_standby_count() {
		return class_standby_count;
	}
	public void setClass_standby_count(int class_standby_count) {
		this.class_standby_count = class_standby_count;
	}
	public int getClass_b_count() {
		return class_b_count;
	}
	public void setClass_b_count(int class_b_count) {
		this.class_b_count = class_b_count;
	}
	public int getB_sort() {
		return b_sort;
	}
	public void setB_sort(int b_sort) {
		this.b_sort = b_sort;
	}
	public String getViewyn() {
		return viewyn;
	}
	public void setViewyn(String viewyn) {
		this.viewyn = viewyn;
	}
	public String getRegidate() {
		return regidate;
	}
	public void setRegidate(String regidate) {
		this.regidate = regidate;
	}
	public int getCur_count() {
		return cur_count;
	}
	public void setCur_count(int cur_count) {
		this.cur_count = cur_count;
	}
	public int getCnt_regular() {
		return cnt_regular;
	}
	public void setCnt_regular(int cnt_regular) {
		this.cnt_regular = cnt_regular;
	}
	public int getCnt_associate() {
		return cnt_associate;
	}
	public void setCnt_associate(int cnt_associate) {
		this.cnt_associate = cnt_associate;
	}
	public int getCnt_general() {
		return cnt_general;
	}
	public void setCnt_general(int cnt_general) {
		this.cnt_general = cnt_general;
	}
	public int getClass_c_count() {
		return class_c_count;
	}
	public void setClass_c_count(int class_c_count) {
		this.class_c_count = class_c_count;
	}
	public int getClass_man_per() {
		return class_man_per;
	}
	public void setClass_man_per(int class_man_per) {
		this.class_man_per = class_man_per;
	}
	public int getClass_women_per() {
		return class_women_per;
	}
	public void setClass_women_per(int class_women_per) {
		this.class_women_per = class_women_per;
	}
}
