package com.mall.service;

import java.util.List;
import java.util.Map;

import com.mall.po.Banner;

public interface BannerService {

	int deleteByPrimaryKey(String banner_id);

    int insert(Banner record);

    int insertSelective(Banner record);

    Banner selectByPrimaryKey(String banner_id);

    int updateByPrimaryKeySelective(Banner record);

    int updateByPrimaryKey(Banner record);
    
    List<Banner> query(Map<String,Object> map);
    
    List<Banner> select(Banner banner);
    
    int count(Map<String,Object> map);
}
