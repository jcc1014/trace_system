package com.trace.service.impl;

import java.util.List;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.trace.dao.VideoDao;
import com.trace.po.Video;
import com.trace.service.VideoService;

@Service
@Transactional
public class VideoServiceImpl implements VideoService {

	@Autowired
	private VideoDao videoDao;
	
	@Override
	public List<Video> selectAllVideo() {
		return videoDao.selectAllVideo();
	}

	@Override
	public int add(Video video) {
		return videoDao.insert(video);
	}

	@Override
	public Video getById(String video_id) {
		return videoDao.selectByPrimaryKey(video_id);
	}

	@Override
	public Video selectByName(String username) {
		return videoDao.selectByName(username);
	}

}
