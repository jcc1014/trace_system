package com.mall.service.impl;

import com.mall.dao.MallOrderMapper;
import com.mall.po.MallOrder;
import com.mall.service.MallOrderService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class MallOrderServiceImpl implements MallOrderService {
	
	@Autowired
	private MallOrderMapper mallOrderMapper;
	
	@Override
	public int insert(MallOrder mallOrder) {
		return mallOrderMapper.insert(mallOrder);
	}
	
	@Override
	public List<MallOrder> select(MallOrder mallOrder) {
		return mallOrderMapper.select(mallOrder);
	}
}
