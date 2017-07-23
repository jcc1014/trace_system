package com.order.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.order.po.Sczl;

public interface SczlMapper {
	
    int deleteByPrimaryKey(@Param("id")String id);

    int insertSelective(Sczl record);

    Sczl selectByPrimaryKey(String id);

    int updateByPrimaryKeySelective(Sczl record);
    
    int count(Map<String,Object> map);
    
    List<Sczl> query(Map<String,Object> map);
    
    List<Sczl> select(Map<String,Object> map);

}