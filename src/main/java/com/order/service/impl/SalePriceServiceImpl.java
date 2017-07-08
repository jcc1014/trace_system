package com.order.service.impl;

import java.util.List;
import java.util.Map;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.order.dao.SalePriceMapper;
import com.order.po.SalePrice;
import com.order.service.SalePriceService;

@Service
@Transactional
public class SalePriceServiceImpl implements SalePriceService {

	@Autowired
	private SalePriceMapper salePriceMapper;
	
	@Override
	public int deleteByPrimaryKey(String id) {
		return salePriceMapper.deleteByPrimaryKey(id);
	}

	@Override
	public int insertSelective(SalePrice record) {
		return salePriceMapper.insertSelective(record);
	}

	@Override
	public SalePrice selectByPrimaryKey(String id) {
		return salePriceMapper.selectByPrimaryKey(id);
	}

	@Override
	public int updateByPrimaryKeySelective(SalePrice record) {
		return salePriceMapper.updateByPrimaryKeySelective(record);
	}

	@Override
	public List<SalePrice> select(SalePrice salePrice) {
		return salePriceMapper.select(salePrice);
	}

	@Override
	public List<SalePrice> query(Map<String, Object> map) {
		return salePriceMapper.query(map);
	}

	@Override
	public int count(Map<String, Object> map) {
		return salePriceMapper.count(map);
	}

	@Override
	public int deleteByParentid(SalePrice salePrice) {
		return salePriceMapper.deleteByParentid(salePrice);
	}

	@Override
	public int updateByParentid(SalePrice salePrice) {
		return salePriceMapper.updateByParentid(salePrice);
	}

	@Override
	public int insertByRequireAndPurchase(Map<String, Object> map) {
		return salePriceMapper.insertByRequireAndPurchase(map);
	}

	@Override
	public SalePrice selectByKindAndGrade(String kind, String grade,
			String datetime) {
		return salePriceMapper.selectByKindAndGrade(kind, grade, datetime);
	}

}
