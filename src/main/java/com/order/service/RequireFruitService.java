package com.order.service;

import java.util.List;

import com.order.po.RequireFruit;
import com.order.po.RequireMeat;

public interface RequireFruitService {
	
	int deleteByPrimaryKey(String id);

    int insert(RequireFruit record);

    int insertSelective(RequireFruit record);

    RequireFruit selectByPrimaryKey(String id);

    int updateByPrimaryKeySelective(RequireFruit record);

    int updateByPrimaryKey(RequireFruit record);
    
    int updateByTimeAndBaseId(RequireFruit record);
    
    List<RequireFruit> select(RequireFruit record);
    
    int updateStatus(RequireFruit record);

}
