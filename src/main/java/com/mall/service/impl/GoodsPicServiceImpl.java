package com.mall.service.impl;

import com.mall.dao.GoodsPicMapper;
import com.mall.po.GoodsPic;
import com.mall.service.GoodsPicService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class GoodsPicServiceImpl implements GoodsPicService{

    @Autowired
    private GoodsPicMapper goodsPicMapper;

    @Override
    public int insert(GoodsPic goodsPic) {
        return goodsPicMapper.insert(goodsPic);
    }
}
