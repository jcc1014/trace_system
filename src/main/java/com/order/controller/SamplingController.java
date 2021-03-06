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

import com.alibaba.fastjson.JSON;
import com.mall.service.GoodsService;
import com.order.po.BaseInfo;
import com.order.po.PurchaseInfo;
import com.order.service.BaseInfoService;
import com.order.service.PurchaseInfoService;
import com.trace.po.Farmer;
import com.trace.po.Test;
import com.trace.po.TraceFlow;
import com.trace.po.User;
import com.trace.service.FarmerService;
import com.trace.service.PurchaseService;
import com.trace.service.TestService;
import com.trace.service.TraceFlowService;
import com.trace.util.DateUtils;
import com.trace.util.ResultUtil;
import com.utils.UUIDFactory;
import com.wechat.util.SendMessage;

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
	@Autowired
	private BaseInfoService baseInfoService;
	@Autowired
	private PurchaseService purchaseService;
	
	@RequestMapping("today_sampling")
	public String today_sampling(HttpServletRequest request,Model model){
		String page = "orderModule/sampling/todaySampling";
		User user = (User)request.getSession().getAttribute("user");
		Test test = new Test();
		test.setTest_time(DateUtils.getCurrentDate("yyyy-MM-dd"));
		test.setTest_name(user==null?null:user.getRealname());
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
		test.setTest_name(user==null?null:user.getRealname());
		test.setIsQh("1");
		List<Test> testList = testService.selectQhTest(test);
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
		test.setTest_name(user==null?null:user.getRealname());
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
		purchaseInfo.setType("0");
		List<Map<String,Object>> purchaseInfoList = purchaseInfoService.select(purchaseInfo);
		model.addAttribute("purchaseInfoList", purchaseInfoList);
		model.addAttribute("test_bh", "qy"+DateUtils.getCurrentDate("yyMMddHHmmss"));
		Map<String, Object> baseMap = new HashMap<String, Object>();
		baseMap.put("type", "1"); //生产基地
		List<BaseInfo> scjdList = baseInfoService.select(baseMap);
		baseMap.put("type", "5"); //供应基地
		List<BaseInfo> gyjdList = baseInfoService.select(baseMap);
		List<BaseInfo> baseList = new ArrayList<BaseInfo>();
		baseList.addAll(scjdList);
		baseList.addAll(gyjdList);
		model.addAttribute("baseList", baseList);
		return page;
	}
	@RequestMapping("addQhSampling")
	public String addQhSampling(HttpServletRequest request,Model model){
		String page = "orderModule/sampling/addQhSampling";
		PurchaseInfo purchaseInfo = new PurchaseInfo();
		purchaseInfo.setCreatetime(DateUtils.getCurrentDate("yyyy-MM-dd"));
		purchaseInfo.setStatus("1");
		purchaseInfo.setType("1");
		List<Map<String,Object>> purchaseInfoList = purchaseInfoService.selectQh(purchaseInfo);
		model.addAttribute("purchaseInfoList", purchaseInfoList);
		model.addAttribute("test_bh", "qhqy"+DateUtils.getCurrentDate("yyMMddHHmmss"));
		Map<String, Object> baseMap = new HashMap<String, Object>();
		baseMap.put("type", "A"); //补货市场
		List<BaseInfo> scjdList = baseInfoService.select(baseMap);
		List<BaseInfo> baseList = new ArrayList<BaseInfo>();
		baseList.addAll(scjdList);
		model.addAttribute("baseList", baseList);
		return page;
	}
	@RequestMapping("addQhSampling2")
	public String addQhSampling2(HttpServletRequest request,Model model){
		String page = "orderModule/sampling/todaySamplingList";
		TraceFlow traceFlow = new TraceFlow();
		traceFlow.setCreatetime(DateUtils.getCurrentDate("yyyy-MM-dd"));
		traceFlow.setTrace_status("1");
		List<TraceFlow> tList = traceFlowService.selectAllTraceFlow(traceFlow);
		TraceFlow t = null;
		List<Map<String,Object>> list = new ArrayList<Map<String,Object>>();
		if(0<tList.size()){
			Map<String,Object> map =null;
			for (int i = 0; i < tList.size(); i++) {
				t = tList.get(i);
				map = new HashMap<String, Object>();
				map.put("trace_flow", t);
				map.put("farmer", farmerService.getById(t.getFarmer_id()));
				map.put("purchase", purchaseService.getById(t.getPurchase_id()));
				map.put("qybh", "qhqy"+DateUtils.getCurrentDate("yyyyMMddHHmmss"));
				list.add(map);
			}
		}
		model.addAttribute("list", list);
		return page;
	}
	@RequestMapping("addSamplingSave")
	public String addSamplingSave(HttpServletRequest request,Test test,Farmer farmer){
		User user = (User)request.getSession().getAttribute("user");
		String page = "redirect:today_sampling.do";
		Farmer f = farmerService.getByPhone(farmer.getFarmer_phone());
		if(null==f){
			farmer.setFarmer_id(UUIDFactory.getInstance().newUUID());
			farmerService.add(farmer);
		}else{
			farmer = f;
		}
		String test_kind = test.getTest_kind();
		test.setTest_kind(test_kind.split(";")[0]);
		test.setTest_grade(test_kind.split(";")[1]);
		test.setTest_spyb(test_kind.split(";")[2]);
		test.setTest_time(DateUtils.getCurrentDate());
		test.setTest_id(UUIDFactory.getInstance().newUUID());
		test.setTest_status("0");
		test.setTest_name(user==null?null:user.getRealname());
		test.setTest_type("0");
		test.setIsQh("0");
		TraceFlow traceFlow = new TraceFlow();
		traceFlow.setCreatetime(DateUtils.getCurrentDate());
		traceFlow.setTest_id(test.getTest_id());
		traceFlow.setFarmer_id(farmer.getFarmer_id());
		traceFlow.setTrace_id(UUIDFactory.getInstance().newUUID());
		traceFlowService.add(traceFlow);
		testService.add(test);
		return page;
	}
	@RequestMapping("addQhSamplingSave")
	public String addQhSamplingSave(HttpServletRequest request,Test test,Farmer farmer){
		User user = (User)request.getSession().getAttribute("user");
		String page = "redirect:today_Qhsampling.do";
		//farmer.setFarmer_id(UUIDFactory.getInstance().newUUID());
		Farmer f = farmerService.getByPhone(farmer.getFarmer_phone());
		if(null==f){
			farmer.setFarmer_id(UUIDFactory.getInstance().newUUID());
			farmerService.add(farmer);
		}else{
			farmer = f;
		}
		String test_kind = test.getTest_kind();
		test.setTest_kind(test_kind.split(";")[0]);
		test.setTest_grade(test_kind.split(";")[1]);
		test.setTest_spyb(test_kind.split(";")[2]);
		test.setTest_time(DateUtils.getCurrentDate());
		test.setTest_id(UUIDFactory.getInstance().newUUID());
		test.setTest_status("0");
		test.setTest_name(user==null?null:user.getRealname());
		test.setTest_type("0");
		test.setIsQh("1");
		TraceFlow traceFlow = new TraceFlow();
		traceFlow.setCreatetime(DateUtils.getCurrentDate());
		traceFlow.setTest_id(test.getTest_id());
		traceFlow.setFarmer_id(farmer.getFarmer_id());
		traceFlow.setTrace_id(UUIDFactory.getInstance().newUUID());
		traceFlowService.add(traceFlow);
		testService.add(test);
		//farmerService.add(farmer);
		return page;
	}
	@RequestMapping("addQhSamplingSave2")
	public String addQhSamplingSave2(HttpServletRequest request,Test test,Farmer farmer,String trace_id){
		User user = (User)request.getSession().getAttribute("user");
		String page = "redirect:addQhSampling2.do";
		test.setTest_time(DateUtils.getCurrentDate());
		test.setTest_id(UUIDFactory.getInstance().newUUID());
		test.setTest_status("0");
		test.setTest_name(user==null?null:user.getRealname());
		test.setTest_type("0");
		test.setIsQh("1");
		TraceFlow traceFlow = new TraceFlow();
		traceFlow.setTest_id(test.getTest_id());
		traceFlow.setTrace_id(trace_id);
		traceFlow.setTrace_status("6");
		traceFlowService.update(traceFlow);
		testService.add(test);
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
			test.setTest_name(user.getRealname());
			test.setTest_status("1");
			int r = testService.updateByNameAndTime(test);
			rs = ResultUtil.resultString(r>0?1:0);
			if(r>0){
				SendMessage.sendMsg(" 已提交取样！（"+DateUtils.getCurrentDate()+"）");
			}
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
			test.setTest_name(user.getRealname());
			test.setTest_status("1");
			int r = testService.updateByNameAndTime(test);
			rs = ResultUtil.resultString(r>0?1:0);
			if(r>0){
				SendMessage.sendMsg(" 已提交缺货取样！（"+DateUtils.getCurrentDate()+"）");
			}
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
	@RequestMapping("todayTest")
	public String todayTest(HttpServletRequest request,Model model){
		String p = "orderModule/sampling/todayTest";
		Test test = new Test();
		test.setTest_time(DateUtils.getCurrentDate("yyyy-MM-dd"));
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
		return p;
	}
	@RequestMapping("todayhadTest")
	public String todayhadTest(HttpServletRequest request,Model model){
		String p = "orderModule/sampling/todayhadTest";
		Test test = new Test();
		test.setTest_time(DateUtils.getCurrentDate("yyyy-MM-dd"));
		test.setTest_status("2");
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
		return p;
	}
	@RequestMapping("hadTestList")
	public String hadTestList(HttpServletRequest request,Model model,String page,String datetime,String result){
		String p = "orderModule/sampling/hadTestList";
		Map<String, Object> test = new HashMap<String, Object>();
		test.put("test_status", "2");
		User user = (User)request.getSession().getAttribute("user");
		if(null!=user){
			test.put("test_user", user.getRealname());
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
	@RequestMapping("addTest")
	public String addTest(HttpServletRequest request,Model model,String id){
		String page = "orderModule/sampling/addTest2";
		Test test = testService.getById(id);
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
			test.setTest_user(user.getRealname());
		}
		int r = testService.update(test);
		rs = ResultUtil.resultString(r);
		return rs;
	}
	@RequestMapping("checkPhone")
	@ResponseBody
	public String checkPhone(HttpServletRequest request,String phone){
		String rs = "";
		Map<String, Object> map = new HashMap<String, Object>();
		Farmer farmer = farmerService.getByPhone(phone);
		if(null!=farmer){
			map.put("code", "200");
			map.put("farmer_name", farmer.getFarmer_name());
			map.put("farmer_hzs", farmer.getFarmer_hzs());
			map.put("baseid", farmer.getBaseid());
		}else{
			map.put("code", "-1");
		}
		rs = JSON.toJSONString(map);
		return rs;
	}
	
}
