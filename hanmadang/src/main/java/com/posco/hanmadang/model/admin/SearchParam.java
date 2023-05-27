package com.posco.hanmadang.model.admin;

import com.posco.hanmadang.model.Vo;

public class SearchParam extends Vo{
    private String b_cate;
    private String em_type;
    private String class_yn;
    private String op;
    private String keyword;
    private int didx;
    
	public String getB_cate() {
		return b_cate;
	}
	public void setB_cate(String b_cate) {
		this.b_cate = b_cate;
	}
	public String getEm_type() {
		return em_type;
	}
	public void setEm_type(String em_type) {
		this.em_type = em_type;
	}
	public String getClass_yn() {
		return class_yn;
	}
	public void setClass_yn(String class_yn) {
		this.class_yn = class_yn;
	}
	public String getOp() {
		return op;
	}
	public void setOp(String op) {
		this.op = op;
	}
	public String getKeyword() {
		return keyword;
	}
	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}
	public int getDidx() {
		return didx;
	}
	public void setDidx(int didx) {
		this.didx = didx;
	}
    
	
}