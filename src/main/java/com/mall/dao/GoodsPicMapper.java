package com.mall.dao;

import com.mall.po.GoodsPic;

public interface GoodsPicMapper {
    int deleteByPrimaryKey(String pic_id);

    int insert(GoodsPic record);

    int insertSelective(GoodsPic record);

    GoodsPic selectByPrimaryKey(String pic_id);

    int updateByPrimaryKeySelective(GoodsPic record);

    int updateByPrimaryKey(GoodsPic record);
}