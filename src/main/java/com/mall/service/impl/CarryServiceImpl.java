package com.mall.service.impl;

import java.util.List;
import java.util.Map;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mall.dao.CarryMapper;
import com.mall.po.Carry;
import com.mall.service.CarryService;

@Service
@Transactional
public class CarryServiceImpl implements CarryService {

	@Autowired
	private CarryMapper carryMapper;
	
	@Override
	public int deleteByPrimaryKey(String carry_id) {
		return carryMapper.deleteByPrimaryKey(carry_id);
	}

	@Override
	public int insertSelective(Carry record) {
		return carryMapper.insertSelective(record);
	}

	@Override
	public Carry selectByPrimaryKey(String carry_id) {
		return carryMapper.selectByPrimaryKey(carry_id);
	}

	@Override
	public int updateByPrimaryKeySelective(Carry record) {
		return carryMapper.updateByPrimaryKeySelective(record);
	}

	@Override
	public List<Carry> select(Carry carry) {
		return carryMapper.select(carry);
	}

	@Override
	public int count(Map<String, Object> map) {
		return carryMapper.count(map);
	}

	@Override
	public List<Carry> query(Map<String, Object> map) {
		return carryMapper.query(map);
	}

}
