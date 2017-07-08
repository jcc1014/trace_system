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

import com.order.po.SalePrice;
import com.order.service.ProduceInfoService;
import com.order.service.PurchaseInfoService;
import com.order.service.RequireInfoService;
import com.order.service.SalePriceService;
import com.order.service.TotalInfoService;
import com.trace.service.PurchaseService;
import com.trace.util.DateUtils;
import com.trace.util.ResultUtil;

@Controller
@RequestMapping("salePrice")
public class SalePriceController {

	@Autowired
	private SalePriceService salePriceService;
	@Autowired
	private ProduceInfoService produceInfoService;
	@Autowired
	private PurchaseService purchaseService;
	@Autowired
	private PurchaseInfoService purchaseInfoService;
	@Autowired
	private TotalInfoService totalInfoService;
	@Autowired
	private RequireInfoService requireInfoService;
	
	@RequestMapping("todaySalePrice")
	public String todaySalePrice(HttpServletRequest request,Model model){
		String page = "orderModule/saleManage/todaySalePrice";
		SalePrice salePrice = new SalePrice();
		salePrice.setCreatetime(DateUtils.getCurrentDate("yyyy-MM-dd"));
		List<SalePrice> salePriceList = salePriceService.select(salePrice);
		if(0==salePriceList.size()){
			//生成价格表
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("datetime", DateUtils.getCurrentDate("yyyy-MM-dd"));
			map.put("datetime2", DateUtils.getCurrentDate("yyyy-MM-dd"));
			salePriceService.insertByRequireAndPurchase(map);
			salePriceList = salePriceService.select(salePrice);
		}
		model.addAttribute("salePriceList", salePriceList);
		return page;
	}
	@RequestMapping("history")
	public String history(HttpServletRequest request,Model model,String datetime){
		String page = "orderModule/saleManage/history";
		SalePrice salePrice = new SalePrice();
		if(null==datetime||"".equals(datetime)){
			salePrice.setCreatetime(DateUtils.getNDayBeforeCurrentDate(1, "yyyy-MM-dd"));
		}else{
			salePrice.setCreatetime(datetime);
		}
		List<SalePrice> salePriceList = salePriceService.select(salePrice);
		model.addAttribute("salePriceList", salePriceList);
		return page;
	}
	
	@RequestMapping("savePrice")
	@ResponseBody
	public String savePrice(HttpServletRequest request,SalePrice salePrice){
		int r = salePriceService.updateByPrimaryKeySelective(salePrice);
		String rs = ResultUtil.resultString(r);
		return rs;
	}
	
}
