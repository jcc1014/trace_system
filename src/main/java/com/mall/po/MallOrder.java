package com.mall.po;

/**
 * @description: mall_order
 * @author liz
 * @date 2017/7/3 14:49
 */
public class MallOrder {
	
	private String id;
	
	private String member_id;
	
	private String current_status;
	
	private Float price;
	
	private Float discount;
	
	private Float final_price;
	
	private String address_id;
	
	private String shop_id;
	
	private String order_number;
	
	private String create_time;
	
	public String getId() {
		return id;
	}
	
	public void setId(String id) {
		this.id = id;
	}
	
	public String getMember_id() {
		return member_id;
	}
	
	public void setMember_id(String member_id) {
		this.member_id = member_id;
	}
	
	public String getCurrent_status() {
		return current_status;
	}
	
	public void setCurrent_status(String current_status) {
		this.current_status = current_status;
	}
	
	public Float getPrice() {
		return price;
	}
	
	public void setPrice(Float price) {
		this.price = price;
	}
	
	public Float getDiscount() {
		return discount;
	}
	
	public void setDiscount(Float discount) {
		this.discount = discount;
	}
	
	public Float getFinal_price() {
		return final_price;
	}
	
	public void setFinal_price(Float final_price) {
		this.final_price = final_price;
	}
	
	public String getAddress_id() {
		return address_id;
	}
	
	public void setAddress_id(String address_id) {
		this.address_id = address_id;
	}
	
	public String getShop_id() {
		return shop_id;
	}
	
	public void setShop_id(String shop_id) {
		this.shop_id = shop_id;
	}
	
	public String getOrder_number() {
		return order_number;
	}
	
	public void setOrder_number(String order_number) {
		this.order_number = order_number;
	}
	
	public String getCreate_time() {
		return create_time;
	}
	
	public void setCreate_time(String create_time) {
		this.create_time = create_time;
	}
}
