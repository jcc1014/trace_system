package com.order.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.trace.po.Qrcode;
import com.trace.po.TraceFlow;
import com.trace.po.Transport;
import com.trace.service.FarmerService;
import com.trace.service.QrcodeService;
import com.trace.service.TraceFlowService;
import com.trace.service.TransportService;
import com.trace.util.DateUtils;
import com.trace.util.QRCodeUtil;
import com.utils.UUIDFactory;

@Controller
@RequestMapping("transport")
public class TransportController {

	@Autowired
	private TransportService transportService;
	@Autowired
	private TraceFlowService traceFlowService;
	@Autowired
	private FarmerService farmerService;
	@Autowired
	private QrcodeService qrcodeService;
	
	@RequestMapping("transportList")
	public String transportList(HttpServletRequest request,Model model){
		String page = "orderModule/transport/transportList";
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("datetime", DateUtils.getCurrentDate("yyyy-MM-dd"));
		List<Map<String,Object>> list = transportService.selectTodayTranportList(map);
		model.addAttribute("list", list);
		return page;
	}
	
	@RequestMapping("addTransport")
	public String addTransport(HttpServletRequest request,Model model,String trace_id){
		String page = "orderModule/transport/addTransport";
		Map<String,Object> map = traceFlowService.selectFlowById(trace_id);
		model.addAttribute("map", map);
		model.addAttribute("trace_id", trace_id);
		return page;
	}
	
	@RequestMapping("addTransportSave")
	public String addTransportSave(HttpServletRequest request,Model model,TraceFlow traceFlow,
			Transport transport){
		String page = "redirect:transportList.do";
		transport.setTransport_id(UUIDFactory.getInstance().newUUID());
		traceFlow.setTransport_id(transport.getTransport_id());
		traceFlow.setTrace_status("6");
		traceFlow.setIdentifier(DateUtils.getCurrentDate("yyyyMMddHHmmss"));
		transportService.add(transport);
		Qrcode qrcode = new Qrcode();
		qrcode.setQrcode_id(UUIDFactory.getInstance().newUUID());
		String path  = request.getSession().getServletContext().getRealPath("/")+"qrcode\\";
		String logoPath  = request.getSession().getServletContext().getRealPath("/")+"\\images\\qrcode_logo.png";
		String content = "http://qianzhide.net:8080/trace_system/trace/trace_detail.do?trace_id="+traceFlow.getTrace_id();
		//String content = "http://jingcc.xin:8080/trace_system/trace/trace_detail.do?trace_id="+traceFlow.getTrace_id();
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
	
	
	
}
