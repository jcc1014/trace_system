package com.mall.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.codec.digest.DigestUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSON;
import com.mall.po.Carry;
import com.mall.po.MallOrder;
import com.mall.po.Shop;
import com.mall.service.AddressService;
import com.mall.service.CarryService;
import com.mall.service.MallOrderService;
import com.mall.service.MemberService;
import com.mall.service.ShopService;
import com.trace.po.User;
import com.trace.service.UserService;
import com.trace.util.DateUtils;
import com.trace.util.ResultUtil;
import com.utils.UUIDFactory;

@Controller
@RequestMapping("carry")
public class CarryController {

	@Autowired
	private CarryService carryService;
	@Autowired
	private UserService userService;
	@Autowired
	private ShopService shopService;
	@Autowired
	private MallOrderService mallOrderService;
	@Autowired
	private AddressService addressService;
	@Autowired
	private MemberService memberService;
	
	@RequestMapping("add")
	public String addPage(HttpServletRequest request){
		return "carry/add";
	}
	
	
	@RequestMapping("addSave")
	@ResponseBody
	public String addSave(HttpServletRequest request,Carry carry){
		Map<String,Object> map = new HashMap<String, Object>();
		try {
			carry.setCarry_id(UUID.randomUUID().toString());
			carry.setDatetime(DateUtils.getCurrentDate());
			int r = carryService.insertSelective(carry);
			if(r==1){
				map.put("code", "200");
				map.put("msg", "保存成功！");
			}else{
				map.put("code", "-1");
				map.put("msg", "保存失败！");
			}
		} catch (Exception e) {
			e.printStackTrace();
			map.put("code", "error");
			map.put("msg", "出错了");
		}
		return JSON.toJSONString(map);
	}
	
	@RequestMapping("list.do")
	public String query(HttpServletRequest request,Model model,String page){
		String p =  "carry/list";
		Map<String,Object> map = new HashMap<String, Object>();
		if("".equals(page)||null==page){
			page = "1";
		}
		int num = carryService.count(map);
		if(num%8==0){
			num = num/8;
		}else{
			num = num/8+1;
		}
		model.addAttribute("num", num);
		model.addAttribute("curr", page);
		map.put("index", (Integer.parseInt(page)-1)*8);
		List<Carry> carryList = carryService.query(map);
		model.addAttribute("carryList", carryList);
		return p;
	}
	
	@RequestMapping("carryList")
	public String carryList(HttpServletRequest request,Model model,Carry carry){
		model.addAttribute("carry", carry);
		String page = "carry/carryList";
		User user = (User)request.getSession().getAttribute("user");
		if("".equals(user.getUsertype())){
			
		}
		List<Carry> carryList = carryService.select(carry);
		model.addAttribute("carryList", carryList);
		return page;
	}
	
	@RequestMapping("shopCarry")
	public String shopCarry(){
		return null;
	}
	
	@RequestMapping("myCarry")
	public String myCarry(){
		return null;
	}
	
	/**
	 * 注册
	 * @return
	 */
	@RequestMapping("register")
	public String register(HttpServletRequest request){
		return "carry/register";
	}
	@RequestMapping("login")
	public String login(HttpServletRequest request){
		return "carry/login";
	}
	@RequestMapping("index")
	public String index(HttpServletRequest request,Model model){
		Shop shop = new Shop();
		List<Shop> shopList = shopService.selectByCarry(shop);
		model.addAttribute("shopList", shopList);
		model.addAttribute("shopJson", JSON.toJSONString(shopList));
		//加载有单子的
		return "carry/index";
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
		if(null==user||!"C".equals(user.getUsertype())){
			map.put("code", "-1");
			map.put("msg", "用户名或者密码不正确！");
			rs = JSON.toJSONString(map);
			return rs;
		}else{
			map.put("code", "200");
			map.put("msg", "登录成功！");
			request.getSession().setAttribute("user", user);
			rs = JSON.toJSONString(map);
		}
		return rs;
	}
	
	@RequestMapping("registerSave")
	@ResponseBody
	public String registerSave(HttpServletRequest request,User user){
		String rs = "";
		user.setUsertype("C");
		user.setUserid(UUIDFactory.getInstance().newUUID());
		user.setPassword(DigestUtils.md5Hex(user.getPassword()));
		user.setUsername(user.getPassword());
		try{
			userService.add(user);
			rs = ResultUtil.resultString(1);
		}catch(Exception e){
			e.printStackTrace();
		}
		return rs;
	}
	
	@RequestMapping("getShopOrder")
	public String getShopOrder(HttpServletRequest request,String id,String s,Model model){
		if(null!=id&&!"".equals(id)){
			MallOrder mallOrder = new MallOrder();
			mallOrder.setShop_id(id);
			mallOrder.setCurrent_status(s);
			List<MallOrder> carryList = mallOrderService.select(mallOrder);
			List<Map<String,Object>> list = new ArrayList<Map<String,Object>>();
			Map<String,Object> map = null;
			for (int i = 0; i < carryList.size(); i++) {
				map = new HashMap<String,Object>();
				map.put("order", carryList.get(i));
				map.put("address", addressService.selectByPrimaryKey(carryList.get(i).getAddress_id()));
				map.put("member", memberService.selectByPrimaryKey(carryList.get(i).getMember_id()));
				list.add(map);
			}
			model.addAttribute("list", list);
			Shop shop = shopService.selectByPrimaryKey(id);
			model.addAttribute("shop", shop);
		}
		return "carry/shopOrder";
	}
	
}
