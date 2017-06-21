package com.mall.service.impl;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mall.dao.ShopGoodsMapper;
import com.mall.po.ShopGoods;
import com.mall.service.ShopGoodsService;

@Service
@Transactional
public class ShopGoodsServiceImpl implements ShopGoodsService{
	@Autowired
	private ShopGoodsMapper shopgoodsMapper;
	
	@Override
	public Map<String, Object> addSave(ShopGoods shopgoods) {
		Map<String,Object> map = new HashMap<String, Object>();
		try {
			shopgoods.setShop_goods_id(UUID.randomUUID().toString());
			SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");//设置日期格式
			shopgoods.setCreatetime(df.format(new Date()));
			shopgoodsMapper.insert(shopgoods);
			map.put("code", "200");
			map.put("msg", "新增成功");
		} catch (Exception e) {
			e.printStackTrace();
			map.put("code", -1);
			map.put("msg", "新增失败！");
			throw new RuntimeException();
		}
		return map;
	}

	@Override
	public List<ShopGoods> selectByShopId(Map<String,Object> map,String userType) {
		if ("0".equals(userType)) {
			return shopgoodsMapper.selectAll(map);
		}else{
			return shopgoodsMapper.selectByShopId(map);
		}
	}

	@Override
	public int queryCount(Map<String,Object> map) {
		return shopgoodsMapper.queryCount(map);
	}

	@Override
	public Map<String, Object> deleteByPrimaryKey(String id) {
		Map<String,Object> map = new HashMap<String, Object>();
		try {
			shopgoodsMapper.deleteByPrimaryKey(id);
			map.put("code", "200");
			map.put("msg", "删除成功！");
			
		} catch (Exception e) {
			e.printStackTrace();
			map.put("code", -1);
			map.put("msg", "删除失败！");
			throw new RuntimeException();
		}
		return map;
	}
	
	@Override
	public List<ShopGoods> select(ShopGoods shopGoods) {
		return shopgoodsMapper.select(shopGoods);
	}
}
