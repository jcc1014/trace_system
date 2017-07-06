package com.order.dao;

import java.util.List;
import java.util.Map;

import com.order.po.PurchaseInfo;

public interface PurchaseInfoMapper {
    int deleteByPrimaryKey(String purchase_id);

    int insertSelective(PurchaseInfo record);

    PurchaseInfo selectByPrimaryKey(String purchase_id);

    int updateByPrimaryKeySelective(PurchaseInfo record);

    int updateByParentid(PurchaseInfo record);
    
    List<Map<String,Object>> query(Map<String,Object> map);
    
    int count(Map<String,Object> map);
    
    List<Map<String,Object>> select(PurchaseInfo record);
}