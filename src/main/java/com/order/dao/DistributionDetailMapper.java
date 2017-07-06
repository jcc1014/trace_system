package com.order.dao;

import java.util.List;
import java.util.Map;

import com.order.po.DistributionDetail;

public interface DistributionDetailMapper {
    int deleteByPrimaryKey(String id);

    int insert(DistributionDetail record);

    int insertSelective(DistributionDetail record);

    DistributionDetail selectByPrimaryKey(String id);

    int updateByPrimaryKeySelective(DistributionDetail record);

    int updateByPrimaryKey(DistributionDetail record);
    
    List<Map<String,Object>> query(Map<String,Object> map);
    
    int count(Map<String,Object> map);
    
    List<Map<String,Object>> select(DistributionDetail record);
}