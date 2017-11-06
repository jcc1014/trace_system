/**
 * @Description: 
 * @maven.com.trace.controller
 * @FileName:UserController.java
 * @Created By:鏅暱瓒�
 * @Created:2017骞�鏈�0鏃�涓嬪崍10:17:36
 */
package com.trace.controller;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.codec.digest.DigestUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSON;
import com.trace.po.User;
import com.trace.service.UserService;
import com.utils.CommonUtils;

/**
 * @Description
 * @ClassName UserController
 * @author jcc
 * @Created 2017 
 */
@Controller
public class UserController {
	
	@Autowired
	private UserService userService;
	
	@RequestMapping("login.do")
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
		return "login";
	}
	
	@RequestMapping("loginCheck.do")
	@ResponseBody
	public String loginCheck(HttpServletRequest request,HttpServletResponse response,HttpSession session,String username,String password){
		Map<String,Object> map = new HashMap<String, Object>();
		String new_password = DigestUtils.md5Hex(password);
		User user = userService.selectByusernameAndpassword(username, new_password);
		if(null==user){
			map.put("code", -1);
			map.put("msg", "用户名或者密码错误！");
		}else{
			CommonUtils.rememberPass(username, password, response);
			map.put("code", 200);
			map.put("msg", "登陆成功！");
		}
		session.setAttribute("user", user);
		String rs = JSON.toJSONString(map);
		return rs;
	}
	
	@RequestMapping("checkName.do")
	@ResponseBody
	public String checkName(HttpServletRequest request,HttpSession session,String realname){
		Map<String,Object> map = new HashMap<String, Object>();
		map.put("realname", realname);
		List<User> list = userService.select(map);
		if(0<list.size()){
			map.put("code", -1);
		}else{
			map.put("code", 200);
		}
		String rs = JSON.toJSONString(map);
		return rs;
	}
	@RequestMapping("logout.do")
	@ResponseBody
	public String logout(HttpServletRequest request,HttpSession session){
		Map<String,Object> map = new HashMap<String, Object>();
		session.removeAttribute("user");
		session.setMaxInactiveInterval(0);
		map.put("code", 200);
		map.put("msg", "退出成功！");
		String rs = JSON.toJSONString(map);
		return rs;
	}
	
	@RequestMapping("index.do")
	public String index(HttpServletRequest request,HttpSession session,Model model){
		String page = "login";
		User user = (User)session.getAttribute("user");
		if(null!=user){
			if("0".equals(user.getUsertype())){
				page = "index/admin_index";
			}
			else if("3".equals(user.getUsertype())){
				page = "index/shop_index";
			}
			else if("2".equals(user.getUsertype())){
				page = "index/test_index";
			}
			else{
				page = "index/trace_index";
			}
		}
		return page;
	}
	
	@RequestMapping("main.do")
	public String main(HttpServletRequest request,HttpSession session,Model model){
		String page = "index/main";
		return page;
	}
	
	@RequestMapping("user/deleteUser.do")
	@ResponseBody
	public String del(HttpServletRequest request,HttpSession session,String id){
		
		Map<String,Object> map = userService.deleteById(id);
		return JSON.toJSONString(map);
	}
	
	@RequestMapping("user/add.do")
	public String add(HttpServletRequest request,HttpSession session,User user){
		return "user/add";
	}
	
	@RequestMapping("user/addSave.do")
	@ResponseBody
	public String addSave(HttpServletRequest request,HttpSession session,User user){
		
		Map<String,Object> map = userService.add(user);
		return JSON.toJSONString(map);
	}
	
	@RequestMapping("user/list.do")
	public String userlist(HttpServletRequest request,HttpSession session,String username,String usertype,String page,Model model){
		String p = "user/list";
		if(null!=username&&!"".equals(username)){
			try {
				username = new String(username.getBytes("ISO8859-1"),"UTF-8");
			} catch (UnsupportedEncodingException e) {
				e.printStackTrace();
			}
		}
		Map<String,Object> map = new HashMap<String, Object>();
		if("".equals(page)||null==page){
			page = "1";
		}
		map.put("username", username);
		map.put("usertype", usertype);
		int num = userService.count(map);
		if(num%8==0){
			num = num/8;
		}else{
			num = num/8+1;
		}
		model.addAttribute("num", num);
		model.addAttribute("curr", page);
		model.addAttribute("username", username);
		model.addAttribute("usertype", usertype);
		map.put("index", (Integer.parseInt(page)-1)*8);
		List<User> userList = userService.select(map);
		model.addAttribute("userList", userList);
		return p;
	}
	@RequestMapping("user/member_list.do")
	public String member_list(HttpServletRequest request,HttpSession session,String username,String usertype,String page,Model model){
		String p = "user/member_list";
		if(null!=username&&!"".equals(username)){
			try {
				username = new String(username.getBytes("ISO8859-1"),"UTF-8");
			} catch (UnsupportedEncodingException e) {
				e.printStackTrace();
			}
		}
		Map<String,Object> map = new HashMap<String, Object>();
		if("".equals(page)||null==page){
			page = "1";
		}
		map.put("username", username);
		map.put("usertype", "4");
		int num = userService.count(map);
		if(num%8==0){
			num = num/8;
		}else{
			num = num/8+1;
		}
		model.addAttribute("num", num);
		model.addAttribute("curr", page);
		model.addAttribute("username", username);
		model.addAttribute("usertype", usertype);
		map.put("index", (Integer.parseInt(page)-1)*8);
		List<User> userList = userService.select(map);
		model.addAttribute("userList", userList);
		return p;
	}
	@RequestMapping("user/jd_user_list.do")
	public String jd_user_list(HttpServletRequest request,HttpSession session,String username,String usertype,String page,Model model){
		String p = "user/jd_user_list";
		if(null!=username&&!"".equals(username)){
			try {
				username = new String(username.getBytes("ISO8859-1"),"UTF-8");
			} catch (UnsupportedEncodingException e) {
				e.printStackTrace();
			}
		}
		Map<String,Object> map = new HashMap<String, Object>();
		if("".equals(page)||null==page){
			page = "1";
		}
		map.put("username", username);
		map.put("usertype", "A");
		int num = userService.count(map);
		if(num%8==0){
			num = num/8;
		}else{
			num = num/8+1;
		}
		model.addAttribute("num", num);
		model.addAttribute("curr", page);
		model.addAttribute("username", username);
		model.addAttribute("usertype", usertype);
		map.put("index", (Integer.parseInt(page)-1)*8);
		List<User> userList = userService.select(map);
		model.addAttribute("userList", userList);
		return p;
	}
	@RequestMapping("user/require_user_list.do")
	public String require_user_list(HttpServletRequest request,HttpSession session,String username,String usertype,String page,Model model){
		String p = "user/require_user_list";
		if(null!=username&&!"".equals(username)){
			try {
				username = new String(username.getBytes("ISO8859-1"),"UTF-8");
			} catch (UnsupportedEncodingException e) {
				e.printStackTrace();
			}
		}
		Map<String,Object> map = new HashMap<String, Object>();
		if("".equals(page)||null==page){
			page = "1";
		}
		map.put("username", username);
		map.put("usertype", "B");
		int num = userService.count(map);
		if(num%8==0){
			num = num/8;
		}else{
			num = num/8+1;
		}
		model.addAttribute("num", num);
		model.addAttribute("curr", page);
		model.addAttribute("username", username);
		model.addAttribute("usertype", usertype);
		map.put("index", (Integer.parseInt(page)-1)*8);
		List<User> userList = userService.select(map);
		model.addAttribute("userList", userList);
		return p;
	}
	
	
}
