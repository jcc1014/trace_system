package com.order.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.order.po.PurchaseInfo;
import com.order.po.TotalInfo;
import com.order.service.ProduceInfoService;
import com.order.service.PurchaseInfoService;
import com.order.service.TotalInfoService;
import com.trace.po.User;
import com.trace.util.DateUtils;
import com.trace.util.ResultUtil;
import com.utils.UUIDFactory;

@Controller
@RequestMapping("purchaseInfo")
public class PruchaseInfoController {

	@Autowired
	private PurchaseInfoService purchaseInfoService;
	@Autowired
	private ProduceInfoService produceInfoService;
	@Autowired
	private TotalInfoService totalInfoService;
	
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
			totalInfo.setCreatetime(DateUtils.getCurrentDate("yyyy-MM-dd"));
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
				purchaseInfo.setRemain_number(Double.parseDouble(number[i]));
				purchaseInfoService.insertSelective(purchaseInfo);
			}
		}
		return rs;
	}
	
	@RequestMapping("todayCgd")
	public String todayCgd(HttpServletRequest request,Model model,String id){
		String page = "orderModule/purchase/todayPurchaseInfo";
		PurchaseInfo purchaseInfo = new PurchaseInfo();
		TotalInfo totalInfo = null;
		if(null==id||"".equals(id)){
			TotalInfo totalInfo2 = new TotalInfo();
			totalInfo2.setType("cgd");
			totalInfo2.setCreatetime(DateUtils.getCurrentDate("yyyy-MM-dd"));
			List<Map<String, Object>> totalInfoList = totalInfoService.select(totalInfo2);
			if(0<totalInfoList.size()){
				model.addAttribute("totalInfo", totalInfoList.get(0));
			}
			
			purchaseInfo.setCreatetime(DateUtils.getCurrentDate("yyyy-MM-dd"));
		}else{
			totalInfo = totalInfoService.selectByPrimaryKey(id);
			model.addAttribute("totalInfo", totalInfo);
			purchaseInfo.setParentid(id);
			purchaseInfo.setCreatetime(DateUtils.getCurrentDate("yyyy-MM-dd"));
		}
		List<Map<String, Object>> list = purchaseInfoService.select(purchaseInfo);
		model.addAttribute("purchaseInfos", list);
		return page;
	}
	
	@RequestMapping("editSave")
	@ResponseBody
	public String editSave(HttpServletRequest request,String id,String number){
		if(null==number||""==number){
			number = "0";
		}
		PurchaseInfo purchaseInfo = new PurchaseInfo();
		purchaseInfo.setPurchase_id(id);
		purchaseInfo.setNumber(Double.parseDouble(number));
		int r = purchaseInfoService.updateByPrimaryKeySelective(purchaseInfo);
		String rs = ResultUtil.resultString(r);
		return rs;
	}
	
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
	
	@RequestMapping("history")
	public String history(HttpServletRequest request,Model model,String datetime){
		String page = "orderModule/purchase/history";
		if(null==datetime||""==datetime){
			datetime = DateUtils.getNDayBeforeCurrentDate(1, "yyyy-MM-dd");
		}
		TotalInfo totalInfo = new TotalInfo();
		totalInfo.setStatus("1");
		totalInfo.setCreatetime(datetime);
		List<Map<String,Object>> totalList = totalInfoService.select(totalInfo);
		if(0<totalList.size()){
			PurchaseInfo purchaseInfo = new PurchaseInfo();
			purchaseInfo.setStatus("1");
			purchaseInfo.setParentid((String)totalList.get(0).get("id"));
			List<Map<String, Object>> purchaseInfoList = purchaseInfoService.select(purchaseInfo);
			model.addAttribute("totalInfo", totalList.get(0));
			model.addAttribute("purchaseInfoList", purchaseInfoList);
		}
		return page;
	}
	
}
