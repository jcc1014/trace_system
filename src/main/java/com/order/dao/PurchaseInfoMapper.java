package com.order.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.order.po.PurchaseInfo;

public interface PurchaseInfoMapper {
    int deleteByPrimaryKey(String purchase_id);

    int deleteByParentId(@Param("parentid")String parentid);
    
    int insertSelective(PurchaseInfo record);

    PurchaseInfo selectByPrimaryKey(String purchase_id);

    int updateByPrimaryKeySelective(PurchaseInfo record);

    int updateByParentid(PurchaseInfo record);
    
    List<Map<String,Object>> query(Map<String,Object> map);
    
    int count(Map<String,Object> map);
    
    List<Map<String,Object>> select(PurchaseInfo record);
    
    List<Map<String,Object>> selectQh(PurchaseInfo record);

    List<Map<String,Object>> getCgAndXq(Map<String,Object> map);
    
    
}