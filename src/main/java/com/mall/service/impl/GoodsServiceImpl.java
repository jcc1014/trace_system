package com.mall.service.impl;

import java.util.List;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mall.dao.GoodsMapper;
import com.mall.dto.PageParam;
import com.mall.po.Goods;
import com.mall.service.GoodsService;

@Service
@Transactional
public class GoodsServiceImpl implements GoodsService{

	@Autowired
	private GoodsMapper goodsMapper;
	
	@Override
	public int deleteByPrimaryKey(String goods_id) {
		return goodsMapper.deleteByPrimaryKey(goods_id);
	}

	@Override
	public int insert(Goods record) {
		return goodsMapper.insert(record);
	}

	@Override
	public int insertSelective(Goods record) {
		return goodsMapper.insertSelective(record);
	}

	@Override
	public Goods selectByPrimaryKey(String goods_id) {
		return goodsMapper.selectByPrimaryKey(goods_id);
	}

	@Override
	public int updateByPrimaryKeySelective(Goods record) {
		return goodsMapper.updateByPrimaryKeySelective(record);
	}

	@Override
	public int updateByPrimaryKey(Goods record) {
		return goodsMapper.updateByPrimaryKey(record);
	}

    @Override
    public List<Goods> selectByPage(Goods goods, Integer pno, Integer pageSize) {
        if (pno != null && pno != 0 && pageSize != 0 && pageSize != null) {
            pno = (pno - 1) * pageSize;
        }
        return goodsMapper.selectByPage(new PageParam<Goods>(pno, pageSize, goods));
    }

}
