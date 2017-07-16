package com.trace.po;

public class Farmer {

	private String farmer_id; //主键
	private String farmer_name; //姓名
	private String farmer_phone; //手机
	private String farmer_hzs;
	private String video_id; //视频id
	private String baseid;
	
	
	public String getFarmer_id() {
		return farmer_id;
	}
	public void setFarmer_id(String farmer_id) {
		this.farmer_id = farmer_id;
	}
	public String getFarmer_name() {
		return farmer_name;
	}
	public void setFarmer_name(String farmer_name) {
		this.farmer_name = farmer_name;
	}
	public String getFarmer_phone() {
		return farmer_phone;
	}
	public void setFarmer_phone(String farmer_phone) {
		this.farmer_phone = farmer_phone;
	}
	public String getVideo_id() {
		return video_id;
	}
	public void setVideo_id(String video_id) {
		this.video_id = video_id;
	}
	public String getFarmer_hzs() {
		return farmer_hzs;
	}
	public void setFarmer_hzs(String farmer_hzs) {
		this.farmer_hzs = farmer_hzs;
	}
	public String getBaseid() {
		return baseid;
	}
	public void setBaseid(String baseid) {
		this.baseid = baseid;
	}
	
	
}
