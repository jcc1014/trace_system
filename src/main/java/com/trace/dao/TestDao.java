/**
 * @Description: 
 * @maven.com.trace.dao
 * @FileName:TestDao.java
 * @Created By:anthony
 * @Created:2017
 */
package com.trace.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.trace.po.Test;

/**
 * @Description
 * @ClassName TestDao
 * @author jcc
 * @Created 2017 
 */
public interface TestDao {
	List<Test> selectAllTest(Test test);
	List<Test> query(Map<String,Object> map);
	int count(Map<String,Object> map);
	List<Test> selectByName(@Param("test_name")String test_name);
	int insert(Test test);
	Test selectByPrimaryKey(@Param("test_id")String test_id);
	int update(Test test);
	int updateByNameAndTime(Test test);
	int deleteById(@Param("test_id")String id);
	List<Map<String,Object>> getTestInfo(Map<String,String> map);
}
