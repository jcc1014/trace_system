package com.mall.dao;

import com.mall.po.GoodsPic;

import java.util.List;

public interface GoodsPicMapper {
    int deleteByPrimaryKey(String pic_id);

    int insert(GoodsPic record);

    int insertSelective(GoodsPic record);

    GoodsPic selectByPrimaryKey(String pic_id);

    int updateByPrimaryKeySelective(GoodsPic record);

    int updateByPrimaryKey(GoodsPic record);

    int deleteByGoodsId(String goods_id);

    List<GoodsPic> selectByGoodsId(String goods_id);
}