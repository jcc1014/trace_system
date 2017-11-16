package com.order.service;

import java.util.List;

import com.order.po.Fruit;

public interface FruitService {
	
	int deleteByPrimaryKey(String id);

    int insert(Fruit record);

    int insertSelective(Fruit record);

    Fruit selectByPrimaryKey(String id);

    int updateByPrimaryKeySelective(Fruit record);

    int updateByPrimaryKey(Fruit record);
    
    List<Fruit> select(Fruit fruit);

}
