package com.order.service.impl;

import java.util.List;
import java.util.Map;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.order.dao.BaseInfoMapper;
import com.order.po.BaseInfo;
import com.order.service.BaseInfoService;

@Service
@Transactional
public class BaseInfoServiceImpl implements BaseInfoService {

	@Autowired
	private BaseInfoMapper baseInfoMapper;
	
	@Override
	public int deleteByPrimaryKey(String id) {
		return baseInfoMapper.deleteByPrimaryKey(id);
	}

	@Override
	public int insertSelective(BaseInfo record) {
		return baseInfoMapper.insertSelective(record);
	}

	@Override
	public BaseInfo selectByPrimaryKey(String id) {
		return baseInfoMapper.selectByPrimaryKey(id);
	}

	@Override
	public int updateByPrimaryKeySelective(BaseInfo record) {
		return baseInfoMapper.updateByPrimaryKeySelective(record);
	}

	@Override
	public int count(Map<String, Object> map) {
		return baseInfoMapper.count(map);
	}

	@Override
	public List<BaseInfo> query(Map<String, Object> map) {
		return baseInfoMapper.query(map);
	}

	@Override
	public List<BaseInfo> select(Map<String, Object> map) {
		return baseInfoMapper.select(map);
	}

	@Override
	public List<Map<String, Object>> remindRequire(Map<String, Object> map) {
		return baseInfoMapper.remindRequire(map);
	}


}
