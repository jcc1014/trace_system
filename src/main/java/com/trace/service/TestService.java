/**
 * @Description: 
 * @maven.com.trace.service
 * @FileName:TestService.java
 * @Created By:anthony
 * @Created:2017年4月10日 下午10:15:06
 */
package com.trace.service;

import java.util.List;
import java.util.Map;

import com.trace.po.Test;

/**
 * @Description
 * @ClassName TestService
 * @author anthony
 * @Created 2017 2017年4月10日 下午10:15:06
 */
public interface TestService {
	List<Test> selectAlltest(Test test);
	List<Test> selectByName(String test_name);
	int add(Test test);
	int update(Test test);
	Test getById(String test_id);
	int updateByNameAndTime(Test test);
	int deleteById(String id);
	List<Test> query(Map<String,Object> map);
	int count(Map<String,Object> map);
	List<Map<String,Object>> getTestInfo(Map<String,String> map);
}
