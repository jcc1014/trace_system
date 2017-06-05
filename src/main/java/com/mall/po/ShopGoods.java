package com.mall.po;

public class ShopGoods {
    private String shop_goods_id;

    private String shop_id;

    private String goods_id;

    private Double goods_num;
    
    private String createtime;

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

    public Double getGoods_num() {
        return goods_num;
    }

    public void setGoods_num(Double goods_num) {
        this.goods_num = goods_num;
    }
    
    public String Createtime() {
    	return createtime;
    }
    
    public void setCreatetime(String createtime) {
    	this.createtime = createtime == null? null:createtime.trim();
    }
    
    
}