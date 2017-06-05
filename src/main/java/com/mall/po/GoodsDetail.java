package com.mall.po;

public class GoodsDetail {
    private String goods_detail_id;

    private String goods_id;

    private String goods_type;

    private Double nowprice;

    private Double oldprice;

    private Integer number;

    public String getGoods_detail_id() {
        return goods_detail_id;
    }

    public void setGoods_detail_id(String goods_detail_id) {
        this.goods_detail_id = goods_detail_id == null ? null : goods_detail_id.trim();
    }

    public String getGoods_id() {
        return goods_id;
    }

    public void setGoods_id(String goods_id) {
        this.goods_id = goods_id == null ? null : goods_id.trim();
    }

    public String getGoods_type() {
        return goods_type;
    }

    public void setGoods_type(String goods_type) {
        this.goods_type = goods_type == null ? null : goods_type.trim();
    }

    public Double getNowprice() {
        return nowprice;
    }

    public void setNowprice(Double nowprice) {
        this.nowprice = nowprice;
    }

    public Double getOldprice() {
        return oldprice;
    }

    public void setOldprice(Double oldprice) {
        this.oldprice = oldprice;
    }

    public Integer getNumber() {
        return number;
    }

    public void setNumber(Integer number) {
        this.number = number;
    }
}