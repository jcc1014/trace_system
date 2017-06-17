package com.mall.dao;

import com.mall.po.Dict;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

@Repository
public interface DictMapper {
    int deleteByPrimaryKey(String dict_id);

    int insert(Dict record);

    int insertSelective(Dict record);

    Dict selectByPrimaryKey(String dict_id);
    
    List<Dict> selectByDictType(@Param("dict_type")String dict_type);
    
    List<Dict> selectByParentId(@Param("parentid")String parentid);

    int updateByPrimaryKeySelective(Dict record);

    int updateByPrimaryKey(Dict record);

    List<Dict> selectByExample(Dict dict);
    
    List<Dict> query(Map<String,Object> map);
    
    List<Dict> select(Dict dict);
    
    int count(Map<String,Object> map);
}