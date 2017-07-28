package com.trace.service.impl;

import java.util.List;
import java.util.Map;

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
	public List<Test> selectAlltest(Test test) {
		return testDao.selectAllTest(test);
	}
	
	@Override
	public List<Test> selectQhTest(Test test) {
		return testDao.selectAllTest(test);
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

	@Override
	public int update(Test test) {
		return testDao.update(test);
	}

	@Override
	public int updateByNameAndTime(Test test) {
		return testDao.updateByNameAndTime(test);
	}

	@Override
	public int deleteById(String id) {
		return testDao.deleteById(id);
	}

	@Override
	public List<Test> query(Map<String, Object> map) {
		return testDao.query(map);
	}

	@Override
	public int count(Map<String, Object> map) {
		return testDao.count(map);
	}

	@Override
	public List<Map<String, Object>> getTestInfo(Map<String, String> map) {
		return testDao.getTestInfo(map);
	}

}
