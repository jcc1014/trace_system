package com.mall.dao;

import com.mall.po.Comment;

public interface CommentMapper {
    int deleteByPrimaryKey(String comment_id);

    int insert(Comment record);

    int insertSelective(Comment record);

    Comment selectByPrimaryKey(String comment_id);

    int updateByPrimaryKeySelective(Comment record);

    int updateByPrimaryKey(Comment record);
}