package com.mall.service;

import com.mall.po.GoodsPic;

import java.util.List;

public interface GoodsPicService {

    int insert(GoodsPic goodsPic);

    int deleteByGoodsId(String goods_id);

    List<GoodsPic> selectByGoodsId(String goods_id);
}
