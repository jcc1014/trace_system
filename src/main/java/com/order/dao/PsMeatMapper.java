package com.order.dao;

import java.util.List;

import com.order.po.PsMeat;

public interface PsMeatMapper {
    int deleteByPrimaryKey(String id);

    int insert(PsMeat record);

    int insertSelective(PsMeat record);

    PsMeat selectByPrimaryKey(String id);

    int updateByPrimaryKeySelective(PsMeat record);

    int updateByPrimaryKeyWithBLOBs(PsMeat record);

    int updateByPrimaryKey(PsMeat record);
    
    List<PsMeat> select(PsMeat psMeat);
}