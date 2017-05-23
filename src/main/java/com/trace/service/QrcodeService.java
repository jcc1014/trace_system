/**
 * @Description: 
 * @maven.com.trace.service
 * @FileName:QrcodeService.java
 * @Created By:anthony
 * @Created:2017年4月10日 下午10:15:06
 */
package com.trace.service;

import java.util.List;

import com.trace.po.Qrcode;

/**
 * @Description
 * @ClassName QrcodeService
 * @author anthony
 * @Created 2017 2017年4月10日 下午10:15:06
 */
public interface QrcodeService {
	List<Qrcode> selectAllQrcode();
	int add(Qrcode qrcode);
	Qrcode getById(String qrcode_id);
}
