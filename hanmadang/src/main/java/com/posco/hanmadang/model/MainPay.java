package com.posco.hanmadang.model;

import org.apache.commons.lang3.builder.ToStringBuilder;

public class MainPay extends Vo{
	private String mbrId;
    private String rstCode;
    private String rstMsg;
    private String salesPrice;
    private String payKind;
    private String oid;
    
    private String payType;
    private String authType;
    private String cardTradeNo;
    private String cardApproveDate;
    private String cardApproveTime;
    private String cardName;
    private String cardCode;
    private String installNo;
    
    private String cardNum;
    
    private int sales_amount;
    private int vat_amount;
    
	public String getMbrId() {
		return mbrId;
	}
	public void setMbrId(String mbrId) {
		this.mbrId = mbrId;
	}
	public String getRstCode() {
		return rstCode;
	}
	public void setRstCode(String rstCode) {
		this.rstCode = rstCode;
	}
	public String getRstMsg() {
		return rstMsg;
	}
	public void setRstMsg(String rstMsg) {
		this.rstMsg = rstMsg;
	}
	public String getSalesPrice() {
		return salesPrice;
	}
	public void setSalesPrice(String salesPrice) {
		this.salesPrice = salesPrice;
	}
	public String getPayKind() {
		return payKind;
	}
	public void setPayKind(String payKind) {
		this.payKind = payKind;
	}
	public String getOid() {
		return oid;
	}
	public void setOid(String oid) {
		this.oid = oid;
	}
	public String getPayType() {
		return payType;
	}
	public void setPayType(String payType) {
		this.payType = payType;
	}
	public String getAuthType() {
		return authType;
	}
	public void setAuthType(String authType) {
		this.authType = authType;
	}
	public String getCardTradeNo() {
		return cardTradeNo;
	}
	public void setCardTradeNo(String cardTradeNo) {
		this.cardTradeNo = cardTradeNo;
	}
	public String getCardApproveDate() {
		return cardApproveDate;
	}
	public void setCardApproveDate(String cardApproveDate) {
		this.cardApproveDate = cardApproveDate;
	}
	public String getCardApproveTime() {
		return cardApproveTime;
	}
	public void setCardApproveTime(String cardApproveTime) {
		this.cardApproveTime = cardApproveTime;
	}
	public String getCardName() {
		return cardName;
	}
	public void setCardName(String cardName) {
		this.cardName = cardName;
	}
	public String getCardCode() {
		return cardCode;
	}
	public void setCardCode(String cardCode) {
		this.cardCode = cardCode;
	}
	public String getInstallNo() {
		return installNo;
	}
	public void setInstallNo(String installNo) {
		this.installNo = installNo;
	}
	public String getCardNum() {
		return cardNum;
	}
	public void setCardNum(String cardNum) {
		this.cardNum = cardNum;
	}
	public int getSales_amount() {
		return sales_amount;
	}
	public void setSales_amount(int sales_amount) {
		this.sales_amount = sales_amount;
	}
	public int getVat_amount() {
		return vat_amount;
	}
	public void setVat_amount(int vat_amount) {
		this.vat_amount = vat_amount;
	}
}
