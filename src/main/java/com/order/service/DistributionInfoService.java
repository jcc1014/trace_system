package com.order.service;

import java.util.List;
import java.util.Map;

import com.order.po.DistributionInfo;

public interface DistributionInfoService {

	int deleteByPrimaryKey(String distribution_id);

    int insertSelective(DistributionInfo record);

    DistributionInfo selectByPrimaryKey(String distribution_id);

    int updateByPrimaryKeySelective(DistributionInfo record);
    
    int updateSignName(DistributionInfo record);

    List<Map<String,Object>> query(Map<String,Object> map);
    
    int count(Map<String,Object> map);
    
    List<Map<String,Object>> select(DistributionInfo record);
    
    List<Map<String,Object>> selectSyncData(DistributionInfo record);
    
    List<Map<String,Object>> selectPurchaseed(DistributionInfo record);
    
    List<Map<String,Object>> getDeliverData(Map<String,Object> map);
}
