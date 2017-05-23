/**
 * @Description: 
 * @maven.com.trace.dao
 * @FileName:PurchaseDao.java
 * @Created By:anthony
 * @Created:2017
 */
package com.trace.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.trace.po.Purchase;

/**
 * @Description
 * @ClassName PurchaseDao
 * @author jcc
 * @Created 2017 
 */
public interface PurchaseDao {
	List<Purchase> selectAllPurchase();
	List<Purchase> selectByName(@Param("purchase_name")String purchase_name);
	int insert(Purchase purchase);
	Purchase selectByPrimaryKey(@Param("purchase_id")String purchase_id);
}
