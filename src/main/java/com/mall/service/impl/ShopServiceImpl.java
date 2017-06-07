package com.mall.service.impl;

import javax.transaction.Transactional;

import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import com.mall.service.ShopService;

@Service
@Transactional
public class ShopServiceImpl implements ShopService{

	@Override
	public Model getShopDetail(Model model, String shop_id) {
		
		return null;
	}

}
