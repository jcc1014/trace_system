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
    
    private String address_id;
    
    private String type;
    
    private String finishtime;
    
    private String ordertime;
    
    private String shop_id;
    
    private String order_number;
    
    private String mall_order_id;

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

	public String getAddress_id() {
		return address_id;
	}

	public void setAddress_id(String address_id) {
		this.address_id = address_id;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getFinishtime() {
		return finishtime;
	}

	public void setFinishtime(String finishtime) {
		this.finishtime = finishtime;
	}

	public String getOrdertime() {
		return ordertime;
	}

	public void setOrdertime(String ordertime) {
		this.ordertime = ordertime;
	}

	public String getShop_id() {
		return shop_id;
	}

	public void setShop_id(String shop_id) {
		this.shop_id = shop_id == null ? null : shop_id.trim();;
	}

	public String getOrder_number() {
		return order_number;
	}

	public void setOrder_number(String order_number) {
		this.order_number = order_number == null ? null : order_number;
	}
	
	public String getMall_order_id() {
		return mall_order_id;
	}
	
	public void setMall_order_id(String mall_order_id) {
		this.mall_order_id = mall_order_id;
	}
}