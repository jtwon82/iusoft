package com.posco.hanmadang.model.admin;

import com.posco.hanmadang.model.Vo;

public class Admin extends Vo {
	private int idx;
    private String id;
    private String pwd;
    private String name;
    private String tel;
    private String phone;
    private String logidate;
    private String regidate;
    private String path_role; 
    private String info;
    private int miss_cnt;
    private String last_pwd;
    private String authNum;
    private boolean authOk;
    private boolean active;
    
    private String ip;
    
	public int getIdx() {
		return idx;
	}
	public void setIdx(int idx) {
		this.idx = idx;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getPwd() {
		return pwd;
	}
	public void setPwd(String pwd) {
		this.pwd = pwd;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getTel() {
		return tel;
	}
	public void setTel(String tel) {
		this.tel = tel;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getLogidate() {
		return logidate;
	}
	public void setLogidate(String logidate) {
		this.logidate = logidate;
	}
	public String getRegidate() {
		return regidate;
	}
	public void setRegidate(String regidate) {
		this.regidate = regidate;
	}
	public String getPath_role() {
		return path_role;
	}
	public void setPath_role(String path_role) {
		this.path_role = path_role;
	}
	public String getInfo() {
		return info;
	}
	public void setInfo(String info) {
		this.info = info;
	}
	public int getMiss_cnt() {
		return miss_cnt;
	}
	public void setMiss_cnt(int miss_cnt) {
		this.miss_cnt = miss_cnt;
	}
	public String getLast_pwd() {
		return last_pwd;
	}
	public void setLast_pwd(String last_pwd) {
		this.last_pwd = last_pwd;
	}
	public String getAuthNum() {
		return authNum;
	}
	public void setAuthNum(String authNum) {
		this.authNum = authNum;
	}
	public boolean isAuthOk() {
		return authOk;
	}
	public void setAuthOk(boolean authOk) {
		this.authOk = authOk;
	}
	public String getIp() {
		return ip;
	}
	public void setIp(String ip) {
		this.ip = ip;
	}
	public boolean isActive() {
		return active;
	}
	public void setActive(boolean active) {
		this.active = active;
	}
}
