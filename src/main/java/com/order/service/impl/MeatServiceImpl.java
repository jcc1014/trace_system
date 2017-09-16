package com.order.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.order.dao.MeatMapper;
import com.order.po.Meat;
import com.order.service.MeatService;

@Service
public class MeatServiceImpl implements MeatService {

	@Autowired
	private MeatMapper meatMapper;
	
	@Override
	public int deleteByPrimaryKey(String id) {
		// TODO Auto-generated method stub
		return meatMapper.deleteByPrimaryKey(id);
	}

	@Override
	public int insert(Meat record) {
		// TODO Auto-generated method stub
		return meatMapper.insert(record);
	}

	@Override
	public int insertSelective(Meat record) {
		// TODO Auto-generated method stub
		return meatMapper.insertSelective(record);
	}

	@Override
	public Meat selectByPrimaryKey(String id) {
		// TODO Auto-generated method stub
		return meatMapper.selectByPrimaryKey(id);
	}

	@Override
	public int updateByPrimaryKeySelective(Meat record) {
		// TODO Auto-generated method stub
		return meatMapper.updateByPrimaryKeySelective(record);
	}

	@Override
	public int updateByPrimaryKey(Meat record) {
		// TODO Auto-generated method stub
		return meatMapper.updateByPrimaryKey(record);
	}

	@Override
	public List<Meat> select(Meat meat) {
		// TODO Auto-generated method stub
		return meatMapper.select(meat);
	}

}
