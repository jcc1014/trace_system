package com.order.service.impl;

import java.util.List;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.order.dao.RequireMeatMapper;
import com.order.po.RequireMeat;
import com.order.service.RequireMeatService;

@Service
@Transactional
public class RequireMeatServiceImpl implements RequireMeatService {

	@Autowired
	private RequireMeatMapper requireMeatMapper;
	
	@Override
	public int deleteByPrimaryKey(String id) {
		// TODO Auto-generated method stub
		return requireMeatMapper.deleteByPrimaryKey(id);
	}

	@Override
	public int insert(RequireMeat record) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int insertSelective(RequireMeat record) {
		// TODO Auto-generated method stub
		return requireMeatMapper.insertSelective(record);
	}

	@Override
	public RequireMeat selectByPrimaryKey(String id) {
		// TODO Auto-generated method stub
		return requireMeatMapper.selectByPrimaryKey(id);
	}

	@Override
	public int updateByPrimaryKeySelective(RequireMeat record) {
		// TODO Auto-generated method stub
		return requireMeatMapper.updateByPrimaryKeySelective(record);
	}

	@Override
	public int updateByPrimaryKey(RequireMeat record) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public List<RequireMeat> select(RequireMeat record) {
		// TODO Auto-generated method stub
		return requireMeatMapper.select(record);
	}

	@Override
	public int updateByTimeAndBaseId(RequireMeat record) {
		// TODO Auto-generated method stub
		return requireMeatMapper.updateByTimeAndBaseId(record);
	}

	@Override
	public int updateStatus(RequireMeat record) {
		// TODO Auto-generated method stub
		return requireMeatMapper.updateStatus(record);
	}

}
