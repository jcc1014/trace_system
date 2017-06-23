package com.mall.service;

import java.util.List;
import java.util.Map;

import com.mall.po.Shop;
import com.trace.po.User;

/**
 * @description 鍟嗗簵service鎺ュ彛绫� * @filename ShopService.java
 * @author Rex
 * @Time 2017-06-07 涓嬪崍22:04:11
 * @version 1.0
 * @CopyRight(C) 鐢熼矞杩芥函绠＄悊
 */
public interface ShopService {
	Map<String,Object> addSave(Shop shop,User user);
	String editSave(Shop shop,User user);
	int querycount(Map<String,Object> map,String str);
	List<Shop> selectList(Map<String,Object> map,String str);
	Map<String,Object> deleteByPrimaryKey(String id);
	List<Shop> select(Shop shop);
    int insertSelective(Shop record);
    Shop selectByPrimaryKey(String shop_id);
    int updateByPrimaryKeySelective(Shop record);
}
