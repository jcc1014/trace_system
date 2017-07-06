package com.order.service.impl;

import java.util.List;
import java.util.Map;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.order.dao.TotalInfoMapper;
import com.order.po.TotalInfo;
import com.order.service.TotalInfoService;

@Service
@Transactional
public class TotalInfoServiceImpl implements TotalInfoService {

	@Autowired
	private TotalInfoMapper totalInfoMapper;
	
	@Override
	public int deleteByPrimaryKey(String id) {
		return totalInfoMapper.deleteByPrimaryKey(id);
	}


	@Override
	public int insertSelective(TotalInfo record) {
		return totalInfoMapper.insertSelective(record);
	}

	@Override
	public TotalInfo selectByPrimaryKey(String id) {
		return totalInfoMapper.selectByPrimaryKey(id);
	}

	@Override
	public int updateByPrimaryKeySelective(TotalInfo record) {
		return totalInfoMapper.updateByPrimaryKeySelective(record);
	}


	@Override
	public List<Map<String, Object>> query(Map<String, Object> map) {
		return totalInfoMapper.query(map);
	}

	@Override
	public int count(Map<String, Object> map) {
		return totalInfoMapper.count(map);
	}

	@Override
	public List<Map<String, Object>> select(TotalInfo record) {
		return totalInfoMapper.select(record);
	}

}
