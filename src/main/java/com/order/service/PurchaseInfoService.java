package com.order.service;

import java.util.List;
import java.util.Map;

import com.order.po.PurchaseInfo;

public interface PurchaseInfoService {

	int deleteByPrimaryKey(String purchase_id);
	
	int deleteByParentId(String parentid);

	int insertSelective(PurchaseInfo record);

	PurchaseInfo selectByPrimaryKey(String purchase_id);

	int updateByPrimaryKeySelective(PurchaseInfo record);
	
	int updateByParnetid(PurchaseInfo record);

	List<Map<String, Object>> query(Map<String, Object> map);

	int count(Map<String, Object> map);

	List<Map<String, Object>> select(PurchaseInfo record);
	
	List<Map<String, Object>> selectQh(PurchaseInfo record);
	
	List<Map<String,Object>> getCgAndXq(Map<String,Object> map);
}
