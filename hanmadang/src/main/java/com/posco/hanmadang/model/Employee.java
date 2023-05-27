package com.posco.hanmadang.model;

import org.apache.commons.lang3.builder.ToStringBuilder;

public class Employee extends Vo{
	private long idx_no;
	private String em_no;
    private String em_name;
    private String part_name;
    private String work_name;
    private String em_type;
    private int rownum;
    
	public long getIdx_no() {
		return idx_no;
	}
	public void setIdx_no(long idx_no) {
		this.idx_no = idx_no;
	}
	public String getEm_no() {
		return em_no;
	}
	public void setEm_no(String em_no) {
		this.em_no = em_no;
	}
	public String getEm_name() {
		return em_name;
	}
	public void setEm_name(String em_name) {
		this.em_name = em_name;
	}
	public String getPart_name() {
		return part_name;
	}
	public void setPart_name(String part_name) {
		this.part_name = part_name;
	}
	public String getWork_name() {
		return work_name;
	}
	public void setWork_name(String work_name) {
		this.work_name = work_name;
	}
	public String getEm_type() {
		return em_type;
	}
	public void setEm_type(String em_type) {
		this.em_type = em_type;
	}
	public int getRownum() {
		return rownum;
	}
	public void setRownum(int rownum) {
		this.rownum = rownum;
	}
}
