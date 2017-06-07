package com.mall.dao;

import java.util.List;

import com.mall.dto.PageParam;
import com.mall.po.Goods;

public interface GoodsMapper {
    int deleteByPrimaryKey(String goods_id);

    int insert(Goods record);

    int insertSelective(Goods record);

    Goods selectByPrimaryKey(String goods_id);

    int updateByPrimaryKeySelective(Goods record);

    int updateByPrimaryKey(Goods record);
    
    List<Goods> selectByPage(PageParam<Goods> params);
}