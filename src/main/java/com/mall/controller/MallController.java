package com.mall.controller;

import com.alibaba.fastjson.JSON;
import com.mall.dto.Result;
import com.mall.enums.ResultEnum;
import com.mall.po.*;
import com.mall.service.*;
import com.sun.org.apache.xpath.internal.operations.Mod;
import com.trace.po.User;
import com.trace.service.UserService;
import com.trace.util.DateUtils;
import com.trace.util.ResultUtil;
import org.apache.commons.codec.digest.DigestUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.*;

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
		Member member = (Member)request.getAttribute("member");
		order.setOrder_id(UUID.randomUUID().toString());
		order.setCreatetime(DateUtils.getCurrentDate());
		order.setCurrent_status("0");
		//order.setMember_id(member.getMember());
		order.setMember_id("1");
		try {
			int r = orderService.insertSelective(order);
			rs = ResultUtil.resultString(r);
		} catch (Exception e) {
			e.printStackTrace();
			rs = ResultUtil.resultString(0);
		}
		return rs;
	}
	
	@RequestMapping("getCartList")
	public String getCartList(HttpServletRequest request,Model model){
		String page = "mall/cartList";
		double sum_amount = 0.0;
		Member member = (Member)request.getSession().getAttribute("member");
		Order order = new Order();
		order.setCurrent_status("0");
		order.setMember_id("1");
//		order.setMember_id(member.getMember());
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
	public String loginCheck(HttpServletRequest request,Model model,String username,String password){
		String rs = "";
		User user = userService.selectByusernameAndpassword(username, DigestUtils.md5Hex(password));
		if(null!=user){
			Member member = memberService.selectByPrimaryKey(user.getUserid());
			request.getSession().setAttribute("member", member);
			request.getSession().setAttribute("user", user);
			rs = ResultUtil.resultString(1);
		}else{
			model.addAttribute("msg", "用户名或者密码错误！");
			rs = ResultUtil.resultString(0);
		}
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
	public String footer(HttpServletRequest request,Model model,String shop_id){
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
		model.addAttribute("shopList", shopList);
		return page;
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
}
