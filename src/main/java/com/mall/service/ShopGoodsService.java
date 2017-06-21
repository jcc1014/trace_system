package com.mall.service;

import java.util.List;
import java.util.Map;

import com.mall.po.ShopGoods;

public interface ShopGoodsService {
	Map<String,Object> addSave(ShopGoods shopgoods);
	List<ShopGoods> selectByShopId(Map<String,Object> map,String userType);
	int queryCount(Map<String,Object> map);
	Map<String,Object> deleteByPrimaryKey(String id);
	List<ShopGoods> select(ShopGoods shopGoods);
}
