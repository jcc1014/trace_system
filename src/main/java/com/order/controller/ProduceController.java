package com.order.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.codec.digest.DigestUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSON;
import com.mall.po.Goods;
import com.mall.service.GoodsService;
import com.order.po.BaseInfo;
import com.order.po.ProduceInfo;
import com.order.po.TotalInfo;
import com.order.service.ProduceInfoService;
import com.order.service.TotalInfoService;
import com.trace.po.User;
import com.trace.service.UserService;
import com.trace.util.DateUtils;
import com.trace.util.ResultUtil;
import com.utils.UUIDFactory;

@Controller
@RequestMapping("produce")
public class ProduceController {

	@Autowired
	private ProduceInfoService produceInfoService;
	@Autowired
	private TotalInfoService totalInfoService;
	@Autowired
	private GoodsService goodsService;
	@Autowired
	private UserService userService;
	
	@RequestMapping("addSave")
	@ResponseBody
	public String addSave(HttpServletRequest request,ProduceInfo produceInfo){
		String rs = "";
		User user = (User)request.getSession().getAttribute("user");
		produceInfo.setCreatetime(DateUtils.getCurrentDate());
		produceInfo.setProduce_id(UUIDFactory.getInstance().newUUID());
		produceInfo.setProduce_infoer(user==null?null:user.getUserid());
		produceInfo.setPhone(user==null?null:user.getPhone());
		produceInfo.setStatus("0");
		String parent_id = UUIDFactory.getInstance().newUUID();
		if(null==produceInfo.getParent_id()||"".equals(produceInfo.getParent_id())){
			produceInfo.setParent_id(parent_id);
		}
		request.getSession().setAttribute("produce_parent_id", parent_id);
		int r = produceInfoService.insertSelective(produceInfo);
		rs = ResultUtil.resultString(r);
		return rs;
	}
	
	@RequestMapping("delete")
	@ResponseBody
	public String delete(HttpServletRequest request,String produce_id){
		String rs = "";
		int r = produceInfoService.deleteByPrimaryKey(produce_id);
		rs = ResultUtil.resultString(r);
		return rs;
	}
	@RequestMapping("add")
	public String add(HttpServletRequest request,Model model,ProduceInfo produceInfo){
		String page = "orderModule/produce/addProduceInfo";
		Goods goods = new Goods();
		goods.setGoods_type("1");
		List<Goods> goodsList = goodsService.select(goods);
		model.addAttribute("goodsList", goodsList);
		List<Map<String,Object>> producelist = produceInfoService.select(produceInfo);
		request.getSession().setAttribute("produce_parent_id", produceInfo.getParent_id());
		model.addAttribute("producelist", producelist);
		model.addAttribute("nowDate", DateUtils.getCurrentDate("yyyy-MM-dd"));
 		return page;
	}
	
	@RequestMapping("info")
	public String info(HttpServletRequest request,Model model){
		String page = "orderModule/produce/info";
		BaseInfo baseInfo = (BaseInfo)request.getSession().getAttribute("baseInfo");
		model.addAttribute("baseInfo", baseInfo);
		return page;
	}
	@RequestMapping("setup")
	public String setup(HttpServletRequest request,Model model){
		String page = "orderModule/produce/setup";
		User user = (User)request.getSession().getAttribute("user");
		model.addAttribute("user", user);
		return page;
	}
	
	@RequestMapping("checkPassword")
	@ResponseBody
	public String checkPassword(HttpServletRequest request,String password){
		String rs = "";
		User user = (User)request.getSession().getAttribute("user");
		if(!DigestUtils.md5Hex(password).equals(user.getPassword())){
			rs = ResultUtil.resultString(0);
		}else{
			rs = ResultUtil.resultString(1);
		}
		return rs;
	}
	
	@RequestMapping("modifyPassword")
	@ResponseBody
	public String modifyPassword(HttpServletRequest request,String new_password){
		String rs = "";
		User u = (User)request.getSession().getAttribute("user");
		User user = new User();
		user.setPassword(DigestUtils.md5Hex(new_password));
		user.setUserid(u.getUserid());
		int r = userService.updatePasswordById(user);
		rs = ResultUtil.resultString(r);
		return rs;
	}
	
	@RequestMapping("today_produce")
	public String today(HttpServletRequest request,Model model){
		String page = "orderModule/produce/todayProduce";
		User user = (User)request.getSession().getAttribute("user");
		TotalInfo totalInfo = new TotalInfo();
		totalInfo.setCreatetime(DateUtils.getCurrentDate("yyyy-MM-dd"));
		totalInfo.setCreateuser(user.getUserid());
		totalInfo.setType("gyd");
		List<Map<String, Object>> list = totalInfoService.select(totalInfo);
		if(null!=list&&0<list.size()){
			//已经建立今天供应单
			model.addAttribute("totalInfo", list.get(0));
			ProduceInfo produceInfo = new ProduceInfo();
			produceInfo.setParent_id((String)list.get(0).get("id"));
			List<Map<String, Object>> produceInfos = produceInfoService.select(produceInfo);
			model.addAttribute("produceInfos", produceInfos);
		}else{
			//未建立今日供应单
			totalInfo.setId(UUIDFactory.getInstance().newUUID());
			BaseInfo baseInfo = (BaseInfo)request.getSession().getAttribute("baseInfo");
			totalInfo.setName(DateUtils.getCurrentDate("yyyy-MM-dd")+baseInfo.getName()+"供应单");
			totalInfo.setSource(baseInfo.getId());
			totalInfo.setSource_name(baseInfo.getName());
			totalInfo.setStatus("0");
			totalInfoService.insertSelective(totalInfo);
			model.addAttribute("totalInfo", totalInfo);
			
		}
		Goods goods = new Goods();
		List<Goods> goodsList = goodsService.select(goods);
		model.addAttribute("goodsList", goodsList);
		model.addAttribute("user", user);
		return page;
	}
	
	@RequestMapping("delProduce")
	@ResponseBody
	public String delProduce(HttpServletRequest request,String produce_id){
		String rs = "";
		int r = produceInfoService.deleteByPrimaryKey(produce_id);
		rs = ResultUtil.resultString(r);
		return rs;
		
	}
	@RequestMapping("submitGyd")
	@ResponseBody
	public String submitGyd(HttpServletRequest request,TotalInfo totalInfo){
		String rs = "";
		totalInfo.setStatus("1");
		int r = totalInfoService.updateByPrimaryKeySelective(totalInfo);
		ProduceInfo produceInfo = new ProduceInfo();
		produceInfo.setStatus("1");
		produceInfo.setParent_id(totalInfo.getId());
		produceInfoService.updateStatusByParentid(produceInfo);
		rs = ResultUtil.resultString(r);
		return rs;
		
	}
	
	@RequestMapping("editProduceSave")
	@ResponseBody
	public String editProduceSave(HttpServletRequest request,ProduceInfo produceInfo){
		String rs = "";
		int r = produceInfoService.updateByPrimaryKeySelective(produceInfo);
		rs = ResultUtil.resultString(r);
		return rs;
		
	}
	
	@RequestMapping("editProduce")
	@ResponseBody
	public String editProduce(HttpServletRequest request,ProduceInfo produceInfo){
		String rs = "";
		produceInfo = produceInfoService.selectByPrimaryKey(produceInfo.getProduce_id());
		Map<String,Object> map = new HashMap<String, Object>();
		if(null!=produceInfo){
			map.put("code", "200");
			map.put("produce_id", produceInfo.getProduce_id());
			map.put("type", produceInfo.getType());
			map.put("grade", produceInfo.getGrade());
			map.put("supply_number", produceInfo.getSupply_number());
			map.put("price", produceInfo.getPrice());
			
		}else{
			map.put("code", "-1");
		}
		rs = JSON.toJSONString(map);
		return rs;
		
	}
	
	@RequestMapping("addProduceSave")
	@ResponseBody
	public String addProduceSave(HttpServletRequest request,ProduceInfo produceInfo){
		String rs = "";
		ProduceInfo p = new ProduceInfo();
		p.setParent_id(produceInfo.getParent_id());
		p.setType(produceInfo.getType());
		p.setGrade(produceInfo.getGrade());
		List<Map<String, Object>> pList = produceInfoService.select(p);
		if(null!=pList&&0<pList.size()){
			Map<String,Object> map = new HashMap<String, Object>();
			map.put("code", "1");
			map.put("msg", "该种类以及品级已经存在！");
			rs = JSON.toJSONString(map);
			return rs;
		}
		produceInfo.setProduce_id(UUIDFactory.getInstance().newUUID());
		produceInfo.setCreatetime(DateUtils.getCurrentDate());
		produceInfo.setStatus("0");
		int r = produceInfoService.insertSelective(produceInfo);
		rs = ResultUtil.resultString(r);
		return rs;
		
	}
	
	@RequestMapping("history")
	public String history(HttpServletRequest request,Model model,String date,String page){
		String p = "orderModule/produce/history";
		User user = (User)request.getSession().getAttribute("user");
		Map<String,Object> map = new HashMap<String, Object>();
		map.put("createuser", user.getUserid());
		map.put("type", "gyd");
		map.put("status", "1");
		if("".equals(page)||null==page){
			page = "1";
		}
		int num = totalInfoService.count(map);
		if(num%8==0){
			num = num/8;
		}else{
			num = num/8+1;
		}
		model.addAttribute("num", num);
		model.addAttribute("curr", page);
		map.put("index", (Integer.parseInt(page)-1)*8);
		List<Map<String, Object>> totalInfoList = totalInfoService.query(map);
		model.addAttribute("totalInfoList", totalInfoList);
		return p;
	}
	@RequestMapping("history_detail")
	public String history_detail(HttpServletRequest request,Model model,String id){
		String p = "orderModule/produce/history_detail";
		ProduceInfo produceInfo = new ProduceInfo();
		produceInfo.setParent_id(id);
		List<Map<String, Object>> list = produceInfoService.select(produceInfo);
		TotalInfo totalInfo = totalInfoService.selectByPrimaryKey(id);
		model.addAttribute("totalInfo", totalInfo);
		model.addAttribute("produceInfos", list);
		return p;
	}
	
	@RequestMapping("todayProduceTotal")
	public String todayProduceTotal(HttpServletRequest request,Model model){
		String page = "orderModule/produce/todayProduceTotal";
		TotalInfo totalInfo2 = new TotalInfo();
		totalInfo2.setType("cgd");
		totalInfo2.setCreatetime(DateUtils.getCurrentDate("yyyy-MM-dd"));
		List<Map<String, Object>> totalInfoList = totalInfoService.select(totalInfo2);
		if(0<totalInfoList.size()){
			return "redirect:/purchaseInfo/todayCgd.do";
		}
		String nowDay = DateUtils.getCurrentDate("yyyy-MM-dd");
		String status = "1";
		List<Map<String,Object>> list = produceInfoService.selectTodayProduceTotal(nowDay,status);
		model.addAttribute("list", list);
		return page;
	}
	
}
