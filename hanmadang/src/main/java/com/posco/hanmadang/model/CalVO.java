package com.posco.hanmadang.model;

import org.apache.commons.lang3.builder.ToStringBuilder;

public class CalVO extends Vo{
	
	private String time_date; 
    private boolean lock_yn;
    private boolean confirm_yn;
	
	public String getTime_date() {
		return time_date;
	}
	public void setTime_date(String time_date) {
		this.time_date = time_date;
	}
	public boolean isLock_yn() {
		return lock_yn;
	}
	public void setLock_yn(boolean lock_yn) {
		this.lock_yn = lock_yn;
	}
	public boolean isConfirm_yn() {
		return confirm_yn;
	}
	public void setConfirm_yn(boolean confirm_yn) {
		this.confirm_yn = confirm_yn;
	}
}
