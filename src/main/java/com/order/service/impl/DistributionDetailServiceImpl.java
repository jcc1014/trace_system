package com.order.service.impl;

import java.util.List;
import java.util.Map;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.order.dao.DistributionDetailMapper;
import com.order.po.DistributionDetail;
import com.order.service.DistributionDetailService;
@Service
@Transactional
public class DistributionDetailServiceImpl implements DistributionDetailService {

	@Autowired
	private DistributionDetailMapper distributionDetailMapper;
	@Override
	public int deleteByPrimaryKey(String id) {
		return distributionDetailMapper.deleteByPrimaryKey(id);
	}

	@Override
	public int insert(DistributionDetail record) {
		return distributionDetailMapper.insert(record);
	}

	@Override
	public int insertSelective(DistributionDetail record) {
		return distributionDetailMapper.insertSelective(record);
	}

	@Override
	public DistributionDetail selectByPrimaryKey(String id) {
		return distributionDetailMapper.selectByPrimaryKey(id);
	}

	@Override
	public int updateByPrimaryKeySelective(DistributionDetail record) {
		return distributionDetailMapper.updateByPrimaryKeySelective(record);
	}

	@Override
	public int updateByPrimaryKey(DistributionDetail record) {
		return distributionDetailMapper.updateByPrimaryKey(record);
	}

	@Override
	public List<Map<String, Object>> query(Map<String, Object> map) {
		return distributionDetailMapper.query(map);
	}

	@Override
	public int count(Map<String, Object> map) {
		return distributionDetailMapper.count(map);
	}

	@Override
	public List<Map<String, Object>> select(DistributionDetail record) {
		return distributionDetailMapper.select(record);
	}

}
