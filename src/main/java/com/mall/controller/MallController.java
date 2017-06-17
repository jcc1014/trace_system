package com.mall.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.mall.po.Banner;
import com.mall.po.Goods;
import com.mall.po.GoodsPic;
import com.mall.service.BannerService;
import com.mall.service.GoodsPicService;
import com.mall.service.GoodsService;

@Controller
@RequestMapping("mall")
public class MallController {
	
	@Autowired
	private BannerService bannerService;
	@Autowired
	private GoodsService goodsService;
	@Autowired
	private GoodsPicService goodsPicService;

	@RequestMapping("mall_index")
	public String index(HttpServletRequest request,Model model){
		Banner banner = new Banner();
		List<Banner> bannerList = bannerService.select(banner);
		model.addAttribute("bannerList", bannerList);
		Goods goods = new Goods();
		List<Goods> goodsList = goodsService.select(goods);
		List<Map<String,Object>> list = new ArrayList<Map<String,Object>>();
		Map<String,Object> map = null;
		for (int i = 0; i < goodsList.size(); i++) {
			map = new HashMap<String, Object>();
			GoodsPic goodsPic = goodsPicService.selectByGoodsId(goodsList.get(i).getGoods_id()).get(0);
			map.put("goodsPic", goodsPic);
			map.put("goods", goodsList.get(i));
			list.add(map);
		}
		model.addAttribute("list", list);
		return "mall/index";
	}
	
	@RequestMapping("goodsDetails")
	public String goodsDetail(HttpServletRequest request,String good_id){
		return null;
	}
	
}
