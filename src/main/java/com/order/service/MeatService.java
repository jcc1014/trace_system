package com.order.service;

import java.util.List;

import com.order.po.Meat;

public interface MeatService {
	
	int deleteByPrimaryKey(String id);

    int insert(Meat record);

    int insertSelective(Meat record);

    Meat selectByPrimaryKey(String id);

    int updateByPrimaryKeySelective(Meat record);

    int updateByPrimaryKey(Meat record);
    
    List<Meat> select(Meat meat);

}
