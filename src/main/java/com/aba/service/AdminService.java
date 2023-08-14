package com.aba.service;

import com.aba.pojo.Admin;

public interface AdminService {
    // 通过用户名和密码获取对应的管理员信息
    Admin selectByName(Admin admin);
}
