package com.trace.service.impl;

import java.util.List;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.trace.dao.PurchaseDao;
import com.trace.po.Purchase;
import com.trace.service.PurchaseService;

@Service
@Transactional
public class PurchaseServiceImpl implements PurchaseService {

	@Autowired
	private PurchaseDao purchaseDao;
	
	@Override
	public List<Purchase> selectAllPurchase() {
		return purchaseDao.selectAllPurchase();
	}

	@Override
	public List<Purchase> selectByName(String purchase_name) {
		return purchaseDao.selectByName(purchase_name);
	}

	@Override
	public int add(Purchase purchase) {
		return purchaseDao.insert(purchase);
	}

	@Override
	public Purchase getById(String purchase_id) {
		return purchaseDao.selectByPrimaryKey(purchase_id);
	}

}
