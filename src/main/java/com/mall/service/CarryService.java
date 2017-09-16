package com.mall.service;

import java.util.List;
import java.util.Map;

import com.mall.po.Carry;

public interface CarryService {
	
    int deleteByPrimaryKey(String carry_id);

    int insertSelective(Carry record);

    Carry selectByPrimaryKey(String carry_id);

    int updateByPrimaryKeySelective(Carry record);

    List<Carry> select(Carry carry);
    
    int count(Map<String,Object> map);
    
    List<Carry> query (Map<String,Object> map);
    
    
}