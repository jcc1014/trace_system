/**
 * @Description: 
 * @maven.com.trace.dao
 * @FileName:QrcodeDao.java
 * @Created By:anthony
 * @Created:2017
 */
package com.trace.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.trace.po.Qrcode;

/**
 * @Description
 * @ClassName QrcodeDao
 * @author jcc
 * @Created 2017 
 */
public interface QrcodeDao {
	List<Qrcode> selectAllQrcode();
	int insert(Qrcode qrcode);
	Qrcode selectByPrimaryKey(@Param("qrcode_id")String qrcode_id);
}
