package com.mall.controller;

import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSON;
import com.mall.po.Goods;
import com.mall.po.Shop;
import com.mall.po.ShopGoods;
import com.mall.service.GoodsService;
import com.mall.service.ShopGoodsService;
import com.mall.service.ShopService;
import com.trace.po.User;

@Controller
@RequestMapping("shopgoods")
public class ShopGoodsController {
	
	@Autowired
	private GoodsService goodsService;
	@Autowired
	private ShopService shopService;
	@Autowired
	private ShopGoodsService shopgoodsService;
	/*
	 * 显示添加进货单页面
	 */
	@RequestMapping("/add.do")
	public String addPage(HttpServletRequest request,HttpSession session,Model model){
		String page = "shopgoods/add";
		session = request.getSession();
		User user = (User) session.getAttribute("user");
		Shop shop = new Shop();
		shop.setMember_id(user.getUserid());
		List<Shop> shoplist = shopService.select(shop);
		model.addAttribute("shoplist", shoplist);
		Goods goods = new Goods();
		List<Goods> goodslist = goodsService.select(goods);
		model.addAttribute("goodlist", goodslist);
		return page;
	}
	/*
	 * 添加进货单
	 */
	@RequestMapping("/addSave.do")
	@ResponseBody
	public String addSave(HttpServletRequest request,HttpSession session,ShopGoods shopgoods){
		Map<String,Object> map = shopgoodsService.addSave(shopgoods);
		return JSON.toJSONString(map);
	}
	/*
	 * 显示进货单列表
	 */
	@RequestMapping("/list.do")
	public String listShopGoods(HttpServletRequest request,HttpSession session,String goods_name,String page,Model model){
		String p = "shopgoods/list";
		if(null!=goods_name&&!"".equals(goods_name)){
			try {
				goods_name = new String(goods_name.getBytes("ISO8859-1"),"UTF-8");
			} catch (UnsupportedEncodingException e) {
				e.printStackTrace();
			}
		}
		session = request.getSession();
		User user = (User) session.getAttribute("user");
		String userType = user.getUsertype();
		Map<String,Object> map = new HashMap<String, Object>();
		if("".equals(page)||null==page){
			page = "1";
		}
		Shop shop = new Shop();
		shop.setMember_id(user.getUserid());
		List<Shop> shoplist = shopService.select(shop);
		List<String> templist = new ArrayList<String>();
		for (int i = 0; i < shoplist.size(); i++) {
			templist.add(shoplist.get(i).getShop_id());
		}
		Map<String,Object> countMap = new HashMap<String,Object>();
		countMap.put("templist", templist);
		countMap.put("goods_name", goods_name);
		int num = shopgoodsService.queryCount(countMap);
		if(num%8==0){
			num = num/8;
		}else{
			num = num/8+1;
		}
		model.addAttribute("num", num);
		model.addAttribute("curr", page);
		map.put("goods_name", goods_name);
		map.put("index", (Integer.parseInt(page)-1)*8);
		map.put("list", templist);
		List<ShopGoods> shopgoodslist = shopgoodsService.selectByShopId(map,userType);
		model.addAttribute("shopidList", templist);
		model.addAttribute("shopgoodslist", shopgoodslist);
		return p;
	}
	/*
	 * 删除进货单
	 */
	@RequestMapping("/delete.do")
	@ResponseBody
	public String del(HttpServletRequest request,HttpSession session,String id){
		Map<String,Object> map = shopgoodsService.deleteByPrimaryKey(id);
		return JSON.toJSONString(map);
	}
}
