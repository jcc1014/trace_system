package com.mall.dao;

import com.mall.po.Banner;

public interface BannerMapper {
    int deleteByPrimaryKey(String banner_id);

    int insert(Banner record);

    int insertSelective(Banner record);

    Banner selectByPrimaryKey(String banner_id);

    int updateByPrimaryKeySelective(Banner record);

    int updateByPrimaryKey(Banner record);
}