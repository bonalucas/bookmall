package com.aba.service;

import com.aba.pojo.Comment;
import com.aba.pojo.CommentExample;

import java.util.List;

public interface CommentService {
    void insertSelective(Comment comment);

    List<Comment> selectByExample(CommentExample commentExample);
}
