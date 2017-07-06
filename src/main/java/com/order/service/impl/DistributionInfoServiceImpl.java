package com.order.service.impl;

import java.util.List;
import java.util.Map;

import javax.transaction.Transactional;

import org.springframework.stereotype.Service;

import com.order.po.DistributionInfo;
import com.order.service.DistributionInfoService;

@Service
@Transactional
public class DistributionInfoServiceImpl implements DistributionInfoService {

	@Override
	public int deleteByPrimaryKey(String distribution_id) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int insert(DistributionInfo record) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int insertSelective(DistributionInfo record) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public DistributionInfo selectByPrimaryKey(String distribution_id) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int updateByPrimaryKeySelective(DistributionInfo record) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int updateByPrimaryKey(DistributionInfo record) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public List<Map<String, Object>> query(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int count(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public List<Map<String, Object>> select(DistributionInfo record) {
		// TODO Auto-generated method stub
		return null;
	}

}
