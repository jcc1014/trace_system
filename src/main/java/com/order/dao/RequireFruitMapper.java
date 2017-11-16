package com.order.dao;

import java.util.List;

import com.order.po.RequireFruit;

public interface RequireFruitMapper {
    int deleteByPrimaryKey(String id);

    int insert(RequireFruit record);

    int insertSelective(RequireFruit record);

    RequireFruit selectByPrimaryKey(String id);

    int updateByPrimaryKeySelective(RequireFruit record);

    int updateByPrimaryKey(RequireFruit record);
    
    int updateStatus(RequireFruit record);
    
    int updateByTimeAndBaseId(RequireFruit record);
    
    List<RequireFruit> select(RequireFruit record);
}