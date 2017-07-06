package com.order.service;

import java.util.List;
import java.util.Map;

import com.order.po.TotalInfo;

public interface TotalInfoService {

	int deleteByPrimaryKey(String id);


    int insertSelective(TotalInfo record);

    TotalInfo selectByPrimaryKey(String id);

    int updateByPrimaryKeySelective(TotalInfo record);

    List<Map<String,Object>> query(Map<String,Object> map);
    
    int count(Map<String,Object> map);
    
    List<Map<String,Object>> select(TotalInfo record);
}
