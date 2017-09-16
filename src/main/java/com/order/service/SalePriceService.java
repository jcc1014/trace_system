package com.order.service;

import java.util.List;
import java.util.Map;

import com.order.po.SalePrice;

public interface SalePriceService {
    int deleteByPrimaryKey(String id);

    int insertSelective(SalePrice record);

    SalePrice selectByPrimaryKey(String id);

    int updateByPrimaryKeySelective(SalePrice record);
    
    List<SalePrice> select(SalePrice salePrice);
    
    List<SalePrice> query(Map<String,Object> map);
    
    int count(Map<String,Object> map);
    
    int deleteByParentid(SalePrice salePrice);
    
    int updateByParentid(SalePrice salePrice);
    
    List<SalePrice> selectMeatPrice(Map<String,Object> map);
    
    SalePrice selectByKindAndGrade(String kind,String grade,String spyb,String datetime);

    
    int insertByRequireAndPurchase(Map<String,Object> map);
}