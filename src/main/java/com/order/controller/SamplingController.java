package com.order.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.mall.service.GoodsService;
import com.order.po.PurchaseInfo;
import com.order.service.PurchaseInfoService;
import com.trace.po.Farmer;
import com.trace.po.Test;
import com.trace.po.TraceFlow;
import com.trace.po.User;
import com.trace.service.FarmerService;
import com.trace.service.TestService;
import com.trace.service.TraceFlowService;
import com.trace.util.DateUtils;
import com.trace.util.ResultUtil;
import com.utils.UUIDFactory;

@Controller
@RequestMapping("sampling")
public class SamplingController {

	@Autowired
	private TestService testService;
	@Autowired
	private FarmerService farmerService;
	@Autowired
	private TraceFlowService traceFlowService;
	@Autowired
	private GoodsService goodsService;
	@Autowired
	private PurchaseInfoService purchaseInfoService;
	
	@RequestMapping("today_sampling")
	public String today_sampling(HttpServletRequest request,Model model){
		String page = "orderModule/sampling/todaySampling";
		User user = (User)request.getSession().getAttribute("user");
		Test test = new Test();
		test.setTest_time(DateUtils.getCurrentDate("yyyy-MM-dd"));
		test.setTest_name(user==null?null:user.getUsername());
		test.setIsQh("0");
		List<Test> testList = testService.selectAlltest(test);
		List<Map<String, Object>> list = new ArrayList<Map<String,Object>>();
		Map<String, Object> map = null;
		TraceFlow traceFlow = null;
		List<TraceFlow> traceFlowList = null;
		if(0<testList.size()){
			for (int i = 0; i < testList.size(); i++) {
				map = new HashMap<String, Object>();
				map.put("test", testList.get(i));
				traceFlow = new TraceFlow();
				traceFlow.setTest_id(testList.get(i).getTest_id());
				traceFlowList = traceFlowService.selectAllTraceFlow(traceFlow);
				map.put("trace", traceFlowList.size()>0?traceFlowList.get(0):null);
				if(traceFlowList.size()>0){
					map.put("farmer", farmerService.getById(traceFlowList.get(0).getFarmer_id()));
				}
				list.add(map);
			}
		}
		model.addAttribute("testList", testList);
		model.addAttribute("list", list);
		return page;
	}
	@RequestMapping("today_Qhsampling")
	public String today_Qhsampling(HttpServletRequest request,Model model){
		String page = "orderModule/sampling/todayQhSampling";
		User user = (User)request.getSession().getAttribute("user");
		Test test = new Test();
		test.setTest_time(DateUtils.getCurrentDate("yyyy-MM-dd"));
		test.setTest_name(user==null?null:user.getUsername());
		test.setIsQh("1");
		List<Test> testList = testService.selectAlltest(test);
		List<Map<String, Object>> list = new ArrayList<Map<String,Object>>();
		Map<String, Object> map = null;
		TraceFlow traceFlow = null;
		List<TraceFlow> traceFlowList = null;
		if(0<testList.size()){
			for (int i = 0; i < testList.size(); i++) {
				map = new HashMap<String, Object>();
				map.put("test", testList.get(i));
				traceFlow = new TraceFlow();
				traceFlow.setTest_id(testList.get(i).getTest_id());
				traceFlowList = traceFlowService.selectAllTraceFlow(traceFlow);
				map.put("trace", traceFlowList.size()>0?traceFlowList.get(0):null);
				if(traceFlowList.size()>0){
					map.put("farmer", farmerService.getById(traceFlowList.get(0).getFarmer_id()));
				}
				list.add(map);
			}
		}
		model.addAttribute("testList", testList);
		model.addAttribute("list", list);
		return page;
	}
	@RequestMapping("history")
	public String history(HttpServletRequest request,Model model,String datetime){
		String page = "orderModule/sampling/history";
		User user = (User)request.getSession().getAttribute("user");
		Test test = new Test();
		if(null==datetime||"".equals(datetime)){
			test.setTest_time(DateUtils.getNDayBeforeCurrentDate(1, "yyyy-MM-dd"));
		}
		test.setTest_name(user==null?null:user.getUsername());
		test.setTest_status("1");
		List<Test> testList = testService.selectAlltest(test);
		List<Map<String, Object>> list = new ArrayList<Map<String,Object>>();
		Map<String, Object> map = null;
		TraceFlow traceFlow = null;
		List<TraceFlow> traceFlowList = null;
		if(0<testList.size()){
			for (int i = 0; i < testList.size(); i++) {
				map = new HashMap<String, Object>();
				map.put("test", testList.get(i));
				traceFlow = new TraceFlow();
				traceFlow.setTest_id(testList.get(i).getTest_id());
				traceFlowList = traceFlowService.selectAllTraceFlow(traceFlow);
				map.put("trace", traceFlowList.size()>0?traceFlowList.get(0):null);
				if(traceFlowList.size()>0){
					map.put("farmer", farmerService.getById(traceFlowList.get(0).getFarmer_id()));
				}
				list.add(map);
			}
		}
		model.addAttribute("testList", testList);
		model.addAttribute("list", list);
		return page;
	}
	
	@RequestMapping("addSampling")
	public String addSampling(HttpServletRequest request,Model model){
		String page = "orderModule/sampling/addSampling";
		PurchaseInfo purchaseInfo = new PurchaseInfo();
		purchaseInfo.setCreatetime(DateUtils.getCurrentDate("yyyy-MM-dd"));
		purchaseInfo.setStatus("1");
		List<Map<String,Object>> purchaseInfoList = purchaseInfoService.select(purchaseInfo);
		model.addAttribute("purchaseInfoList", purchaseInfoList);
		return page;
	}
	@RequestMapping("addQhSampling")
	public String addQhSampling(HttpServletRequest request,Model model){
		String page = "orderModule/sampling/addQhSampling";
		PurchaseInfo purchaseInfo = new PurchaseInfo();
		purchaseInfo.setCreatetime(DateUtils.getCurrentDate("yyyy-MM-dd"));
		purchaseInfo.setStatus("1");
		purchaseInfo.setType("1");
		List<Map<String,Object>> purchaseInfoList = purchaseInfoService.select(purchaseInfo);
		model.addAttribute("purchaseInfoList", purchaseInfoList);
		return page;
	}
	@RequestMapping("addSamplingSave")
	public String addSamplingSave(HttpServletRequest request,Test test,Farmer farmer){
		User user = (User)request.getSession().getAttribute("user");
		String page = "redirect:today_sampling.do";
		farmer.setFarmer_id(UUIDFactory.getInstance().newUUID());
		String test_kind = test.getTest_kind();
		test.setTest_kind(test_kind.split(";")[0]);
		test.setTest_grade(test_kind.split(";")[1]);
		test.setTest_time(DateUtils.getCurrentDate());
		test.setTest_id(UUIDFactory.getInstance().newUUID());
		test.setTest_status("0");
		test.setTest_name(user==null?null:user.getUsername());
		test.setTest_type("0");
		test.setIsQh("0");
		TraceFlow traceFlow = new TraceFlow();
		traceFlow.setCreatetime(DateUtils.getCurrentDate());
		traceFlow.setTest_id(test.getTest_id());
		traceFlow.setFarmer_id(farmer.getFarmer_id());
		traceFlow.setTrace_id(UUIDFactory.getInstance().newUUID());
		traceFlowService.add(traceFlow);
		testService.add(test);
		farmerService.add(farmer);
		return page;
	}
	@RequestMapping("addQhSamplingSave")
	public String addQhSamplingSave(HttpServletRequest request,Test test,Farmer farmer){
		User user = (User)request.getSession().getAttribute("user");
		String page = "redirect:today_Qhsampling.do";
		farmer.setFarmer_id(UUIDFactory.getInstance().newUUID());
		String test_kind = test.getTest_kind();
		test.setTest_kind(test_kind.split(";")[0]);
		test.setTest_grade(test_kind.split(";")[1]);
		test.setTest_time(DateUtils.getCurrentDate());
		test.setTest_id(UUIDFactory.getInstance().newUUID());
		test.setTest_status("0");
		test.setTest_name(user==null?null:user.getUsername());
		test.setTest_type("0");
		test.setIsQh("1");
		TraceFlow traceFlow = new TraceFlow();
		traceFlow.setCreatetime(DateUtils.getCurrentDate());
		traceFlow.setTest_id(test.getTest_id());
		traceFlow.setFarmer_id(farmer.getFarmer_id());
		traceFlow.setTrace_id(UUIDFactory.getInstance().newUUID());
		traceFlowService.add(traceFlow);
		testService.add(test);
		farmerService.add(farmer);
		return page;
	}
	
	@RequestMapping("delSampling")
	@ResponseBody
	public String delSampling(HttpServletRequest request,String id){
		int r = testService.deleteById(id);
		String rs = ResultUtil.resultString(r);
		return rs;
	}
	
	@RequestMapping("submitQyd")
	@ResponseBody
	public String submitQyd(HttpServletRequest request){
		String rs = "";
		User user = (User)request.getSession().getAttribute("user");
		Test test = new Test();
		if(null!=user){
			test.setTest_time(DateUtils.getCurrentDate("yyyy-MM-dd"));
			test.setTest_name(user.getUsername());
			test.setTest_status("1");
			int r = testService.updateByNameAndTime(test);
			rs = ResultUtil.resultString(r>0?1:0);
		}
		return rs;
	}
	
	@RequestMapping("submitQhQyd")
	@ResponseBody
	public String submitQhQyd(HttpServletRequest request){
		String rs = "";
		User user = (User)request.getSession().getAttribute("user");
		Test test = new Test();
		if(null!=user){
			test.setTest_time(DateUtils.getCurrentDate("yyyy-MM-dd"));
			test.setTest_name(user.getUsername());
			test.setTest_status("1");
			int r = testService.updateByNameAndTime(test);
			rs = ResultUtil.resultString(r>0?1:0);
		}
		return rs;
	}
	
	@RequestMapping("testList")
	public String testPage(HttpServletRequest request,Model model,String page){
		String p = "orderModule/sampling/list";
		Map<String, Object> test = new HashMap<String, Object>();
		test.put("test_time", DateUtils.getCurrentDate("yyyy-MM-dd"));
		test.put("test_status", "1");
		if("".equals(page)||null==page){
			page = "1";
		}
		int num = testService.count(test);
		if(num%8==0){
			num = num/8;
		}else{
			num = num/8+1;
		}
		model.addAttribute("num", num);
		model.addAttribute("curr", page);
		test.put("index", (Integer.parseInt(page)-1)*8);
		List<Test> testList = testService.query(test);
		List<Map<String, Object>> list = new ArrayList<Map<String,Object>>();
		Map<String, Object> map = null;
		TraceFlow traceFlow = null;
		List<TraceFlow> traceFlowList = null;
		if(0<testList.size()){
			for (int i = 0; i < testList.size(); i++) {
				map = new HashMap<String, Object>();
				map.put("test", testList.get(i));
				traceFlow = new TraceFlow();
				traceFlow.setTest_id(testList.get(i).getTest_id());
				traceFlowList = traceFlowService.selectAllTraceFlow(traceFlow);
				map.put("trace", traceFlowList.size()>0?traceFlowList.get(0):null);
				if(traceFlowList.size()>0){
					map.put("farmer", farmerService.getById(traceFlowList.get(0).getFarmer_id()));
				}
				list.add(map);
			}
		}
		model.addAttribute("testList", testList);
		model.addAttribute("list", list);
		return p;
	}
	@RequestMapping("hadTestList")
	public String hadTestList(HttpServletRequest request,Model model,String page,String datetime,String result){
		String p = "orderModule/sampling/hadTestList";
		Map<String, Object> test = new HashMap<String, Object>();
		test.put("test_status", "2");
		User user = (User)request.getSession().getAttribute("user");
		if(null!=user){
			test.put("test_user", user.getUsername());
		}
		if(null!=datetime&&"".equals(datetime)){
			test.put("test_time", datetime);
		}
		if(null!=result&&"".equals(result)){
			test.put("test_result", result);
		}
		if("".equals(page)||null==page){
			page = "1";
		}
		int num = testService.count(test);
		if(num%8==0){
			num = num/8;
		}else{
			num = num/8+1;
		}
		model.addAttribute("test_result", result);
		model.addAttribute("test_time", datetime);
		model.addAttribute("num", num);
		model.addAttribute("curr", page);
		test.put("index", (Integer.parseInt(page)-1)*8);
		List<Test> testList = testService.query(test);
		List<Map<String, Object>> list = new ArrayList<Map<String,Object>>();
		Map<String, Object> map = null;
		TraceFlow traceFlow = null;
		List<TraceFlow> traceFlowList = null;
		if(0<testList.size()){
			for (int i = 0; i < testList.size(); i++) {
				map = new HashMap<String, Object>();
				map.put("test", testList.get(i));
				traceFlow = new TraceFlow();
				traceFlow.setTest_id(testList.get(i).getTest_id());
				traceFlowList = traceFlowService.selectAllTraceFlow(traceFlow);
				map.put("trace", traceFlowList.size()>0?traceFlowList.get(0):null);
				if(traceFlowList.size()>0){
					map.put("farmer", farmerService.getById(traceFlowList.get(0).getFarmer_id()));
				}
				list.add(map);
			}
		}
		model.addAttribute("testList", testList);
		model.addAttribute("list", list);
		return p;
	}
	
	@RequestMapping("testSamplings")
	public String testSamplings(HttpServletRequest request,Model model,String test_id){
		String page = "orderModule/sampling/addTest";
		Test test = testService.getById(test_id);
		model.addAttribute("test", test);
		return page;
	}
	@RequestMapping("watchSamplings")
	public String watchSamplings(HttpServletRequest request,Model model,String test_id){
		String page = "orderModule/sampling/watchTest";
		Test test = testService.getById(test_id);
		model.addAttribute("test", test);
		return page;
	}
	
	@RequestMapping("testSave")
	@ResponseBody
	public String testSave(HttpServletRequest request,Model model,Test test){
		String rs = "";
		test.setTest_status("2");
		User user = (User)request.getSession().getAttribute("user");
		if(null!=user){
			test.setTest_user(user.getUsername());
		}
		int r = testService.update(test);
		rs = ResultUtil.resultString(r);
		return rs;
	}
}
