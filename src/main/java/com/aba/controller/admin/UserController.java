package com.aba.controller.admin;

import com.aba.pojo.Msg;
import com.aba.pojo.User;
import com.aba.pojo.UserExample;
import com.aba.service.UserService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
@RequestMapping("/admin/user")
public class UserController {

    @Autowired
    private UserService userService;

    @RequestMapping("/showjson")
    @ResponseBody
    public Msg getAllUsers(@RequestParam(value = "page", defaultValue = "1") Integer pn) {
        //一页显示10条数据
        PageHelper.startPage(pn, 10);
        // 查询所有的用户信息
        List<User> userList = userService.selectByExample(new UserExample());
        //显示几个页号
        PageInfo<User> page = new PageInfo<>(userList,5);
        // 加入成功信息并将当前查询分页的数据传给Msg的Mao映射
        return Msg.success("查询成功!").add("pageInfo", page);
    }

    @RequestMapping("/show")
    public String userManage() {
        return "admin/userManage";
    }

    @RequestMapping(value = "/delete/{userid}", method = RequestMethod.DELETE)
    @ResponseBody
    public Msg deleteUser(@PathVariable("userid")Integer userid) {
        userService.deleteUserById(userid);
        return Msg.success("删除成功!");
    }
}
