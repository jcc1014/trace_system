package com.mall.dao;

import com.mall.po.MallOrder;

import java.util.List;

public interface MallOrderMapper {
    int insert(MallOrder mallOrder);
    
    List<MallOrder> select(MallOrder mallOrder);
}