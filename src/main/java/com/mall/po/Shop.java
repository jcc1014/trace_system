package com.mall.po;

public class Shop {
    private String shop_id;

    private String member_id;

    private String address;

    private String coordinate;

    private String createtime;
    
    private String shop_name;
    
    private String shop_phone;
    
    private int shop_order;
    
    private String shop_pic;
    
	public String getShop_name() {
		return shop_name;
	}

	public void setShop_name(String shop_name) {
		this.shop_name = shop_name;
	}

	public String getShop_id() {
        return shop_id;
    }

    public void setShop_id(String shop_id) {
        this.shop_id = shop_id == null ? null : shop_id.trim();
    }
    

    public String getMember_id() {
		return member_id;
	}

	public void setMember_id(String member_id) {
		this.member_id = member_id;
	}

	public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address == null ? null : address.trim();
    }

    public String getCoordinate() {
        return coordinate;
    }

    public void setCoordinate(String coordinate) {
        this.coordinate = coordinate == null ? null : coordinate.trim();
    }

    public String getCreatetime() {
        return createtime;
    }

    public void setCreatetime(String createtime) {
        this.createtime = createtime == null ? null : createtime.trim();
    }
    
    public String getShop_phone() {
    	return shop_phone;
    }
    
    public void setShop_phone(String shop_phone) {
    	this.shop_phone = shop_phone == null ? null : shop_phone.trim();
    }
    public int getShop_order() {
    	return shop_order;
    }
    
    public void setShop_order(int shop_order) {
    	this.shop_order = shop_order;
    }

	public String getShop_pic() {
		return shop_pic;
	}

	public void setShop_pic(String shop_pic) {
		this.shop_pic = shop_pic;
	}
}