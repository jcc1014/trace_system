package com.trace.service.impl;

import java.util.List;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.trace.dao.TransportDao;
import com.trace.po.Transport;
import com.trace.service.TransportService;

@Service
@Transactional
public class TransportServiceImpl implements TransportService {

	@Autowired
	private TransportDao transportDao;
	
	@Override
	public List<Transport> selectAllTransport() {
		return transportDao.selectAllTransport();
	}

	@Override
	public List<Transport> selectByName(String transport_user) {
		return transportDao.selectByName(transport_user);
	}

	@Override
	public int add(Transport transport) {
		return transportDao.insert(transport);
	}

	@Override
	public Transport getById(String test_id) {
		// TODO Auto-generated method stub
		return null;
	}

}
