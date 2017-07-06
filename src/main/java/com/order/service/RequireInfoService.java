package com.order.service;

import java.util.List;
import java.util.Map;

import com.order.po.RequireInfo;

public interface RequireInfoService {
	
	int deleteByPrimaryKey(String id);

    int insertSelective(RequireInfo record);

    RequireInfo selectByPrimaryKey(String id);

    int updateByPrimaryKeySelective(RequireInfo record);

    List<Map<String,Object>> query(Map<String,Object> map);
    
    int count(Map<String,Object> map);
    
    List<Map<String,Object>> select(RequireInfo record);

    int updateByParentid(RequireInfo record);
}
