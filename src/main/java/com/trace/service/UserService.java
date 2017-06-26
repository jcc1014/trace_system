/**
 * @Description: 
 * @maven.com.trace.service
 * @FileName:UserService.java
 * @Created By:景长超
 * @Created:2017年4月10日 下午10:15:06
 */
package com.trace.service;

import java.util.List;
import java.util.Map;

import com.trace.po.User;

/**
 * @Description
 * @ClassName UserService
 * @author anthony
 * @Created 2017 2017年4月10日 下午10:15:06
 */
public interface UserService {
	List<User> selectAllUser();
	List<User> select(Map<String, Object> map);
	List<User> query(User user);
	int count(Map<String, Object> map);
	User selectByusernameAndpassword(String username, String password);
	Map<String,Object> add(User user);
	User getById(String userid);
	Map<String,Object> deleteById(String id);
	int updatePasswordById(User user);
}
