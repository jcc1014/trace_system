/**
 * @Description: 
 * @maven.com.trace.service
 * @FileName:TransportService.java
 * @Created By:anthony
 * @Created:2017年4月10日 下午10:15:06
 */
package com.trace.service;

import java.util.List;

import com.trace.po.Transport;

/**
 * @Description
 * @ClassName TransportService
 * @author anthony
 * @Created 2017 2017年4月10日 下午10:15:06
 */
public interface TransportService {
	List<Transport> selectAllTransport();
	List<Transport> selectByName(String transport_user);
	int add(Transport transport);
	Transport getById(String test_id);
}
