package com.posco.hanmadang.model.admin;

import com.posco.hanmadang.model.Vo;

public class VIPMember extends Vo{
    private String name;
    private String class_name;
    private String class_time;
    private String phone;
    private String em_name;
    private String em_type;
    private String type;
    
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
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
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getEm_name() {
		return em_name;
	}
	public void setEm_name(String em_name) {
		this.em_name = em_name;
	}
	public String getEm_type() {
		return em_type;
	}
	public void setEm_type(String em_type) {
		this.em_type = em_type;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
 
    
}