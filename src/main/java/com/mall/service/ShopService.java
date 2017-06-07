package com.mall.service;

import org.springframework.ui.Model;

/**
 * @description 商店service接口类
 * @filename ShopService.java
 * @author Rex
 * @Time 2017-06-07 下午22:04:11
 * @version 1.0
 * @CopyRight(C) 生鲜追溯管理
 */
public interface ShopService {
	Model getShopDetail(Model model,String shop_id);
}
