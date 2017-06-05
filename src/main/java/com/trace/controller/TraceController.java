package com.trace.controller;

import java.io.UnsupportedEncodingException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSON;
import com.trace.po.Farmer;
import com.trace.po.Purchase;
import com.trace.po.Qrcode;
import com.trace.po.Test;
import com.trace.po.TraceFlow;
import com.trace.po.Transport;
import com.trace.po.User;
import com.trace.service.QrcodeService;
import com.trace.service.TestService;
import com.trace.service.TraceFlowService;
import com.trace.service.UserService;

@Controller
@RequestMapping("trace")
public class TraceController {

	@Autowired
	private TraceFlowService traceService;
	@Autowired
	private QrcodeService qrcodeService;
	@Autowired
	private UserService userService;
	@Autowired
	private TestService testService;
	
	@RequestMapping(value="/list.do",produces="text/plain")
	public String list(HttpServletRequest request,Model model,String farmer_name,String starttime,String endtime,String page){
		String p = "trace/list";
		try {
			if(null!=farmer_name&&!"".equals(farmer_name)){
				farmer_name = new String(farmer_name.getBytes("ISO8859-1"),"UTF-8");
			}
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		Map<String,Object> map = new HashMap<String, Object>();
		if("".equals(page)||null==page){
			page = "1";
		}
		map.put("createtime", starttime);
		map.put("createtime", endtime);
		map.put("farmer_name", farmer_name);
		int num = traceService.count(map);
		if(num%8==0){
			num = num/8;
		}else{
			num = num/8+1;
		}
		model.addAttribute("num", num);
		model.addAttribute("curr", page);
		map.put("index", (Integer.parseInt(page)-1)*8);
		List<Map<String,Object>> list = traceService.query(map);
		model.addAttribute("list",list);
		return p;
	}
	
	@RequestMapping("add.do")
	public String add(HttpServletRequest request,Model model){
		String page = "trace/add";
		HttpSession session = request.getSession();
		String trace_id = (String)session.getAttribute("trace_id");
		User purchase = new User();
		purchase.setUsertype("1");
		List<User> purchaseList = userService.query(purchase);
		model.addAttribute("purchaseList", purchaseList);
		User test = new User();
		test.setUsertype("2");
		List<User> testList = userService.query(test);
		model.addAttribute("testList", testList);
		model.addAttribute("trace_id", trace_id);
		if(null!=trace_id&&!"".equals(trace_id)){
			traceService.getTraceDetail(model, trace_id);
		}
		return page;
	}
	@RequestMapping("farmerAdd.do")
	@ResponseBody
	public String farmerAdd(HttpServletRequest request,String trace_id,String farmer_name,String farmer_phone,String farmer_hzs,String farmer_video){
		String rs = "";
		rs = traceService.farmerAdd(trace_id,farmer_name, farmer_phone,farmer_hzs, farmer_video);
		return rs;
	}
	
	@RequestMapping("purchaseAdd.do")
	@ResponseBody
	public String purchaseAdd(HttpServletRequest request,String trace_id,Purchase purchase,String purchase_video){
		String rs = "";
		rs = traceService.purchaseAdd(trace_id, purchase,purchase_video);
		return rs;
	}
	
	@RequestMapping("testAdd.do")
	@ResponseBody
	public String testAdd(HttpServletRequest request,String trace_id,Test test){
		String rs = "";
		rs = traceService.testAdd(trace_id, test);
		return rs;
	}
	
	@RequestMapping("samplingAdd.do")
	@ResponseBody
	public String samplingAdd(HttpServletRequest request,String trace_id,Test test){
		String rs = "";
		rs = traceService.samplingAdd(trace_id, test);
		return rs;
	}
	@RequestMapping("sampling.do")
	public String sampling(HttpServletRequest request,Model model,String sampling_id){
		String page = "trace/samplingEdit";
		Test sampling = testService.getById(sampling_id);
		User test = new User();
		test.setUsertype("2");
		List<User> testList = userService.query(test);
		model.addAttribute("testList", testList);
		model.addAttribute("sampling", sampling);
		return page;
	}
	
	@RequestMapping("samplingSave.do")
	@ResponseBody
	public String samplingSave(HttpServletRequest request,Test sampling){
		Map<String,Object> map = new HashMap<String, Object>(); 
		int r = testService.update(sampling);
		if(r==1){
			map.put("code", "200");
		}else{
			map.put("code", "-1");
		}
		return JSON.toJSONString(map);
	}
	
	
	@RequestMapping("transportAdd.do")
	@ResponseBody
	public String transportAdd(HttpServletRequest request,String trace_id,Transport transport){
		String rs = "";
		rs = traceService.transportAdd(trace_id, transport);
		return rs;
	}
	
	@RequestMapping("qrcodeAdd.do")
	@ResponseBody
	public String qrcodeAdd(HttpServletRequest request,String trace_id,Qrcode qrcode){
		String rs = "";
		rs = traceService.qrcodeAdd(trace_id, qrcode);
		return rs;
	}
	
	@RequestMapping("trace_detail.do")
	public String trace_detail(HttpServletRequest request,Model model,String trace_id){
		String page = "mobile/trace_detail";
		if("".equals(trace_id)){
			page = "mobile/404";
			return page;
		}
		traceService.getTraceDetail(model, trace_id);
		return page;
	}
	
	@RequestMapping("addSave.do")
	@ResponseBody
	public String addSave(HttpServletRequest request,Farmer farmer,Purchase purchase,Test test,
			Transport transport,String farmer_video,String purchase_video,String qrcode,String test_name2,
			String test_time2,String test_machine2,String test_result2,String test_influence2){
		String rs = traceService.addSave(request, farmer, purchase, test, transport, farmer_video, 
				purchase_video, qrcode, test_name2, test_time2, test_machine2,
				test_result2, test_influence2);
		
		return rs;
	}
	
	@RequestMapping("print.do")
	public String print(HttpServletRequest request,String trace_id,Model model){
		TraceFlow traceFlow = traceService.getById(trace_id);
		if(null!=traceFlow){
			Qrcode qrcode = qrcodeService.getById(traceFlow.getQrcode());
			model.addAttribute("qrcode", qrcode);
		}
		model.addAttribute("traceFlow", traceFlow);
		return "trace/print";
	}
}
