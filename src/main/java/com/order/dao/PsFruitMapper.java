package com.order.dao;

import java.util.List;

import com.order.po.PsFruit;

public interface PsFruitMapper {
    int deleteByPrimaryKey(String id);

    int insert(PsFruit record);

    int insertSelective(PsFruit record);

    PsFruit selectByPrimaryKey(String id);

    int updateByPrimaryKeySelective(PsFruit record);

    int updateByPrimaryKeyWithBLOBs(PsFruit record);

    int updateByPrimaryKey(PsFruit record);
    
    List<PsFruit> select(PsFruit psFruit);
}