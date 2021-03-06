package com.mall.controller;

import java.io.File;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.mall.po.*;
import com.mall.service.*;
import com.mall.utils.MD5Util;

import org.apache.commons.codec.digest.DigestUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSON;
import com.mall.dto.Result;
import com.mall.enums.ResultEnum;
import com.trace.po.User;
import com.trace.service.UserService;
import com.trace.util.DateUtils;
import com.trace.util.ResultUtil;
import com.utils.CommonUtils;

@Controller
@RequestMapping("mall")
public class MallController {
	
	@Autowired
	private BannerService bannerService;
	@Autowired
	private GoodsService goodsService;
	@Autowired
	private GoodsPicService goodsPicService;
	@Autowired
	private ShopService shopService;
	@Autowired
	private MemberService memberService;
	@Autowired
	private OrderService orderService;
	@Autowired
	private UserService userService;
	@Autowired
	private ShopGoodsService shopGoodsService;
	@Autowired
	private AddressService addressService;
	@Autowired
	private MallOrderService mallOrderService;
	

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
	
	@RequestMapping("addCart")
	@ResponseBody
	public String addCart(HttpServletRequest request,Order order){
		String rs = null;
		Member member = (Member)request.getSession().getAttribute("member");
		if(null!=member){
			order.setMember_id(member.getMember());
			order.setOrder_id(UUID.randomUUID().toString());
			order.setCreatetime(DateUtils.getCurrentDate());
			order.setCurrent_status("0");
			try {
				int r = orderService.insertSelective(order);
				rs = ResultUtil.resultString(r);
			} catch (Exception e) {
				e.printStackTrace();
				rs = ResultUtil.resultString(0);
			}
		}
		return rs;
	}
	
	@RequestMapping("getCartList")
	public String getCartList(HttpServletRequest request,Model model){
		String page = "mall/cartList";
		double sum_amount = 0.0;
		Member member = (Member)request.getSession().getAttribute("member");
		if(null==member){
			page = "mall/login";
			return page;
		}
		Order order = new Order();
		order.setCurrent_status("0");
		order.setMember_id(member.getMember());
		List<Order> orderList = orderService.select(order);
		if(null!=orderList&&0<orderList.size()){
			List<Map<String,Object>> list = new ArrayList<Map<String,Object>>();
			Map<String, Object> map = null;
			Goods goods = null;
			GoodsPic goodsPic = null;
			for (int i = 0; i < orderList.size(); i++) {
				goods = goodsService.selectByPrimaryKey(orderList.get(i).getGoods_id());
				goodsPic = goodsPicService.selectByGoodsId(orderList.get(i).getGoods_id()).get(0);
				map = new HashMap<String, Object>();
				map.put("goods", goods);
				map.put("goodsPic", goodsPic);
				map.put("order", orderList.get(i));
				list.add(map);
				sum_amount += orderList.get(i).getAmount();
			}
			model.addAttribute("list", list);
			model.addAttribute("sum_amount", sum_amount);
		}
		return page;
	}
	
	/**
	 * 商品详情
	 * @param request
	 * @param model
	 * @param goods_id
	 * @return
	 */
	@RequestMapping("goodsDetails")
	public String goodsDetail(HttpServletRequest request,Model model,String goods_id){
		String page = "mall/goodsDetails";
		//String page = "mall/map";
		Goods goods = goodsService.selectByPrimaryKey(goods_id);
		List<GoodsPic> goodsPicList = goodsPicService.selectByGoodsId(goods_id);
		model.addAttribute("goods", goods);
		model.addAttribute("goodsPicList", goodsPicList);
		model.addAttribute("goodsPic", goodsPicList.get(0));
		return page;
	}
	
	/**
	 * 测试地图
	 * @param request
	 * @param model
	 * @param goods_id
	 * @return
	 */
	@RequestMapping("map")
	public String map(HttpServletRequest request,Model model,String goods_id){
		String page = "mall/map";
		return page;
	}
	
	/**
	 * 获取商店
	 * @param request
	 * @param coordinate
	 * @return
	 */
	@RequestMapping("getShop")
	@ResponseBody
	public String getShopList(HttpServletRequest request,String coordinate){
		String rs = "";
		Shop shop = new Shop();
		List<Shop> shopList = shopService.select(shop);
		if(null!=shopList&&0<shopList.size()){
			List<Map<String,Object>> list = new ArrayList<Map<String,Object>>();
			Member member = null;
			Map<String,Object> map = null;
			for (int i = 0; i < shopList.size(); i++) {
				map = new HashMap<String, Object>();
				member = memberService.selectByPrimaryKey(shopList.get(i).getMember_id());
				map.put("member", member);
				map.put("shop", shopList.get(i));
				list.add(map);
			}
			rs = JSON.toJSONString(list);
		}
		return rs;
	}
	
	/**
	 * 会员页面
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping("user")
	public String user(HttpServletRequest request,Model model){
		String page = "mall/user";
		Member member = (Member)request.getSession().getAttribute("member");
		if(null==member){
			page = "mall/login";
		}
		return page;
	}
	
	/**
	 * 登录页面
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping("login")
	public String login(HttpServletRequest request,Model model){
		String page = "mall/login";
		Cookie[] cookies = request.getCookies();
		String username = null;
		String password = null;
		if(null!=cookies&&0<cookies.length){ //从cookie取值
			for (int i = 0; i < cookies.length; i++) {
				if("username".equals(cookies[i].getName())){
					username = cookies[i].getValue();
				}else if("password".equals(cookies[i].getName())){
					password = cookies[i].getValue();
				}
			}
		}
		try {
			if(null!=username){
				model.addAttribute("username", URLDecoder.decode(username,"utf-8"));
			}
			else{
				model.addAttribute("username", null);
			}
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		model.addAttribute("password", password);
		return page;
	}
	
	/**
	 * 登录检查
	 * @param request
	 * @param model
	 * @param username
	 * @param password
	 * @return
	 */
	@RequestMapping("loginCheck")
	@ResponseBody
	public String loginCheck(HttpServletRequest request,HttpServletResponse response,Model model,String username,String password){
		String rs = "";
		User user = userService.selectByusernameAndpassword(username, DigestUtils.md5Hex(password));
		if(null!=user){
			Member member = memberService.selectByPrimaryKey(user.getUserid());
			request.getSession().setAttribute("member", member);
			request.getSession().setAttribute("user", user);
			CommonUtils.rememberPass(username, password, response);
			rs = ResultUtil.resultString(1);
		}else{
			rs = ResultUtil.resultString(0);
		}
		request.getSession().setAttribute("user", user);
		return rs;
	}
	
	/**
	 * 注册
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping("register")
	public String register(HttpServletRequest request,Model model){
		String page = "mall/register";
		return page;
	}
	
	/**
	 * 检查手机号
	 * @param request
	 * @param phone
	 * @return
	 */
	@RequestMapping(value="checkPhone")
	@ResponseBody
	public String register(HttpServletRequest request,String phone){
		String rs = "0";
		User user = new User();
		user.setUsername(phone);
		List<User> list = userService.query(user);
		if(null!=list&&0<list.size()){
			rs = "1";
		}
		return rs;
	}
	
	/**
	 * 保存
	 * @param request
	 * @param user
	 * @param member
	 * @return
	 */
	@RequestMapping(value="addSave",produces = "application/json;charset=utf-8")
	@ResponseBody
	public String addSave(HttpServletRequest request,HttpServletResponse response,User user,Member member){
		String rs = memberService.addMember(user, member);
		return rs;
	}
	
	/**
	 * 商店列表
	 * @param request
	 * @param model
	 * @param shop
	 * @return
	 */
	@RequestMapping("shopList")
	public String shopList(HttpServletRequest request,Model model,Shop shop){
		String page = "mall/shopList";
		List<Shop> list = shopService.select(shop);
		model.addAttribute("shopList", list);
		return page;
	}
	
	
	@RequestMapping("shopGoodsList")
	public String shopGoodsList(HttpServletRequest request,Model model,String shop_id){
		String page = "mall/shopGoodsList";
		Shop shop =shopService.selectByPrimaryKey(shop_id);
		model.addAttribute("shop", shop);
		ShopGoods shopGoods = new ShopGoods();
		shopGoods.setShop_id(shop_id);
		List<ShopGoods> shopGoodsList = shopGoodsService.select(shopGoods);
		List<Map<String,Object>> list = new ArrayList<Map<String,Object>>();
		Map<String,Object> map = null;
		Goods goods = null;
		GoodsPic goodsPic = null;
		if(null!=shopGoodsList&&0<shopGoodsList.size()){
			for (int i = 0; i < shopGoodsList.size(); i++) {
				map = new HashMap<String, Object>();
				goods = goodsService.selectByPrimaryKey(shopGoodsList.get(i).getGoods_id());
				goodsPic = goodsPicService.selectByGoodsId(shopGoodsList.get(i).getGoods_id()).get(0);
				map.put("goods", goods);
				map.put("goodsPic", goodsPic);
				map.put("shopGoods", shopGoodsList.get(i));
				list.add(map);
			}
			model.addAttribute("list", list);
		}
		return page;
	}
	
	@RequestMapping("delCart")
	@ResponseBody
	public String delCart(HttpServletRequest request,String order_ids){
		String rs = "";
		if(""!=order_ids){
			String[] order_idArr = order_ids.split(";");
			rs = orderService.deleteOrder(order_idArr);
		}
		return rs;
	}
	
	@RequestMapping("selectAddress")
	public String selectAddress(HttpServletRequest request,Model model,String str){
		String page = "mall/selectAddress";
		Member member = (Member)request.getSession().getAttribute("member");
		Address address = new Address();
		address.setMember_id(member.getMember());
		List<Address> list = addressService.select(address);	
		model.addAttribute("addressList", list);
		request.getSession().setAttribute("goods_orders", str);
		return page;
	}
	
	@RequestMapping("selectShop")
	public String selectShop(HttpServletRequest request,Model model,String address_id){
		String page = "mall/getShop";
		Shop shop = new Shop();
		List<Shop> shopList = shopService.select(shop);
		request.getSession().setAttribute("address_id", address_id);
		model.addAttribute("shopList", shopList);
		model.addAttribute("shopJson", JSON.toJSONString(shopList));
		return page;
	}
	
	@RequestMapping("getMapShop")
	@ResponseBody
	public String getMapShop(HttpServletRequest request){
		String rs = "";
		Shop shop = new Shop();
		List<Shop> shopList = shopService.select(shop);
		rs = JSON.toJSONString(shopList);
		return rs;
	}
	

	/**
	 * @description 收货地址列表页
	 * @author liz
	 * @date 2017/6/20 15:08
	 */
	@RequestMapping("address_list")
    public String listAddress(HttpServletRequest request, ModelMap modelMap) {
        Address address = new Address();
        Member member = (Member)request.getSession().getAttribute("member");
        address.setMember_id(member.getMember());
	    List<Address> list = addressService.select(address);
        modelMap.put("list", list);
        return "mall/address_list";
    }

	/**
	 * @description 修改收货地址页
	 * @author liz
	 * @date 2017/6/20 15:15
	 */
	@RequestMapping("address_edit")
    public String editAddress(String address_id, ModelMap modelMap) {
	    if (!StringUtils.isEmpty(address_id)) {
            Address address = addressService.selectByPrimaryKey(address_id);
            modelMap.put("ar", address);
        }
        return "mall/address_edit";
    }

    /**
     * @description 删除收货地址
     * @author liz
     * @date 2017/6/20 16:57
     */
    @ResponseBody
    @RequestMapping(value = "address_delete", produces = "application/json;charset=utf-8")
    public Result<String> deleteAddress(String address_id) {
	    try {
            int row = addressService.deleteByPrimaryKey(address_id);
            if (row > 0) {
                return new Result<>(ResultEnum.SUCCESS);
            } else {
                return new Result<>(ResultEnum.FAILURE);
            }
        } catch (Exception e) {
            e.printStackTrace();
            return new Result<>(ResultEnum.FAILURE);
        }
    }

    /**
     * @description 保存收货地址
     * @author liz
     * @date 2017/6/20 16:09
     */
    @ResponseBody
    @RequestMapping(value = "address_save", produces = "application/json;charset=utf-8")
    public Result<String> saveAddress(HttpServletRequest request, Address address) {
        Member member = (Member)request.getSession().getAttribute("member");
        Address a2 = new Address();
        a2.setMember_id(member.getMember());
        List<Address> list = addressService.select(a2);
        if (list == null || list.size() == 0) {
            address.setStatus("1");
        }
        address.setMember_id(member.getMember());
        Result<String> result = null;
        try {
            if (StringUtils.isEmpty(address.getAddress_id())) {
                String id = UUID.randomUUID().toString();
                address.setAddress_id(id);
                int row = addressService.insert(address);
                if (row > 0) {
                    result = new Result<>(ResultEnum.SUCCESS);
                } else {
                    result = new Result<>(ResultEnum.FAILURE);
                }
            } else {
                int row = addressService.updateByPrimaryKey(address);
				if (row > 0) {
					result = new Result<>(ResultEnum.SUCCESS);
				} else {
					result = new Result<>(ResultEnum.FAILURE);
				}
            }
        } catch (Exception e) {
            e.printStackTrace();
            result = new Result<>(ResultEnum.FAILURE);
        }
        return result;
    }
    
    /**
     * @description: 更新默认地址
     * @author liz
     * @date 2017/6/20 21:43
     */
    @ResponseBody
    @RequestMapping(value = "address_default_update", produces = "application/json;charset=utf-8")
	public Result<String> updateDefaultAddress(String new_id, String old_id) {
	    try {
	    	addressService.updateDefaultAddress(new_id, old_id);
	    	return new Result<>(ResultEnum.SUCCESS);
	    } catch (Exception e) {
		    e.printStackTrace();
		    return new Result<>(ResultEnum.FAILURE);
	    }
    }
    
    @RequestMapping("checkOrder")
    @ResponseBody
    public String checkOrder(HttpServletRequest request,String shop_id){
    	Map<String,Object> map = new HashMap<String, Object>();
    	String goods_orders = (String)request.getSession().getAttribute("goods_orders");
    	if(null!=goods_orders&&!"".equals(goods_orders)){
    		List<Order> orderList = new ArrayList<Order>();
    		Order order = null;
    		String[] goodsArr = goods_orders.split(";");
    		for (int i = 0; i < goodsArr.length; i++) {
				order = orderService.selectByPrimaryKey(goodsArr[i]);
				orderList.add(order);
			}
    		ShopGoods shopGoods = null;
    		List<ShopGoods> shopGoodsList = null;
    		boolean f = false;
    		boolean f2 = true;
    		String msg = "您需要的：";
    		String enoughOrder = "";
    		if(0<orderList.size()){
    			for (int i = 0; i < orderList.size(); i++) {
					shopGoods = new ShopGoods();
					shopGoods.setGoods_id(orderList.get(i).getGoods_id());
					shopGoods.setCreatetime(DateUtils.getCurrentDate("yyyy-MM-dd"));
					shopGoods.setShop_id(shop_id);
					shopGoodsList  = shopGoodsService.select(shopGoods);
					if(null!=shopGoodsList&&0<shopGoodsList.size()){
						shopGoods = shopGoodsList.get(0);
					}
					if(shopGoods.getGoods_remain()>orderList.get(i).getNumber()){
						f = true;
						msg += shopGoods.getGoods_name()+"("+orderList.get(i).getNumber()+")数量充足！</br>";
						enoughOrder += orderList.get(i).getOrder_id()+";";
					}else{
						f2 = false; 
						msg += shopGoods.getGoods_name()+"("+orderList.get(i).getNumber()+")数量不足！</br>";
					}
				}
    			if(f2==true){
    				map.put("code", "200");
    				map.put("msg", msg);
    			}else if(f==true&&f2==false){
    				map.put("code", "1");
    				map.put("msg", msg);
    				if(null!=enoughOrder){
    					request.getSession().setAttribute("enoughOrder",
    							enoughOrder.substring(0, enoughOrder.length()-1));
    				}
    			}else{
    				map.put("code", "-1");
    				map.put("msg", "您需要的商品数量不足，请换一家店铺购买！");
    			}
    		}
    	}else{
    		map.put("code", "404");
    	}
    	return JSON.toJSONString(map);
    }
    
    @RequestMapping("payOrder")
    public String payOrder(HttpServletRequest request,Model model,String type,String shop_id){
    	String page = "mall/payOrder";
    	String orderStr = "";
    	double sum_amount = 0.0;
    	String address_id = (String)request.getSession().getAttribute("address_id");
    	Address address = addressService.selectByPrimaryKey(address_id);
    	if("1".equals(type)){
    		orderStr = (String)request.getSession().getAttribute("goods_orders");
    	}else if("2".equals(type)){
    		orderStr = (String)request.getSession().getAttribute("enoughOrder");
    	}
    	if(!"".equals(orderStr)){
    		String[] orderArr = orderStr.split(";");
    		if(null!=orderArr){
    			List<Order> orderList = new ArrayList<Order>();
    			Order order = null;
    			for (int i = 0; i < orderArr.length; i++) {
    				order = orderService.selectByPrimaryKey(orderArr[i]);
    				//order.setCurrent_status("1");
    				order.setAddress_id(address_id);
    				order.setShop_id(shop_id);
    				orderList.add(order);
    				orderService.updateByPrimaryKeySelective(order);
    			}
    			if(null!=orderList&&0<orderList.size()){
    				List<Map<String,Object>> list = new ArrayList<Map<String,Object>>();
    				Map<String, Object> map = null;
    				Goods goods = null;
    				GoodsPic goodsPic = null;
    				for (int i = 0; i < orderList.size(); i++) {
    					goods = goodsService.selectByPrimaryKey(orderList.get(i).getGoods_id());
    					goodsPic = goodsPicService.selectByGoodsId(orderList.get(i).getGoods_id()).get(0);
    					map = new HashMap<String, Object>();
    					map.put("goods", goods);
    					map.put("goodsPic", goodsPic);
    					map.put("order", orderList.get(i));
    					list.add(map);
    					sum_amount += orderList.get(i).getAmount();
    				}
    				model.addAttribute("list", list);
    				model.addAttribute("sum_amount", sum_amount);
    				model.addAttribute("order_address",address);
    				model.addAttribute("type",type);
    				model.addAttribute("shop_id",shop_id);
    			}
    		}
    	}
    	return page;
    }
    
    @RequestMapping("pay")
    @ResponseBody
    public String pay(HttpServletRequest request,String type,String orderType,String shop_id){
    	String orderStr = "";
    	Map<String,Object> map = new HashMap<String, Object>();
    	if("1".equals(type)){
    		orderStr = (String)request.getSession().getAttribute("goods_orders");
    	}else if("2".equals(type)){
    		orderStr = (String)request.getSession().getAttribute("enoughOrder");
    	}
    	if(!"".equals(orderStr)){
    		String[] orderArr = orderStr.split(";");
    		Order order = null;
    		String mall_order_id = UUID.randomUUID().toString();
    		// 添加总订单
		    Member member = (Member) request.getSession().getAttribute("member");
		    MallOrder mallOrder = new MallOrder();
		    mallOrder.setId(mall_order_id);
		    mallOrder.setCreate_time(DateUtils.getCurrentDate());
		    mallOrder.setCurrent_status("2");
		    mallOrder.setMember_id(member.getMember());
		    mallOrder.setOrder_number("DD" + DateUtils.getCurrentDate("yyyyMMddHHmmss"));
		    float price = 0;
    		for (int i = 0; i < orderArr.length; i++) {
				order = new Order();
				order.setOrder_id(orderArr[i]);
				order.setOrdertime(DateUtils.getCurrentDate());
				order.setType(orderType);
				order.setCurrent_status("2");
				order.setOrder_number("DD"+DateUtils.getCurrentDate("yyyyMMddHHmmss"));
			    order.setMall_order_id(mall_order_id);
			    orderService.updateByPrimaryKeySelective(order);
			    // 组装总订单
			    order = orderService.selectByPrimaryKey(orderArr[i]);
			    mallOrder.setAddress_id(order.getAddress_id());
			    mallOrder.setShop_id(order.getShop_id());
			    price += order.getPrice() * order.getNumber();
		    }
		    mallOrder.setPrice(price);
		    mallOrder.setFinal_price(price);
    		mallOrderService.insert(mallOrder);
		    map.put("msg","支付成功！");
    	}else{
    		map.put("msg","支付失败！");
    	}
    	return JSON.toJSONString(map);
    }
    @RequestMapping("myOrder")
    public String myOrder(HttpServletRequest request,Model model,String status){
    	String page = "mall/myOrder";
    	Member member = (Member)request.getSession().getAttribute("member");
    	if(null==member){
    		page = "mall/login";
    		return page;
    	}
    	Order order = new Order();
    	order.setCurrent_status(status);
    	order.setMember_id(member.getMember());
    	List<Order> orderList = orderService.select(order);
    	List<Map<String,Object>> list = new ArrayList<Map<String,Object>>();
    	Map<String,Object> map = null;
    	Goods goods = null;
    	if(0<orderList.size()){
    		for (int i = 0; i < orderList.size(); i++) {
				map = new HashMap<String, Object>();
				map.put("order", orderList.get(i));
				goods = goodsService.selectByPrimaryKey(orderList.get(i).getGoods_id());
				map.put("goods", goods);
				list.add(map);
			}
    	}
    	model.addAttribute("list", list);
    	model.addAttribute("status", status);
    	return page;
    }
	
	/**
	 * @description: 打开个人设置
	 * @author liz
	 * @date 2017/6/25 16:29
	 */
	@RequestMapping("personal_setting")
	public String personalCenter() {
		return "mall/personal_setting";
	}
	
	/**
	 * @description: 打开修改基本信息页
	 * @author liz
	 * @date 2017/6/25 16:54
	 */
	@RequestMapping("personal_setting_basic")
	public String personalSettingBasic(HttpServletRequest request, ModelMap modelMap) {
		Member member = (Member)request.getSession().getAttribute("member");
		modelMap.put("username", member.getName());
		modelMap.put("member", member);
		return "mall/personal_setting_basic";
	}
	
	/**
	 * @description: 保存修改的基本信息
	 * @author liz
	 * @date 2017/6/25 17:33
	 */
	@ResponseBody
	@RequestMapping(value = "personal_setting_basic_save", produces = "application/json;charset=utf-8")
	public Result<String> personalSettingBasicSave(HttpServletRequest request, String name,String sex,String photo) {
		try {
			Member member = (Member)request.getSession().getAttribute("member");
			member.setName(name);
			member.setSex(sex);
			if(null!=photo&&!"".equals(photo)){
				member.setPhoto(photo);
			}
			memberService.updateByPrimaryKey(member);
			request.getSession().setAttribute("member", member);
			return new Result<>(ResultEnum.SUCCESS);
		} catch (Exception e) {
			e.printStackTrace();
			return new Result<>(ResultEnum.FAILURE);
		}
	}
	
	/**
	 * @description: 打开修改密码页1
	 * @author liz
	 * @date 2017/6/25 16:55
	 */
	@RequestMapping("personal_setting_password_step1")
	public String personalSettingPasswordStep1() {
		return "mall/personal_setting_password_step1";
	}
	
	/**
	 * @description: 修改密码时校验原始密码
	 * @author liz
	 * @date 2017/6/25 18:11
	 */
	@ResponseBody
	@RequestMapping(value = "personal_setting_password_check", produces = "application/json;charset=utf-8")
	public Result<String> personalSettingPasswordCheck(HttpServletRequest request, String oldPassword) {
		User user = (User) request.getSession().getAttribute("user");
		if (!StringUtils.isEmpty(oldPassword)) {
			if (DigestUtils.md5Hex(oldPassword).equals(user.getPassword())) {
				return new Result<>(ResultEnum.SUCCESS, MD5Util.getMd5(oldPassword));
			}
		}
		return new Result<>(ResultEnum.FAILURE);
	}
	
	/**
	 * @description: 打开修改密码页2
	 * @author liz
	 * @date 2017/6/25 18:14
	 */
	@RequestMapping("personal_setting_password_step2")
	public String personalSettingPasswordStep2(String key, ModelMap modelMap) {
		modelMap.put("key", key);
		return "mall/personal_setting_password_step2";
	}
	
	/**
	 * @description: 修改密码保存
	 * @author liz
	 * @date 2017/6/25 18:35
	 */
	@ResponseBody
	@RequestMapping(value = "personal_setting_password_save", produces = "application/json;charset=utf-8")
	public Result<String> personalSettingPasswordSave(HttpServletRequest request, String newPassword, String key) {
		User user = (User) request.getSession().getAttribute("user");
		String pre_key = MD5Util.getMd5(user.getPassword(), false);
		if (StringUtils.isEmpty(key) || !key.equals(pre_key)) {
			return new Result<>(ResultEnum.UNAUTHORIZED);
		}
		if (StringUtils.isEmpty(newPassword)) {
			return new Result<>(ResultEnum.FAILURE);
		}
		try {
			user.setPassword(DigestUtils.md5Hex(newPassword));
			userService.updatePasswordById(user);
		} catch (Exception e) {
			e.printStackTrace();
			return new Result<>(ResultEnum.FAILURE);
		}
		return new Result<>(ResultEnum.SUCCESS);
	}
	
	/**
	 * @description: 保存个人图片
	 * @author liz
	 * @date 2017/6/25 19:43
	 */
	@ResponseBody
	@RequestMapping(value = "personal_setting_pic_save", produces = "application/json;charset=utf-8")
	public Result<String> personalSettingPicSave(HttpServletRequest request, String path, String realPath) {
		try {
			Member member = (Member)request.getSession().getAttribute("member");
			String photo = member.getPhotoRealPath();
			if (!StringUtils.isEmpty(photo)) {
				File file = new File(photo);
				if (file.exists()) {
					file.delete();
				}
			}
			member.setPhoto(path);
			member.setPhotoRealPath(realPath);
			memberService.updateByPrimaryKey(member);
			return new Result<>(ResultEnum.SUCCESS, path);
		} catch (Exception e) {
			e.printStackTrace();
			return new Result<>(ResultEnum.FAILURE);
		}
	}    
    @RequestMapping("delPayOrder")
    @ResponseBody
    public String delPayOrder(HttpServletRequest request,String order_id,String orderType){
    	String rs = "";
    	String orderStr = (String)request.getSession().getAttribute("goods_orders");
    	String newOrderStr = "";
    	if(null!=orderStr&&!"".equals(orderStr)){
    		String[] orderArr = orderStr.split(";");
    		for (int i = 0; i < orderArr.length; i++) {
				if(!order_id.equals(orderArr[i])){
					newOrderStr += orderArr[i]+";";
				}
			}
    		if(!"".equals(newOrderStr)){
    			newOrderStr = newOrderStr.substring(0,newOrderStr.length()-1);
    		}
    	}
    	String enoughOrder = (String)request.getSession().getAttribute("enoughOrder");
    	String newEnoughStr = "";
    	if(null!=enoughOrder&&!"".equals(enoughOrder)){
    		String[] enoughArr = orderStr.split(";");
    		for (int i = 0; i < enoughArr.length; i++) {
				if(order_id.equals(enoughArr[i])){
					newEnoughStr += enoughArr[i]+";";
				}
			}
    		if(!"".equals(newOrderStr)){
    			newEnoughStr = newOrderStr.substring(0,newOrderStr.length()-1);
    		}
    	}
    	int r = orderService.deleteByPrimaryKey(order_id);
    	if(1==r){
    		Map<String,Object> map = new HashMap<String, Object>();
    		map.put("code", "200");
    		map.put("goods_orders", newOrderStr);
    		map.put("enoughOrder", newEnoughStr);
    		map.put("msg", "删除成功！");
    		map.put("orderType", orderType);
    		rs = JSON.toJSONString(map);
    		request.getSession().setAttribute("goods_orders", newOrderStr);
    		request.getSession().setAttribute("enoughOrder", newEnoughStr);
    	}else{
    		rs = ResultUtil.resultString(0);
    	}
    	return rs;
    }
    
    @RequestMapping("addOrder")
    public String addOrder(HttpServletRequest request,Model model,String shop_id,String type){
    	String page = "mall/addOrder";
    	String orderStr = "";
    	if("1".equals(type)){
    		orderStr = (String)request.getSession().getAttribute("goods_orders");
    	}else if("2".equals(type)){
    		orderStr = (String)request.getSession().getAttribute("enoughOrder");
    	}
    	String[] orderArr = orderStr.split(";");
    	String goodsStr = "";
    	for (int i = 0; i < orderArr.length; i++) {
			goodsStr += orderService.selectByPrimaryKey(orderArr[i]).getGoods_id()+";";
		}
    	Shop shop =shopService.selectByPrimaryKey(shop_id);
		model.addAttribute("shop", shop);
		ShopGoods shopGoods = new ShopGoods();
		shopGoods.setShop_id(shop_id);
		List<ShopGoods> shopGoodsList = shopGoodsService.select(shopGoods);
		List<ShopGoods> shopGoodsList2 = new ArrayList<ShopGoods>();
		//去掉已经添加的种类
		for (int i = 0; i < shopGoodsList.size(); i++) {
			if(goodsStr.indexOf(shopGoodsList.get(i).getGoods_id())<0 ){
				shopGoodsList2.add(shopGoodsList.get(i));
			}
		}
		List<Map<String,Object>> list = new ArrayList<Map<String,Object>>();
		Map<String,Object> map = null;
		Goods goods = null;
		GoodsPic goodsPic = null;
		if(null!=shopGoodsList2&&0<shopGoodsList2.size()){
			for (int i = 0; i < shopGoodsList2.size(); i++) {
				map = new HashMap<String, Object>();
				goods = goodsService.selectByPrimaryKey(shopGoodsList2.get(i).getGoods_id());
				goodsPic = goodsPicService.selectByGoodsId(shopGoodsList2.get(i).getGoods_id()).get(0);
				map.put("goods", goods);
				map.put("goodsPic", goodsPic);
				map.put("shopGoods", shopGoodsList2.get(i));
				list.add(map);
			}
			model.addAttribute("list", list);
			model.addAttribute("type", type);
		}
    	return page;
    }
    
    @RequestMapping("addOrderSave")
    @ResponseBody
    public String addOrderSave(HttpServletRequest request,Order order,String type){
    	String rs = "";
    	User user = (User)request.getSession().getAttribute("user");
    	String orderStr = (String)request.getSession().getAttribute("goods_orders");
    	String enoughOrder = (String)request.getSession().getAttribute("enoughOrder");
    	String address_id = (String)request.getSession().getAttribute("address_id");
    	String order_id = UUID.randomUUID().toString();
    	order.setOrder_id(order_id);
    	order.setAddress_id(address_id);
    	order.setCreatetime(DateUtils.getCurrentDate());
    	order.setMember_id(user.getUserid());
    	order.setCurrent_status("0");
    	try {
    		int r = orderService.insertSelective(order);
    		rs = ResultUtil.resultString(r);
    		orderStr = orderStr+";"+order_id;
    		enoughOrder = enoughOrder+";"+order_id;
    		request.getSession().setAttribute("goods_orders",orderStr);
    		request.getSession().setAttribute("enoughOrder",enoughOrder);
    		
		} catch (Exception e) {
		}
    	return rs;
    }
    
    @RequestMapping("logout")
    public String logout(HttpServletRequest request,HttpSession session){
    	session.removeAttribute("user");
    	session.removeAttribute("member");
		session.setMaxInactiveInterval(0);
    	return "mall/login";
    }
}
