package com.mall.service;

import java.util.List;

import com.mall.po.ShopGoods;

public interface ShopGoodsService {

	int deleteByPrimaryKey(String shop_goods_id);

    int insert(ShopGoods record);

    int insertSelective(ShopGoods record);

    ShopGoods selectByPrimaryKey(String shop_goods_id);

    int updateByPrimaryKeySelective(ShopGoods record);

    int updateByPrimaryKey(ShopGoods record);
    
    List<ShopGoods> select(ShopGoods shopGoods);
}
