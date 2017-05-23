package com.trace.service.impl;

import java.util.List;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.trace.dao.VegetablesDao;
import com.trace.po.Vegetables;
import com.trace.service.VegetablesService;

@Service
@Transactional
public class VegetablesServiceImpl implements VegetablesService {

	@Autowired
	private VegetablesDao vegetablesDao;
	
	@Override
	public List<Vegetables> selectAllVegetables() {
		return vegetablesDao.selectAllVegetables();
	}

	@Override
	public List<Vegetables> selectByName(String vegetables_name) {
		return vegetablesDao.selectByName(vegetables_name);
	}

	@Override
	public int add(Vegetables vegetables) {
		return vegetablesDao.insert(vegetables);
	}

	@Override
	public Vegetables getById(String vegetables_id) {
		return vegetablesDao.selectByPrimaryKey(vegetables_id);
	}

}
