/**
 * 
 */
package com.timer.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import com.order.po.ProduceInfo;
import com.order.po.RequireInfo;
import com.order.po.TotalInfo;
import com.order.service.BaseInfoService;
import com.order.service.ProduceInfoService;
import com.order.service.RequireInfoService;
import com.order.service.TotalInfoService;
import com.timer.TimerTask;
import com.trace.util.DateUtils;
import com.trace.util.Log4JUtils;


/**
 * <p>Title: </p>
 * <p>Description: </p>
 * @version V1.0
 * @author jcc
 * @date 
 */
@Component
public class TimerTaskImpl implements TimerTask {

	@Autowired
	private RequireInfoService requireInfoService;
	@Autowired
	private BaseInfoService baseInfoService;
	@Autowired
	private TotalInfoService totalInfoService;
	@Autowired
	private ProduceInfoService produceInfoService;
	
	@Scheduled(cron="0 0 20 * * ?" ) 
	@Override
	public void submitTodayRequire() {
		//每天20：00 提交需求单
		String dateTime = DateUtils.getCurrentDate("yyyy-MM-dd");
		TotalInfo totalInfo = new TotalInfo();
		totalInfo.setCreatetime(dateTime);
		totalInfo.setType("xqd");
		totalInfo.setStatus("0");
		List<Map<String, Object>>  totalInfoList =  totalInfoService.select(totalInfo);
		if(0<totalInfoList.size()){
			Map<String, Object> map = null;
			TotalInfo t = null;
			RequireInfo requireInfo = null;
			for (int i = 0; i < totalInfoList.size(); i++) {
				map = totalInfoList.get(i);
				t = new TotalInfo();
				t.setId((String)map.get("id"));
				t.setStatus("1");
				totalInfoService.updateByPrimaryKeySelective(t);
				requireInfo = new RequireInfo();
				requireInfo.setParentid((String)map.get("id"));
				requireInfo.setStatus("1");
				requireInfoService.updateByParentid(requireInfo);
			}
			Log4JUtils.getLogger().info(DateUtils.getCurrentDate()+":需求单提交成功！");
		}else{
			Log4JUtils.getLogger().error(DateUtils.getCurrentDate()+":没有可以提交的需求单！");
		}
		
	}

	@Scheduled(cron="0 0 17 * * ?" ) 
	@Override
	public void submitTodayProduce() {
		TotalInfo totalInfo = new TotalInfo();
		totalInfo.setType("gyd");
		totalInfo.setCreatetime(DateUtils.getCurrentDate("yyyy-MM-dd"));
		totalInfo.setStatus("0");
		List<Map<String, Object>>  totalInfoList =  totalInfoService.select(totalInfo);
		if(0<totalInfoList.size()){
			Map<String, Object> map = null;
			TotalInfo t = null;
			ProduceInfo produceInfo = null;
			for (int i = 0; i < totalInfoList.size(); i++) {
				map = totalInfoList.get(i);
				t = new TotalInfo();
				t.setId((String)map.get("id"));
				t.setStatus("1");
				totalInfoService.updateByPrimaryKeySelective(t);
				produceInfo = new ProduceInfo();
				produceInfo.setParent_id((String)map.get("id"));
				produceInfo.setStatus("1");
				produceInfoService.updateStatusByParentid(produceInfo);
			}
			Log4JUtils.getLogger().info(DateUtils.getCurrentDate()+":供应单提交成功！");
		}else{
			Log4JUtils.getLogger().error(DateUtils.getCurrentDate()+":没有可以提交的供应单！");
		}
	}

	
	  
}
