package com.order.dao;

import java.util.List;
import java.util.Map;

import com.order.po.RemainPurchase;

public interface RemainPurchaseMapper {
    int deleteByPrimaryKey(String id);

    int insertSelective(RemainPurchase record);

    RemainPurchase selectByPrimaryKey(String id);

    int updateByPrimaryKeySelective(RemainPurchase record);

    int updateByParentid(RemainPurchase record);
    
    List<Map<String,Object>> query(Map<String,Object> map);
    
    int count(Map<String,Object> map);
    
    List<Map<String,Object>> select(RemainPurchase record);

}