/**
 * @Description: 
 * @maven.com.trace.dao
 * @FileName:FarmerDao.java
 * @Created By:anthony
 * @Created:2017
 */
package com.trace.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.trace.po.Farmer;

/**
 * @Description
 * @ClassName FarmerDao
 * @author jcc
 * @Created 2017 
 */
public interface FarmerDao {
	List<Farmer> selectAllFarmer();
	List<Farmer> selectByName(@Param("farmer_name")String farmer_name);
	int insert(Farmer farmer);
	Farmer selectByPrimaryKey(@Param("farmer_id")String farmer_id);
	Farmer getByPhone(@Param("phone")String phone);
}
