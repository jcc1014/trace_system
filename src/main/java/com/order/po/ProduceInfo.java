package com.order.po;

public class ProduceInfo {
    private String produce_id; //生产信息id

    private String produce_name; //生产产地名称

    private String produce_place; //产地地址

    private String type; //种类（菜的种类）

    private String grade; //品级

    private Double supply_number; //供应量

    private Double price; //价格

    private String produce_infoer; //产地信息员

    private String status; //状态

    private String createtime; //创建时间

    private String phone; //手机号
    
    private String parent_id; //上级id(total里面的id)

    public String getProduce_id() {
        return produce_id;
    }

    public void setProduce_id(String produce_id) {
        this.produce_id = produce_id == null ? null : produce_id.trim();
    }

    public String getProduce_name() {
        return produce_name;
    }

    public void setProduce_name(String produce_name) {
        this.produce_name = produce_name == null ? null : produce_name.trim();
    }

    public String getProduce_place() {
        return produce_place;
    }

    public void setProduce_place(String produce_place) {
        this.produce_place = produce_place == null ? null : produce_place.trim();
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type == null ? null : type.trim();
    }

    public String getGrade() {
        return grade;
    }

    public void setGrade(String grade) {
        this.grade = grade == null ? null : grade.trim();
    }

    public Double getSupply_number() {
        return supply_number;
    }

    public void setSupply_number(Double supply_number) {
        this.supply_number = supply_number;
    }

    public Double getPrice() {
        return price;
    }

    public void setPrice(Double price) {
        this.price = price;
    }

    public String getProduce_infoer() {
        return produce_infoer;
    }

    public void setProduce_infoer(String produce_infoer) {
        this.produce_infoer = produce_infoer == null ? null : produce_infoer.trim();
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status == null ? null : status.trim();
    }

    public String getCreatetime() {
        return createtime;
    }

    public void setCreatetime(String createtime) {
        this.createtime = createtime == null ? null : createtime.trim();
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone == null ? null : phone.trim();
    }

	public String getParent_id() {
		return parent_id;
	}

	public void setParent_id(String parent_id) {
		this.parent_id = parent_id;
	}
}