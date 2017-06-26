/**
 * @Description: 
 * @maven.com.trace.dao
 * @FileName:UserDao.java
 * @Created By:鏅暱瓒�
 * @Created:2017骞�鏈�0鏃�涓嬪崍10:13:33
 */
package com.trace.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.trace.po.User;

/**
 * @Description
 * @ClassName UserDao
 * @author jcc
 * @Created 2017 
 */
public interface UserDao {
	List<User> selectAllUser();
	List<User> select(Map<String, Object> map);
	List<User> query(User user);
	int count(Map<String, Object> map);
	User selectByusernameAndpassword(@Param("username") String username, @Param("password") String password);
	int insert(User user); 
	User selectByPrimaryKey(@Param("userid") String userid);
	int deleteById(@Param("id") String id);
	int updatePasswordById(User user);
}
