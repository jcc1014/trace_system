package com.trace.po;

public class Purchase {

	private String purchase_id; 
	private String purchase_name; //人员
	private String purchase_time; //采购时间
	private double purchase_num; //数量
	private String purchase_video; //视频
	private String purchase_type; //类型
	private String purchase_parentid; //上级信息
	
	
	public String getPurchase_id() {
		return purchase_id;
	}
	public void setPurchase_id(String purchase_id) {
		this.purchase_id = purchase_id;
	}
	public String getPurchase_name() {
		return purchase_name;
	}
	public void setPurchase_name(String purchase_name) {
		this.purchase_name = purchase_name;
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
	public String getPurchase_type() {
		return purchase_type;
	}
	public void setPurchase_type(String purchase_type) {
		this.purchase_type = purchase_type;
	}
	public String getPurchase_parentid() {
		return purchase_parentid;
	}
	public void setPurchase_parentid(String purchase_parentid) {
		this.purchase_parentid = purchase_parentid;
	}
	
}
