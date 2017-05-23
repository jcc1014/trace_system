package com.trace.service.impl;

import java.util.List;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.trace.dao.TestDao;
import com.trace.po.Test;
import com.trace.service.TestService;

@Service
@Transactional
public class TestServiceImpl implements TestService {

	@Autowired
	private TestDao testDao;
	
	@Override
	public List<Test> selectAlltest() {
		return testDao.selectAllTest();
	}

	@Override
	public List<Test> selectByName(String test_name) {
		return testDao.selectByName(test_name);
	}

	@Override
	public int add(Test test) {
		return testDao.insert(test);
	}

	@Override
	public Test getById(String test_id) {
		return testDao.selectByPrimaryKey(test_id);
	}

}
