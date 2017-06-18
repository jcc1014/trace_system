package com.mall.service;

import com.mall.po.Member;
import com.trace.po.User;

public interface MemberService {

	int deleteByPrimaryKey(String member);

    int insert(Member record);

    int insertSelective(Member record);

    Member selectByPrimaryKey(String member);

    int updateByPrimaryKeySelective(Member record);

    int updateByPrimaryKey(Member record);
    
    String addMember(User user,Member member);
}
