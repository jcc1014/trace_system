package com.mall.service;

import java.util.List;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mall.dao.ShopGoodsMapper;
import com.mall.po.ShopGoods;

@Service
@Transactional
public class ShopGoodsServiceImpl implements ShopGoodsService {

	@Autowired
	private ShopGoodsMapper shopGoodsMapper;
	
	@Override
	public int deleteByPrimaryKey(String shop_goods_id) {
		return shopGoodsMapper.deleteByPrimaryKey(shop_goods_id);
	}

	@Override
	public int insert(ShopGoods record) {
		return shopGoodsMapper.insert(record);
	}

	@Override
	public int insertSelective(ShopGoods record) {
		return shopGoodsMapper.insertSelective(record);
	}

	@Override
	public ShopGoods selectByPrimaryKey(String shop_goods_id) {
		return shopGoodsMapper.selectByPrimaryKey(shop_goods_id);
	}

	@Override
	public int updateByPrimaryKeySelective(ShopGoods record) {
		return shopGoodsMapper.updateByPrimaryKeySelective(record);
	}

	@Override
	public int updateByPrimaryKey(ShopGoods record) {
		return shopGoodsMapper.updateByPrimaryKey(record);
	}

	@Override
	public List<ShopGoods> select(ShopGoods shopGoods) {
		return shopGoodsMapper.select(shopGoods);
	}

}
