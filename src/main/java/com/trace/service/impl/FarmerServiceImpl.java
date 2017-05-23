package com.trace.service.impl;

import java.util.List;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.trace.dao.FarmerDao;
import com.trace.po.Farmer;
import com.trace.service.FarmerService;

@Service
@Transactional
public class FarmerServiceImpl implements FarmerService {

	@Autowired
	private FarmerDao farmerDao;
	
	@Override
	public List<Farmer> selectAllFarmer() {
		return farmerDao.selectAllFarmer();
	}

	@Override
	public List<Farmer> selectByName(String farmer_name) {
		return farmerDao.selectByName(farmer_name);
	}

	@Override
	public int add(Farmer farmer) {
		return farmerDao.insert(farmer);
	}

	@Override
	public Farmer getById(String farmer_id) {
		return farmerDao.selectByPrimaryKey(farmer_id);
	}

}
