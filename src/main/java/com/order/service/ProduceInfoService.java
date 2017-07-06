package com.order.service;

import java.util.List;
import java.util.Map;

import com.order.po.ProduceInfo;

public interface ProduceInfoService {

	int deleteByPrimaryKey(String produce_id);

    int insertSelective(ProduceInfo record);

    ProduceInfo selectByPrimaryKey(String produce_id);

    int updateByPrimaryKeySelective(ProduceInfo record);
    
    int updateStatusByParentid(ProduceInfo record);

    List<Map<String,Object>> query(Map<String,Object> map);
    
    int count(Map<String,Object> map);
    
    List<Map<String,Object>> select(ProduceInfo record);
    
    List<Map<String,Object>> selectTodayProduceTotal(String nowDay,String status);
}
