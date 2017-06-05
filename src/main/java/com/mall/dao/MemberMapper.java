package com.mall.dao;

import com.mall.po.Member;

public interface MemberMapper {
    int deleteByPrimaryKey(String member);

    int insert(Member record);

    int insertSelective(Member record);

    Member selectByPrimaryKey(String member);

    int updateByPrimaryKeySelective(Member record);

    int updateByPrimaryKey(Member record);
}