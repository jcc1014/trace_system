package com.mall.service;

import java.util.List;
import java.util.Map;

import com.mall.po.Dict;

public interface DictService {

	List<Dict> selectByExample(Dict dict);
	
	List<Dict> query(Map<String, Object> map);
    
    List<Dict> select(Dict dict);
    
    int count(Map<String, Object> map);
    
    List<Dict> selectByDictType(String dict_type);
    
    List<Dict> selectByParentId(String parentid);
    
    int deleteByPrimaryKey(String dict_id);

    int insert(Dict record);

    int insertSelective(Dict record);
    
    int insertParent(Dict record);
    
    int updateByPrimaryKeySelective(Dict record);

    int updateByPrimaryKey(Dict record);
}
