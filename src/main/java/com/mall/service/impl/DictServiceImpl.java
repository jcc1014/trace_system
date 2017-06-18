package com.mall.service.impl;

import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mall.dao.DictMapper;
import com.mall.po.Dict;
import com.mall.service.DictService;

@Service
@Transactional
public class DictServiceImpl implements DictService {

	@Autowired
	private DictMapper dictMapper;
	
	@Override
	public List<Dict> selectByExample(Dict dict) {
		return dictMapper.selectByExample(dict);
	}

	@Override
	public List<Dict> query(Map<String, Object> map) {
		return dictMapper.query(map);
	}

	@Override
	public List<Dict> select(Dict dict) {
		return dictMapper.selectByExample(dict);
	}

	@Override
	public int count(Map<String, Object> map) {
		return dictMapper.count(map);
	}

	@Override
	public List<Dict> selectByDictType(String dict_type) {
		return dictMapper.selectByDictType(dict_type);
	}

	@Override
	public List<Dict> selectByParentId(String parentid) {
		return dictMapper.selectByParentId(parentid);
	}

	@Override
	public int deleteByPrimaryKey(String dict_id) {
		return dictMapper.deleteByPrimaryKey(dict_id);
	}

	@Override
	public int insert(Dict record) {
		return dictMapper.insert(record);
	}

	@Override
	public int insertSelective(Dict record) {
		int r = 0;
		try {
			record.setDict_id(UUID.randomUUID().toString());
			List<Dict> list = dictMapper.selectByParentId(record.getParentid());
			record.setDict_index(list.size()+1+"");
			r = dictMapper.insertSelective(record);
		} catch (Exception e) {
			e.printStackTrace();
			throw new RuntimeException();
		}
		return r;
	}

	@Override
	public int updateByPrimaryKeySelective(Dict record) {
		return dictMapper.updateByPrimaryKeySelective(record);
	}

	@Override
	public int updateByPrimaryKey(Dict record) {
		return dictMapper.updateByPrimaryKey(record);
	}

	@Override
	public int insertParent(Dict record) {
		int r = 0;
		try {
			record.setDict_id(UUID.randomUUID().toString());
			record.setParentid("0");
			List<Dict> list = dictMapper.selectByParentId("0");
			record.setDict_index(list.size()+1+"");
			r = dictMapper.insertSelective(record);
		} catch (Exception e) {
			e.printStackTrace();
			throw new RuntimeException();
		}
		return r;
	}

}
