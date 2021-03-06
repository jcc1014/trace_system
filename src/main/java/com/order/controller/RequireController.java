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
import com.order.po.BaseInfo;
import com.order.po.RequireInfo;
import com.order.po.TotalInfo;
import com.order.service.ProduceInfoService;
import com.order.service.RequireInfoService;
import com.order.service.TotalInfoService;
import com.trace.po.User;
import com.trace.service.UserService;
import com.trace.util.DateUtils;
import com.trace.util.ResultUtil;
import com.utils.UUIDFactory;
import com.wechat.util.SendMessage;

@Controller
@RequestMapping("require")
public class RequireController {

	@Autowired
	private ProduceInfoService produceInfoService;
	@Autowired
	private TotalInfoService totalInfoService;
	@Autowired
	private GoodsService goodsService;
	@Autowired
	private UserService userService;
	@Autowired
	private RequireInfoService requireInfoService;
	@Autowired
	private DictService dictService;
	
	/**
	 * 今日需求单
	 * @param request
	 * @param model
	 * @return todayRequire（页面）
	 */
	@RequestMapping("today_require")
	public String today(HttpServletRequest request,Model model){
		String page = "orderModule/require/todayRequire";
		User user = (User)request.getSession().getAttribute("user");
		TotalInfo totalInfo = new TotalInfo();
		totalInfo.setCreatetime(DateUtils.getCurrentDate("yyyy-MM-dd"));
		totalInfo.setCreateuser(user.getUserid());
		totalInfo.setType("xqd"); //需求单
		List<Map<String, Object>> list = totalInfoService.select(totalInfo);
		if(null!=list&&0<list.size()){
			//已经建立今天需求单
			model.addAttribute("totalInfo", list.get(0));
			RequireInfo requireInfo = new RequireInfo();
			requireInfo.setParentid((String)list.get(0).get("id"));
			List<Map<String, Object>> requireList = requireInfoService.select(requireInfo);
			model.addAttribute("requireList", requireList);
		}else{
			//未建立今日需求单
			totalInfo.setId(UUIDFactory.getInstance().newUUID());
			BaseInfo baseInfo = (BaseInfo)request.getSession().getAttribute("baseInfo");
			totalInfo.setName(DateUtils.getCurrentDate("yyyy-MM-dd")+baseInfo.getName()+"需求单");
			totalInfo.setSource(baseInfo.getId());
			totalInfo.setSource_name(baseInfo.getName());
			totalInfo.setStatus("0");
			totalInfo.setCreatetime(DateUtils.getCurrentDate("yyyy-MM-dd HH:mm:ss"));
			totalInfo.setSource_type(baseInfo.getType());
			totalInfoService.insertSelective(totalInfo);
			model.addAttribute("totalInfo", totalInfo);
			
		}
		Goods goods = new Goods();
		goods.setGoods_type("1"); //菜的类型
		List<Goods> goodsList = goodsService.select(goods); //所有的菜
		List<Dict> dictList = dictService.selectByParentId("spyb");
		model.addAttribute("goodsList", goodsList);
		model.addAttribute("dictList", dictList);
		model.addAttribute("user", user);
		return page;
	}
	
	/**
	 * 删除需求单
	 * @param request
	 * @param id
	 * @return
	 */
	@RequestMapping("delRequire")
	@ResponseBody
	public String delRequire(HttpServletRequest request,String id){
		String rs = "";
		int r = requireInfoService.deleteByPrimaryKey(id);
		rs = ResultUtil.resultString(r);
		return rs;
		
	}
	
	/**
	 * 提交需求单
	 * @param request
	 * @param totalInfo 总体信息
	 * @return
	 */
	@RequestMapping("submitXqd")
	@ResponseBody
	public String submitXqd(HttpServletRequest request,TotalInfo totalInfo){
		String rs = "";
		//if(DateUtils.getCurrentDate("HHmmss").compareTo("2000000"))
		totalInfo.setStatus("1");
		RequireInfo requireInfo = new RequireInfo();
		requireInfo.setStatus("1");
		requireInfo.setParentid(totalInfo.getId());
		requireInfoService.updateByParentid(requireInfo);
		int r = totalInfoService.updateByPrimaryKeySelective(totalInfo);
		rs = ResultUtil.resultString(r);
		BaseInfo baseInfo = (BaseInfo)request.getSession().getAttribute("baseInfo");
		SendMessage.sendMsg(baseInfo.getName()+" 已提交需求单！（"+DateUtils.getCurrentDate()+"）");
		return rs;
		
	}
	
	/**
	 * 编辑需求单保存
	 * @param request
	 * @param requireInfo
	 * @return
	 */
	@RequestMapping("editRequireSave")
	@ResponseBody
	public String editRequireSave(HttpServletRequest request,RequireInfo requireInfo){
		String rs = "";
		int r = requireInfoService.updateByPrimaryKeySelective(requireInfo);
		rs = ResultUtil.resultString(r);
		return rs;
		
	}
	
	/**
	 * 编辑需求单
	 * @param request
	 * @param requireInfo
	 * @return
	 */
	@RequestMapping("editRequire")
	@ResponseBody
	public String editRequire(HttpServletRequest request,RequireInfo requireInfo){
		String rs = "";
		requireInfo = requireInfoService.selectByPrimaryKey(requireInfo.getId());
		Map<String,Object> map = new HashMap<String, Object>();
		if(null!=requireInfo){
			map.put("code", "200");
			map.put("id", requireInfo.getId());
			map.put("kind", requireInfo.getKind());
			map.put("grade", requireInfo.getGrade());
			map.put("num", requireInfo.getNum());
			map.put("spyb", requireInfo.getSpyb());
			
		}else{
			map.put("code", "-1");
		}
		rs = JSON.toJSONString(map);
		return rs;
		
	}
	
	/**
	 * 新增需求单保存
	 * @param request
	 * @param requireInfo
	 * @return
	 */
	@RequestMapping("addRequireSave")
	@ResponseBody
	public String addRequireSave(HttpServletRequest request,RequireInfo requireInfo){
		String rs = "";
		RequireInfo p = new RequireInfo();
		p.setParentid(requireInfo.getParentid());
		p.setKind(requireInfo.getKind());
		p.setGrade(requireInfo.getGrade());
		p.setSpyb(requireInfo.getSpyb());
		List<Map<String, Object>> pList = requireInfoService.select(p);
		if(null!=pList&&0<pList.size()){
			Map<String,Object> map = new HashMap<String, Object>();
			map.put("code", "1");
			map.put("msg", "该种类以及品级已经存在！");
			rs = JSON.toJSONString(map);
			return rs;
		}
		requireInfo.setId(UUIDFactory.getInstance().newUUID());
		requireInfo.setCreatetime(DateUtils.getCurrentDate());
		requireInfo.setStatus("0");
		int r = requireInfoService.insertSelective(requireInfo);
		rs = ResultUtil.resultString(r);
		return rs;
		
	}
	
	/**
	 * 需求历史
	 * @param request
	 * @param model
	 * @param date
	 * @param page
	 * @return
	 */
	@RequestMapping("history")
	public String history(HttpServletRequest request,Model model,String date,String page){
		String p = "orderModule/require/history";
		User user = (User)request.getSession().getAttribute("user");
		Map<String,Object> map = new HashMap<String, Object>();
		map.put("createuser", user.getUserid());
		map.put("type", "xqd");
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
	
	/**
	 * 需求历史详细
	 * @param request
	 * @param model
	 * @param id
	 * @return
	 */
	@RequestMapping("history_detail")
	public String history_detail(HttpServletRequest request,Model model,String id){
		String p = "orderModule/require/history_detail";
		RequireInfo requireInfo = new RequireInfo();
		requireInfo.setParentid(id);
		List<Map<String, Object>> list = requireInfoService.select(requireInfo);
		TotalInfo totalInfo = totalInfoService.selectByPrimaryKey(id);
		model.addAttribute("totalInfo", totalInfo);
		model.addAttribute("requireInfos", list);
		return p;
	}
	
	/**
	 * 基础信息
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping("info")
	public String info(HttpServletRequest request,Model model){
		String page = "orderModule/require/info";
		BaseInfo baseInfo = (BaseInfo)request.getSession().getAttribute("baseInfo");
		model.addAttribute("baseInfo", baseInfo);
		return page;
	}
}
