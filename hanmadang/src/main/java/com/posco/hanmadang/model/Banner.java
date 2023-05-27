package com.posco.hanmadang.model;

public class Banner extends Vo{
	private int idx_no;
    private String b_name;
    private String b_img;
    private String b_link;
    private String regidate;
    private String linktarget;
    
	public int getIdx_no() {
		return idx_no;
	}
	public void setIdx_no(int idx_no) {
		this.idx_no = idx_no;
	}
	public String getB_name() {
		return b_name;
	}
	public void setB_name(String b_name) {
		this.b_name = b_name;
	}
	public String getB_img() {
		return b_img;
	}
	public void setB_img(String b_img) {
		this.b_img = b_img;
	}
	public String getB_link() {
		return b_link;
	}
	public void setB_link(String b_link) {
		this.b_link = b_link;
	}
	public String getRegidate() {
		return regidate;
	}
	public void setRegidate(String regidate) {
		this.regidate = regidate;
	}
	public String getLinktarget() {
		return linktarget;
	}
	public void setLinktarget(String linktarget) {
		this.linktarget = linktarget;
	}
    
	
}
