package com.order.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSON;
import com.mall.po.Dict;
import com.mall.po.Goods;
import com.mall.service.DictService;
import com.mall.service.GoodsService;
import com.order.po.Sczl;
import com.order.service.BaseInfoService;
import com.order.service.SczlService;
import com.trace.service.UserService;
import com.trace.util.ResultUtil;
import com.utils.UUIDFactory;

@Controller
@RequestMapping("sczl")
public class SczlController {

	@Autowired
	private UserService userService;
	@Autowired
	private BaseInfoService baseInfoService;
	@Autowired
	private DictService dictService;
	@Autowired
	private SczlService sczlService;
	@Autowired
	private GoodsService goodsService;
	
	
	@RequestMapping("add")
	public String add(HttpServletRequest request,Model model){
		String page = "orderModule/sczl/add";
		Goods goods = new Goods();
		List<Goods> goodsList = goodsService.select(goods);
		model.addAttribute("goodsList", goodsList);
		List<Dict> dictList = dictService.selectByParentId("spyb");
		model.addAttribute("dictList", dictList);
		return page;
	}
	
	@RequestMapping("modify")
	public String modify(HttpServletRequest request,Model model,String id){
		String page = "orderModule/sczl/modify";
		Sczl sczl = sczlService.selectByPrimaryKey(id);
		Goods goods = new Goods();
		List<Goods> goodsList = goodsService.select(goods);
		model.addAttribute("goodsList", goodsList);
		List<Dict> dictList = dictService.selectByParentId("spyb");
		model.addAttribute("dictList", dictList);
		model.addAttribute("sczl", sczl);
		return page;
	}
	
	@RequestMapping("modifySave")
	@ResponseBody
	public String modifySave(HttpServletRequest request,Sczl sczl){
		int r = sczlService.updateByPrimaryKeySelective(sczl);
		return ResultUtil.resultString(r);
	}
	
	@RequestMapping("addSave")
	@ResponseBody
	public String addSave(HttpServletRequest request,Sczl sczl){
		String rs = "";
		Map<String,Object> map = new HashMap<String, Object>();
		map.put("kind", sczl.getKind());
		map.put("grade", sczl.getGrade());
		map.put("spyb", sczl.getSpyb());
		List<Sczl> list = sczlService.select(map);
		if(0==list.size()){
			
			sczl.setId(UUIDFactory.getInstance().newUUID());
			int r = sczlService.insertSelective(sczl);
			rs = ResultUtil.resultString(r);
		}else{
			map.put("code", "400");
			map.put("msg", "已存在");
			rs = JSON.toJSONString(map);
		}
		return rs;
	}
	
	@RequestMapping("list")
	public String list(HttpServletRequest request,Model model,Sczl sczl,String page){
		String p =  "orderModule/sczl/list";
		Map<String,Object> map = new HashMap<String, Object>();
		if(null!=sczl.getKind()&&!"".equals(sczl.getKind())){
			map.put("kind", sczl.getKind());
		}
		if(null!=sczl.getGrade()&&!"".equals(sczl.getGrade())){
			map.put("grade", sczl.getGrade());
		}
		if(null!=sczl.getSpyb()&&!"".equals(sczl.getSpyb())){
			map.put("spyb", sczl.getSpyb());
		}
		if("".equals(page)||null==page){
			page = "1";
		}
		int num = sczlService.count(map);
		if(num%8==0){
			num = num/8;
		}else{
			num = num/8+1;
		}
		Goods goods = new Goods();
		List<Goods> goodsList = goodsService.select(goods);
		model.addAttribute("goodsList", goodsList);
		List<Dict> dictList = dictService.selectByParentId("spyb");
		model.addAttribute("dictList", dictList);
		model.addAttribute("num", num);
		model.addAttribute("sczl", sczl);
		model.addAttribute("curr", page);
		map.put("index", (Integer.parseInt(page)-1)*8);
		List<Sczl> sczlList = sczlService.query(map);
		model.addAttribute("sczlList", sczlList);
		return p;
	}
	@RequestMapping("query")
	public String query(HttpServletRequest request,Model model,Sczl sczl){
		String p =  "orderModule/sczl/query";
		Goods goods = new Goods();
		List<Goods> goodsList = goodsService.select(goods);
		model.addAttribute("goodsList", goodsList);
		List<Dict> dictList = dictService.selectByParentId("spyb");
		model.addAttribute("dictList", dictList);
		Map<String,Object> map = new HashMap<String, Object>();
		if(null!=sczl.getGrade()&&!"".equals(sczl.getGrade())&&
				null!=sczl.getKind()&&!"".equals(sczl.getKind())&&
				null!=sczl.getSpyb()&&!"".equals(sczl.getSpyb())){
			map.put("kind", sczl.getKind());
			map.put("grade", sczl.getGrade());
			map.put("spyb", sczl.getSpyb());
			List<Sczl> list = sczlService.select(map);
			if(0<list.size()){
				model.addAttribute("content", list.get(0).getContent());
			}
		}
		return p;
	}
	
	
	
	@RequestMapping("delete")
	@ResponseBody
	public String delete(HttpServletRequest request,String id){
		String rs = "";
		int r = sczlService.deleteByPrimaryKey(id);
		rs = ResultUtil.resultString(r);
		return rs;
	}
	
}
