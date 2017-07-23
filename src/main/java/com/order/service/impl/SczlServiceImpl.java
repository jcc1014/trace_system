package com.order.service.impl;

import java.util.List;
import java.util.Map;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.order.dao.SczlMapper;
import com.order.po.Sczl;
import com.order.service.SczlService;

@Service
@Transactional
public class SczlServiceImpl implements SczlService {

	@Autowired
	private SczlMapper sczlMapper;
	
	@Override
	public int deleteByPrimaryKey(String id) {
		return sczlMapper.deleteByPrimaryKey(id);
	}

	@Override
	public int insertSelective(Sczl record) {
		return sczlMapper.insertSelective(record);
	}

	@Override
	public Sczl selectByPrimaryKey(String id) {
		return sczlMapper.selectByPrimaryKey(id);
	}

	@Override
	public int updateByPrimaryKeySelective(Sczl record) {
		return sczlMapper.updateByPrimaryKeySelective(record);
	}

	@Override
	public int count(Map<String, Object> map) {
		return sczlMapper.count(map);
	}

	@Override
	public List<Sczl> query(Map<String, Object> map) {
		return sczlMapper.query(map);
	}

	@Override
	public List<Sczl> select(Map<String, Object> map) {
		return sczlMapper.select(map);
	}

}
