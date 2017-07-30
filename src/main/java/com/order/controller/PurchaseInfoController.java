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

import com.order.po.BaseInfo;
import com.order.po.PurchaseInfo;
import com.order.po.RemainPurchase;
import com.order.po.TotalInfo;
import com.order.service.BaseInfoService;
import com.order.service.ProduceInfoService;
import com.order.service.PurchaseInfoService;
import com.order.service.RemainPurchaseService;
import com.order.service.TotalInfoService;
import com.trace.po.User;
import com.trace.service.UserService;
import com.trace.util.DateUtils;
import com.trace.util.ResultUtil;
import com.utils.UUIDFactory;

@Controller
@RequestMapping("purchaseInfo")
public class PurchaseInfoController {

	@Autowired
	private PurchaseInfoService purchaseInfoService;
	@Autowired
	private ProduceInfoService produceInfoService;
	@Autowired
	private TotalInfoService totalInfoService;
	@Autowired
	private RemainPurchaseService remainPurchaseService;
	@Autowired
	private BaseInfoService baseInfoService;
	@Autowired
	private UserService userService;
	
	/**
	 * 创建采购单
	 * @param request
	 * @param model
	 * @param number
	 * @return
	 */
	@RequestMapping("createCgd")
	public String createCgd(HttpServletRequest request,Model model,String[] number){
		String rs = "redirect:todayCgd.do";
		String nowDay = DateUtils.getCurrentDate("yyyy-MM-dd");
		String status = "1";
		User user = (User)request.getSession().getAttribute("user");
		List<Map<String,Object>> list = produceInfoService.selectTodayProduceTotal(nowDay,status);
		if(number.length>0&&list.size()==number.length){
			PurchaseInfo purchaseInfo = null;
			Map<String,Object> map = null;
			TotalInfo totalInfo = new TotalInfo();
			totalInfo.setId(UUIDFactory.getInstance().newUUID());
			totalInfo.setCreatetime(DateUtils.getCurrentDate("yyyy-MM-dd HH:mm:ss"));
			totalInfo.setName(DateUtils.getCurrentDate("yyyy-MM-dd")+"采购单");
			totalInfo.setCreateuser(null==user?null:user.getUserid());
			totalInfo.setType("cgd");
			totalInfo.setStatus("0");
			totalInfoService.insertSelective(totalInfo);
			for (int i = 0; i < number.length; i++) {
				map = list.get(i);
				purchaseInfo = new PurchaseInfo();
				purchaseInfo.setPurchase_id(UUIDFactory.getInstance().newUUID());
				purchaseInfo.setParentid(totalInfo.getId());
				purchaseInfo.setCreatetime(DateUtils.getCurrentDate("yyyy-MM-dd"));
				purchaseInfo.setGrade((String)map.get("grade"));
				purchaseInfo.setKind((String)map.get("type"));
				purchaseInfo.setSupply_number((double)map.get("supply_number"));
				purchaseInfo.setNumber(Double.parseDouble(number[i]));
				purchaseInfo.setStatus("0");
				purchaseInfo.setType("1");
				purchaseInfo.setRemain_number(Double.parseDouble(number[i]));
				purchaseInfoService.insertSelective(purchaseInfo);
			}
		}
		return rs;
	}
	
	/**
	 * 今日采购单
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping("todayCgd")
	public String todayCgd(HttpServletRequest request,Model model){
		String page = "orderModule/purchase/todayPurchaseInfo";
		TotalInfo totalInfo2 = new TotalInfo();
		totalInfo2.setType("cgd");
		totalInfo2.setCreatetime(DateUtils.getCurrentDate("yyyy-MM-dd"));
		List<Map<String, Object>> totalInfoList = totalInfoService.select(totalInfo2);
		model.addAttribute("totalInfoList", totalInfoList.size()>0?totalInfoList:null);
		return page;
	}
	@RequestMapping("todayPurchaseInfoDetail")
	public String todayPurchaseInfoDetail(HttpServletRequest request,Model model,String id){
		String page = "orderModule/purchase/todayPurchaseInfoDetail";
		TotalInfo totalInfo = totalInfoService.selectByPrimaryKey(id);
		PurchaseInfo purchaseInfo = new PurchaseInfo();
		purchaseInfo.setParentid(id);
		List<Map<String, Object>> purchaseInfoList = purchaseInfoService.select(purchaseInfo);
		BaseInfo baseInfo = baseInfoService.selectByPrimaryKey(totalInfo.getSource());
		User u = userService.getById(baseInfo.getFzr());
		model.addAttribute("u", u);
		model.addAttribute("baseInfo", baseInfo);
		model.addAttribute("purchaseInfos", purchaseInfoList);
		model.addAttribute("totalInfo", totalInfo);
		return page;
	}
	
	/**
	 * 历史详细
	 * @param request
	 * @param model
	 * @param id
	 * @return
	 */
	@RequestMapping("historyDetail")
	public String historyDetail(HttpServletRequest request,Model model,String id){
		String page = "orderModule/purchase/historyDetail";
		TotalInfo totalInfo = totalInfoService.selectByPrimaryKey(id);
		PurchaseInfo purchaseInfo = new PurchaseInfo();
		purchaseInfo.setParentid(id);
		List<Map<String, Object>> purchaseInfoList = purchaseInfoService.select(purchaseInfo);
		BaseInfo baseInfo = baseInfoService.selectByPrimaryKey(totalInfo.getSource());
		User u = userService.getById(baseInfo.getFzr());
		model.addAttribute("u", u);
		model.addAttribute("baseInfo", baseInfo);
		model.addAttribute("purchaseInfos", purchaseInfoList);
		model.addAttribute("totalInfo", totalInfo);
		return page;
	}
	
	/**
	 * 编辑保存
	 * @param request
	 * @param id
	 * @param number
	 * @return
	 */
	@RequestMapping("editSave")
	@ResponseBody
	public String editSave(HttpServletRequest request,String id,String number){
		if(null==number||""==number){
			number = "0";
		}
		PurchaseInfo purchaseInfo = new PurchaseInfo();
		purchaseInfo.setPurchase_id(id);
		purchaseInfo.setNumber(Double.parseDouble(number));
		purchaseInfo.setRemain_number(Double.parseDouble(number));
		int r = purchaseInfoService.updateByPrimaryKeySelective(purchaseInfo);
		String rs = ResultUtil.resultString(r);
		return rs;
	}
	
	/**
	 * 提交
	 * @param request
	 * @param id
	 * @return
	 */
	@RequestMapping("submit")
	@ResponseBody
	public String submit(HttpServletRequest request,String id){
		TotalInfo totalInfo = new TotalInfo();
		totalInfo.setStatus("1");
		totalInfo.setId(id);
		PurchaseInfo purchaseInfo = new PurchaseInfo();
		purchaseInfo.setStatus("1");
		purchaseInfo.setParentid(id);
		purchaseInfoService.updateByParnetid(purchaseInfo);
		int r = totalInfoService.updateByPrimaryKeySelective(totalInfo);
		String rs = ResultUtil.resultString(r);
		return rs;
	}
	
	/**
	 * 历史列表
	 * @param request
	 * @param model
	 * @param datetime
	 * @return
	 */
	@RequestMapping("history")
	public String history(HttpServletRequest request,Model model,String datetime){
		String page = "orderModule/purchase/history";
		if(null==datetime||""==datetime){
			datetime = DateUtils.getNDayBeforeCurrentDate(1, "yyyy-MM-dd");
		}
		TotalInfo totalInfo2 = new TotalInfo();
		totalInfo2.setType("cgd");
		totalInfo2.setStatus("1");
		totalInfo2.setCreatetime(datetime);
		List<Map<String, Object>> totalInfoList = totalInfoService.select(totalInfo2);
		model.addAttribute("totalInfoList", totalInfoList);
		return page;
	}
	
	/**
	 * 创建缺货单
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping("createQhd")
	@ResponseBody
	public String getCgAndXq(HttpServletRequest request,Model model){
		String rs = "";
		TotalInfo t = new TotalInfo();
		t.setCreatetime(DateUtils.getCurrentDate("yyyy-MM-dd"));
		t.setType("qhd");
		List<Map<String, Object>> tList = totalInfoService.select(t);
		if(1==tList.size()){
			String tid = (String)tList.get(0).get("id");
			purchaseInfoService.deleteByParentId(tid);
			totalInfoService.deleteByPrimaryKey(tid);
		}
		User user = (User)request.getSession().getAttribute("user");
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("date1", DateUtils.getCurrentDate("yyyy-MM-dd"));
		map.put("date2", DateUtils.getCurrentDate("yyyy-MM-dd"));
		List<Map<String, Object>> list = purchaseInfoService.getCgAndXq(map); //获取采购和需求
		Map<String,Object> rmap = null;
		PurchaseInfo purchaseInfo = null;
		TotalInfo qhd = new TotalInfo();
		qhd.setCreatetime(DateUtils.getCurrentDate("yyyy-MM-dd"));
		qhd.setType("qhd");
		qhd.setId(UUIDFactory.getInstance().newUUID());
		qhd.setCreateuser(user==null?null:user.getUserid());
		qhd.setName(DateUtils.getCurrentDate("yyyy-MM-dd")+"缺货单");
		qhd.setStatus("1");
		boolean qhd_f = false;
		TotalInfo fyd = new TotalInfo();
		fyd.setCreatetime(DateUtils.getCurrentDate("yyyy-MM-dd"));
		fyd.setType("fyd");
		fyd.setId(UUIDFactory.getInstance().newUUID());
		fyd.setCreateuser(user==null?null:user.getUserid());
		fyd.setName(DateUtils.getCurrentDate("yyyy-MM-dd")+"富余单");
		fyd.setStatus("1");
		boolean fyd_f = false;
		RemainPurchase remainPurchase = null;
		if(0<list.size()){
			for (int i = 0; i < list.size(); i++) {
				rmap = list.get(i);
				if(null==rmap.get("createtime")||"".equals(rmap.get("createtime"))){
					//缺货
					purchaseInfo = new PurchaseInfo();
					purchaseInfo.setPurchase_id(UUIDFactory.getInstance().newUUID());
					purchaseInfo.setCreatetime(DateUtils.getCurrentDate());
					purchaseInfo.setCreateuser(null==user?null:user.getUsername());
					purchaseInfo.setGrade((String) rmap.get("grade1"));
					purchaseInfo.setKind((String) rmap.get("kind1"));
					purchaseInfo.setSpyb((String) rmap.get("spyb1"));
					purchaseInfo.setNumber((double)rmap.get("num"));
					purchaseInfo.setParentid(qhd.getId());
					purchaseInfo.setRemain_number((double)rmap.get("num"));
					purchaseInfo.setStatus("1");
					purchaseInfo.setType("1");
					purchaseInfoService.insertSelective(purchaseInfo);
					qhd_f = true;
				}
				else if(null!=rmap.get("createtime")&&!"".equals(rmap.get("createtime"))
						&&(null!=rmap.get("createtime1")&&!"".equals(rmap.get("createtime1")))){
					//有货
					//比较数量
					if((double)rmap.get("num")>(double)rmap.get("number")){
						//不够
						purchaseInfo = new PurchaseInfo();
						purchaseInfo.setPurchase_id(UUIDFactory.getInstance().newUUID());
						purchaseInfo.setCreatetime(DateUtils.getCurrentDate());
						purchaseInfo.setCreateuser(null==user?null:user.getUsername());
						purchaseInfo.setGrade((String) rmap.get("grade1"));
						purchaseInfo.setKind((String) rmap.get("kind1"));
						purchaseInfo.setSpyb((String) rmap.get("spyb1"));
						purchaseInfo.setNumber((double)rmap.get("num")-(double)rmap.get("number"));
						purchaseInfo.setParentid(qhd.getId());
						purchaseInfo.setRemain_number((double)rmap.get("num")-(double)rmap.get("number"));
						purchaseInfo.setStatus("1");
						purchaseInfo.setType("1");
						purchaseInfoService.insertSelective(purchaseInfo);
						qhd_f = true;
						
					}else if((double)rmap.get("num")<(double)rmap.get("number")){
						//多余
						remainPurchase = new RemainPurchase();
						remainPurchase.setCreatetime(DateUtils.getCurrentDate());
						remainPurchase.setId(UUIDFactory.getInstance().newUUID());
						remainPurchase.setGrade((String) rmap.get("grade"));
						remainPurchase.setKind((String) rmap.get("kind"));
						remainPurchase.setSpyb((String) rmap.get("spyb"));
						remainPurchase.setNum((double)rmap.get("number")-(double)rmap.get("num"));
						remainPurchase.setParentid(fyd.getId());
						remainPurchase.setStatus("1");
						fyd_f = true;
						remainPurchaseService.insertSelective(remainPurchase);
						
						
					}
				}else if(null==rmap.get("createtime1")||"".equals(rmap.get("createtime1"))){
					//多余
					remainPurchase = new RemainPurchase();
					remainPurchase.setCreatetime(DateUtils.getCurrentDate());
					remainPurchase.setId(UUIDFactory.getInstance().newUUID());
					remainPurchase.setGrade((String) rmap.get("grade"));
					remainPurchase.setKind((String) rmap.get("kind"));
					remainPurchase.setSpyb((String) rmap.get("spyb"));
					remainPurchase.setNum((double)rmap.get("number"));
					remainPurchase.setParentid(fyd.getId());
					remainPurchase.setStatus("1");
					fyd_f = true;
					remainPurchaseService.insertSelective(remainPurchase);
				}
			}
			if(qhd_f==true){
				totalInfoService.insertSelective(qhd);
			}
			if(fyd_f==true){
				totalInfoService.insertSelective(fyd);
			}
			rs = ResultUtil.resultString(1);
		}else{
			rs = ResultUtil.resultString(0);
		}
		return rs;
	}
	
	@RequestMapping("allQhd")
	public String allQhd(HttpServletRequest request,Model model,String size){
		String page = "orderModule/purchase/allQhd";
		Map<String,Object> map = new HashMap<String, Object>();
		map.put("type", "qhd");
		map.put("index", 0);
		if(null!=size&&!"".equals(size)){
			map.put("size", Double.parseDouble(size));
		}else{
			map.put("size", 10);
		}
		List<Map<String, Object>> totalInfoList = totalInfoService.query(map);
		if(0<totalInfoList.size()
				&&totalInfoList.get(0).get("createtime").equals(DateUtils.getCurrentDate("yyyy-MM-dd"))){
			model.addAttribute("today", "1");
		}else{
			model.addAttribute("today", "0");
		}
		model.addAttribute("list", totalInfoList);
		return page;
	}
	
	@RequestMapping("getQhInfo")
	public String getQhInfo(HttpServletRequest request,Model model,String id){
		String page = "orderModule/purchase/todayQhInfo";
		PurchaseInfo purchaseInfo = new PurchaseInfo();
		TotalInfo totalInfo = totalInfoService.selectByPrimaryKey(id);
		if(null!=totalInfo){
			model.addAttribute("totalInfo", totalInfo);
			purchaseInfo.setParentid((String)totalInfo.getId());
			List<Map<String, Object>> list = purchaseInfoService.select(purchaseInfo);
			model.addAttribute("purchaseInfos", list);
			model.addAttribute("qhd", "1");
		}else{
			model.addAttribute("qhd", "0");
		}
		return page;
	}
	
	@RequestMapping("getQhd")
	public String getQhd(HttpServletRequest request,Model model){
		String page = "orderModule/purchase/cgy_todayQhInfo";
		PurchaseInfo purchaseInfo = new PurchaseInfo();
		TotalInfo totalInfo2 = new TotalInfo();
		totalInfo2.setType("qhd");
		totalInfo2.setCreatetime(DateUtils.getNDayBeforeCurrentDate(1, "yyyy-MM-dd"));
		List<Map<String, Object>> totalInfoList = totalInfoService.select(totalInfo2);
		if(0<totalInfoList.size()){
			model.addAttribute("totalInfo", totalInfoList.get(0));
			purchaseInfo.setParentid((String)totalInfoList.get(0).get("id"));
			List<Map<String, Object>> list = purchaseInfoService.select(purchaseInfo);
			model.addAttribute("purchaseInfos", list);
			model.addAttribute("qhd", "1");
		}else{
			model.addAttribute("qhd", "0");
		}
		return page;
	}
	
	@RequestMapping("getFyd")
	public String getFyd(HttpServletRequest request,Model model){
		String page = "orderModule/purchase/todayFyInfo";
		RemainPurchase purchaseInfo = new RemainPurchase();
		TotalInfo totalInfo2 = new TotalInfo();
		totalInfo2.setType("fyd");
		totalInfo2.setCreatetime(DateUtils.getCurrentDate("yyyy-MM-dd"));
		List<Map<String, Object>> totalInfoList = totalInfoService.select(totalInfo2);
		if(0<totalInfoList.size()){
			model.addAttribute("totalInfo", totalInfoList.get(0));
			purchaseInfo.setParentid((String)totalInfoList.get(0).get("id"));
			List<Map<String, Object>> list = remainPurchaseService.select(purchaseInfo);
			model.addAttribute("purchaseInfos", list);
		}
		return page;
	}
}
