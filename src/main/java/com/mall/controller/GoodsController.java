package com.mall.controller;

import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.mall.po.Goods;
import com.mall.service.GoodsService;

@Controller
@RequestMapping("goods")
public class GoodsController {

	@Autowired
	private GoodsService goodsService;
	
	/**
	 * 测试系统前后台连通，以及数据库连通（测试成功）
	 * @param request
	 * @param goods
	 * @return
	 */
	@RequestMapping("add")
	public String addGoods(HttpServletRequest request,Goods goods){
		goods.setGoods_id(UUID.randomUUID().toString());
		goods.setGoods_name("西红柿");
		goods.setGoods_type("tomato");
		goodsService.insertSelective(goods);
		return null;
	}
}
