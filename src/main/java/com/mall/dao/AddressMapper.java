package com.mall.dao;

import java.util.List;

import com.mall.po.Address;
import org.apache.ibatis.annotations.Param;

public interface AddressMapper {
    int deleteByPrimaryKey(String address_id);

    int insert(Address record);

    int insertSelective(Address record);

    Address selectByPrimaryKey(String address_id);

    int updateByPrimaryKeySelective(Address record);

    int updateByPrimaryKey(Address record);
    
    List<Address> select(Address address);
    
    int updateStatus(@Param("address_id") String id, @Param("status") String status);
}