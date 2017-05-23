package com.trace.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import com.alibaba.fastjson.JSON;
import com.trace.dao.FarmerDao;
import com.trace.dao.PurchaseDao;
import com.trace.dao.QrcodeDao;
import com.trace.dao.TestDao;
import com.trace.dao.TraceFlowDao;
import com.trace.dao.TransportDao;
import com.trace.dao.VideoDao;
import com.trace.po.Farmer;
import com.trace.po.Purchase;
import com.trace.po.Qrcode;
import com.trace.po.Test;
import com.trace.po.TraceFlow;
import com.trace.po.Transport;
import com.trace.po.Video;
import com.trace.service.TraceFlowService;
import com.trace.util.DateUtils;

@Service
@Transactional
public class TraceFlowServiceImpl implements TraceFlowService {

	@Autowired
	private TraceFlowDao traceFlowDao;
	@Autowired
	private FarmerDao farmerDao;
	@Autowired
	private TestDao testDao;
	@Autowired
	private PurchaseDao purchaseDao;
	@Autowired
	private TransportDao transportDao;
	@Autowired
	private VideoDao videoDao;
	@Autowired
	private QrcodeDao qrcodeDao;
	
	@Override
	public List<TraceFlow> selectAllTraceFlow() {
		return traceFlowDao.selectAllTraceFlow();
	}

	@Override
	public int add(TraceFlow traceFlow) {
		int r = traceFlowDao.insert(traceFlow);
		return r;
	}

	@Override
	public TraceFlow getById(String trace_id) {
		return traceFlowDao.selectByPrimaryKey(trace_id);
	}

	@Override
	public List<Map<String, Object>> query(Map<String, Object> map) {
		return traceFlowDao.query(map);
	}

	@Override
	public int count(Map<String, Object> map) {
		return traceFlowDao.count(map);
	}

	public Model getTraceDetail(Model model,String trace_id){
		TraceFlow traceFlow = traceFlowDao.selectByPrimaryKey(trace_id);
		model.addAttribute("traceFlow", traceFlow);
		if(null!=traceFlow){
			Farmer farmer = farmerDao.selectByPrimaryKey(traceFlow.getFarmer_id());
			model.addAttribute("farmer", farmer);
			if(null!=farmer.getVideo_id()&&!"".equals(farmer.getVideo_id())){
				Video v = videoDao.selectByPrimaryKey(farmer.getVideo_id());
				if(v!=null){
					model.addAttribute("farmerVideo", v.getVideo_path());
				}
			}
			Purchase purchase = purchaseDao.selectByPrimaryKey(traceFlow.getPurchase_id());
			model.addAttribute("purchase", purchase);
			if(null!=purchase.getPurchase_video()&&!"".equals(purchase.getPurchase_video())){
				Video v = videoDao.selectByPrimaryKey(purchase.getPurchase_video());
				if(v!=null){
					model.addAttribute("pruchaseVideo", v.getVideo_path());
				}
			}
			Test test = testDao.selectByPrimaryKey(traceFlow.getTest_id());
			model.addAttribute("test", test);
			Test sampling = testDao.selectByPrimaryKey(traceFlow.getSampling_id());
			model.addAttribute("sampling", sampling);
			Transport transport = transportDao.selectByPrimaryKey(traceFlow.getTransport_id());
			model.addAttribute("transport", transport);
		}
		return model;
	}
	
	public String farmerAdd(String trace_id,String farmer_name,String farmer_phone,String farmer_hzs,String video_path){
		Map<String,String> map = new HashMap<String, String>();
		try {
			Farmer farmer = new Farmer();
			farmer.setFarmer_id(UUID.randomUUID().toString());
			farmer.setFarmer_name(farmer_name);
			farmer.setFarmer_phone(farmer_phone);
			farmer.setFarmer_hzs(farmer_hzs);
			Video v = videoDao.selectByName(farmer_name);
			if(null!=video_path && !"".equals(video_path)){
				if(null!=v){
					videoDao.deleteById(v.getVideo_id());
				}
				Video video = new Video();
				video.setVideo_id(UUID.randomUUID().toString());
				video.setVideo_path(video_path);
				video.setVideo_type("0");
				video.setCreatetime(DateUtils.getCurrentDate());
				video.setUsername(farmer_name);
				farmer.setVideo_id(video.getVideo_id());
				videoDao.insert(video);
			}else{
				if(null!=v){
					farmer.setVideo_id(v.getVideo_id());
				}
			}
			TraceFlow traceFlow = new TraceFlow();
			traceFlow.setTrace_id(trace_id);
			traceFlow.setTrace_status("1");
			traceFlow.setCreatetime(DateUtils.getCurrentDate());
			traceFlow.setFarmer_id(farmer.getFarmer_id());
			farmerDao.insert(farmer);
			traceFlowDao.insert(traceFlow);
			map.put("code", "200");
			map.put("status", "1");
			map.put("trace_id", trace_id);
			
		} catch (Exception e) {
			e.printStackTrace();
			map.put("code", "-1");
			throw new RuntimeException();
		}
		
		return JSON.toJSONString(map);
	}

	@Override
	public String purchaseAdd(String trace_id, Purchase purchase,String purchase_video) {
		Map<String,String> map = new HashMap<String, String>();
		try {
			TraceFlow traceFlow = new TraceFlow();
			traceFlow.setTrace_id(trace_id);
			String purchase_id = UUID.randomUUID().toString();
			purchase.setPurchase_id(purchase_id);
			traceFlow.setPurchase_id(purchase_id);
			traceFlow.setTrace_status("2");
			Video v = new Video();
			v.setCreatetime(DateUtils.getCurrentDate());
			v.setUsername("");
			v.setVideo_id(UUID.randomUUID().toString());
			v.setVideo_path(purchase_video);
			v.setVideo_type("1");
			videoDao.insert(v);
			purchase.setPurchase_video(v.getVideo_id());
			purchaseDao.insert(purchase);
			traceFlowDao.update(traceFlow);
			map.put("code", "200");
			map.put("trace_id", trace_id);
			map.put("status", "2");
		} catch (Exception e) {
			e.printStackTrace();
			map.put("code", "-1");
			throw new RuntimeException();
		}
		
		return JSON.toJSONString(map);
	}

	@Override
	public String testAdd(String trace_id, Test test) {
		Map<String,String> map = new HashMap<String, String>();
		try {
			TraceFlow traceFlow = new TraceFlow();
			traceFlow.setTrace_id(trace_id);
			String test_id = UUID.randomUUID().toString();
			test.setTest_id(test_id);
			test.setTest_type("0");
			traceFlow.setTest_id(test_id);
			traceFlow.setTrace_status("3");
			testDao.insert(test);
			traceFlowDao.update(traceFlow);
			map.put("code", "200");
			map.put("trace_id", trace_id);
			map.put("status", "3");
		} catch (Exception e) {
			e.printStackTrace();
			map.put("code", "-1");
			throw new RuntimeException();
		}
		
		return JSON.toJSONString(map);
	}

	@Override
	public String samplingAdd(String trace_id, Test test) {
		Map<String,String> map = new HashMap<String, String>();
		try {
			TraceFlow traceFlow = new TraceFlow();
			traceFlow.setTrace_id(trace_id);
			String test_id = UUID.randomUUID().toString();
			test.setTest_id(test_id);
			test.setTest_type("1");
			traceFlow.setSampling_id(test_id);
			traceFlow.setTrace_status("4");
			testDao.insert(test);
			traceFlowDao.update(traceFlow);
			map.put("code", "200");
			map.put("trace_id", trace_id);
			map.put("status", "4");
		} catch (Exception e) {
			e.printStackTrace();
			map.put("code", "-1");
			throw new RuntimeException();
		}
		
		return JSON.toJSONString(map);
	}

	@Override
	public String transportAdd(String trace_id, Transport transport) {
		Map<String,String> map = new HashMap<String, String>();
		try {
			TraceFlow traceFlow = new TraceFlow();
			traceFlow.setTrace_id(trace_id);
			String transport_id = UUID.randomUUID().toString();
			transport.setTransport_id(transport_id);
			traceFlow.setTransport_id(transport_id);
			traceFlow.setTrace_status("5");
			transportDao.insert(transport);
			traceFlowDao.update(traceFlow);
			map.put("code", "200");
			map.put("trace_id", trace_id);
			map.put("status", "5");
		} catch (Exception e) {
			e.printStackTrace();
			map.put("code", "-1");
			throw new RuntimeException();
		}
		
		return JSON.toJSONString(map);
	}

	@Override
	public String qrcodeAdd(String trace_id, Qrcode qrcode) {
		Map<String,String> map = new HashMap<String, String>();
		try {
			TraceFlow traceFlow = new TraceFlow();
			traceFlow.setTrace_id(trace_id);
			String qrcode_id = UUID.randomUUID().toString();
			qrcode.setQrcode_id(qrcode_id);
			traceFlow.setQrcode(qrcode_id);
			traceFlow.setTrace_status("6");
			qrcodeDao.insert(qrcode);
			traceFlowDao.update(traceFlow);
			map.put("code", "200");
			map.put("trace_id", trace_id);
			map.put("status", "6");
		} catch (Exception e) {
			e.printStackTrace();
			map.put("code", "-1");
			throw new RuntimeException();
		}
		
		return JSON.toJSONString(map);
	}

	@Override
	public String addSave(HttpServletRequest request, Farmer farmer,
			Purchase purchase, Test test, Transport transport,
			String farmer_video, String purchase_video, String qrcode,
			String test_name2, String test_time2, String test_machine2,
			String test_result2, String test_influence2) {
			
		if(null!=farmer_video&&!"".equals(farmer_video)){
			Video farmerVideo = new Video();
			farmerVideo.setVideo_id(UUID.randomUUID().toString());
			farmerVideo.setCreatetime(DateUtils.getCurrentDate());
			farmerVideo.setVideo_path(farmer_video);
			farmerVideo.setUsername(farmer.getFarmer_phone());
			farmerVideo.setVideo_type("0");
			videoDao.insert(farmerVideo);
		}else{
			Video v = videoDao.selectByName(farmer.getFarmer_phone());
			if(null!=v){
				farmer.setVideo_id(v.getVideo_path());
			}
		}
		farmer.setFarmer_id(UUID.randomUUID().toString());
		farmerDao.insert(farmer);
		//-------------------------------
		purchase.setPurchase_id(UUID.randomUUID().toString());
		if(null!=purchase_video&&!"".equals(purchase_video)){
			Video purchaseVideo = new Video();
			purchaseVideo.setVideo_id(UUID.randomUUID().toString());
			purchaseVideo.setCreatetime(DateUtils.getCurrentDate());
			purchaseVideo.setVideo_path(purchase_video);
			purchaseVideo.setUsername("");
			purchaseVideo.setVideo_type("1");
			videoDao.insert(purchaseVideo);
		}
		purchaseDao.insert(purchase);
		test.setTest_id(UUID.randomUUID().toString());
		test.setTest_type("0");
		testDao.insert(test);
		Test sampling = new Test();
		sampling.setTest_id(UUID.randomUUID().toString());
		sampling.setTest_time(test_time2);
		sampling.setTest_machine(test_machine2);
		sampling.setTest_result(test_result2);
		sampling.setTest_influence(test_influence2);
		sampling.setTest_type("1");
		testDao.insert(sampling);
		transport.setTransport_id(UUID.randomUUID().toString());
		TraceFlow traceFlow = new TraceFlow();
		String trace_id = UUID.randomUUID().toString();
		traceFlow.setTrace_id(trace_id);
		traceFlow.setFarmer_id(farmer.getFarmer_id());
		traceFlow.setPurchase_id(purchase.getPurchase_id());
		traceFlow.setTest_id(test.getTest_id());
		traceFlow.setSampling_id(sampling.getTest_id());
		traceFlow.setTransport_id(transport.getTransport_id());
		traceFlow.setQrcode(qrcode);
		traceFlowDao.insert(traceFlow);
		Map<String, String> map = new HashMap<String, String>();
		map.put("code", "200");
		map.put("trace_id", trace_id);
		return JSON.toJSONString(map);
	}
}
