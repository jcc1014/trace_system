/**
 * @Description: 
 * @maven.com.trace.dao
 * @FileName:VideoDao.java
 * @Created By:jcc
 * @Created:
 */
package com.trace.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.trace.po.Video;

/**
 * @Description
 * @ClassName VideoDao
 * @author jcc
 * @Created 2017 
 */
public interface VideoDao {
	List<Video> selectAllVideo();
	int insert(Video video);
	Video selectByPrimaryKey(@Param("video_id")String video_id);
	Video selectByName(@Param("username")String username);
	int deleteById(@Param("video_id")String video_id);
	int update(Video video);
}
