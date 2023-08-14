package com.aba.service.impl;

import com.aba.dao.AdminMapper;
import com.aba.pojo.Admin;
import com.aba.service.AdminService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service("adminService")
public class AdminServiceImpl implements AdminService {

    // false代表匹配失败后将被忽略
    @Autowired(required = false)
    private AdminMapper adminMapper;

    @Override
    public Admin selectByName(Admin admin) {
        return adminMapper.selectByName(admin);
    }
}
