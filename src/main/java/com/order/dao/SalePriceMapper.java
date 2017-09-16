package com.order.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.order.po.SalePrice;

public interface SalePriceMapper {
    int deleteByPrimaryKey(String id);

    int insertSelective(SalePrice record);

    SalePrice selectByPrimaryKey(String id);
    
    SalePrice selectByKindAndGrade(@Param("kind")String kind,@Param("grade")String grade,
    		@Param("spyb")String spyb,@Param("datetime")String datetime);

    int updateByPrimaryKeySelective(SalePrice record);
    
    List<SalePrice> select(SalePrice salePrice);
    
    List<SalePrice> query(Map<String,Object> map);
    
    int count(Map<String,Object> map);
    
    int deleteByParentid(SalePrice salePrice);
    
    int updateByParentid(SalePrice salePrice);
    
    int insertByRequireAndPurchase(Map<String,Object> map);
    
    List<SalePrice> selectMeatPrice(Map<String,Object> map);
}