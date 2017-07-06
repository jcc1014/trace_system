package com.order.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.order.po.PurchaseInfo;
import com.order.service.PurchaseInfoService;
import com.trace.po.Purchase;
import com.trace.po.TraceFlow;
import com.trace.po.User;
import com.trace.service.FarmerService;
import com.trace.service.PurchaseService;
import com.trace.service.TestService;
import com.trace.service.TraceFlowService;
import com.trace.util.DateUtils;
import com.utils.UUIDFactory;

@Controller
@RequestMapping("purchase")
public class PurchaseController {

	@Autowired
	private PurchaseInfoService purchaseInfoService;
	@Autowired
	private FarmerService farmerService;
	@Autowired
	private TestService testService;
	@Autowired
	private TraceFlowService traceFlowService;
	@Autowired
	private PurchaseService purchaseService;
	
	@RequestMapping("purchaseList")
	public String purchaseList(HttpServletRequest request,Model model,PurchaseInfo purchaseInfo){
		String page = "orderModule/purchase/purchaseList";
		purchaseInfo.setCreatetime(DateUtils.getCurrentDate("yyyy-MM-dd"));
		purchaseInfo.setStatus("1");
		List<Map<String, Object>> purchaseInfoList = purchaseInfoService.select(purchaseInfo);
		model.addAttribute("purchaseInfos", purchaseInfoList);
		return page;
	}
	
	@RequestMapping("addPurchase")
	public String addPurchase(HttpServletRequest request,Model model,String purchase_id){
		String page = "orderModule/purchase/addPurchase";
		PurchaseInfo purchaseInfo = purchaseInfoService.selectByPrimaryKey(purchase_id);
		Map<String,String> test = new HashMap<String, String>();
		test.put("test_time",DateUtils.getCurrentDate("yyyy-MM-dd"));
		test.put("kind", purchaseInfo.getKind());
		test.put("grade", purchaseInfo.getGrade());
		List<Map<String, Object>> list = testService.getTestInfo(test);
		model.addAttribute("list", list);
		model.addAttribute("purchaseInfo", purchaseInfo);
		return page;
	}
	
	@RequestMapping("addPurchaseSave")
	public String addPurchaseSave(HttpServletRequest request,String trace_id,Purchase purchase){
		String page = "redirect:purchaseList.do";
		purchase.setPurchase_id(UUIDFactory.getInstance().newUUID());
		purchase.setPurchase_time(DateUtils.getCurrentDate());
		TraceFlow traceFlow = new TraceFlow();
		traceFlow.setTrace_id(trace_id);
		traceFlow.setPurchase_id(purchase.getPurchase_id());
		traceFlowService.update(traceFlow);
		purchaseService.add(purchase);
		PurchaseInfo purchaseInfo = new PurchaseInfo();
		PurchaseInfo purchaseInfo2 = purchaseInfoService.selectByPrimaryKey(purchase.getPurchase_parentid());
		purchaseInfo.setPurchase_id(purchase.getPurchase_parentid());
		purchaseInfo.setRemain_number(purchaseInfo2.getRemain_number()-purchase.getPurchase_num());
		purchaseInfoService.updateByPrimaryKeySelective(purchaseInfo);
		return page;
	}
	
	@RequestMapping("history")
	public String history(HttpServletRequest request,Model model,Purchase purchase){
		String page = "orderModule/purchase/purchaseHistory";
		User user = (User)request.getSession().getAttribute("user");
		if(null==purchase.getPurchase_time()||"".equals(purchase.getPurchase_time())){
			purchase.setPurchase_time(DateUtils.getNDayBeforeCurrentDate(1, "yyyy-MM-dd"));
		}
		purchase.setPurchase_user(user==null?null:user.getUsername());
		List<Map<String,Object>> list = purchaseService.selectPurchase(purchase);
		model.addAttribute("list", list);
		return page;
	}
	@RequestMapping("watchPurchaseDetail")
	public String watchPurchaseDetail(HttpServletRequest request,Model model,Purchase purchase){
		String page = "orderModule/purchase/purchaseDetail";
		User user = (User)request.getSession().getAttribute("user");
		purchase.setPurchase_time(DateUtils.getCurrentDate("yyyy-MM-dd"));
		purchase.setPurchase_user(user==null?null:user.getUsername());
		List<Map<String,Object>> list = purchaseService.selectPurchase(purchase);
		model.addAttribute("list", list);
		return page;
	}
}
