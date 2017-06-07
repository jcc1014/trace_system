package com.mall.service;

import java.util.List;

import com.mall.po.Goods;

public interface GoodsService {

	int deleteByPrimaryKey(String goods_id);

    int insert(Goods record);

    int insertSelective(Goods record);

    Goods selectByPrimaryKey(String goods_id);

    int updateByPrimaryKeySelective(Goods record);

    int updateByPrimaryKey(Goods record);
	
    /**
     * Description: ��������ҳ��ѯ��Ʒ
     * @author Li Zheng
     * @date 2017��6��7������5:01:15
     * @param goods
     * @param pno
     * @param pageSize
     * @return
     */
    List<Goods> selectByPage(Goods goods, Integer pno, Integer pageSize);
    
}
