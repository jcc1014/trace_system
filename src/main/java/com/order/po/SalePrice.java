package com.order.po;

public class SalePrice {
    private String id;

    private String kind;

    private String grade;
    
    private String spyb;

    private double price;

    private double canteen_price;

    private double market_price;

    private double retail_price;

    private double other_price;

    private String createtime;

    private String status;

    private String parentid;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id == null ? null : id.trim();
    }

    public String getKind() {
        return kind;
    }

    public void setKind(String kind) {
        this.kind = kind == null ? null : kind.trim();
    }

    public String getGrade() {
        return grade;
    }

    public void setGrade(String grade) {
        this.grade = grade == null ? null : grade.trim();
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public double getCanteen_price() {
        return canteen_price;
    }

    public void setCanteen_price(double canteen_price) {
        this.canteen_price = canteen_price;
    }

    public double getMarket_price() {
        return market_price;
    }

    public void setMarket_price(double market_price) {
        this.market_price = market_price;
    }

    public double getRetail_price() {
        return retail_price;
    }

    public void setRetail_price(double retail_price) {
        this.retail_price = retail_price;
    }

    public double getOther_price() {
        return other_price;
    }

    public void setOther_price(double other_price) {
        this.other_price = other_price;
    }

    public String getCreatetime() {
        return createtime;
    }

    public void setCreatetime(String createtime) {
        this.createtime = createtime == null ? null : createtime.trim();
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status == null ? null : status.trim();
    }

    public String getParentid() {
        return parentid;
    }

    public void setParentid(String parentid) {
        this.parentid = parentid == null ? null : parentid.trim();
    }

	public String getSpyb() {
		return spyb;
	}

	public void setSpyb(String spyb) {
		this.spyb = spyb;
	}
    
}