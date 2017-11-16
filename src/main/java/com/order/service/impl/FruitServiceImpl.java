package com.order.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.order.dao.FruitMapper;
import com.order.po.Fruit;
import com.order.service.FruitService;

@Service
public class FruitServiceImpl implements FruitService {

	@Autowired
	private FruitMapper fruitMapper;
	
	@Override
	public int deleteByPrimaryKey(String id) {
		return fruitMapper.deleteByPrimaryKey(id);
	}

	@Override
	public int insert(Fruit record) {
		return fruitMapper.insert(record);
	}

	@Override
	public int insertSelective(Fruit record) {
		return fruitMapper.insertSelective(record);
	}

	@Override
	public Fruit selectByPrimaryKey(String id) {
		return fruitMapper.selectByPrimaryKey(id);
	}

	@Override
	public int updateByPrimaryKeySelective(Fruit record) {
		return fruitMapper.updateByPrimaryKeySelective(record);
	}

	@Override
	public int updateByPrimaryKey(Fruit record) {
		return fruitMapper.updateByPrimaryKey(record);
	}

	@Override
	public List<Fruit> select(Fruit Fruit) {
		return fruitMapper.select(Fruit);
	}

}
