package com.mall.service;

import java.util.List;

import com.mall.po.Dict;

public interface DictService {

	List<Dict> selectByExample(Dict dict);
	
}
