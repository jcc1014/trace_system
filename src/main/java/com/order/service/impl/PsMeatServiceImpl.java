package com.order.service.impl;

import java.util.List;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.order.dao.PsMeatMapper;
import com.order.po.PsMeat;
import com.order.service.PsMeatService;
@Service
@Transactional
public class PsMeatServiceImpl implements PsMeatService {

	@Autowired
	private PsMeatMapper psMeatMapper;
	
	@Override
	public int deleteByPrimaryKey(String id) {
		return psMeatMapper.deleteByPrimaryKey(id);
	}

	@Override
	public int insert(PsMeat record) {
		return 0;
	}

	@Override
	public int insertSelective(PsMeat record) {
		return psMeatMapper.insertSelective(record);
	}

	@Override
	public PsMeat selectByPrimaryKey(String id) {
		return psMeatMapper.selectByPrimaryKey(id);
	}

	@Override
	public int updateByPrimaryKeySelective(PsMeat record) {
		return psMeatMapper.updateByPrimaryKeySelective(record);
	}

	@Override
	public int updateByPrimaryKeyWithBLOBs(PsMeat record) {
		return 0;
	}

	@Override
	public int updateByPrimaryKey(PsMeat record) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public List<PsMeat> select(PsMeat psMeat) {
		return psMeatMapper.select(psMeat);
	}

}
