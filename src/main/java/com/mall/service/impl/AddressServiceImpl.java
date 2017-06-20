package com.mall.service.impl;

import java.util.List;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mall.dao.AddressMapper;
import com.mall.po.Address;
import com.mall.service.AddressService;

@Service
@Transactional
public class AddressServiceImpl implements AddressService {

	@Autowired
	private AddressMapper addressMapper;
	
	@Override
	public int deleteByPrimaryKey(String address_id) {
		return addressMapper.deleteByPrimaryKey(address_id);
	}

	@Override
	public int insert(Address record) {
		return addressMapper.insert(record);
	}

	@Override
	public int insertSelective(Address record) {
		return addressMapper.insertSelective(record);
	}

	@Override
	public Address selectByPrimaryKey(String address_id) {
		return addressMapper.selectByPrimaryKey(address_id);
	}

	@Override
	public int updateByPrimaryKeySelective(Address record) {
		return addressMapper.updateByPrimaryKeySelective(record);
	}

	@Override
	public int updateByPrimaryKey(Address record) {
		return addressMapper.updateByPrimaryKey(record);
	}

	@Override
	public List<Address> select(Address address) {
		return addressMapper.select(address);
	}

}
