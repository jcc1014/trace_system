package com.order.service.impl;

import java.util.List;
import java.util.Map;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.order.dao.RemainPurchaseMapper;
import com.order.po.RemainPurchase;
import com.order.service.RemainPurchaseService;

@Service
@Transactional
public class RemainPurchaseServiceImpl implements RemainPurchaseService {

	@Autowired
	private RemainPurchaseMapper remainPurchaseMapper;
	
	@Override
	public int deleteByPrimaryKey(String id) {
		return remainPurchaseMapper.deleteByPrimaryKey(id);
	}

	@Override
	public int insertSelective(RemainPurchase record) {
		return remainPurchaseMapper.insertSelective(record);
	}

	@Override
	public RemainPurchase selectByPrimaryKey(String id) {
		return remainPurchaseMapper.selectByPrimaryKey(id);
	}

	@Override
	public int updateByPrimaryKeySelective(RemainPurchase record) {
		return remainPurchaseMapper.updateByPrimaryKeySelective(record);
	}

	@Override
	public int updateByParentid(RemainPurchase record) {
		return remainPurchaseMapper.updateByParentid(record);
	}

	@Override
	public List<Map<String, Object>> query(Map<String, Object> map) {
		return remainPurchaseMapper.query(map);
	}

	@Override
	public int count(Map<String, Object> map) {
		return remainPurchaseMapper.count(map);
	}

	@Override
	public List<Map<String, Object>> select(RemainPurchase record) {
		return remainPurchaseMapper.select(record);
	}

}
