/**
 * @Description: 
 * @maven.com.trace.service
 * @FileName:TestService.java
 * @Created By:anthony
 * @Created:2017年4月10日 下午10:15:06
 */
package com.trace.service;

import java.util.List;

import com.trace.po.Test;

/**
 * @Description
 * @ClassName TestService
 * @author anthony
 * @Created 2017 2017年4月10日 下午10:15:06
 */
public interface TestService {
	List<Test> selectAlltest();
	List<Test> selectByName(String test_name);
	int add(Test test);
	Test getById(String test_id);
}
