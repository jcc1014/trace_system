/**
 * 
 */
package com.timer.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import com.order.po.BaseInfo;
import com.order.po.ProduceInfo;
import com.order.po.PurchaseInfo;
import com.order.po.RemainPurchase;
import com.order.po.RequireInfo;
import com.order.po.TotalInfo;
import com.order.service.BaseInfoService;
import com.order.service.ProduceInfoService;
import com.order.service.PurchaseInfoService;
import com.order.service.RemainPurchaseService;
import com.order.service.RequireInfoService;
import com.order.service.TotalInfoService;
import com.timer.TimerTask;
import com.trace.util.DateUtils;
import com.trace.util.Log4JUtils;
import com.utils.UUIDFactory;
import com.wechat.util.SendMessage;


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
	@Autowired
	private RemainPurchaseService remainPurchaseService;
	@Autowired
	private PurchaseInfoService purchaseInfoService;
	
	@Scheduled(cron="0 0 21 * * ?" ) 
	@Override
	public void submitTodayRequire() {
		//每天20：00 提交需求单
		String dateTime = DateUtils.getCurrentDate("yyyy-MM-dd");
		TotalInfo totalInfo = new TotalInfo();
		totalInfo.setCreatetime(dateTime);
		totalInfo.setType("xqd");
		//totalInfo.setStatus("0");
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
	
	//每天23点自动执行
	@Scheduled(cron="0 0 23 * * ?" ) 
	@Override
	public void submitTodayQhd() {
		TotalInfo t = new TotalInfo();
		t.setCreatetime(DateUtils.getCurrentDate("yyyy-MM-dd"));
		t.setType("qhd");
		List<Map<String, Object>> tList = totalInfoService.select(t);
		if(1==tList.size()){ //今日缺货单已经生成
			Log4JUtils.getLogger().info(DateUtils.getCurrentDate()+":缺货单已经生成！");
			SendMessage.sendMsg("系统提示：（"+DateUtils.getCurrentDate()+"）\n缺货单已经人工生成，无须自动生成。");
		}else{
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("date1", DateUtils.getCurrentDate("yyyy-MM-dd"));
			map.put("date2", DateUtils.getCurrentDate("yyyy-MM-dd"));
			List<Map<String, Object>> list = purchaseInfoService.getCgAndXq(map); //获取采购和需求
			Map<String,Object> rmap = null;
			PurchaseInfo purchaseInfo = null;
			TotalInfo qhd = new TotalInfo();
			qhd.setCreatetime(DateUtils.getCurrentDate("yyyy-MM-dd"));
			qhd.setType("qhd");
			qhd.setId(UUIDFactory.getInstance().newUUID());
			qhd.setCreateuser("auto");
			qhd.setName(DateUtils.getCurrentDate("yyyy-MM-dd")+"缺货单");
			qhd.setStatus("1");
			boolean qhd_f = false;
			TotalInfo fyd = new TotalInfo();
			fyd.setCreatetime(DateUtils.getCurrentDate("yyyy-MM-dd"));
			fyd.setType("fyd");
			fyd.setId(UUIDFactory.getInstance().newUUID());
			fyd.setCreateuser("auto");
			fyd.setName(DateUtils.getCurrentDate("yyyy-MM-dd")+"富余单");
			fyd.setStatus("1");
			boolean fyd_f = false;
			RemainPurchase remainPurchase = null;
			if(0<list.size()){
				for (int i = 0; i < list.size(); i++) {
					rmap = list.get(i);
					if(null==rmap.get("createtime")||"".equals(rmap.get("createtime"))){
						//缺货
						purchaseInfo = new PurchaseInfo();
						purchaseInfo.setPurchase_id(UUIDFactory.getInstance().newUUID());
						purchaseInfo.setCreatetime(DateUtils.getCurrentDate());
						purchaseInfo.setCreateuser("auto");
						purchaseInfo.setGrade((String) rmap.get("grade1"));
						purchaseInfo.setKind((String) rmap.get("kind1"));
						purchaseInfo.setSpyb((String) rmap.get("spyb1"));
						purchaseInfo.setNumber((double)rmap.get("num"));
						purchaseInfo.setParentid(qhd.getId());
						purchaseInfo.setRemain_number((double)rmap.get("num"));
						purchaseInfo.setStatus("1");
						purchaseInfo.setType("1");
						purchaseInfoService.insertSelective(purchaseInfo);
						qhd_f = true;
					}
					else if(null!=rmap.get("createtime")&&!"".equals(rmap.get("createtime"))
							&&(null!=rmap.get("createtime1")&&!"".equals(rmap.get("createtime1")))){
						//有货
						//比较数量
						if((double)rmap.get("num")>(double)rmap.get("number")){
							//不够
							purchaseInfo = new PurchaseInfo();
							purchaseInfo.setPurchase_id(UUIDFactory.getInstance().newUUID());
							purchaseInfo.setCreatetime(DateUtils.getCurrentDate());
							purchaseInfo.setCreateuser("auto");
							purchaseInfo.setGrade((String) rmap.get("grade1"));
							purchaseInfo.setKind((String) rmap.get("kind1"));
							purchaseInfo.setSpyb((String) rmap.get("spyb1"));
							purchaseInfo.setNumber((double)rmap.get("num")-(double)rmap.get("number"));
							purchaseInfo.setParentid(qhd.getId());
							purchaseInfo.setRemain_number((double)rmap.get("num")-(double)rmap.get("number"));
							purchaseInfo.setStatus("1");
							purchaseInfo.setType("1");
							purchaseInfoService.insertSelective(purchaseInfo);
							qhd_f = true;
							
						}else if((double)rmap.get("num")<(double)rmap.get("number")){
							//多余
							remainPurchase = new RemainPurchase();
							remainPurchase.setCreatetime(DateUtils.getCurrentDate());
							remainPurchase.setId(UUIDFactory.getInstance().newUUID());
							remainPurchase.setGrade((String) rmap.get("grade"));
							remainPurchase.setKind((String) rmap.get("kind"));
							remainPurchase.setSpyb((String) rmap.get("spyb"));
							remainPurchase.setNum((double)rmap.get("number")-(double)rmap.get("num"));
							remainPurchase.setParentid(fyd.getId());
							remainPurchase.setStatus("1");
							fyd_f = true;
							remainPurchaseService.insertSelective(remainPurchase);
							
							
						}
					}else if(null==rmap.get("createtime1")||"".equals(rmap.get("createtime1"))){
						//多余
						remainPurchase = new RemainPurchase();
						remainPurchase.setCreatetime(DateUtils.getCurrentDate());
						remainPurchase.setId(UUIDFactory.getInstance().newUUID());
						remainPurchase.setGrade((String) rmap.get("grade"));
						remainPurchase.setKind((String) rmap.get("kind"));
						remainPurchase.setSpyb((String) rmap.get("spyb"));
						remainPurchase.setNum((double)rmap.get("number"));
						remainPurchase.setParentid(fyd.getId());
						remainPurchase.setStatus("1");
						fyd_f = true;
						remainPurchaseService.insertSelective(remainPurchase);
					}
				}
				if(qhd_f==true){
					totalInfoService.insertSelective(qhd);
				}
				if(fyd_f==true){
					totalInfoService.insertSelective(fyd);
				}
				Log4JUtils.getLogger().info(DateUtils.getCurrentDate()+":缺货单生成成功！");
				SendMessage.sendMsg("系统提示：（"+DateUtils.getCurrentDate()+"）\n缺货单生成成功！");
			}else{
				Log4JUtils.getLogger().error(DateUtils.getCurrentDate()+":没有可以提交的供应单！");
				SendMessage.sendMsg("系统提示：（"+DateUtils.getCurrentDate()+"）\n缺货单生成失败！");
			}
		}
		
	}
	
	//每天23：20自动执行
	@Scheduled(cron="0 30 23 * * ?" ) 
	@Override
	public void submitTodayCgd() {
		TotalInfo t = new TotalInfo();
		t.setCreatetime(DateUtils.getCurrentDate("yyyy-MM-dd"));
		t.setType("qhcgd"); //缺货采购单
		List<Map<String, Object>> tList = totalInfoService.select(t);
		if(tList.size()==0){
			//从默认市场取出id 和名称
			Map<String,Object> map = new HashMap<String, Object>();
			map.put("isdefault", "1");
			List<BaseInfo> bList = baseInfoService.select(map);
			BaseInfo baseInfo = null;
			if(0<bList.size()){
				baseInfo = bList.get(0);
			}
			t.setType("qhd");
			List<Map<String,Object>> qhList = totalInfoService.select(t);
			Map<String,Object> qhMap = null;
			if(0<qhList.size()){
				qhMap = qhList.get(0);
				TotalInfo totalInfo = new TotalInfo();
				totalInfo.setStatus("1");
				String cgid = UUIDFactory.getInstance().newUUID();
				totalInfo.setId(cgid);
				totalInfo.setCreatetime(DateUtils.getCurrentDate("yyyy-MM-dd"));
				totalInfo.setCreateuser("auto");
				totalInfo.setStatus("0");//提交状态
				totalInfo.setSource(qhMap.get("id").toString());//缺货单id
				totalInfo.setName(DateUtils.getCurrentDate("yyyyMMdd")+baseInfo.getName()+"采购单");
				totalInfo.setSource_name(qhMap.get("name").toString());//
				totalInfo.setType("qhcgd");
				totalInfo.setNowtime(DateUtils.getCurrentDate());
				totalInfo.setSource_type("3");//来自缺货
				totalInfo.setCgsc(baseInfo.getId());
				int r = totalInfoService.insertSelective(totalInfo);
				if(1==r){
					PurchaseInfo p = new PurchaseInfo();
					p.setParentid(qhMap.get("id").toString());
					p.setCgdh(cgid);
					int n = purchaseInfoService.updateByParnetid(p);
					if(0==n){
						totalInfoService.deleteByPrimaryKey(cgid);
						SendMessage.sendMsg(" 缺货采购单自动生成失败！（"+DateUtils.getCurrentDate()+"）\n原因是缺货单不存在！");
					}else{
						SendMessage.sendMsg("已自动生成缺货"+DateUtils.getCurrentDate("yyyyMMdd")+baseInfo.getName()+"采购单！（"+DateUtils.getCurrentDate()+"）");
					}
				}
			}
		}
		
	}

	@Scheduled(cron="0 0 22 * * ?" ) 
	@Override
	public void remindRequire() {
		Map<String,Object> map = new HashMap<String, Object>();
		map.put("time", DateUtils.getCurrentDate("yyyy-MM-dd"));
		List<Map<String,Object>> list = baseInfoService.remindRequire(map);
		String msg = "截止到"+DateUtils.getCurrentDate()+"\n";
		if(0!=list.size()){
			for (int i = 0; i < list.size(); i++) {
				msg += list.get(i).get("name")+"（ "+list.get(i).get("phone")+"）\n";
			}
			msg = msg+"还未提交"+DateUtils.getCurrentDate("yyyy-MM-dd")+"的需求单！";
		}else{
			msg += "各单位需求单都已提交！";
		}
		SendMessage.sendMsgTest(msg);
	}

}
