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
import com.mall.po.Dict;
import com.mall.po.Goods;
import com.mall.service.DictService;
import com.mall.service.GoodsService;
import com.order.po.BaseInfo;
import com.order.po.ProduceInfo;
import com.order.po.PurchaseInfo;
import com.order.po.TotalInfo;
import com.order.service.ProduceInfoService;
import com.order.service.PurchaseInfoService;
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
	@Autowired
	private PurchaseInfoService purchaseInfoService;
	@Autowired
	private DictService dictService;
	
	/**
	 * 新增保存
	 * @param request
	 * @param produceInfo
	 * @return
	 */
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
	
	/**
	 * 删除信息
	 * @param request
	 * @param produce_id
	 * @return
	 */
	@RequestMapping("delete")
	@ResponseBody
	public String delete(HttpServletRequest request,String produce_id){
		String rs = "";
		int r = produceInfoService.deleteByPrimaryKey(produce_id);
		rs = ResultUtil.resultString(r);
		return rs;
	}
	
	/**
	 * 新增页面
	 * @param request
	 * @param model
	 * @param produceInfo
	 * @return
	 */
	@RequestMapping("add")
	public String add(HttpServletRequest request,Model model,ProduceInfo produceInfo){
		String page = "orderModule/produce/addProduceInfo";
		Goods goods = new Goods();
		goods.setGoods_type("1");
		List<Goods> goodsList = goodsService.select(goods);
		model.addAttribute("goodsList", goodsList);
		List<Map<String,Object>> producelist = produceInfoService.select(produceInfo);
		request.getSession().setAttribute("produce_parent_id", produceInfo.getParent_id());
		List<Dict> dictList = dictService.selectByParentId("grade");
		model.addAttribute("producelist", producelist);
		model.addAttribute("dictList", dictList);
		model.addAttribute("nowDate", DateUtils.getCurrentDate("yyyy-MM-dd"));
 		return page;
	}
	
	/**
	 * 基础信息页面
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping("info")
	public String info(HttpServletRequest request,Model model){
		String page = "orderModule/produce/info";
		BaseInfo baseInfo = (BaseInfo)request.getSession().getAttribute("baseInfo");
		model.addAttribute("baseInfo", baseInfo);
		return page;
	}
	
	/**
	 * 设置页面
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping("setup")
	public String setup(HttpServletRequest request,Model model){
		String page = "orderModule/produce/setup";
		User user = (User)request.getSession().getAttribute("user");
		model.addAttribute("user", user);
		return page;
	}
	
	/**
	 * 校验密码
	 * @param request
	 * @param password
	 * @return
	 */
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
	
	/**
	 * 修改密码
	 * @param request
	 * @param new_password
	 * @return
	 */
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
	
	/**
	 * 今日供应单
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping("today_produce")
	public String today(HttpServletRequest request,Model model){
		String page = "orderModule/produce/todayProduce";
		User user = (User)request.getSession().getAttribute("user");
		TotalInfo totalInfo = new TotalInfo();
		if(Integer.parseInt(DateUtils.getCurrentDate("HHmmss"))<170000){
			totalInfo.setCreatetime(DateUtils.getCurrentDate("yyyy-MM-dd"));
		}else{
			totalInfo.setCreatetime(DateUtils.getNDayAfterCurrentDate(1, "yyyy-MM-dd"));
		}
		//totalInfo.setNowtime(DateUtils.getCurrentDate());
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
			if(Integer.parseInt(DateUtils.getCurrentDate("HHmmss"))<170000){
			//if(Integer.parseInt(DateUtils.getCurrentDate("HHmmss"))<220000){
				totalInfo.setName(DateUtils.getCurrentDate("yyyy-MM-dd")+baseInfo.getName()+"供应单");
				totalInfo.setCreatetime(DateUtils.getCurrentDate("yyyy-MM-dd"));
			}else{
				totalInfo.setName(DateUtils.getNDayAfterCurrentDate(1, "yyyy-MM-dd")+baseInfo.getName()+"供应单");
				totalInfo.setCreatetime(DateUtils.getNDayAfterCurrentDate(1, "yyyy-MM-dd"));
			}
			totalInfo.setNowtime(DateUtils.getCurrentDate());
			totalInfo.setSource(baseInfo.getId());
			totalInfo.setSource_name(baseInfo.getName());
			totalInfo.setSource_type(baseInfo.getType());
			totalInfo.setSource_type(baseInfo.getType());
			totalInfo.setCreateuser(user.getUserid());
			totalInfo.setStatus("0");
			totalInfoService.insertSelective(totalInfo);
			model.addAttribute("totalInfo", totalInfo);
			
		}
		Goods goods = new Goods();
		List<Goods> goodsList = goodsService.select(goods);
		List<Dict> dictList = dictService.selectByParentId("spyb");
		model.addAttribute("dictList", dictList);
		model.addAttribute("goodsList", goodsList);
		model.addAttribute("user", user);
		return page;
	}
	
	/**
	 * 删除供应单
	 * @param request
	 * @param produce_id
	 * @return
	 */
	@RequestMapping("delProduce")
	@ResponseBody
	public String delProduce(HttpServletRequest request,String produce_id){
		String rs = "";
		int r = produceInfoService.deleteByPrimaryKey(produce_id);
		rs = ResultUtil.resultString(r);
		return rs;
		
	}
	
	/**
	 * 提交供应单
	 * @param request
	 * @param totalInfo
	 * @return
	 */
	@RequestMapping("submitGyd")
	@ResponseBody
	public String submitGyd(HttpServletRequest request,TotalInfo totalInfo){
		String rs = "";
		totalInfo.setStatus("1");
		int r = totalInfoService.updateByPrimaryKeySelective(totalInfo);
		if(r==1){
			TotalInfo gyd = totalInfoService.selectByPrimaryKey(totalInfo.getId());
			TotalInfo cgd = new TotalInfo();
			TotalInfo cgd2 = new TotalInfo();
			cgd2.setCreatetime(gyd.getCreatetime());
			cgd2.setType("cgd");
			cgd2.setSource(gyd.getSource());
			List<Map<String,Object>> list = totalInfoService.select(cgd2);
			if(1==list.size()){
				TotalInfo realCgd = totalInfoService.selectByPrimaryKey((String)list.get(0).get("id"));
				ProduceInfo p = new ProduceInfo();
				p.setParent_id(gyd.getId());
				List<Map<String, Object>> l = produceInfoService.select(p);
				PurchaseInfo purchase = new PurchaseInfo();
				purchase.setParentid(realCgd.getId());
				List<Map<String, Object>> l2 = purchaseInfoService.select(purchase);
				for (int i = 0; i < l.size(); i++) {
					boolean f = true;
					for (int j = 0; j < l2.size(); j++) {
						if (l2.get(j).get("kind").equals(l.get(i).get("type"))&&
								l2.get(j).get("grade").equals(l.get(i).get("grade"))&&
								l2.get(j).get("spyb").equals(l.get(i).get("spyb"))) {
							f =  false;
							break;
						}
					}
					if(true==f){
						PurchaseInfo p2 = new PurchaseInfo();
						p2.setPurchase_id(UUIDFactory.getInstance().newUUID());
						p2.setCreatetime(DateUtils.getCurrentDate("yyyy-MM-dd"));
						p2.setGrade((String)l.get(i).get("grade"));
						p2.setKind((String)l.get(i).get("type"));
						p2.setSpyb((String)l.get(i).get("spyb"));
						p2.setType("0");
						p2.setParentid(realCgd.getId());
						p2.setPrice((double)l.get(i).get("price"));
						p2.setSupply_number((double)l.get(i).get("supply_number"));
						p2.setStatus("0");
						purchaseInfoService.insertSelective(p2);
					}
				}
			}else if(0==list.size()){
				
				cgd.setId(UUIDFactory.getInstance().newUUID());
				cgd.setCreatetime(DateUtils.getCurrentDate("yyyy-MM-dd HH:mm:ss"));
				cgd.setName(DateUtils.getCurrentDate("yyyy-MM-dd")+gyd.getSource_name()+"采购单");
				cgd.setSource_name(gyd.getSource_name());
				cgd.setSource(gyd.getSource());
				cgd.setType("cgd");
				cgd.setStatus("0");
				cgd.setSource_type(gyd.getSource_type());
				cgd.setCreateuser("自动生成");
				int cgd_r = totalInfoService.insertSelective(cgd);
				if(1==cgd_r){
					Map<String,Object> m = new HashMap<String, Object>();
					m.put("cg_parentid", cgd.getId());
					m.put("gy_parentid", gyd.getId());
					produceInfoService.createCgdByProduceId(m);
				}
			}
			
		}
		ProduceInfo produceInfo = new ProduceInfo();
		produceInfo.setStatus("1");
		produceInfo.setParent_id(totalInfo.getId());
		produceInfoService.updateStatusByParentid(produceInfo);
		rs = ResultUtil.resultString(r);
		return rs;
		
	}
	
	/**
	 * 编辑保存
	 * @param request
	 * @param produceInfo
	 * @return
	 */
	@RequestMapping("editProduceSave")
	@ResponseBody
	public String editProduceSave(HttpServletRequest request,ProduceInfo produceInfo){
		String rs = "";
		int r = produceInfoService.updateByPrimaryKeySelective(produceInfo);
		rs = ResultUtil.resultString(r);
		return rs;
		
	}
	
	/**
	 * 编辑页面
	 * @param request
	 * @param produceInfo
	 * @return
	 */
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
			map.put("spyb", produceInfo.getSpyb());
			map.put("supply_number", produceInfo.getSupply_number());
			map.put("price", produceInfo.getPrice());
			
		}else{
			map.put("code", "-1");
		}
		rs = JSON.toJSONString(map);
		return rs;
		
	}
	
	/**
	 * 添加保存
	 * @param request
	 * @param produceInfo
	 * @return
	 */
	@RequestMapping("addProduceSave")
	@ResponseBody
	public String addProduceSave(HttpServletRequest request,ProduceInfo produceInfo){
		String rs = "";
		ProduceInfo p = new ProduceInfo();
		p.setParent_id(produceInfo.getParent_id());
		p.setType(produceInfo.getType());
		p.setGrade(produceInfo.getGrade());
		p.setSpyb(produceInfo.getSpyb());
		List<Map<String, Object>> pList = produceInfoService.select(p);
		if(null!=pList&&0<pList.size()){
			Map<String,Object> map = new HashMap<String, Object>();
			map.put("code", "1");
			map.put("msg", "该种类以及品级已经存在！");
			rs = JSON.toJSONString(map);
			return rs;
		}
		produceInfo.setProduce_id(UUIDFactory.getInstance().newUUID());
		if(Integer.parseInt(DateUtils.getCurrentDate("HHmmss"))<170000){
			
			produceInfo.setCreatetime(DateUtils.getCurrentDate("yyyy-MM-dd"));
		}else{
			produceInfo.setCreatetime(DateUtils.getNDayAfterCurrentDate(1, "yyyy-MM-dd"));
		}
		produceInfo.setStatus("0");
		produceInfo.setNowtime(DateUtils.getCurrentDate());
		int r = produceInfoService.insertSelective(produceInfo);
		rs = ResultUtil.resultString(r);
		return rs;
		
	}
	
	/**
	 * 历史页面
	 * @param request
	 * @param model
	 * @param date
	 * @param page
	 * @return
	 */
	@RequestMapping("history")
	public String history(HttpServletRequest request,Model model,String date,String page){
		String p = "orderModule/produce/history";
		User user = (User)request.getSession().getAttribute("user");
		TotalInfo totalInfo = new TotalInfo();
		totalInfo.setCreateuser(user.getUserid());
		totalInfo.setStatus("1");
		totalInfo.setType("gyd");
		List<Map<String, Object>> totalInfoList = totalInfoService.select(totalInfo);
		model.addAttribute("totalInfoList", totalInfoList);
		return p;
	}
	
	/**
	 * 历史富余单
	 * @param request
	 * @param model
	 * @param date
	 * @param page
	 * @return
	 */
	@RequestMapping("historyFy")
	public String historyFy(HttpServletRequest request,Model model,String date,String page){
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
	
	/**
	 * 历史详情
	 * @param request
	 * @param model
	 * @param id
	 * @return
	 */
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
	
	/**
	 * 今日总供应
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping("todayProduceTotal")
	public String todayProduceTotal(HttpServletRequest request,Model model){
		String page = "orderModule/produce/todayProduceTotal";
		TotalInfo totalInfo2 = new TotalInfo();
		totalInfo2.setType("gyd");
		totalInfo2.setStatus("1");
		totalInfo2.setCreatetime(DateUtils.getCurrentDate("yyyy-MM-dd"));
		List<Map<String, Object>> totalInfoList = totalInfoService.select(totalInfo2);
		model.addAttribute("totalInfoList", totalInfoList);
		return page;
	}
	
	/**
	 * 今日总供应细节
	 * @param request
	 * @param model
	 * @param id
	 * @return
	 */
	@RequestMapping("todayProduceTotalDetail")
	public String todayProduceTotalDetail(HttpServletRequest request,Model model,String id){
		String page = "orderModule/produce/todayProduceTotalDetail";
		TotalInfo totalInfo = totalInfoService.selectByPrimaryKey(id);
		User u = userService.getById(totalInfo.getCreateuser());
		ProduceInfo produceInfo = new ProduceInfo();
		produceInfo.setParent_id(totalInfo.getId());
		List<Map<String,Object>> list = produceInfoService.select(produceInfo);
		model.addAttribute("produceInfos", list);
		model.addAttribute("u", u);
		model.addAttribute("totalInfo", totalInfo);
		return page;
	}
	
}
