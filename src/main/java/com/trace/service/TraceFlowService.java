/**
 * @Description: 
 * @maven.com.trace.service
 * @FileName:TraceFlowService.java
 * @Created By:anthony
 * @Created:2017年4月10日 下午10:15:06
 */
package com.trace.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.ui.Model;

import com.trace.po.Farmer;
import com.trace.po.Purchase;
import com.trace.po.Qrcode;
import com.trace.po.Test;
import com.trace.po.TraceFlow;
import com.trace.po.Transport;

/**
 * @Description
 * @ClassName TraceFlowService
 * @author anthony
 * @Created 2017 2017年4月10日 下午10:15:06
 */
public interface TraceFlowService {
	List<TraceFlow> selectAllTraceFlow(TraceFlow traceFlow);
	int add(TraceFlow traceFlow);
	int update(TraceFlow traceFlow);
	TraceFlow getById(String trace_id);
	List<Map<String,Object>> query(Map<String,Object> map);
	Map<String,Object> selectFlowById(String trace_id);
	int count(Map<String,Object> map);
	Model getTraceDetail(Model model,String trace_id);
	String farmerAdd(String trace_id,String farmer_name,String farmer_phone,String farmer_hzs,String video_path);
	String purchaseAdd(String trace_id,Purchase purchase,String purchase_video);
	String testAdd(String trace_id,Test test);
	String samplingAdd(String trace_id,Test test);
	String transportAdd(String trace_id,Transport transport);
	String qrcodeAdd(String trace_id,Qrcode qrcode);
	String addSave(HttpServletRequest request,Farmer farmer,Purchase purchase,Test test,
			Transport transport,String farmer_video,String purchase_video,String qrcode,String test_name2,
			String test_time2,String test_machine2,String test_result2,String test_influence2);
}
