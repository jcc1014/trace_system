package com.order.service.impl;

import java.util.List;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.order.dao.RequireFruitMapper;
import com.order.po.RequireFruit;
import com.order.service.RequireFruitService;

@Service
@Transactional
public class RequireFruitServiceImpl implements RequireFruitService {

	@Autowired
	private RequireFruitMapper requireFruitMapper;
	
	@Override
	public int deleteByPrimaryKey(String id) {
		return requireFruitMapper.deleteByPrimaryKey(id);
	}

	@Override
	public int insert(RequireFruit record) {
		return 0;
	}

	@Override
	public int insertSelective(RequireFruit record) {
		return requireFruitMapper.insertSelective(record);
	}

	@Override
	public RequireFruit selectByPrimaryKey(String id) {
		return requireFruitMapper.selectByPrimaryKey(id);
	}

	@Override
	public int updateByPrimaryKeySelective(RequireFruit record) {
		return requireFruitMapper.updateByPrimaryKeySelective(record);
	}

	@Override
	public int updateByPrimaryKey(RequireFruit record) {
		return 0;
	}

	@Override
	public List<RequireFruit> select(RequireFruit record) {
		return requireFruitMapper.select(record);
	}

	@Override
	public int updateByTimeAndBaseId(RequireFruit record) {
		return requireFruitMapper.updateByTimeAndBaseId(record);
	}

	@Override
	public int updateStatus(RequireFruit record) {
		return requireFruitMapper.updateStatus(record);
	}

}
