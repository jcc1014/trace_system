package com.order.service.impl;

import java.util.List;
import java.util.Map;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.order.dao.DistributionInfoMapper;
import com.order.po.DistributionInfo;
import com.order.service.DistributionInfoService;

@Service
@Transactional
public class DistributionInfoServiceImpl implements DistributionInfoService {

	@Autowired
	private DistributionInfoMapper distributionInfoMapper;
	
	@Override
	public int deleteByPrimaryKey(String distribution_id) {
		return distributionInfoMapper.deleteByPrimaryKey(distribution_id);
	}


	@Override
	public int insertSelective(DistributionInfo record) {
		return distributionInfoMapper.insertSelective(record);
	}

	@Override
	public DistributionInfo selectByPrimaryKey(String distribution_id) {
		return distributionInfoMapper.selectByPrimaryKey(distribution_id);
	}

	@Override
	public int updateByPrimaryKeySelective(DistributionInfo record) {
		return distributionInfoMapper.updateByPrimaryKeySelective(record);
	}

	@Override
	public List<Map<String, Object>> query(Map<String, Object> map) {
		return distributionInfoMapper.query(map);
	}

	@Override
	public int count(Map<String, Object> map) {
		return distributionInfoMapper.count(map);
	}

	@Override
	public List<Map<String, Object>> select(DistributionInfo record) {
		return distributionInfoMapper.select(record);
	}


	@Override
	public List<Map<String, Object>> getDeliverData(Map<String, Object> map) {
		return distributionInfoMapper.getDeliverData(map);
	}


	@Override
	public int updateSignName(DistributionInfo record) {
		return distributionInfoMapper.updateSignName(record);
	}

}
