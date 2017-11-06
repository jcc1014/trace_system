package com.order.service.impl;

import java.util.List;
import java.util.Map;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.order.dao.ProduceInfoMapper;
import com.order.po.ProduceInfo;
import com.order.service.ProduceInfoService;

@Service
@Transactional
public class ProduceInfoServiceImpl implements ProduceInfoService {

	@Autowired
	private ProduceInfoMapper produceInfoMapper;
	
	@Override
	public int deleteByPrimaryKey(String produce_id) {
		return produceInfoMapper.deleteByPrimaryKey(produce_id);
	}


	@Override
	public int insertSelective(ProduceInfo record) {
		return produceInfoMapper.insertSelective(record);
	}

	@Override
	public ProduceInfo selectByPrimaryKey(String produce_id) {
		return produceInfoMapper.selectByPrimaryKey(produce_id);
	}

	@Override
	public int updateByPrimaryKeySelective(ProduceInfo record) {
		return produceInfoMapper.updateByPrimaryKeySelective(record);
	}

	@Override
	public List<Map<String, Object>> query(Map<String, Object> map) {
		return null;
	}

	@Override
	public int count(Map<String, Object> map) {
		return 0;
	}

	@Override
	public List<Map<String, Object>> select(ProduceInfo record) {
		return produceInfoMapper.select(record);
	}


	@Override
	public List<Map<String, Object>> selectTodayProduceTotal(String nowDay,
			String status) {
		return produceInfoMapper.selectTodayProduceTotal(nowDay,status);
	}


	@Override
	public int updateStatusByParentid(ProduceInfo record) {
		return produceInfoMapper.updateStatusByParentid(record);
	}


	@Override
	public int createCgdByProduceId(Map<String, Object> map) {
		return produceInfoMapper.createCgdByProduceId(map);
	}


}
