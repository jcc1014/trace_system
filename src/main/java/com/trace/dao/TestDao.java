/**
 * @Description: 
 * @maven.com.trace.dao
 * @FileName:TestDao.java
 * @Created By:anthony
 * @Created:2017
 */
package com.trace.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.trace.po.Test;

/**
 * @Description
 * @ClassName TestDao
 * @author jcc
 * @Created 2017 
 */
public interface TestDao {
	List<Test> selectAllTest();
	List<Test> selectByName(@Param("test_name")String test_name);
	int insert(Test test);
	Test selectByPrimaryKey(@Param("test_id")String test_id);
}
