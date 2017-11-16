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

import com.order.po.BaseInfo;
import com.order.po.PurchaseInfo;
import com.order.po.TotalInfo;
import com.order.service.BaseInfoService;
import com.order.service.PurchaseInfoService;
import com.order.service.TotalInfoService;
import com.trace.po.Purchase;
import com.trace.po.Qrcode;
import com.trace.po.Test;
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
import com.trace.util.FontImage;
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
	
	/**
	 * 采购列表
	 * @param request
	 * @param model
	 * @param purchaseInfo
	 * @return
	 */
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
			purchaseInfo.setParentid((String)totalInfos.get(0).get("id"));
			List<Map<String, Object>> purchaseInfoList = purchaseInfoService.select(purchaseInfo);
			Test test = null;
			List<Test> testList = null;
			for (int i = 0; i < purchaseInfoList.size(); i++) {
				test = new Test();
				test.setTest_time(DateUtils.getCurrentDate("yyyy-MM-dd"));
				test.setTest_grade((String)purchaseInfoList.get(i).get("grade"));
				test.setTest_kind((String)purchaseInfoList.get(i).get("kind"));
				test.setTest_result("1");
				testList = testService.selectAlltest(test);
				if(0<testList.size()){
					purchaseInfoList.get(i).put("test", "1");
				}
				else{
					purchaseInfoList.get(i).put("test", "0");
				}
			}
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
	
	/**
	 * 新增采购
	 * @param request
	 * @param model
	 * @param purchase_id
	 * @return
	 */
	@RequestMapping("addPurchase")
	public String addPurchase(HttpServletRequest request,Model model,String purchase_id){
		String page = "orderModule/purchase/addPurchase";
		PurchaseInfo purchaseInfo = purchaseInfoService.selectByPrimaryKey(purchase_id);
		Map<String,String> test = new HashMap<String, String>();
		test.put("test_time",DateUtils.getCurrentDate("yyyy-MM-dd"));
		test.put("kind", purchaseInfo.getKind());
		test.put("grade", purchaseInfo.getGrade());
		test.put("spyb", purchaseInfo.getSpyb());
		test.put("result","1");
		test.put("status", "2");
		test.put("qh", "0");
		List<Map<String, Object>> list = testService.getTestInfo(test);
		model.addAttribute("list", list);
		model.addAttribute("purchaseInfo", purchaseInfo);
		return page;
	}
	/**
	 * 新增缺货采购
	 * @param request
	 * @param model
	 * @param purchase_id
	 * @return
	 */
	@RequestMapping("addQhPurchase")
	public String addQhPurchase(HttpServletRequest request,Model model,String purchase_id){
		String page = "orderModule/purchase/addQhPurchase";
		PurchaseInfo purchaseInfo = purchaseInfoService.selectByPrimaryKey(purchase_id);
		Map<String,String> test = new HashMap<String, String>();
		test.put("test_time",DateUtils.getCurrentDate("yyyy-MM-dd HH:mm:ss"));
		test.put("kind", purchaseInfo.getKind());
		test.put("grade", purchaseInfo.getGrade());
		test.put("spyb", purchaseInfo.getSpyb());
		test.put("status", "2");
		test.put("result", "1");
		test.put("qh", "1");
		List<Map<String, Object>> list = testService.getTestInfo(test);
		model.addAttribute("list", list);
		model.addAttribute("purchaseInfo", purchaseInfo);
		return page;
	}
	
	/**
	 * 采购保存
	 * @param request
	 * @param trace_id
	 * @param purchase
	 * @param transport
	 * @return
	 */
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
		request.getSession().setAttribute("transport_user", transport.getTransport_user());
		request.getSession().setAttribute("transport_truck", transport.getTransport_truck());
		request.getSession().setAttribute("transport_desitination", transport.getTransport_destination());
		Qrcode qrcode = new Qrcode();
		qrcode.setQrcode_id(UUIDFactory.getInstance().newUUID());
		//String path  = request.getSession().getServletContext().getRealPath("/")+"qrcode\\";
		//String logoPath  = request.getSession().getServletContext().getRealPath("/")+"\\images\\qrcode_logo.png";
		//String content = "http://119.188.168.205:8080/trace_system/trace/trace_detail.do?trace_id="+traceFlow.getTrace_id();
		//String content = "http://jingcc.xin:8080/trace_system/trace/trace_detail.do?trace_id="+traceFlow.getTrace_id();
		String filename = UUIDFactory.getInstance().newUUID();
		try {
			//QRCodeUtil.encode(content, logoPath, path, filename, true);
			qrcode.setQrcode_path(filename+".jpg");
			qrcodeService.add(qrcode);
			traceFlow.setQrcode(qrcode.getQrcode_id());
		} catch (Exception e) {
			e.printStackTrace();
		}
		traceFlowService.update(traceFlow);
		
		return page;
	}
	
	//现在在用
	@RequestMapping("addPurchaseSave2")
	@ResponseBody
	public String addPurchaseSave2(HttpServletRequest request,String farmer_id,Purchase purchase,Transport transport){
		purchase.setPurchase_id(UUIDFactory.getInstance().newUUID());
		purchase.setPurchase_time(DateUtils.getCurrentDate());
		TraceFlow traceFlow = new TraceFlow();
		traceFlow.setTrace_id(UUIDFactory.getInstance().newUUID());
		traceFlow.setPurchase_id(purchase.getPurchase_id());
		traceFlow.setCreatetime(DateUtils.getCurrentDate());
		traceFlow.setFarmer_id(farmer_id);
		traceFlow.setIdentifier("qhcg"+DateUtils.getCurrentDate("yyyyMMddHHmmss"));
		purchaseService.add(purchase);
		PurchaseInfo purchaseInfo = new PurchaseInfo();
		PurchaseInfo purchaseInfo2 = purchaseInfoService.selectByPrimaryKey(purchase.getPurchase_parentid());
		purchaseInfo.setPurchase_id(purchase.getPurchase_parentid());
		purchaseInfo.setRemain_number(purchaseInfo2.getRemain_number()-purchase.getPurchase_num());
		if(0==purchaseInfo.getRemain_number()){
			purchaseInfo.setStatus("1");
		}
		purchaseInfoService.updateByPrimaryKeySelective(purchaseInfo);
		//增加运输信息
		transport.setTransport_id(UUIDFactory.getInstance().newUUID());
		traceFlow.setTransport_id(transport.getTransport_id());
		traceFlow.setTrace_status("1");
		transportService.add(transport);
		request.getSession().setAttribute("transport_user", transport.getTransport_user());
		request.getSession().setAttribute("transport_truck", transport.getTransport_truck());
		request.getSession().setAttribute("transport_desitination", transport.getTransport_destination());
		request.getSession().setAttribute("farmer_id", farmer_id);
		//Qrcode qrcode = new Qrcode();
		//qrcode.setQrcode_id(UUIDFactory.getInstance().newUUID());
		//String path  = request.getSession().getServletContext().getRealPath("/")+"qrcode\\";
		//String content = "http://jingcc.xin:8080/trace_system/trace/trace_detail.do?trace_id="+traceFlow.getTrace_id();
		//String content = "http://qianzhide.net:8080/trace_system/trace/trace_detail.do?trace_id="+traceFlow.getTrace_id();
		//String filename = purchaseInfo2.getKind()+purchaseInfo2.getGrade()+DateUtils.getCurrentDate("yyMMddHHmmss");
		try {
			/*String logoPath  = request.getSession().getServletContext().getRealPath("/")+"\\images\\qrcode_logo2.png";
			int w = 0;
			int h = 210;
			int size = 60;
			if(purchaseInfo2.getKind().length()==5){
				w = 160;
				h = 160;
				size = 30;
			}
			else if(purchaseInfo2.getKind().length()==4){
				w = 260;
			}
			else if(purchaseInfo2.getKind().length()==3){
				w = 200;
			}
			else if(purchaseInfo2.getKind().length()==2){
				w = 140;
				h = 140;
			}
			FontImage.createImage(purchaseInfo2.getKind(), new Font("宋体", Font.BOLD, size), new File(  
					logoPath), w, h); 
			QRCodeUtil.encode(content, logoPath, path, filename, true);
			qrcode.setQrcode_path(filename+".jpg");
			qrcodeService.add(qrcode);
			traceFlow.setQrcode(qrcode.getQrcode_id());*/
			traceFlowService.add(traceFlow);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "1";
	}
	/**
	 * 缺货采购保存
	 * @param request
	 * @param trace_id
	 * @param purchase
	 * @param transport
	 * @return
	 */
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
		//Qrcode qrcode = new Qrcode();
		//qrcode.setQrcode_id(UUIDFactory.getInstance().newUUID());
		//String path  = request.getSession().getServletContext().getRealPath("/")+"qrcode\\";
		//String logoPath  = request.getSession().getServletContext().getRealPath("/")+"\\images\\qrcode_logo.png";
		//String content = "http://119.188.168.205:8080/trace_system/trace/trace_detail.do?trace_id="+traceFlow.getTrace_id();
		//String content = "http://jingcc.xin:8080/trace_system/trace/trace_detail.do?trace_id="+traceFlow.getTrace_id();
		//String filename = UUIDFactory.getInstance().newUUID();
		/*try {
			QRCodeUtil.encode(content, logoPath, path, filename, true);
			setQrcode_path(filename+".jpg");
			qrcodeService.add(qrcode);
			traceFlow.setQrcode(qrcode.getQrcode_id());
		} catch (Exception e) {
			e.printStackTrace();
		}*/
		traceFlowService.update(traceFlow);
		return page;
	}
	
	/**
	 * 历史纪录
	 * @param request
	 * @param model
	 * @param purchase
	 * @return
	 */
	@RequestMapping("history")
	public String history(HttpServletRequest request,Model model,Purchase purchase){
		String page = "orderModule/purchase/purchaseHistory";
		User user = (User)request.getSession().getAttribute("user");
		if(null==purchase.getPurchase_time()||"".equals(purchase.getPurchase_time())){
			purchase.setPurchase_time(DateUtils.getNDayBeforeCurrentDate(1, "yyyy-MM-dd"));
		}
		purchase.setPurchase_user(user==null?null:user.getRealname());
		List<Map<String,Object>> list = purchaseService.selectPurchase(purchase);
		model.addAttribute("list", list);
		return page;
	}
	/**
	 * 查看采购详情
	 * @param request
	 * @param model
	 * @param purchase
	 * @return
	 */
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
	/**
	 * 通过id查看单个采购详情
	 * @param request
	 * @param model
	 * @param id
	 * @return
	 */
	@RequestMapping("watchPurchaseDetailById")
	public String watchPurchaseDetailById(HttpServletRequest request,Model model,String id){
		String page = "orderModule/purchase/purchaseDetail";
		Purchase purchase = new Purchase();
		purchase.setPurchase_parentid(id);
		List<Map<String,Object>> list = purchaseService.selectPurchase(purchase);
		model.addAttribute("list", list);
		return page;
	}
}
