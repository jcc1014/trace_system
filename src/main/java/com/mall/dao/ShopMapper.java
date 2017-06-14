package com.mall.dao;

import java.util.List;
import java.util.Map;

import com.mall.po.Shop;

public interface ShopMapper {
    int deleteByPrimaryKey(String shop_id);

    int insert(Shop record);

    int insertSelective(Shop record);

    Shop selectByPrimaryKey(String shop_id);

    int updateByPrimaryKeySelective(Shop record);

    int updateByPrimaryKey(Shop record);
    
    int queryCount(Map<String,Object> map);
    
    int queryCountAll(Map<String,Object> map);
    
    List<Shop> selectList(Map<String,Object> map);
    
    List<Shop> selectListAll(Map<String,Object> map);
}