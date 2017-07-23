package com.order.service;

import java.util.List;
import java.util.Map;

import com.order.po.Sczl;

public interface SczlService {

    int deleteByPrimaryKey(String id);

    int insertSelective(Sczl record);

    Sczl selectByPrimaryKey(String id);

    int updateByPrimaryKeySelective(Sczl record);
    
    int count(Map<String,Object> map);
    
    List<Sczl> query(Map<String,Object> map);
    
    List<Sczl> select(Map<String,Object> map);

}
