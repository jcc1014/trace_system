package com.order.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.order.po.BaseInfo;
import com.order.po.DistributionInfo;
import com.order.po.RequireInfo;
import com.order.po.SalePrice;
import com.order.service.BaseInfoService;
import com.order.service.DistributionDetailService;
import com.order.service.DistributionInfoService;
import com.order.service.RequireInfoService;
import com.order.service.SalePriceService;
import com.trace.util.DateUtils;
import com.utils.UUIDFactory;

@Controller
@RequestMapping("distribution")
public class DistributionInfoController {

	@Autowired
	private BaseInfoService baseInfoService;
	@Autowired
	private DistributionInfoService distributionInfoService;
	@Autowired
	private DistributionDetailService distributionDetailService;
	@Autowired
	private SalePriceService salePriceService;
	@Autowired
	private RequireInfoService requireInfoService;
	
	@RequestMapping("todayDistribution")
	public String todayDistribution(HttpServletRequest request,Model model){
		String page = "orderModule/distribution/todayDistribution";
		DistributionInfo distributionInfo = new DistributionInfo();
		distributionInfo.setCreatetime(DateUtils.getCurrentDate("yyyy-MM-dd"));
		List<Map<String,Object>> list = distributionInfoService.select(distributionInfo);
		if(0<list.size()){
			model.addAttribute("list", list);
		}else{
			//生成配送单
			RequireInfo requireInfo = new RequireInfo();
			requireInfo.setCreatetime(DateUtils.getCurrentDate("yyyy-MM-dd"));
			requireInfo.setStatus("1");
			List<Map<String,Object>> requireList = requireInfoService.select(requireInfo);
			Map<String,Object> map = null;
			SalePrice salePrice = null;
			BaseInfo baseInfo = null;
			double price = 0.0;
			DistributionInfo dInfo = null;
			if(0<requireList.size()){
				for (int i = 0; i < requireList.size(); i++) {
					map = requireList.get(i);
					baseInfo = baseInfoService.selectByPrimaryKey((String)map.get("parentid"));
					salePrice = salePriceService.selectByKindAndGrade((String)map.get("kind"), 
							(String)map.get("grade"), DateUtils.getCurrentDate("yyyy-MM-dd"));
					if(null!=salePrice){
						if("2".equals(baseInfo.getType())){
							price = salePrice.getMarket_price();
						}else if("3".equals(baseInfo.getType())){
							price = salePrice.getCanteen_price();
						}else if("4".equals(baseInfo.getType())){
							price = salePrice.getOther_price();
						}
						dInfo = new DistributionInfo();
						dInfo.setCreatetime(DateUtils.getCurrentDate("yyyy-MM-dd"));
						dInfo.setBase_id(baseInfo.getId());
						dInfo.setDistribution_address(baseInfo.getAddress());
						dInfo.setDistribution_id(UUIDFactory.getInstance().newUUID());
						dInfo.setGrade((String)map.get("grade"));
						dInfo.setKind((String)map.get("kind"));
						dInfo.setPrice(price);
						dInfo.setRequire_id((String)map.get("id"));
						dInfo.setRequire_num((double)map.get("num"));
						dInfo.setSum_price(price*(double)map.get("num"));
						dInfo.setRequire_name(baseInfo.getName());
						dInfo.setWps((double)map.get("num"));
						dInfo.setYps(0.0);
						distributionInfoService.insertSelective(dInfo);
					}
				}
				list = distributionInfoService.select(distributionInfo);
				model.addAttribute("list", list);
			}
		}
		return page;
	}
	
	public String detail(HttpServletRequest request,Model model,String id){
		String page = "orderModule/distribution/detail";
		DistributionInfo distributionInfo = distributionInfoService.selectByPrimaryKey(id);
		model.addAttribute("distribution", distributionInfo);
		return page;
	}
}
