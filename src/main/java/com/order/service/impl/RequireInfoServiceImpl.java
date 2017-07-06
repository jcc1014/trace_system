package com.order.service.impl;

import java.util.List;
import java.util.Map;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.order.dao.RequireInfoMapper;
import com.order.po.RequireInfo;
import com.order.service.RequireInfoService;

@Service
@Transactional
public class RequireInfoServiceImpl implements RequireInfoService {

	@Autowired
	private RequireInfoMapper requireInfoMapper;
	
	@Override
	public int deleteByPrimaryKey(String id) {
		return requireInfoMapper.deleteByPrimaryKey(id);
	}


	@Override
	public int insertSelective(RequireInfo record) {
		return requireInfoMapper.insertSelective(record);
	}

	@Override
	public RequireInfo selectByPrimaryKey(String id) {
		return requireInfoMapper.selectByPrimaryKey(id);
	}

	@Override
	public int updateByPrimaryKeySelective(RequireInfo record) {
		return requireInfoMapper.updateByPrimaryKeySelective(record);
	}


	@Override
	public List<Map<String, Object>> query(Map<String, Object> map) {
		return requireInfoMapper.query(map);
	}

	@Override
	public int count(Map<String, Object> map) {
		return requireInfoMapper.count(map);
	}

	@Override
	public List<Map<String, Object>> select(RequireInfo record) {
		return requireInfoMapper.select(record);
	}


	@Override
	public int updateByParentid(RequireInfo record) {
		return requireInfoMapper.updateByParentid(record);
	}

}
