package com.mall.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.mall.po.Dict;
import com.mall.service.DictService;
import com.trace.util.ResultUtil;

@Controller
@RequestMapping("dict")
public class DictController {
	
	@Autowired
	private DictService dictService;
	
	@RequestMapping("/list")
	public String list(HttpServletRequest request,Dict dict,String page,Model model){
		String p = "dict/list";
		Map<String,Object> map = new HashMap<String, Object>();
		if("".equals(page)||null==page){
			page = "1";
		}
		map.put("parentid", null);
		int num = dictService.count(map);
		if(num%8==0){
			num = num/8;
		}else{
			num = num/8+1;
		}
		model.addAttribute("num", num);
		model.addAttribute("curr", page);
		map.put("index", (Integer.parseInt(page)-1)*8);
		map.put("dict_name", dict.getDict_name());
		map.put("dict_type", dict.getDict_type());
		
		List<Dict> dictList = dictService.query(map);
		model.addAttribute("dictList", dictList);
		return p;
	}
	
	@RequestMapping("/listParent")
	public String listParent(HttpServletRequest request,Dict dict,String page,Model model){
		String p = "dict/listParent";
		Map<String,Object> map = new HashMap<String, Object>();
		if("".equals(page)||null==page){
			page = "1";
		}
		map.put("parentid", "0");
		int num = dictService.count(map);
		if(num%8==0){
			num = num/8;
		}else{
			num = num/8+1;
		}
		model.addAttribute("num", num);
		model.addAttribute("curr", page);
		map.put("index", (Integer.parseInt(page)-1)*8);
		map.put("dict_name", dict.getDict_name());
		List<Dict> dictList = dictService.query(map);
		model.addAttribute("dictList", dictList);
		return p;
	}
	
	@RequestMapping("/add")
	public String add(HttpServletRequest request,Model model){
		String page = "dict/add";
		List<Dict> list = dictService.selectByParentId("0");
		model.addAttribute("typeList", list);
		return page;
	}
	
	@RequestMapping("/addParent")
	public String addParent(HttpServletRequest request,Model model){
		String page = "dict/addParent";
		return page;
	}
	
	@RequestMapping("/addSave")
	@ResponseBody
	public String addSave(HttpServletRequest request,Dict dict){
		int r = dictService.insertSelective(dict);
		return ResultUtil.resultString(r);
		
	}
	
	@RequestMapping("/addParentSave")
	@ResponseBody
	public String addParentSave(HttpServletRequest request,Dict dict){
		int r = dictService.insertParent(dict);
		return ResultUtil.resultString(r);
		
	}

}
