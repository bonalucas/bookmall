package com.aba.controller.admin;

import com.aba.pojo.Admin;
import com.aba.service.AdminService;
import com.aba.utils.MD5Util;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

@Controller
@RequestMapping("/admin")
public class LoginController {

    @Autowired
    private AdminService adminService;

    @RequestMapping("/login")
    public String adminLogin() {
        return "admin/adminLogin";
    }

    @RequestMapping("/confirmLogin")
    public String confirmLogin(Admin admin, Model model, HttpServletRequest request) {
        // MD5加密
        admin.setPassword(MD5Util.getMD5(admin.getPassword()));
        Admin selectAdmin = adminService.selectByName(admin);
        if (selectAdmin == null) {
            model.addAttribute("errorMsg", "用户名或密码错误");
            return "admin/adminLogin";
        } else {
            HttpSession session = request.getSession();
            // 将管理员信息放入session域中
            session.setAttribute("admin", selectAdmin);
            return "redirect:/admin/user/show";
        }
    }

    @RequestMapping("/logout")
    public String adminLogout(HttpServletRequest request) {
        HttpSession session = request.getSession();
        session.removeAttribute("admin");
        return "admin/adminLogin";
    }
}
