package com.order.controller;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.codec.digest.DigestUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSON;
import com.order.po.BaseInfo;
import com.order.service.BaseInfoService;
import com.trace.po.User;
import com.trace.service.UserService;
import com.trace.util.ResultUtil;
import com.utils.CommonUtils;
import com.utils.UUIDFactory;

@Controller
@RequestMapping("baseInfo")
public class BaseInfoController {

	@Autowired
	private UserService userService;
	@Autowired
	private BaseInfoService baseInfoService;
	
	@RequestMapping("add")
	public String add(HttpServletRequest request,Model model){
		String page = "orderModule/base/add";
		return page;
	}
	
	@RequestMapping("addSave")
	@ResponseBody
	public String addSave(HttpServletRequest request,User user,BaseInfo baseInfo){
		String rs = "";
		String userid = UUIDFactory.getInstance().newUUID();
		user.setUserid(userid);
		user.setPassword(DigestUtils.md5Hex("000000"));
		if("1".equals(baseInfo.getType())){
			user.setUsertype("A"); //生产基地
		}else if("2".equals(baseInfo.getType())){
			user.setUsertype("B"); //超市，食堂，商店等
		}
		baseInfo.setFzr(userid);
		baseInfo.setId(UUIDFactory.getInstance().newUUID());
		userService.add(user);
		int r = baseInfoService.insertSelective(baseInfo);
		rs = ResultUtil.resultString(r);
		return rs;
	}
	
	@RequestMapping("list")
	public String list(HttpServletRequest request,Model model,String type,String name,String page){
		String p =  "orderModule/base/list";
		Map<String,Object> map = new HashMap<String, Object>();
		if(null!=name&&!"".equals(name)){
			map.put("name", name);
		}
		if(null!=type&&!"".equals(type)){
			map.put("type", type);
		}
		if("".equals(page)||null==page){
			page = "1";
		}
		int num = baseInfoService.count(map);
		if(num%8==0){
			num = num/8;
		}else{
			num = num/8+1;
		}
		List<User> userList = userService.selectAllUser();
		model.addAttribute("num", num);
		model.addAttribute("type", type);
		model.addAttribute("userList", userList);
		model.addAttribute("name", name);
		model.addAttribute("curr", page);
		map.put("index", (Integer.parseInt(page)-1)*8);
		List<BaseInfo> baseInfoList = baseInfoService.query(map);
		model.addAttribute("baseInfoList", baseInfoList);
		return p;
	}
	
	@RequestMapping("login")
	public String login(HttpServletRequest request,Model model){
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
		return "orderModule/login";
	}
	
	
	@RequestMapping("delete")
	@ResponseBody
	public String delete(HttpServletRequest request,String id){
		String rs = "";
		BaseInfo baseInfo = baseInfoService.selectByPrimaryKey(id);
		String fzr = baseInfo.getFzr();
		userService.deleteByUsername(fzr);
		int r = baseInfoService.deleteByPrimaryKey(id);
		rs = ResultUtil.resultString(r);
		return rs;
	}
	
	@RequestMapping("logout")
	public String logout(HttpServletRequest request){
		request.getSession().removeAttribute("user");
		request.getSession().setMaxInactiveInterval(0);
		return "redirect:login.do";
	}
	
	@RequestMapping("loginCheck")
	@ResponseBody
	public String loginCheck(HttpServletRequest request,HttpServletResponse response,String username,String password){
		Map<String, Object> rsMap = new HashMap<String, Object>();
		String new_password = DigestUtils.md5Hex(password);
		User user  = userService.selectByusernameAndpassword(username, new_password);
		if(null!=user){
			Map<String,Object> map = new HashMap<String, Object>();
			map.put("fzr", user.getUserid());
			List<BaseInfo> list = baseInfoService.select(map);
			BaseInfo baseInfo = null;
			if(null!=list&&0<list.size()){
				baseInfo = list.get(0);
			}
			request.getSession().setAttribute("user", user);
			request.getSession().setAttribute("baseInfo", baseInfo);
			CommonUtils.rememberPass(username, password, response);
			rsMap.put("code", "200");
			rsMap.put("msg", "登录成功！");
			/*List<String> userList = new ArrayList<String>();
			userList.add("erp-0000");
			TextMessageEntity textMessageEntity = new TextMessageEntity();
			textMessageEntity.setTouser(userList);
			Map<String, String> text = new HashMap<String, String>();
			text.put("content", "时间："+DateUtils.getCurrentDate()+"\n用户："+user.getUsername()+"\n操作：登录");
			textMessageEntity.setText(text);
			try {
				JSONObject jsonObject = SendMessage.sendTextMessage(textMessageEntity);
				Log4JUtils.getLogger().error(jsonObject.get("errcode"));
			} catch (IOException e) {
				e.printStackTrace();
			}*/
		}else{
			rsMap.put("code", "-1");
			rsMap.put("msg", "登录失败！</br>请检查用户名和密码是否正确！");
		}
		
		return JSON.toJSONString(rsMap);
	}
	@RequestMapping("index")
	public String index(HttpServletRequest request){
		String page = "redirect:login.do"; //生产基地
		User user = (User)request.getSession().getAttribute("user");
		if(null!=user){
			if("B".equals(user.getUsertype())){
				//超市等
				page = "orderModule/require_index";
			}else if("A".equals(user.getUsertype())){
				page = "orderModule/scjd_index";
			}
			else if("5".equals(user.getUsertype())){
				//采购主管
				page = "orderModule/purchaseManage_index";
			}else if("6".equals(user.getUsertype())){
				//销售主管
				page = "orderModule/saleManage_index";
			}else if("7".equals(user.getUsertype())){
				//运输
				//page = "orderModule/transport_index";
				page = "404";
			}else if("1".equals(user.getUsertype())){
				//采购员
				page = "orderModule/purchase_index";
			}else if("8".equals(user.getUsertype())){
				//取样
				page = "orderModule/sampling_index";
			}else if("9".equals(user.getUsertype())){
				//配送
				page = "orderModule/distribution_index";
			}else if("2".equals(user.getUsertype())){
				//检验
				page = "orderModule/test_index";
			}else if("rlcg".equals(user.getUsertype())){
				//肉类采购
				page = "orderModule/meat_purchase_index";
			}else if("rlsj".equals(user.getUsertype())){
				//肉类售价
				page = "orderModule/meat_saleManage_index";
			}else if("rlps".equals(user.getUsertype())){
				//肉类配送
				page = "orderModule/meat_distribution_index";
			}else if("sgps".equals(user.getUsertype())){
				//肉类配送
				page = "orderModule/fruit_distribution_index";
			}else if("fruit".equals(user.getUsertype())){
				//肉类配送
				page = "orderModule/fruit_manage_index";
			}
			else{
				page = "404";
			}
		}
		return page;
	}
	
	@RequestMapping("addPurchaser")
	public String addPurchaser(HttpServletRequest request,Model model,String baseid){
		String page = "orderModule/base/addPurchase";
		BaseInfo baseInfo = baseInfoService.selectByPrimaryKey(baseid);
		model.addAttribute("baseInfo", baseInfo);
		return page;
	}
}
