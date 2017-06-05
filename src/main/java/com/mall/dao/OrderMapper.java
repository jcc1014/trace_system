package com.mall.dao;

import com.mall.po.Order;

public interface OrderMapper {
    int deleteByPrimaryKey(String order_id);

    int insert(Order record);

    int insertSelective(Order record);

    Order selectByPrimaryKey(String order_id);

    int updateByPrimaryKeySelective(Order record);

    int updateByPrimaryKey(Order record);
}