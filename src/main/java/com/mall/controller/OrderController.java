package com.mall.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.codec.digest.DigestUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSON;
import com.mall.po.Address;
import com.mall.po.Goods;
import com.mall.po.Order;
import com.mall.po.Shop;
import com.mall.service.AddressService;
import com.mall.service.GoodsService;
import com.mall.service.OrderService;
import com.mall.service.ShopService;
import com.trace.po.User;
import com.trace.service.UserService;
import com.trace.util.DateUtils;

@Controller
@RequestMapping("order")
public class OrderController {
	
	@Autowired
	private OrderService orderService;
	@Autowired
	private AddressService addressService;
	@Autowired
	private GoodsService goodsService;
	@Autowired
	private ShopService shopService;
	@Autowired
	private UserService userService;
	
	@RequestMapping("list")
	public String list(HttpServletRequest request,Model model,Order order,String page){
		String p = "order/list";
		Map<String,Object> map = new HashMap<String, Object>();
		order.setCurrent_status("3");
		map.put("t", order);
		if("".equals(page)||null==page){
			page = "1";
		}
		int num = orderService.count(map);
		if(num%8==0){
			num = num/8;
		}else{
			num = num/8+1;
		}
		model.addAttribute("num", num);
		model.addAttribute("curr", page);
		map.put("index", (Integer.parseInt(page)-1)*8);
		List<Order> orderList = orderService.query(map);
		model.addAttribute("orderList", orderList);
		return p;
	}
	
	/**
	 * 商店登录
	 * @param request
	 * @return
	 */
	@RequestMapping("/login")
	public String login(HttpServletRequest request){
		String page = "order/login";
		return page;
	}
	
	/**
	 * 登录检测
	 * @param request
	 * @param user
	 * @return
	 */
	@RequestMapping("/loginCheck")
	@ResponseBody
	public String loginCheck(HttpServletRequest request,User user){
		String rs = "";
		Map<String,Object> map = new HashMap<String, Object>();
		if(null!=user.getPassword()&&!"".equals(user.getPassword())){
			user.setPassword(DigestUtils.md5Hex(user.getPassword()));
		}
		user = userService.selectByusernameAndpassword(user.getUsername(), user.getPassword());
		if(null==user||!"3".equals(user.getUsertype())){
			map.put("code", "-1");
			map.put("msg", "用户名或者密码不正确！");
			rs = JSON.toJSONString(map);
			return rs;
		}else{
			Shop shop = new Shop();
			shop.setMember_id(user.getUserid());
			List<Shop> shopList = shopService.select(shop);
			if(0==shopList.size()){
				map.put("code", "404");
				map.put("msg", "该用户不是商店管理员");
				rs = JSON.toJSONString(map);
				return rs;
			}else{
				map.put("code", "200");
				map.put("msg", "登录成功！");
				rs = JSON.toJSONString(map);
				request.getSession().setAttribute("user", user);
				request.getSession().setAttribute("shop", shopList.get(0));
			}
		}
		return rs;
	}
	
	/**
	 * 订单管理（历史订单，未完成订单）//按照时间来只显示当天的
	 * @param request
	 * @param date
	 * @param shop_id
	 * @param type
	 * @return
	 */
	@RequestMapping("orderManageList")
	public String orderManage(HttpServletRequest request,Model model,String type,String date){
		String page = "order/manager";
		User user = (User)request.getSession().getAttribute("user");
		if(null==date||"".equals(date)){
			date = DateUtils.getCurrentDate("yyyy-MM-dd");
		}
		if(null==user){
			return "redirect:/order/login.do";
		}
		Shop shop = new Shop();
		Order order = new Order();
		shop.setMember_id(user.getUserid());
		List<Shop> shopList = shopService.select(shop);
		if(0<shopList.size()){
			shop = shopList.get(0);
			order.setShop_id(shop.getShop_id());
		}
		if("0".equals(type)){
			order.setCurrent_status("2");
		}else if("1".equals(type)){
			order.setCurrent_status("3");
		}
		order.setOrdertime(date);
		List<Order> orderList = orderService.select(order);
		List<Map<String,Object>> list = new ArrayList<Map<String,Object>>();
		Map<String,Object> map = null;
		Address address = null;
		Goods goods = null;
		if(0<orderList.size()){
			for (int i = 0; i < orderList.size(); i++) {
				map = new HashMap<String, Object>();
				map.put("order", orderList.get(i));
				address = addressService.selectByPrimaryKey(orderList.get(i).getAddress_id());
				goods = goodsService.selectByPrimaryKey(orderList.get(i).getGoods_id());
				map.put("address", address);
				map.put("goods", goods);
				list.add(map);
			}
		}
		model.addAttribute("list", list);
		return page;
	}

}
