/**
 * @Description: 
 * @maven.com.trace.dao
 * @FileName:TransportDao.java
 * @Created By:jcc
 * @Created:
 */
package com.trace.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.trace.po.Transport;

/**
 * @Description
 * @ClassName TransportDao
 * @author jcc
 * @Created 2017 
 */
public interface TransportDao {
	List<Transport> selectAllTransport();
	List<Transport> selectByName(@Param("transport_user")String transport_user);
	int insert(Transport transport);
	Transport selectByPrimaryKey(@Param("transport_id")String transport_id);
	List<Map<String,Object>> selectTodayTranportList(Map<String,Object> map);
}
