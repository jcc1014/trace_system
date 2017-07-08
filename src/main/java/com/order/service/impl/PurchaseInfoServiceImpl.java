package com.order.service.impl;

import java.util.List;
import java.util.Map;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.order.dao.PurchaseInfoMapper;
import com.order.po.PurchaseInfo;
import com.order.service.PurchaseInfoService;

@Service
@Transactional
public class PurchaseInfoServiceImpl implements PurchaseInfoService {

	@Autowired
	private PurchaseInfoMapper purchaseInfoMapper;
	
	@Override
	public int deleteByPrimaryKey(String purchase_id) {
		return purchaseInfoMapper.deleteByPrimaryKey(purchase_id);
	}


	@Override
	public int insertSelective(PurchaseInfo record) {
		return purchaseInfoMapper.insertSelective(record);
	}

	@Override
	public PurchaseInfo selectByPrimaryKey(String purchase_id) {
		return purchaseInfoMapper.selectByPrimaryKey(purchase_id);
	}

	@Override
	public int updateByPrimaryKeySelective(PurchaseInfo record) {
		return purchaseInfoMapper.updateByPrimaryKeySelective(record);
	}


	@Override
	public List<Map<String, Object>> query(Map<String, Object> map) {
		return purchaseInfoMapper.query(map);
	}

	@Override
	public int count(Map<String, Object> map) {
		return purchaseInfoMapper.count(map);
	}

	@Override
	public List<Map<String, Object>> select(PurchaseInfo record) {
		return purchaseInfoMapper.select(record);
	}


	@Override
	public int updateByParnetid(PurchaseInfo record) {
		return purchaseInfoMapper.updateByParentid(record);
	}


	@Override
	public List<Map<String, Object>> getCgAndXq(Map<String, Object> map) {
		return purchaseInfoMapper.getCgAndXq(map);
	}

}
