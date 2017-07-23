package com.order.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.order.po.BaseInfo;
import com.order.po.PurchaseInfo;
import com.order.po.TotalInfo;
import com.order.service.BaseInfoService;
import com.order.service.PurchaseInfoService;
import com.order.service.TotalInfoService;
import com.trace.po.Purchase;
import com.trace.po.Qrcode;
import com.trace.po.TraceFlow;
import com.trace.po.Transport;
import com.trace.po.User;
import com.trace.service.FarmerService;
import com.trace.service.PurchaseService;
import com.trace.service.QrcodeService;
import com.trace.service.TestService;
import com.trace.service.TraceFlowService;
import com.trace.service.TransportService;
import com.trace.service.UserService;
import com.trace.util.DateUtils;
import com.trace.util.QRCodeUtil;
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
	@Autowired
	private TotalInfoService totalInfoService;
	@Autowired
	private BaseInfoService baseInfoService;
	@Autowired
	private UserService userService;
	@Autowired
	private TransportService transportService;
	@Autowired
	private QrcodeService qrcodeService;
	
	@RequestMapping("purchaseList")
	public String purchaseList(HttpServletRequest request,Model model,PurchaseInfo purchaseInfo){
		String page = "orderModule/purchase/purchaseList";
		User user = (User)request.getSession().getAttribute("user");
		TotalInfo totalInfo = new TotalInfo();
		totalInfo.setCreatetime(DateUtils.getCurrentDate("yyyy-MM-dd"));
		totalInfo.setType("cgd");
		totalInfo.setSource(user.getBaseid());
		totalInfo.setStatus("1");
		List<Map<String, Object>>  totalInfos = totalInfoService.select(totalInfo);
		if(1==totalInfos.size()){
			purchaseInfo.setParentid(totalInfo.getId());
			List<Map<String, Object>> purchaseInfoList = purchaseInfoService.select(purchaseInfo);
			model.addAttribute("purchaseInfos", purchaseInfoList);
			model.addAttribute("totalInfo", totalInfos.get(0));
			BaseInfo baseInfo = baseInfoService.selectByPrimaryKey(user.getBaseid());
			if(null!=baseInfo){
				User u = userService.getById(baseInfo.getFzr());
				model.addAttribute("u", u);
				model.addAttribute("baseInfo", baseInfo);
			}else{
				model.addAttribute("u", null);
				model.addAttribute("baseInfo", null);
			}
			
		}
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
	@RequestMapping("addQhPurchase")
	public String addQhPurchase(HttpServletRequest request,Model model,String purchase_id){
		String page = "orderModule/purchase/addQhPurchase";
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
	public String addPurchaseSave(HttpServletRequest request,String trace_id,Purchase purchase,Transport transport){
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
		//增加运输信息
		transport.setTransport_id(UUIDFactory.getInstance().newUUID());
		traceFlow.setTransport_id(transport.getTransport_id());
		traceFlow.setTrace_status("6");
		traceFlow.setIdentifier(DateUtils.getCurrentDate("yyyyMMddHHmmss"));
		transportService.add(transport);
		Qrcode qrcode = new Qrcode();
		qrcode.setQrcode_id(UUIDFactory.getInstance().newUUID());
		String path  = request.getSession().getServletContext().getRealPath("/")+"qrcode\\";
		String logoPath  = request.getSession().getServletContext().getRealPath("/")+"\\images\\qrcode_logo.png";
		String content = "http://jingcc.xin:8080/trace_system/trace/trace_detail.do?trace_id="+traceFlow.getTrace_id();
		String filename = UUIDFactory.getInstance().newUUID();
		try {
			QRCodeUtil.encode(content, logoPath, path, filename, true);
			qrcode.setQrcode_path(filename+".jpg");
			qrcodeService.add(qrcode);
			traceFlow.setQrcode(qrcode.getQrcode_id());
		} catch (Exception e) {
			e.printStackTrace();
		}
		traceFlowService.update(traceFlow);
		
		return page;
	}
	@RequestMapping("addQhPurchaseSave")
	public String addQhPurchaseSave(HttpServletRequest request,String trace_id,Purchase purchase,Transport transport){
		String page = "redirect:/purchaseInfo/getQhd.do";
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
		//增加运输信息
		transport.setTransport_id(UUIDFactory.getInstance().newUUID());
		traceFlow.setTransport_id(transport.getTransport_id());
		traceFlow.setTrace_status("6");
		traceFlow.setIdentifier(DateUtils.getCurrentDate("yyyyMMddHHmmss"));
		transportService.add(transport);
		Qrcode qrcode = new Qrcode();
		qrcode.setQrcode_id(UUIDFactory.getInstance().newUUID());
		String path  = request.getSession().getServletContext().getRealPath("/")+"qrcode\\";
		String logoPath  = request.getSession().getServletContext().getRealPath("/")+"\\images\\qrcode_logo.png";
		String content = "http://jingcc.xin:8080/trace_system/trace/trace_detail.do?trace_id="+traceFlow.getTrace_id();
		String filename = UUIDFactory.getInstance().newUUID();
		try {
			QRCodeUtil.encode(content, logoPath, path, filename, true);
			qrcode.setQrcode_path(filename+".jpg");
			qrcodeService.add(qrcode);
			traceFlow.setQrcode(qrcode.getQrcode_id());
		} catch (Exception e) {
			e.printStackTrace();
		}
		traceFlowService.update(traceFlow);
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
