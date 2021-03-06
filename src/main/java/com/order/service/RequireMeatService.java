package com.order.service;

import java.util.List;

import com.order.po.RequireMeat;

public interface RequireMeatService {
	
	int deleteByPrimaryKey(String id);

    int insert(RequireMeat record);

    int insertSelective(RequireMeat record);

    RequireMeat selectByPrimaryKey(String id);

    int updateByPrimaryKeySelective(RequireMeat record);

    int updateByPrimaryKey(RequireMeat record);
    
    int updateByTimeAndBaseId(RequireMeat record);
    
    List<RequireMeat> select(RequireMeat record);
    
    int updateStatus(RequireMeat record);

}
