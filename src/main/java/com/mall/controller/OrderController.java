package com.mall.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import com.mall.po.*;
import com.mall.service.*;
import org.apache.commons.codec.digest.DigestUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSON;
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
	@Autowired
	private MallOrderService mallOrderService;
	@Autowired
	private GoodsPicService goodsPicService;
	
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
		/*String page = "order/manager";
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
		return page;*/
		String page = "order/manager";
		User user = (User)request.getSession().getAttribute("user");
		if(null==user){
			return "redirect:/order/login.do";
		}
		if (null == date || "".equals(date)) {
			date = "today";
		}
		String sql = "";
		if (date.equals("today")){
			sql = "AND create_time > '" + DateUtils.getCurrentDate("yyyy-MM-dd") + " 00:00:00'";
		} else {
			sql = "AND create_time < '" + DateUtils.getCurrentDate("yyyy-MM-dd") + " 00:00:00'";
		}
		
		Shop shop = new Shop();
		MallOrder mallOrder = new MallOrder();
		shop.setMember_id(user.getUserid());
		List<Shop> shopList = shopService.select(shop);
		if(0<shopList.size()){
			shop = shopList.get(0);
			mallOrder.setShop_id(shop.getShop_id());
		}
		if("0".equals(type)){
			mallOrder.setCurrent_status("2");
		}else if("1".equals(type)){
			mallOrder.setCurrent_status("3");
		}
		mallOrder.setCreate_time(sql);
		List<MallOrder> mallOrderList = mallOrderService.select(mallOrder);
		List<Map<String,Object>> list = new ArrayList<Map<String,Object>>();
		Map<String,Object> map = null;
		Address address = null;
		Goods goods = null;
		if(0 < mallOrderList.size()){
			for (int i = 0; i < mallOrderList.size(); i++) {
				map = new HashMap<String, Object>();
				map.put("order", mallOrderList.get(i));
				address = addressService.selectByPrimaryKey(mallOrderList.get(i).getAddress_id());
				Order order = new Order();
				order.setMall_order_id(mallOrderList.get(i).getId());
				List<Order> orders = orderService.select(order);
				StringBuilder order_content = new StringBuilder();
				for (int j = 0; j < orders.size(); j ++) {
					goods = goodsService.selectByPrimaryKey(orders.get(j).getGoods_id());
					order_content.append(goods.getGoods_name()).append("*").append(orders.get(j).getNumber()).append(" ");
				}
				map.put("address", address);
				map.put("content", order_content);
				list.add(map);
			}
		}
		model.addAttribute("list", list);
		model.addAttribute("date", date);
		return page;
	}

	/**
	 * @description: 返回订单详情页面
	 * @author liz
	 * @date 2017/7/5 21:55
	 */
	@RequestMapping("order_detail")
	public String orderDetail(String id, ModelMap modelMap) {
		Order order = new Order();
		order.setMall_order_id(id);
		List<Order> orders = orderService.select(order);
		List<Map<String,Object>> list = new ArrayList<>();
		Map<String,Object> map;
		for (int i = 0; i < orders.size(); i ++) {
			map = new HashMap<>();
			map.put("price", orders.get(i).getPrice());
			map.put("number", orders.get(i).getNumber());
			Goods goods = goodsService.selectByPrimaryKey(orders.get(i).getGoods_id());
			map.put("name", goods.getGoods_name());
			List<GoodsPic> pics = goodsPicService.selectByGoodsId(orders.get(i).getGoods_id());
			map.put("pic", pics == null ? "" : pics.size() > 0 ? pics.get(0).getPic_path() : "");
			list.add(map);
		}
		modelMap.put("list", list);
		return "order/order_detail";
	}
	
}
