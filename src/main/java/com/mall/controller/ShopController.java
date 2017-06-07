package com.mall.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

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
		HttpSession session = request.getSession();
		//String shop_id = (String)session.getAttribute("shop_id");
		User user = (User) session.getAttribute("user");//获取当前登录的
		//model.addAttribute("shop_id", shop_id);
		model.addAttribute("member_id", user.getUserid());
		model.addAttribute("member_name",user.getUsername());
		/*if (null != shop_id && !"".equals(shop_id)) {
			//shopService.get
		}*/
		return page;
	}
}
