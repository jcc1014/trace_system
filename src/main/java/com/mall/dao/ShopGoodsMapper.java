package com.mall.dao;

import com.mall.po.ShopGoods;

public interface ShopGoodsMapper {
    int deleteByPrimaryKey(String shop_goods_id);

    int insert(ShopGoods record);

    int insertSelective(ShopGoods record);

    ShopGoods selectByPrimaryKey(String shop_goods_id);

    int updateByPrimaryKeySelective(ShopGoods record);

    int updateByPrimaryKey(ShopGoods record);
}