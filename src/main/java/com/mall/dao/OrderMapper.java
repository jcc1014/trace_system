package com.mall.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.mall.po.Order;

public interface OrderMapper {
    int deleteByPrimaryKey(String order_id);

    int insert(Order record);

    int insertSelective(Order record);

    Order selectByPrimaryKey(@Param("order_id") String order_id);

    int updateByPrimaryKeySelective(Order record);

    int updateByPrimaryKey(Order record);
    
    List<Order> select(Order order);
    
    List<Order> query(Map<String,Object> map);
    
    int count(Map<String,Object> map);
}