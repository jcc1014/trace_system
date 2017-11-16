package com.order.service.impl;

import java.util.List;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.order.dao.PsFruitMapper;
import com.order.po.PsFruit;
import com.order.service.PsFruitService;
@Service
@Transactional
public class PsFruitServiceImpl implements PsFruitService {

	@Autowired
	private PsFruitMapper psFruitMapper;
	
	@Override
	public int deleteByPrimaryKey(String id) {
		return psFruitMapper.deleteByPrimaryKey(id);
	}

	@Override
	public int insert(PsFruit record) {
		return 0;
	}

	@Override
	public int insertSelective(PsFruit record) {
		return psFruitMapper.insertSelective(record);
	}

	@Override
	public PsFruit selectByPrimaryKey(String id) {
		return psFruitMapper.selectByPrimaryKey(id);
	}

	@Override
	public int updateByPrimaryKeySelective(PsFruit record) {
		return psFruitMapper.updateByPrimaryKeySelective(record);
	}

	@Override
	public int updateByPrimaryKeyWithBLOBs(PsFruit record) {
		return 0;
	}

	@Override
	public int updateByPrimaryKey(PsFruit record) {
		return 0;
	}

	@Override
	public List<PsFruit> select(PsFruit psFruit) {
		return psFruitMapper.select(psFruit);
	}

}
