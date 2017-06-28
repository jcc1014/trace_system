package com.mall.service.impl;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import javax.transaction.Transactional;

import com.mall.dao.GoodsPicMapper;
import com.mall.po.GoodsPic;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mall.dao.GoodsMapper;
import com.mall.dto.PageParam;
import com.mall.po.Goods;
import com.mall.service.GoodsService;
import org.springframework.util.StringUtils;

@Service
public class GoodsServiceImpl implements GoodsService{

	@Autowired
	private GoodsMapper goodsMapper;

	@Autowired
	private GoodsPicMapper goodsPicMapper;

	@Override
	public int deleteByPrimaryKey(String goods_id) {
		return goodsMapper.deleteByPrimaryKey(goods_id);
	}

	@Override
	public int insert(Goods record) {
		return goodsMapper.insert(record);
	}

	@Override
	public int insertSelective(Goods record) {
		return goodsMapper.insertSelective(record);
	}

	@Override
	public Goods selectByPrimaryKey(String goods_id) {
		return goodsMapper.selectByPrimaryKey(goods_id);
	}

	@Override
	public int updateByPrimaryKeySelective(Goods record) {
		return goodsMapper.updateByPrimaryKeySelective(record);
	}

	@Override
	public int updateByPrimaryKey(Goods record) {
		return goodsMapper.updateByPrimaryKey(record);
	}

    @Override
    public List<Goods> selectByPage(PageParam<Goods> pageParam) {
        return goodsMapper.selectByPage(pageParam);
    }

	@Override
	public Long count(Goods goods) {
		return goodsMapper.count(goods);
	}

	@Override
	@Transactional
	public void insertGoodsAndPic(Goods goods, String[] goods_pic, String[] real_path) throws Exception {
		try {
            String goods_id = goods.getGoods_id();
			int row = 0;
            if (StringUtils.isEmpty(goods_id)) {
                goods_id = UUID.randomUUID().toString();
                goods.setGoods_id(goods_id);
	            row = goodsMapper.insert(goods);
            } else {
	            goodsPicMapper.deleteByGoodsId(goods_id);
	            row = goodsMapper.updateByPrimaryKeySelective(goods);
            }
            if (row > 0) {
                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
				if (goods_pic != null && goods_pic.length > 0) {
					for (int i = 0; i < goods_pic.length; i ++) {
						GoodsPic goodsPic = new GoodsPic();
						goodsPic.setPic_id(UUID.randomUUID().toString());
						goodsPic.setGoods_id(goods_id);
						goodsPic.setPic_path(goods_pic[i]);
						goodsPic.setReal_path(real_path[i]);
						goodsPic.setPic_index(String.valueOf(i));
						goodsPic.setCreate_time(sdf.format(new Date()));
						goodsPicMapper.insert(goodsPic);
					}
				}
				return;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		throw new RuntimeException();
	}

	@Override
	public List<Goods> select(Goods goods) {
		return goodsMapper.select(goods);
	}
}
