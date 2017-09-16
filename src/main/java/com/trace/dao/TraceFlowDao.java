/**
 * @Description: 
 * @maven.com.trace.dao
 * @FileName:TraceFlowDao.java
 * @Created By:jcc
 * @Created:2017
 */
package com.trace.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.trace.po.TraceFlow;

/**
 * @Description
 * @ClassName TraceFlowDao
 * @author jcc
 * @Created 2017 
 */
public interface TraceFlowDao {
	List<TraceFlow> selectAllTraceFlow(TraceFlow traceFlow);
	int insert(TraceFlow traceFlow);
	TraceFlow selectByPrimaryKey(@Param("trace_id")String trace_id);
	
	List<Map<String,Object>> query(Map<String,Object> map);
	List<Map<String,Object>> selectIdentifier(Map<String,Object> map);
	Map<String,Object> selectFlowById(@Param("trace_id")String trace_id);
	Map<String,Object> selectFlowByCode(@Param("code")String code);
	int count(Map<String,Object> map);
	int update(TraceFlow traceFlow);
}
