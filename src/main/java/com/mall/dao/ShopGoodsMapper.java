package com.mall.dao;

import java.util.List;
import java.util.Map;

import com.mall.po.ShopGoods;

public interface ShopGoodsMapper {
    int deleteByPrimaryKey(String shop_goods_id);

    int insert(ShopGoods record);

    int insertSelective(ShopGoods record);

    ShopGoods selectByPrimaryKey(String shop_goods_id);

    int updateByPrimaryKeySelective(ShopGoods record);

    int updateByPrimaryKey(ShopGoods record);
    
    List<ShopGoods> selectByShopId(Map<String,Object> map);
    
    List<ShopGoods> selectAll(Map<String,Object> map);
    
    int queryCount(Map<String,Object> map);
    
    List<ShopGoods> select(ShopGoods shopGoods);
}