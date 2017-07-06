/**
 * @Description: 
 * @maven.com.trace.service
 * @FileName:PurchaseService.java
 * @Created By:anthony
 * @Created:2017年4月10日 下午10:15:06
 */
package com.trace.service;

import java.util.List;
import java.util.Map;

import com.trace.po.Purchase;

/**
 * @Description
 * @ClassName PurchaseService
 * @author anthony
 * @Created 2017 2017年4月10日 下午10:15:06
 */
public interface PurchaseService {
	List<Map<String,Object>> selectPurchase(Purchase purchase);
	List<Purchase> selectByName(String purchase_name);
	int add(Purchase purchase);
	int update(Purchase purchase);
	int updateByPid(Purchase purchase);
	Purchase getById(String purchase_id);
}
