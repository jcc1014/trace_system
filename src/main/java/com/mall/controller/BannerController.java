package com.mall.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSON;
import com.mall.po.Banner;
import com.mall.service.BannerService;
import com.trace.util.DateUtils;

@Controller
@RequestMapping("banner")
public class BannerController {
	
	@Autowired
	private BannerService bannerService;
	
	@RequestMapping("add")
	public String addPage(HttpServletRequest request){
		return "banner/add";
	}
	
	
	@RequestMapping("addSave")
	@ResponseBody
	public String addSave(HttpServletRequest request,Banner banner){
		Map<String,Object> map = new HashMap<String, Object>();
		try {
			banner.setBanner_id(UUID.randomUUID().toString());
			banner.setCreatetime(DateUtils.getCurrentDate());
			int count = bannerService.count(map);
			banner.setBanner_index(String.valueOf(count+1));
			banner.setBanner_type("1");
			int r = bannerService.insertSelective(banner);
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
		String p =  "banner/list";
		Map<String,Object> map = new HashMap<String, Object>();
		if("".equals(page)||null==page){
			page = "1";
		}
		int num = bannerService.count(map);
		if(num%8==0){
			num = num/8;
		}else{
			num = num/8+1;
		}
		model.addAttribute("num", num);
		model.addAttribute("curr", page);
		map.put("index", (Integer.parseInt(page)-1)*8);
		List<Banner> bannerList = bannerService.query(map);
		model.addAttribute("bannerList", bannerList);
		return p;
	}

}
