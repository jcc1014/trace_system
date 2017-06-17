package com.mall.service;

import java.util.List;

import com.mall.dto.PageParam;
import com.mall.po.Goods;

public interface GoodsService {

	int deleteByPrimaryKey(String goods_id);

    int insert(Goods record);

    int insertSelective(Goods record);

    Goods selectByPrimaryKey(String goods_id);

    int updateByPrimaryKeySelective(Goods record);

    int updateByPrimaryKey(Goods record);
	
    List<Goods> selectByPage(PageParam<Goods> pageParam);
    
    Long count(Goods goods);

    void insertGoodsAndPic(Goods goods, String[] goods_pic, String[] real_path) throws Exception;
    
    List<Goods> select(Goods goods);
}
