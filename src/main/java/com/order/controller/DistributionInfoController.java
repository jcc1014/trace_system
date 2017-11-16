package com.order.controller;

import java.awt.Font;
import java.io.File;
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
import com.order.po.BaseInfo;
import com.order.po.DistributionDetail;
import com.order.po.DistributionInfo;
import com.order.po.RequireInfo;
import com.order.po.SalePrice;
import com.order.po.TotalInfo;
import com.order.service.BaseInfoService;
import com.order.service.DistributionDetailService;
import com.order.service.DistributionInfoService;
import com.order.service.RequireInfoService;
import com.order.service.SalePriceService;
import com.order.service.TotalInfoService;
import com.trace.po.Purchase;
import com.trace.po.Qrcode;
import com.trace.po.TraceFlow;
import com.trace.po.User;
import com.trace.service.PurchaseService;
import com.trace.service.QrcodeService;
import com.trace.service.TraceFlowService;
import com.trace.util.DateUtils;
import com.trace.util.FontImage;
import com.trace.util.QRCodeUtil;
import com.trace.util.ResultUtil;
import com.utils.UUIDFactory;
import com.wechat.util.SendMessage;

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
	@Autowired
	private TotalInfoService totalInfoService;
	@Autowired
	private TraceFlowService traceFlowService;
	@Autowired
	private PurchaseService purchaseService;
	@Autowired
	private QrcodeService qrcodeService;
	
	
	@RequestMapping("distributionListPage")
	public String distributionListPage(HttpServletRequest request,Model model){
		TotalInfo totalInfo = new TotalInfo();
		totalInfo.setCreatetime(DateUtils.getNDayBeforeCurrentDate(1, "yyyy-MM-dd"));
		totalInfo.setType("xqd");
		totalInfo.setStatus("1");
		List<Map<String, Object>> list = totalInfoService.select(totalInfo);
		model.addAttribute("list", list);
		return "orderModule/distribution/distributionListPage";
	}
	
	/**
	 * 今日配送
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping("todayDistribution")
	public String todayDistribution(HttpServletRequest request,String id,String pid,Model model){
		String page = "orderModule/distribution/todayDistribution";
		DistributionInfo distributionInfo = new DistributionInfo();
		distributionInfo.setCreatetime(DateUtils.getCurrentDate("yyyy-MM-dd"));
		distributionInfo.setBase_id(id);
		List<Map<String,Object>> list = distributionInfoService.selectPurchaseed(distributionInfo);
		//List<Map<String,Object>> list = distributionInfoService.select(distributionInfo);
		if(0<list.size()){
			model.addAttribute("list", list);
		}else{
			//生成配送单
			RequireInfo requireInfo = new RequireInfo();
			//requireInfo.setCreatetime(DateUtils.getCurrentDate("yyyy-MM-dd"));
			requireInfo.setCreatetime(DateUtils.getNDayBeforeCurrentDate(1, "yyyy-MM-dd"));
			requireInfo.setParentid(pid);
			requireInfo.setStatus("1");
			List<Map<String,Object>> requireList = requireInfoService.select(requireInfo);
			Map<String,Object> map = null;
			SalePrice salePrice = null;
			TotalInfo totalInfo = null;
			BaseInfo baseInfo = null;
			double price = 0.0;
			DistributionInfo dInfo = null;
			if(0<requireList.size()){
				for (int i = 0; i < requireList.size(); i++) {
					map = requireList.get(i);
					totalInfo = totalInfoService.selectByPrimaryKey((String)map.get("parentid"));
					baseInfo = baseInfoService.selectByPrimaryKey(totalInfo.getSource());
					salePrice = salePriceService.selectByKindAndGrade((String)map.get("kind"), 
							(String)map.get("grade"),(String)map.get("spyb"), DateUtils.getCurrentDate("yyyy-MM-dd"));
					if(null!=salePrice){
						if("2".equals(totalInfo.getSource_type())){
							price = salePrice.getMarket_price();
						}else if("3".equals(totalInfo.getSource_type())){
							price = salePrice.getCanteen_price();
						}else if("4".equals(totalInfo.getSource_type())){
							price = salePrice.getOther_price();
						}
						dInfo = new DistributionInfo();
						dInfo.setCreatetime(DateUtils.getCurrentDate("yyyy-MM-dd"));
						dInfo.setBase_id(baseInfo.getId());
						dInfo.setDistribution_address(baseInfo.getAddress());
						dInfo.setDistribution_id(UUIDFactory.getInstance().newUUID());
						dInfo.setGrade((String)map.get("grade"));
						dInfo.setKind((String)map.get("kind"));
						dInfo.setSpyb((String)map.get("spyb"));
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
				list = distributionInfoService.selectPurchaseed(distributionInfo);
				//list = distributionInfoService.select(distributionInfo);
				model.addAttribute("list", list);
			}
		}
		return page;
	}
	
	@RequestMapping("detail")
	public String detail(HttpServletRequest request,Model model,String id){
		String page = "orderModule/distribution/detail";
		DistributionInfo distributionInfo = distributionInfoService.selectByPrimaryKey(id);
		if(null!=distributionInfo){
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("kind", distributionInfo.getKind());
			map.put("grade", distributionInfo.getGrade());
			map.put("spyb", distributionInfo.getSpyb());
			map.put("datetime", DateUtils.getCurrentDate());
			List<Map<String, Object>> indentifierList = traceFlowService.selectIdentifier(map);
			model.addAttribute("identifierList", indentifierList);
		}
		model.addAttribute("distribution", distributionInfo);
		
		return page;
	}
	
	@RequestMapping("addDetailSave")
	public String addDetailSave(HttpServletRequest request,Model model,DistributionDetail distributionDetail){
		String page = "redirect:todayDistribution.do";
		DistributionInfo distributionInfo = distributionInfoService.selectByPrimaryKey(distributionDetail.getDistribution_id());
		distributionInfo.setYps((null==distributionInfo.getYps()?0.0:distributionInfo.getYps())+distributionDetail.getDistribution_num());
		distributionInfo.setWps(distributionInfo.getRequire_num()-(null==distributionInfo.getYps()?0.0:distributionInfo.getYps()));
		distributionInfoService.updateByPrimaryKeySelective(distributionInfo);
		
		distributionDetail.setId(UUIDFactory.getInstance().newUUID());
		distributionDetail.setCreatetime(DateUtils.getCurrentDate("yyyy-MM-dd HH:mm:ss"));
		distributionDetail.setStatus("1");
		distributionDetail.setPsbh("ps"+DateUtils.getCurrentDate("yyMMddHHmmss"));
		Qrcode qrcode = new Qrcode();
		qrcode.setQrcode_id(UUIDFactory.getInstance().newUUID());
		String path  = request.getSession().getServletContext().getRealPath("/")+"distribution\\";
		String logoPath  = request.getSession().getServletContext().getRealPath("/")+"\\images\\qrcode_logo.png";
		//String content = basePath+"/trace/trace_detail?trace_id="+trace_id;
		//String content = "http://jingcc.xin:8080/trace_system/distribution/getInfo.do?id="+distributionDetail.getId();
		String content = "http://qianzhide.net:8080/trace_system/distribution/getInfo.do?id="+distributionDetail.getId();
		String filename = distributionInfo.getKind()+distributionInfo.getGrade()+"级"
						+DateUtils.getCurrentDate("yyMMddHHmmss");
		qrcode.setQrcode_path(filename+".jpg");
		try {
			int w = 0;
			int h = 210;
			int size = 60;
			if(distributionInfo.getKind().length()==5){
				w = 160;
				h = 160;
				size = 30;
			}
			else if(distributionInfo.getKind().length()==4){
				w = 260;
			}
			else if(distributionInfo.getKind().length()==3){
				w = 200;
			}
			else if(distributionInfo.getKind().length()==2){
				w = 140;
				h = 140;
			}
			FontImage.createImage(distributionInfo.getKind(), new Font("黑体", Font.BOLD, size), new File(  
					logoPath), w, h);
			QRCodeUtil.encode(content, logoPath, path, filename, true);
		} catch (Exception e) {
			e.printStackTrace();
		}
		distributionDetail.setDistribution_qrcode(qrcode.getQrcode_id());
		distributionDetailService.insertSelective(distributionDetail);
		qrcodeService.add(qrcode);
		return page;
	}
	
	@RequestMapping("checkTrace")
	@ResponseBody
	public String checkTrace(HttpServletRequest request,String id)
	{
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("code", "-1");
		TraceFlow traceFlow = new TraceFlow();
		traceFlow.setIdentifier(id);
		List<TraceFlow> list = traceFlowService.selectAllTraceFlow(traceFlow);
		if(1==list.size()){
			Purchase purchase = purchaseService.getById(list.get(0).getPurchase_id());
			map.put("purchase_kind", purchase.getPurchase_kind());
			map.put("purchase_grade", purchase.getPurchase_grade());
			map.put("purchase_num", purchase.getPurchase_num());
			map.put("code", "200");
			DistributionDetail detail = new DistributionDetail();
			detail.setTrace_id(id);
			List<Map<String, Object>> detailList = distributionDetailService.select(detail);
			if (0<detailList.size()) {
				double sum = 0.0;
				for (int i = 0; i < detailList.size(); i++) {
					sum += (double)(detailList.get(i).get("distribution_num"));
				}
				map.put("sum", sum);
				request.getSession().setAttribute("remain", purchase.getPurchase_num()-sum);
				map.put("remain", purchase.getPurchase_num()-sum);
			}else{
				map.put("sum", 0);
				request.getSession().setAttribute("remain", purchase.getPurchase_num());
				map.put("remain", purchase.getPurchase_num());
			}
		}
		return JSON.toJSONString(map);
	}
	
	@RequestMapping("today_sh")
	public String today_sh(HttpServletRequest request,Model model){
		String page = "orderModule/distribution/today_sh";
		Map<String,Object> map = new HashMap<String, Object>();
		map.put("datetime", DateUtils.getCurrentDate("yyyy-MM-dd"));
		User user = (User)request.getSession().getAttribute("user");
		if(null!=user&&"B".equals(user.getUsertype())){
			BaseInfo baseInfo = (BaseInfo)request.getSession().getAttribute("baseInfo");
			if(null!=baseInfo){
				map.put("baseid", baseInfo.getId());
			}
		}
		List<Map<String,Object>> list = distributionInfoService.getDeliverData(map);
		if(0<list.size()&&!"".equals(list.get(0).get("signname"))&&null!=list.get(0).get("signname")){
			model.addAttribute("sign", "1");
		}
		model.addAttribute("list", list);
		return page;
	}
	@RequestMapping("sign")
	public String sign(HttpServletRequest request,Model model,String time,String baseid){
		String page = "orderModule/distribution/sign";
		model.addAttribute("time", time);
		model.addAttribute("baseid", baseid);
		return page;
	}
	@RequestMapping("signSave")
	@ResponseBody
	public String signSave(HttpServletRequest request,String baseid,String time,String signname){
		String rs = "";
		DistributionInfo distributionInfo = new DistributionInfo();
		distributionInfo.setCreatetime(time);
		distributionInfo.setBase_id(baseid);
		List<Map<String, Object>> list = distributionInfoService.select(distributionInfo);
		distributionInfo.setSignname(signname);
		int r = distributionInfoService.updateSignName(distributionInfo);
		if(0<r){
			if(1==list.size()){
				
				String msg = "日期："+time+"\n需求名称："+list.get(0).get("require_name")+"\n 已确认收货";
				SendMessage.sendMsg(msg);
			}
			rs = ResultUtil.resultString(1);
		}else{
			rs = ResultUtil.resultString(0);
		}
		return rs;
	}
	@RequestMapping("today_shDetail")
	public String today_shDetail(HttpServletRequest request,Model model,String baseid,String time){
		String page = "orderModule/distribution/today_shDetail";
		DistributionInfo distributionInfo = new DistributionInfo();
		distributionInfo.setCreatetime(time);
		distributionInfo.setBase_id(baseid);
		List<Map<String, Object>> distributionInfoList = distributionInfoService.select(distributionInfo);
		if(0<distributionInfoList.size()){
			if(null!=distributionInfoList.get(0).get("signname")&&
					!"".equals(distributionInfoList.get(0).get("signname"))){
				model.addAttribute("signname", "已签名确认");
				model.addAttribute("signnameUrl", distributionInfoList.get(0).get("signname"));
			}else{
				model.addAttribute("signname", "未签名确认");
				model.addAttribute("signnameUrl", "");
			}
		}
		model.addAttribute("distributionInfoList", distributionInfoList);
		BaseInfo baseInfo = baseInfoService.selectByPrimaryKey(baseid);
		model.addAttribute("baseInfo", baseInfo);
		model.addAttribute("time", time);
		return page;
	}
 	@RequestMapping("distributionDetailList")
	public String distributionDetailList(HttpServletRequest request,Model model,String id){
		String page = "orderModule/distribution/distributionDetail";
		DistributionInfo distributionInfo = distributionInfoService.selectByPrimaryKey(id);
		model.addAttribute("distributionInfo", distributionInfo);
		DistributionDetail distributionDetail = new DistributionDetail();
		distributionDetail.setDistribution_id(id);
		List<Map<String,Object>> list = distributionDetailService.select(distributionDetail);
		model.addAttribute("list", list);
		return page;
	}
 	
 	@RequestMapping("psList")
 	public String psList(HttpServletRequest request,Model model,
 			DistributionDetail distributionDetail,String page){
 		String p = "orderModule/distribution/list";
 		if("".equals(page)||null==page){
			page = "1";
		}
 		Map<String, Object> map = new HashMap<String, Object>();
 		map.put("createtime", distributionDetail.getCreatetime());
 		map.put("psbh", distributionDetail.getPsbh());
 		map.put("trace_id", distributionDetail.getTrace_id());
		int num = distributionDetailService.count(map);
		if(num%8==0){
			num = num/8;
		}else{
			num = num/8+1;
		}
		model.addAttribute("num", num);
		model.addAttribute("curr", page);
		map.put("index", (Integer.parseInt(page)-1)*8);
 		List<Map<String,Object>> list = distributionDetailService.query(map);
 		DistributionInfo distributionInfo = null;
 		for (int i = 0; i < list.size(); i++) {
			distributionInfo = distributionInfoService.selectByPrimaryKey(list.get(i).get("distribution_id").toString());
			list.get(i).put("distributionInfo", distributionInfo);
 		}
 		model.addAttribute("list", list);
 		return p;
 	}
 	
 	
	@RequestMapping("delivery")
	@ResponseBody
	public String delivery(HttpServletRequest request,DistributionInfo distributionInfo){
		int r = distributionInfoService.updateByPrimaryKeySelective(distributionInfo);
		return ResultUtil.resultString(r);
	}
	@RequestMapping("getQrcode")
	@ResponseBody
	public String getQrcode(HttpServletRequest request,String id){
		Qrcode qrcode = qrcodeService.getById(id);
		if(null!=qrcode){
			return JSON.toJSONString(qrcode); 
		}else{
			return "";
		}
	}
	@RequestMapping("print")
	public String print(HttpServletRequest request,Model model,String id){
		Qrcode qrcode = qrcodeService.getById(id);
		model.addAttribute("qrcode", qrcode);
		return "orderModule/distribution/print";
	}
	
	@RequestMapping("modifyNum")
	@ResponseBody
	public String modifyNum(HttpServletRequest request,DistributionDetail distributionDetail){
		int r = distributionDetailService.updateByPrimaryKeySelective(distributionDetail);
		return ResultUtil.resultString(r);
	}
	
	@RequestMapping("getInfo")
	public String getInfo(HttpServletRequest request,Model model,String id){
		String page = "orderModule/distribution/info";
		DistributionDetail detail = distributionDetailService.selectByPrimaryKey(id);
		model.addAttribute("detail", detail);
		String code = detail.getTrace_id();
		Map<String, Object> traceFlow = traceFlowService.selectFlowByCode(code);
		model.addAttribute("trace", traceFlow);
		if(null!=traceFlow){
			String base_id = null==traceFlow.get("baseid")?null:(String)traceFlow.get("baseid");
			if(null!=base_id){
				BaseInfo baseInfo = baseInfoService.selectByPrimaryKey(base_id);
				model.addAttribute("ycd", baseInfo);
			}
		}
		String distribution_id = detail.getDistribution_id();
		DistributionInfo distributionInfo = distributionInfoService.selectByPrimaryKey(distribution_id);
		model.addAttribute("distributionInfo", distributionInfo);
		BaseInfo xsdw = baseInfoService.selectByPrimaryKey(distributionInfo.getBase_id());
		model.addAttribute("xsdw", xsdw);
		return page;
	}
}
