package com.mall.service;

import java.util.List;
import java.util.Map;

import com.mall.po.Order;

public interface OrderService {

	int deleteByPrimaryKey(String order_id);

    int insert(Order record);

    int insertSelective(Order record);

    Order selectByPrimaryKey(String order_id);

    int updateByPrimaryKeySelective(Order record);

    int updateByPrimaryKey(Order record);
    
    List<Order> select(Order order);
    
    String deleteOrder(String[] order_idArr);
    
    List<Order> query(Map<String,Object> map);
    
    int count(Map<String,Object> map);
}
