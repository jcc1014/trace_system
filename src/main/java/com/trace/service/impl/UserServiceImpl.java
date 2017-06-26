/**
 * @Description: 
 * @maven.com.trace.service.impl
 * @FileName:UserServiceImpl.java
 * @Created By:鏅暱瓒�
 * @Created:2017骞�鏈�0鏃�涓嬪崍10:15:56
 */
package com.trace.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.transaction.Transactional;

import org.apache.commons.codec.digest.DigestUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.trace.dao.UserDao;
import com.trace.po.User;
import com.trace.service.UserService;

/**
 * @Description
 * @ClassName UserServiceImpl
 * @author jcc
 * @Created 2017
 */
@Service
@Transactional
public class UserServiceImpl implements UserService{

	@Autowired
	private UserDao userDao;
	
	public List<User> selectAllUser() {
		return userDao.selectAllUser();
	}

	public User selectByusernameAndpassword(String username, String password) {
		return userDao.selectByusernameAndpassword(username, password);
	}

	@Override
	public Map<String,Object> add(User user) {
		Map<String,Object> map = new HashMap<String, Object>();
		try {
			user.setUserid(UUID.randomUUID().toString());
			user.setPassword(DigestUtils.md5Hex("000000"));
			userDao.insert(user);
			map.put("code", "200");
			map.put("msg", "保存成功，初始密码为000000");
			
		} catch (Exception e) {
			e.printStackTrace();
			map.put("code", -1);
			map.put("msg", "保存失败！");
			throw new RuntimeException();
		}
		return map;
	}

	@Override
	public User getById(String userid) {
		return userDao.selectByPrimaryKey(userid);
	}


	@Override
	public List<User> select(Map<String,Object> map) {
		return userDao.select(map);
	}

	@Override
	public int count(Map<String,Object> map) {
		return userDao.count(map);
	}

	@Override
	public List<User> query(User user) {
		return userDao.query(user);
	}

	@Override
	public Map<String,Object> deleteById(String id) {
		Map<String,Object> map = new HashMap<String, Object>();
		try {
			userDao.deleteById(id);
			map.put("code", "200");
			map.put("msg", "删除成功！");
			
		} catch (Exception e) {
			e.printStackTrace();
			map.put("code", -1);
			map.put("msg", "删除失败！");
			throw new RuntimeException();
		}
		return map;
	}
	
	@Override
	public int countUser(User user) {
		return userDao.countUser(user);
	}
	
	@Override
	public int updatePasswordById(User user) {
		return userDao.updatePasswordById(user);
	}
}
