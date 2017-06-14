package com.mall.controller;

import java.io.UnsupportedEncodingException;
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
import com.mall.po.Shop;
import com.mall.service.ShopService;
import com.trace.po.User;

/**
 * @description 商店控制器类
 * @filename ShopController.java
 * @author Rex
 * @Time 2017-06-07 下午19:14:31
 * @version 1.0
 * @CopyRight(C) 生鲜追溯管理
 */
@Controller
@RequestMapping("shop")
public class ShopController {
	@Autowired
	private ShopService shopService;
	
	/*
	 * 显示商家管理新增商家初始页面
	 */
	@RequestMapping("/addshop.do")
	public String addShop(HttpServletRequest request,Model model){
		String page = "shop/addshop";
		return page;
	}
	
	/*
	 * 显示商家列表初始化界面
	 */
	@RequestMapping("/listshop.do")
	public String listShop(HttpServletRequest request,HttpSession session,String shopname,String page,Model model){
		String p = "shop/listshop";
		if(null!=shopname&&!"".equals(shopname)){
			try {
				shopname = new String(shopname.getBytes("ISO8859-1"),"UTF-8");
			} catch (UnsupportedEncodingException e) {
				e.printStackTrace();
			}
		}
		session = request.getSession();
		User user = (User)session.getAttribute("user");
		String usertype = user.getUsertype();
		Map<String,Object> map = new HashMap<String, Object>();
		if("".equals(page)||null==page){
			page = "1";
		}
		map.put("shop_name", shopname);
		map.put("member_id", user.getUserid());
		int num = shopService.querycount(map,usertype);
		if(num%8==0){
			num = num/8;
		}else{
			num = num/8+1;
		}
		model.addAttribute("num", num);
		model.addAttribute("curr", page);
		map.put("index", (Integer.parseInt(page)-1)*8);
		List<Shop> shoplist = shopService.selectList(map,usertype);
		model.addAttribute("shoplist", shoplist);
		return p;
	}
	
	/*
	 * 添加商家
	 */
	@RequestMapping("/addSave.do")
	@ResponseBody
	public String addSave(HttpServletRequest request,HttpSession session,Shop shop){
		session = request.getSession();
		User user = (User) session.getAttribute("user");//获取当前登录的
		Map<String,Object> map = shopService.addSave(shop,user);
		return JSON.toJSONString(map);
	}
	
	/*
	 * 删除商家
	 */
	@RequestMapping("/deleteShop.do")
	@ResponseBody
	public String del(HttpServletRequest request,HttpSession session,String id){
		Map<String,Object> map = shopService.deleteByPrimaryKey(id);
		return JSON.toJSONString(map);
	}
}
