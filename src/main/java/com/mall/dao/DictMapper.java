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
     * Description: ����dict_name��dict_type��parentid��ѯ 
     * @author Li Zheng
     * @date 2017��6��7������10:25:48
     * @param dict
     * @return
     */
    List<Dict> selectByExample(Dict dict);
}