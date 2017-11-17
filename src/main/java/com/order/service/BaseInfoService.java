package com.order.service;

import java.util.List;
import java.util.Map;

import com.order.po.BaseInfo;

public interface BaseInfoService {

    int deleteByPrimaryKey(String id);

    int insertSelective(BaseInfo record);

    BaseInfo selectByPrimaryKey(String id);

    int updateByPrimaryKeySelective(BaseInfo record);
    
    int count(Map<String,Object> map);
    
    List<BaseInfo> query(Map<String,Object> map);
    
    List<BaseInfo> select(Map<String,Object> map);
    
    List<Map<String,Object>> remindRequire(Map<String,Object> map);

}
