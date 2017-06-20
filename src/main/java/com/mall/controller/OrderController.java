package com.mall.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.mall.po.Order;
import com.mall.service.OrderService;

@Controller
@RequestMapping("order")
public class OrderController {
	
	@Autowired
	private OrderService orderService;
	
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

}
