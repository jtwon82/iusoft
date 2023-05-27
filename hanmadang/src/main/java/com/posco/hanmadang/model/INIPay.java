package com.posco.hanmadang.model;

import org.apache.commons.lang3.builder.ToStringBuilder;

public class INIPay extends Vo{
	private String uid;
    private String oid;
    private String goodname;
    private String currency;
    private String paymethod;
    private String encrypted;
    
    private String sessionkey;
    private String buyername;
    private String buyertel;
    private String buyeremail;
    private String cardcode;
    private String parentemail;
    private String recvname;
    private String recvtel;
    
    private String recvaddr;
    private String recvpostnum;
    private String recvmsg;
    private String joincard;
    
    private String joinexpire;
    private String id_customer;
    
    
	public String getUid() {
		return uid;
	}


	public void setUid(String uid) {
		this.uid = uid;
	}


	public String getOid() {
		return oid;
	}


	public void setOid(String oid) {
		this.oid = oid;
	}


	public String getGoodname() {
		return goodname;
	}


	public void setGoodname(String goodname) {
		this.goodname = goodname;
	}


	public String getCurrency() {
		return currency;
	}


	public void setCurrency(String currency) {
		this.currency = currency;
	}


	public String getPaymethod() {
		return paymethod;
	}


	public void setPaymethod(String paymethod) {
		this.paymethod = paymethod;
	}


	public String getEncrypted() {
		return encrypted;
	}


	public void setEncrypted(String encrypted) {
		this.encrypted = encrypted;
	}


	public String getSessionkey() {
		return sessionkey;
	}


	public void setSessionkey(String sessionkey) {
		this.sessionkey = sessionkey;
	}


	public String getBuyername() {
		return buyername;
	}


	public void setBuyername(String buyername) {
		this.buyername = buyername;
	}


	public String getBuyertel() {
		return buyertel;
	}


	public void setBuyertel(String buyertel) {
		this.buyertel = buyertel;
	}


	public String getBuyeremail() {
		return buyeremail;
	}


	public void setBuyeremail(String buyeremail) {
		this.buyeremail = buyeremail;
	}


	public String getCardcode() {
		return cardcode;
	}


	public void setCardcode(String cardcode) {
		this.cardcode = cardcode;
	}


	public String getParentemail() {
		return parentemail;
	}


	public void setParentemail(String parentemail) {
		this.parentemail = parentemail;
	}


	public String getRecvname() {
		return recvname;
	}


	public void setRecvname(String recvname) {
		this.recvname = recvname;
	}


	public String getRecvtel() {
		return recvtel;
	}


	public void setRecvtel(String recvtel) {
		this.recvtel = recvtel;
	}


	public String getRecvaddr() {
		return recvaddr;
	}


	public void setRecvaddr(String recvaddr) {
		this.recvaddr = recvaddr;
	}


	public String getRecvpostnum() {
		return recvpostnum;
	}


	public void setRecvpostnum(String recvpostnum) {
		this.recvpostnum = recvpostnum;
	}


	public String getRecvmsg() {
		return recvmsg;
	}


	public void setRecvmsg(String recvmsg) {
		this.recvmsg = recvmsg;
	}


	public String getJoincard() {
		return joincard;
	}


	public void setJoincard(String joincard) {
		this.joincard = joincard;
	}


	public String getJoinexpire() {
		return joinexpire;
	}


	public void setJoinexpire(String joinexpire) {
		this.joinexpire = joinexpire;
	}


	public String getId_customer() {
		return id_customer;
	}


	public void setId_customer(String id_customer) {
		this.id_customer = id_customer;
	}
	
}
