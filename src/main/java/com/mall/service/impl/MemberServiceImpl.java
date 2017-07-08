package com.mall.service.impl;

import java.util.UUID;

import javax.transaction.Transactional;

import org.apache.commons.codec.digest.DigestUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mall.dao.MemberMapper;
import com.mall.po.Member;
import com.mall.service.MemberService;
import com.trace.dao.UserDao;
import com.trace.po.User;
import com.trace.util.ResultUtil;
import com.utils.UUIDFactory;

@Service
@Transactional
public class MemberServiceImpl implements MemberService{

	@Autowired
	private MemberMapper memberMapper;
	@Autowired
	private UserDao userMapper;
	
	@Override
	public int deleteByPrimaryKey(String member) {
		return 0;
	}

	@Override
	public int insert(Member record) {
		return 0;
	}

	@Override
	public int insertSelective(Member record) {
		return 0;
	}

	@Override
	public Member selectByPrimaryKey(String member) {
		return memberMapper.selectByPrimaryKey(member);
	}

	@Override
	public int updateByPrimaryKeySelective(Member record) {
		return memberMapper.updateByPrimaryKeySelective(record);
	}

	@Override
	public int updateByPrimaryKey(Member record) {
		return memberMapper.updateByPrimaryKey(record);
	}

	@Override
	public String addMember(User user, Member member) {
		String rs = "";
		try {
			user.setUserid(UUIDFactory.getInstance().newUUID());
			user.setUsername(member.getPhone());
			user.setPassword(DigestUtils.md5Hex(user.getPassword()));
			user.setUsertype("4"); //会员
			member.setType("4"); 
			userMapper.insert(user);
			member.setMember(user.getUserid());
			memberMapper.insertSelective(member);
			rs = ResultUtil.resultString(1);
		} catch (Exception e) {
			e.printStackTrace();
			rs = ResultUtil.resultString(0);
			throw new RuntimeException();
		}
		return rs;
	}

}
