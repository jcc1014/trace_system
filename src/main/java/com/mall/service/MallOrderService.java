package com.mall.service;

import com.mall.po.MallOrder;
import com.mall.po.Order;

import java.util.List;
import java.util.Map;

public interface MallOrderService {
    int insert(MallOrder mallOrder);
    
    List<MallOrder> select(MallOrder mallOrder);
}
