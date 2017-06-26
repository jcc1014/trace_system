package com.mall.service.impl;

import java.util.List;
import java.util.Map;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mall.dao.BannerMapper;
import com.mall.po.Banner;
import com.mall.service.BannerService;

/**
 * 轮播图
 * @author jingcc
 *
 */
@Service
@Transactional
public class BannerServiceImpl implements BannerService {

	@Autowired
	private BannerMapper bannerMapper;
	
	@Override
	public int deleteByPrimaryKey(String banner_id) {
		return bannerMapper.deleteByPrimaryKey(banner_id);
	}

	@Override
	public int insert(Banner record) {
		return bannerMapper.insert(record);
	}

	@Override
	public int insertSelective(Banner record) {
		return bannerMapper.insertSelective(record);
	}

	@Override
	public Banner selectByPrimaryKey(String banner_id) {
		return bannerMapper.selectByPrimaryKey(banner_id);
	}

	@Override
	public int updateByPrimaryKeySelective(Banner record) {
		return bannerMapper.updateByPrimaryKeySelective(record);
	}

	@Override
	public int updateByPrimaryKey(Banner record) {
		return bannerMapper.updateByPrimaryKey(record);
	}

	@Override
	public List<Banner> query(Map<String, Object> map) {
		return bannerMapper.query(map);
	}

	@Override
	public int count(Map<String, Object> map) {
		return bannerMapper.count(map);
	}

	@Override
	public List<Banner> select(Banner banner) {
		return bannerMapper.select(banner);
	}

}
