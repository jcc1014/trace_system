package com.mall.dao;

import com.mall.po.GoodsDetail;

public interface GoodsDetailMapper {
    int deleteByPrimaryKey(String goods_detail_id);

    int insert(GoodsDetail record);

    int insertSelective(GoodsDetail record);

    GoodsDetail selectByPrimaryKey(String goods_detail_id);

    int updateByPrimaryKeySelective(GoodsDetail record);

    int updateByPrimaryKey(GoodsDetail record);
}