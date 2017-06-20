package com.mall.service.impl;

import java.util.List;
import java.util.Map;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mall.dao.OrderMapper;
import com.mall.po.Order;
import com.mall.service.OrderService;
import com.trace.util.ResultUtil;

@Service
@Transactional
public class OrderServiceImpl implements OrderService {

	@Autowired
	private OrderMapper orderMapper;
	
	@Override
	public int deleteByPrimaryKey(String order_id) {
		return orderMapper.deleteByPrimaryKey(order_id);
	}

	@Override
	public int insert(Order record) {
		return orderMapper.insert(record);
	}

	@Override
	public int insertSelective(Order record) {
		return orderMapper.insertSelective(record);
	}

	@Override
	public Order selectByPrimaryKey(String order_id) {
		return orderMapper.selectByPrimaryKey(order_id);
	}

	@Override
	public int updateByPrimaryKeySelective(Order record) {
		return orderMapper.updateByPrimaryKeySelective(record);
	}

	@Override
	public int updateByPrimaryKey(Order record) {
		return orderMapper.updateByPrimaryKey(record);
	}

	@Override
	public List<Order> select(Order order) {
		return orderMapper.select(order);
	}

	@Override
	public String deleteOrder(String[] order_idArr) {
		String rs = "";
		try {
			for (int i = 0; i < order_idArr.length; i++) {
				orderMapper.deleteByPrimaryKey(order_idArr[i]);
			}
			rs = ResultUtil.resultString(1);
		} catch (Exception e) {
			e.printStackTrace();
			rs = ResultUtil.resultString(0);
			throw new RuntimeException();
		}
		return rs;
	}

	@Override
	public List<Order> query(Map<String, Object> map) {
		return orderMapper.query(map);
	}

	@Override
	public int count(Map<String, Object> map) {
		return orderMapper.count(map);
	}

}
