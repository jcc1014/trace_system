package com.trace.controller;

import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSON;
import com.trace.util.QRCodeUtil;

@Controller
@RequestMapping("qrcode")
public class QrcodeController {

	private String configPath = "qrcode";
	
	@RequestMapping("produce.do")
	@ResponseBody
	public String produce(HttpServletRequest request,String trace_id) {
		if(null==trace_id){
			trace_id = "";
		}
		//String urlpath = request.getContextPath();
		//String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+urlpath;
		Map<String,String> map = new HashMap<String, String>();
		String path  = request.getSession().getServletContext().getRealPath("/")+configPath+"\\";
		//String content = basePath+"/trace/trace_detail?trace_id="+trace_id;
		trace_id = UUID.randomUUID().toString();
		//String content = "http://jingcc.xin:8080/trace_system/trace/trace_detail.do?trace_id="+trace_id;
		String content = "http://qianzhide.net:8080/trace_system/trace/trace_detail.do?trace_id="+trace_id;
		String filename = UUID.randomUUID().toString();
		try {
			String logoPath  = request.getSession().getServletContext().getRealPath("/")+"\\images\\qrcode_logo2.png";
			QRCodeUtil.encode(content, logoPath, path, filename, true);
			
			map.put("code", "200");
			map.put("path", path+filename);
			map.put("name", filename);
			map.put("trace_id", trace_id);
		} catch (Exception e) {
			e.printStackTrace();
			map.put("code", "-1");
		}
		return JSON.toJSONString(map);
	}
}
