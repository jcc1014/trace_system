package com.mall.dao;

import com.mall.po.Goods;

public interface GoodsMapper {
    int deleteByPrimaryKey(String goods_id);

    int insert(Goods record);

    int insertSelective(Goods record);

    Goods selectByPrimaryKey(String goods_id);

    int updateByPrimaryKeySelective(Goods record);

    int updateByPrimaryKey(Goods record);
}