package com.mall.dao;

import java.util.List;

import com.mall.po.Dict;

public interface DictMapper {
    int deleteByPrimaryKey(String dict_id);

    int insert(Dict record);

    int insertSelective(Dict record);

    Dict selectByPrimaryKey(String dict_id);

    int updateByPrimaryKeySelective(Dict record);

    int updateByPrimaryKey(Dict record);
    
    /**
     * Description: 根据dict_name、dict_type、parentid查询 
     * @author Li Zheng
     * @date 2017年6月7日下午10:25:48
     * @param dict
     * @return
     */
    List<Dict> selectByExample(Dict dict);
}