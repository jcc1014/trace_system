package com.mall.po;

public class Carry {

	private String carry_id;
	
	private String shop_id;
	
	private String carry_user;
	
	private String datetime;
	
	private String mall_order_id; //订单id
	
	private String status; //配送的状态
	
	private String finishtime;
	

	public String getCarry_id() {
		return carry_id;
	}

	public void setCarry_id(String carry_id) {
		this.carry_id = carry_id;
	}

	public String getShop_id() {
		return shop_id;
	}

	public void setShop_id(String shop_id) {
		this.shop_id = shop_id;
	}

	public String getCarry_user() {
		return carry_user;
	}

	public void setCarry_user(String carry_user) {
		this.carry_user = carry_user;
	}

	public String getDatetime() {
		return datetime;
	}

	public void setDatetime(String datetime) {
		this.datetime = datetime;
	}

	public String getMall_order_id() {
		return mall_order_id;
	}

	public void setMall_order_id(String mall_order_id) {
		this.mall_order_id = mall_order_id;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getFinishtime() {
		return finishtime;
	}

	public void setFinishtime(String finishtime) {
		this.finishtime = finishtime;
	}
	
	
	
}
