package com.trace.po;

public class Purchase {

	private String purchase_id; 
	
	private String purchase_user; //人员
	
	private String purchase_time; //采购时间
	
	private double purchase_num; //数量
	
	private double purchase_price; //数量
	
	private String purchase_video; //视频
	
	private String purchase_parentid; //上级信息
	
	private String purchase_kind; //种类
	
	private String purchase_grade; //级别
	
	private String purchase_spyb; //三品一标
	
	
	public String getPurchase_id() {
		return purchase_id;
	}
	
	public void setPurchase_id(String purchase_id) {
		this.purchase_id = purchase_id;
	}
	
	public String getPurchase_user() {
		return purchase_user;
	}
	
	public void setPurchase_user(String purchase_user) {
		this.purchase_user = purchase_user;
	}
	
	public String getPurchase_time() {
		return purchase_time;
	}
	
	public void setPurchase_time(String purchase_time) {
		this.purchase_time = purchase_time;
	}
	
	public double getPurchase_num() {
		return purchase_num;
	}
	
	public void setPurchase_num(double purchase_num) {
		this.purchase_num = purchase_num;
	}
	
	public String getPurchase_video() {
		return purchase_video;
	}
	
	public void setPurchase_video(String purchase_video) {
		this.purchase_video = purchase_video;
	}
	
	public String getPurchase_parentid() {
		return purchase_parentid;
	}
	
	public void setPurchase_parentid(String purchase_parentid) {
		this.purchase_parentid = purchase_parentid;
	}
	
	public double getPurchase_price() {
		return purchase_price;
	}
	
	public void setPurchase_price(double purchase_price) {
		this.purchase_price = purchase_price;
	}
	
	public String getPurchase_kind() {
		return purchase_kind;
	}
	
	public void setPurchase_kind(String purchase_kind) {
		this.purchase_kind = purchase_kind;
	}
	
	public String getPurchase_grade() {
		return purchase_grade;
	}
	
	public void setPurchase_grade(String purchase_grade) {
		this.purchase_grade = purchase_grade;
	}
	
	public String getPurchase_spyb() {
		return purchase_spyb;
	}
	
	public void setPurchase_spyb(String purchase_spyb) {
		this.purchase_spyb = purchase_spyb;
	}
}
