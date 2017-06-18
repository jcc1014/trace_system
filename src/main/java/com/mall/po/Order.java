package com.mall.po;

public class Order {
    private String order_id;

    private String member_id;

    private double number;

    private String goods_id;

    private String createtime;

    private String current_status;
    
    private double price;
    
    private double amount;
    
    private double real_amount;
    
    private double sub_amount;
    
    private double rebate;

    public String getOrder_id() {
        return order_id;
    }

    public void setOrder_id(String order_id) {
        this.order_id = order_id == null ? null : order_id.trim();
    }

    public String getMember_id() {
        return member_id;
    }

    public void setMember_id(String member_id) {
        this.member_id = member_id == null ? null : member_id.trim();
    }

    public double getNumber() {
        return number;
    }

    public void setNumber(double number) {
        this.number = number;
    }

    public String getGoods_id() {
        return goods_id;
    }

    public void setGoods_id(String goods_id) {
        this.goods_id = goods_id == null ? null : goods_id.trim();
    }

    public String getCreatetime() {
        return createtime;
    }

    public void setCreatetime(String createtime) {
        this.createtime = createtime == null ? null : createtime.trim();
    }

    public String getCurrent_status() {
        return current_status;
    }

    public void setCurrent_status(String current_status) {
        this.current_status = current_status == null ? null : current_status.trim();
    }

	public double getPrice() {
		return price;
	}

	public void setPrice(double price) {
		this.price = price;
	}

	public double getAmount() {
		return amount;
	}

	public void setAmount(double amount) {
		this.amount = amount;
	}

	public double getReal_amount() {
		return real_amount;
	}

	public void setReal_amount(double real_amount) {
		this.real_amount = real_amount;
	}

	public double getSub_amount() {
		return sub_amount;
	}

	public void setSub_amount(double sub_amount) {
		this.sub_amount = sub_amount;
	}

	public double getRebate() {
		return rebate;
	}

	public void setRebate(double rebate) {
		this.rebate = rebate;
	}
    
    
}