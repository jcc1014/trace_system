/**
 * @Description: 
 * @maven.com.trace.service
 * @FileName:VegetablesService.java
 * @Created By:anthony
 * @Created:2017年4月10日 下午10:15:06
 */
package com.trace.service;

import java.util.List;

import com.trace.po.Vegetables;

/**
 * @Description
 * @ClassName VegetablesService
 * @author anthony
 * @Created 2017 2017年4月10日 下午10:15:06
 */
public interface VegetablesService {
	List<Vegetables> selectAllVegetables();
	List<Vegetables> selectByName(String vegetables_name);
	int add(Vegetables vegetables);
	Vegetables getById(String vegetables_id);
}
