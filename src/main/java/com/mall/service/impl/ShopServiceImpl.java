package com.mall.service.impl;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mall.dao.ShopMapper;
import com.mall.po.Shop;
import com.mall.service.ShopService;
import com.trace.po.User;

@Service
@Transactional
public class ShopServiceImpl implements ShopService{
	
	@Autowired
	private ShopMapper shopmapper;

	@Override
	public Map<String, Object> addSave(Shop shop,User user) {
		Map<String,Object> map = new HashMap<String, Object>();
		try {
			shop.setShop_id(UUID.randomUUID().toString());
			SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");//设置日期格式
			shop.setCreatetime(df.format(new Date()));
			shop.setMember_id(user.getUserid());
			shopmapper.insert(shop);
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
	
}
