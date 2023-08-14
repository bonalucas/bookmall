package com.aba.service;

import com.aba.pojo.User;
import com.aba.pojo.UserExample;

import java.util.List;

public interface UserService {
    User selectByPrimaryKey(int userId);

    // 查询所有用户信息
    List<User> selectByExample(UserExample userExample);

    void insertSelective(User user);

    void deleteUserById(Integer userid);

    void updateByPrimaryKeySelective(User user);

}
