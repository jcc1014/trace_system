/**
 * @Description: 
 * @maven.com.trace.dao
 * @FileName:VegetablesDao.java
 * @Created By:jcc
 * @Created:
 */
package com.trace.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.trace.po.Vegetables;

/**
 * @Description
 * @ClassName VegetablesDao
 * @author jcc
 * @Created 2017 
 */
public interface VegetablesDao {
	List<Vegetables> selectAllVegetables();
	List<Vegetables> selectByName(@Param("vegetables_name")String vegetables_name);
	int insert(Vegetables vegetables);
	Vegetables selectByPrimaryKey(@Param("vegetables_id")String vegetables_id);
}
