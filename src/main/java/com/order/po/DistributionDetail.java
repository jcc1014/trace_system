package com.order.po;

public class DistributionDetail {
    private String id;  //主键id

    private String distribution_id; //配送id(相当于parentid)

    private Double distribution_num; //配送数量

    private String price; //价格

    private String distribution_car; //配送车辆

    private String distribution_user; //配送人员

    private String phone; //手机号

    private String distribution_qrcode; //生成二维码地址

    private String status; //状态

    private String psbh; //配送号
    
    private String trace_id;
    
    private String createtime;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id == null ? null : id.trim();
    }

    public String getDistribution_id() {
        return distribution_id;
    }

    public void setDistribution_id(String distribution_id) {
        this.distribution_id = distribution_id == null ? null : distribution_id.trim();
    }

    public Double getDistribution_num() {
        return distribution_num;
    }

    public void setDistribution_num(Double distribution_num) {
        this.distribution_num = distribution_num;
    }

    public String getPrice() {
        return price;
    }

    public void setPrice(String price) {
        this.price = price == null ? null : price.trim();
    }

    public String getDistribution_car() {
        return distribution_car;
    }

    public void setDistribution_car(String distribution_car) {
        this.distribution_car = distribution_car == null ? null : distribution_car.trim();
    }

    public String getDistribution_user() {
        return distribution_user;
    }

    public void setDistribution_user(String distribution_user) {
        this.distribution_user = distribution_user == null ? null : distribution_user.trim();
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone == null ? null : phone.trim();
    }

    public String getDistribution_qrcode() {
        return distribution_qrcode;
    }

    public void setDistribution_qrcode(String distribution_qrcode) {
        this.distribution_qrcode = distribution_qrcode == null ? null : distribution_qrcode.trim();
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status == null ? null : status.trim();
    }

    public String getPsbh() {
        return psbh;
    }

    public void setPsbh(String psbh) {
        this.psbh = psbh == null ? null : psbh.trim();
    }

	public String getTrace_id() {
		return trace_id;
	}

	public void setTrace_id(String trace_id) {
		this.trace_id = trace_id;
	}

	public String getCreatetime() {
		return createtime;
	}

	public void setCreatetime(String createtime) {
		this.createtime = createtime;
	}
}