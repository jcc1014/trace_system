/**
 * @Description: 
 * @maven.com.trace.service
 * @FileName:FarmerService.java
 * @Created By:anthony
 * @Created:2017年4月10日 下午10:15:06
 */
package com.trace.service;

import java.util.List;

import com.trace.po.Farmer;

/**
 * @Description
 * @ClassName FarmerService
 * @author anthony
 * @Created 2017 2017年4月10日 下午10:15:06
 */
public interface FarmerService {
	List<Farmer> selectAllFarmer();
	List<Farmer> selectByName(String farmer_name);
	int add(Farmer farmer);
	Farmer getById(String farmer_id);
}
