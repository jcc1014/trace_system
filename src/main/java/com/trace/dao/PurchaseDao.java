/**
 * @Description: 
 * @maven.com.trace.dao
 * @FileName:PurchaseDao.java
 * @Created By:anthony
 * @Created:2017
 */
package com.trace.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.trace.po.Purchase;

/**
 * @Description
 * @ClassName PurchaseDao
 * @author jcc
 * @Created 2017 
 */
public interface PurchaseDao {
	List<Map<String,Object>> selectPurchase(Purchase purchase);
	List<Purchase> selectByName(@Param("purchase_name")String purchase_name);
	int insert(Purchase purchase);
	int update(Purchase purchase);
	int updateByPid(Purchase purchase);
	Purchase selectByPrimaryKey(@Param("purchase_id")String purchase_id);
}
