/**
 * @Description: 
 * @maven.com.trace.service
 * @FileName:VideoService.java
 * @Created By:anthony
 * @Created:2017年4月10日 下午10:15:06
 */
package com.trace.service;

import java.util.List;

import com.trace.po.Video;

/**
 * @Description
 * @ClassName VideoService
 * @author anthony
 * @Created 2017 2017年4月10日 下午10:15:06
 */
public interface VideoService {
	List<Video> selectAllVideo();
	int add(Video video);
	Video getById(String video_id);
	Video selectByName(String username);
}
