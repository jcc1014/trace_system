package com.mall.controller;

import java.io.UnsupportedEncodingException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.codec.digest.DigestUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSON;
import com.mall.po.Shop;
import com.mall.service.MemberService;
import com.mall.service.ShopService;
import com.trace.po.User;
import com.trace.service.UserService;
import com.trace.util.ResultUtil;

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
	@Autowired
	private UserService userService;
	@Autowired
	private MemberService memberService;
	
	/*
	 * 显示商家管理新增商家初始页面
	 */
	@RequestMapping("/addshop.do")
	public String addShop(HttpServletRequest request,Model model){
		String page = "shop/addshop";
		return page;
	}
	
	@RequestMapping("/getMyShop.do")
	public String getMyShop(HttpServletRequest request,Model model){
		String page = "shop/myShop";
		User user = (User)request.getSession().getAttribute("user");
		if(null!=user){
			Shop shop = new Shop();
			shop.setMember_id(user.getUserid());
			List<Shop> list = shopService.select(shop);
			model.addAttribute("shop", list.size()>0?list.get(0):"");
		}
		return page;
	}
	
	@RequestMapping("/watchShop.do")
	public String watchShop(HttpServletRequest request,Model model,String shop_id){
		String page = "shop/myShop";
		if(null!=shop_id){
			Shop shop = new Shop();
			shop.setShop_id(shop_id);
			List<Shop> list = shopService.select(shop);
			model.addAttribute("shop", list.size()>0?list.get(0):"");
		}
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
		//map.put("member_id", user.getUserid());
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
		User u = new User();
		u.setUsertype("3");
		List<User> userList = userService.query(u);
		model.addAttribute("shoplist", shoplist);
		model.addAttribute("userList", userList);
		return p;
	}
	
	/*
	 * 添加商家
	 */
	@RequestMapping("/addSave.do")
	@ResponseBody
	public String addSave(HttpServletRequest request,HttpSession session,User user,Shop shop){
		session = request.getSession();
		user.setPassword(DigestUtils.md5Hex("000000"));
		user.setUserid(UUID.randomUUID().toString());
		user.setUsertype("3");
		Map<String,Object> map = shopService.addSave(shop,user);
		return JSON.toJSONString(map);
	}
	
	@RequestMapping("/editSave.do")
	@ResponseBody
	public String editSave(HttpServletRequest request,HttpSession session,User user,Shop shop){
		User u = (User)request.getSession().getAttribute("user");
		user.setUserid(u.getUserid());
		String rs = shopService.editSave(shop,user);
		return rs;
	}
	
	@RequestMapping("/checkUser.do")
	@ResponseBody
	public String checkUser(HttpServletRequest request,User user){
		int r = userService.countUser(user);
		String rs = "";
		if(r>0){
			rs = ResultUtil.resultString(0);
		}
		if(r==0){
			rs = ResultUtil.resultString(1);
		}
		return rs;
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
	
	@RequestMapping("selectAddress")
	public String selectAddress(HttpServletRequest request,Model model){
		String page = "shop/showMap";
		return page;
	}
}
