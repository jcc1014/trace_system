package com.order.service.impl;

import java.util.List;
import java.util.Map;

import javax.transaction.Transactional;

import org.springframework.stereotype.Service;

import com.order.po.DistributionDetail;
import com.order.service.DistributionDetailService;
@Service
@Transactional
public class DistributionDetailServiceImpl implements DistributionDetailService {

	@Override
	public int deleteByPrimaryKey(String id) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int insert(DistributionDetail record) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int insertSelective(DistributionDetail record) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public DistributionDetail selectByPrimaryKey(String id) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int updateByPrimaryKeySelective(DistributionDetail record) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int updateByPrimaryKey(DistributionDetail record) {
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
	public List<Map<String, Object>> select(DistributionDetail record) {
		// TODO Auto-generated method stub
		return null;
	}

}
