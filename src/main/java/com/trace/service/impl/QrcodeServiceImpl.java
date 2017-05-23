package com.trace.service.impl;

import java.util.List;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.trace.dao.QrcodeDao;
import com.trace.po.Qrcode;
import com.trace.service.QrcodeService;

@Service
@Transactional
public class QrcodeServiceImpl implements QrcodeService {

	@Autowired
	private QrcodeDao qrcodeDao;
	
	@Override
	public List<Qrcode> selectAllQrcode() {
		return qrcodeDao.selectAllQrcode();
	}

	@Override
	public int add(Qrcode qrcode) {
		return qrcodeDao.insert(qrcode);
	}

	@Override
	public Qrcode getById(String qrcode_id) {
		return qrcodeDao.selectByPrimaryKey(qrcode_id);
	}

}
