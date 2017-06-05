package com.mall.dao;

import com.mall.po.Address;

public interface AddressMapper {
    int deleteByPrimaryKey(String address_id);

    int insert(Address record);

    int insertSelective(Address record);

    Address selectByPrimaryKey(String address_id);

    int updateByPrimaryKeySelective(Address record);

    int updateByPrimaryKey(Address record);
}