package com.mall.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mall.dao.DictMapper;
import com.mall.po.Dict;
import com.mall.service.DictService;

@Service
public class DictServiceImpl implements DictService {

	@Autowired
	private DictMapper dictMapper;
	
	@Override
	public List<Dict> selectByExample(Dict dict) {
		return dictMapper.selectByExample(dict);
	}

}
