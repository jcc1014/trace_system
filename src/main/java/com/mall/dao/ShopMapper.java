package com.mall.dao;

import com.mall.po.Shop;

public interface ShopMapper {
    int deleteByPrimaryKey(String shop_id);

    int insert(Shop record);

    int insertSelective(Shop record);

    Shop selectByPrimaryKey(String shop_id);

    int updateByPrimaryKeySelective(Shop record);

    int updateByPrimaryKey(Shop record);
}