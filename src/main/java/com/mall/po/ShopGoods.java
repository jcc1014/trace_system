package com.mall.po;

public class ShopGoods {
    private String shop_goods_id;

    private String shop_id;

    private String goods_id;

    private double goods_num;
    
    private String createtime;
    
    private String goods_name;
    
    private String shop_name;
    
    private double goods_remain;
    
    public String getShop_goods_id() {
        return shop_goods_id;
    }

    public void setShop_goods_id(String shop_goods_id) {
        this.shop_goods_id = shop_goods_id == null ? null : shop_goods_id.trim();
    }

    public String getShop_id() {
        return shop_id;
    }

    public void setShop_id(String shop_id) {
        this.shop_id = shop_id == null ? null : shop_id.trim();
    }

    public String getGoods_id() {
        return goods_id;
    }

    public void setGoods_id(String goods_id) {
        this.goods_id = goods_id == null ? null : goods_id.trim();
    }

    public double getGoods_num() {
        return goods_num;
    }

    public void setGoods_num(double goods_num) {
        this.goods_num = goods_num;
    }
    
    public String getCreatetime() {
    	return createtime;
    }
    
    public void setCreatetime(String createtime) {
    	this.createtime = createtime == null? null:createtime.trim();
    }
    
    public String getGoods_name() {
    	return goods_name;
    }
    
    public void setGoods_name(String goods_name) {
    	this.goods_name = goods_name == null? null:goods_name.trim();
    }
    public String getShop_name() {
    	return shop_name;
    }
    
    public void setShop_name(String shop_name) {
    	this.shop_name = shop_name == null? null:shop_name.trim();
    }

	public double getGoods_remain() {
		return goods_remain;
	}

	public void setGoods_remain(double goods_remain) {
		this.goods_remain = goods_remain;
	}

    
}