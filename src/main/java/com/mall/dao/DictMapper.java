package com.mall.dao;

import com.mall.po.Dict;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface DictMapper {
    int deleteByPrimaryKey(String dict_id);

    int insert(Dict record);

    int insertSelective(Dict record);

    Dict selectByPrimaryKey(String dict_id);

    int updateByPrimaryKeySelective(Dict record);

    int updateByPrimaryKey(Dict record);

    List<Dict> selectByExample(Dict dict);
}