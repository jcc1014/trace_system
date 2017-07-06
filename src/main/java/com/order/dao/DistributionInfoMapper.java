package com.order.dao;

import java.util.List;
import java.util.Map;

import com.order.po.DistributionInfo;

public interface DistributionInfoMapper {
    int deleteByPrimaryKey(String distribution_id);

    int insert(DistributionInfo record);

    int insertSelective(DistributionInfo record);

    DistributionInfo selectByPrimaryKey(String distribution_id);

    int updateByPrimaryKeySelective(DistributionInfo record);

    int updateByPrimaryKey(DistributionInfo record);
    
    List<Map<String,Object>> query(Map<String,Object> map);
    
    int count(Map<String,Object> map);
    
    List<Map<String,Object>> select(DistributionInfo record);
}