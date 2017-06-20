package com.mall.po;

import org.springframework.util.StringUtils;

public class Goods {
    private String goods_id;

    private String goods_name;

    private String goods_type;

    private String goods_description;

    private String shop_id;
    
    private Float new_price;
    
    private Float old_price;

    private String create_time;

    public String getGoods_id() {
        return goods_id;
    }

    public void setGoods_id(String goods_id) {
        this.goods_id = goods_id == null ? null : goods_id.trim();
    }

    public String getGoods_name() {
        return goods_name;
    }

    public void setGoods_name(String goods_name) {
        this.goods_name = goods_name == null ? null : goods_name.trim();
    }

    public String getGoods_type() {
        return goods_type;
    }

    public void setGoods_type(String goods_type) {
        this.goods_type = goods_type == null ? null : goods_type.trim();
    }

    public String getGoods_description() {
        return goods_description;
    }

    public void setGoods_description(String goods_description) {
        this.goods_description = goods_description == null ? null : goods_description.trim();
    }

    public String getShop_id() {
        return shop_id;
    }

    public void setShop_id(String shop_id) {
        this.shop_id = shop_id == null ? null : shop_id.trim();
    }

    public Float getNew_price() {
        return new_price;
    }

    public void setNew_price(Float new_price) {
        this.new_price = new_price;
    }

    public Float getOld_price() {
        return old_price;
    }

    public void setOld_price(Float old_price) {
        this.old_price = old_price;
    }

    public String getCreate_time() {
        return create_time;
    }

    public void setCreate_time(String create_time) {
        if (!StringUtils.isEmpty(create_time)) {
            if (create_time.endsWith(".0")) {
                create_time = create_time.substring(0, create_time.length() - 2);
            }
        }
        this.create_time = create_time;
    }
}