/**
 * 
 */
package com.wechat.controller;

import java.io.IOException;
import java.io.UnsupportedEncodingException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.alibaba.fastjson.JSONObject;
import com.wechat.util.SendMessage;
import com.wechat.util.WeChatUrl;

@Controller
@RequestMapping("wechat")
public class WeChatController {
	
	private static Logger log = Logger.getLogger(WeChatController.class);  
	

	@RequestMapping("/userInfo.do")
	public String userInfo()
	{
		String redirectUrl = "http://jing.ngrok.cc/erp/wechat/wechat.do";
		try {
			redirectUrl = java.net.URLEncoder.encode(redirectUrl,"GBK");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		String url = "https://open.weixin.qq.com/connect/oauth2/authorize?appid=wxeaaae42c6ba76150"
				+ "&redirect_uri="+redirectUrl
				+ "&response_type=code&scope=snsapi_base&state=userinfo#wechat_redirect";
		return "redirect:"+url;
	}
	
	@RequestMapping("/workreport.do")
	public String workreport()
	{
		String redirectUrl = "http://jing.ngrok.cc/erp/wechat/wechat.do";
		try {
			redirectUrl = java.net.URLEncoder.encode(redirectUrl,"GBK");
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		String url = "https://open.weixin.qq.com/connect/oauth2/authorize?appid=wxeaaae42c6ba76150"
				+ "&redirect_uri="+redirectUrl
				+ "&response_type=code&scope=snsapi_base&state=workreport#wechat_redirect";
		return "redirect:"+url;
	}
	@RequestMapping("/expense.do")
	public String expense()
	{
		String redirectUrl = "http://jing.ngrok.cc/erp/wechat/wechat.do";
		try {
			redirectUrl = java.net.URLEncoder.encode(redirectUrl,"GBK");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		String url = "https://open.weixin.qq.com/connect/oauth2/authorize?appid=wxeaaae42c6ba76150"
				+ "&redirect_uri="+redirectUrl
				+ "&response_type=code&scope=snsapi_base&state=expense#wechat_redirect";
		return "redirect:"+url;
	}
	@RequestMapping("/problem.do")
	public String problem()
	{
		String redirectUrl = "http://jing.ngrok.cc/erp/wechat/wechat.do";
		try {
			redirectUrl = java.net.URLEncoder.encode(redirectUrl,"GBK");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		String url = "https://open.weixin.qq.com/connect/oauth2/authorize?appid=wxeaaae42c6ba76150"
				+ "&redirect_uri="+redirectUrl
				+ "&response_type=code&scope=snsapi_base&state=problem#wechat_redirect";
		return "redirect:"+url;
	}
	
	@RequestMapping("/income.do")
	public String income()
	{
		String redirectUrl = "http://jing.ngrok.cc/erp/wechat/wechat.do";
		try {
			redirectUrl = java.net.URLEncoder.encode(redirectUrl,"GBK");
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		String url = "https://open.weixin.qq.com/connect/oauth2/authorize?appid=wxeaaae42c6ba76150"
				+ "&redirect_uri="+redirectUrl
				+ "&response_type=code&scope=snsapi_base&state=income#wechat_redirect";
		return "redirect:"+url;
	}
	@RequestMapping("/cost.do")
	public String cost()
	{
		String redirectUrl = "http://jing.ngrok.cc/erp/wechat/wechat.do";
		try {
			redirectUrl = java.net.URLEncoder.encode(redirectUrl,"GBK");
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		String url = "https://open.weixin.qq.com/connect/oauth2/authorize?appid=wxeaaae42c6ba76150"
				+ "&redirect_uri="+redirectUrl
				+ "&response_type=code&scope=snsapi_base&state=cost#wechat_redirect";
		return "redirect:"+url;
	}
	@RequestMapping("/cash.do")
	public String cash()
	{
		String redirectUrl = "http://jing.ngrok.cc/erp/wechat/wechat.do";
		try {
			redirectUrl = java.net.URLEncoder.encode(redirectUrl,"GBK");
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		String url = "https://open.weixin.qq.com/connect/oauth2/authorize?appid=wxeaaae42c6ba76150"
				+ "&redirect_uri="+redirectUrl
				+ "&response_type=code&scope=snsapi_base&state=cash#wechat_redirect";
		return "redirect:"+url;
	}
	@RequestMapping("/profit.do")
	public String profit()
	{
		String redirectUrl = "http://jing.ngrok.cc/erp/wechat/wechat.do";
		try {
			redirectUrl = java.net.URLEncoder.encode(redirectUrl,"GBK");
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		String url = "https://open.weixin.qq.com/connect/oauth2/authorize?appid=wxeaaae42c6ba76150"
				+ "&redirect_uri="+redirectUrl
				+ "&response_type=code&scope=snsapi_base&state=profit#wechat_redirect";
		return "redirect:"+url;
	}
	
	@RequestMapping("/wechat.do")
	public String wechatUrl(HttpSession session,
			HttpServletRequest request,HttpServletResponse response)
	{
		String page = "404";
		String code =  request.getParameter("code");
		String state = request.getParameter("state");
		JSONObject jsonObject = new JSONObject();
		String token = null;
		try {
			token = SendMessage.getToken();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		String url = WeChatUrl.getUserInfoUrl(token, code);
		try {
			JSONObject rs = SendMessage.resultOfSyncRequest(jsonObject, url);
			log.info(rs.toString());
			String jobnumber = rs.getString("UserId");
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return page;
	}
	
	@RequestMapping("/salaryMsg.do")
	public String salaryMsg(HttpSession session,
			HttpServletRequest request,HttpServletResponse response)
	{
		String page = "404";
		String code =  request.getParameter("code");
		String state =  request.getParameter("state");
		JSONObject jsonObject = new JSONObject();
		String token = null;
		try {
			token = SendMessage.getToken();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		String url = WeChatUrl.getUserInfoUrl(token, code);
		try {
			JSONObject rs = SendMessage.resultOfSyncRequest(jsonObject, url);
			log.info(rs.toString());
			String jobnumber = rs.getString("UserId");
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return page;
	}
	
	@RequestMapping("/login.do")
	public String login(HttpServletRequest request)
	{
		return "";
	}
}
