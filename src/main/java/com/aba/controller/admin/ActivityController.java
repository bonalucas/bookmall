package com.aba.controller.admin;

import com.aba.pojo.*;
import com.aba.service.ActivityService;
import com.aba.service.GoodsService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
@RequestMapping("/admin/activity")
public class ActivityController {

    @Autowired(required = false)
    ActivityService activityService;

    @Autowired(required = false)
    GoodsService goodsService;

    @RequestMapping("/show")
    public String showActivity(@RequestParam(value = "page",defaultValue = "1") Integer pn, Model model, HttpSession session) {

        Admin admin = (Admin) session.getAttribute("admin");
        if (admin == null) {
            return "admin/adminLogin";
        }

        //一页显示几个数据
        PageHelper.startPage(pn, 10);

        ActivityExample activityExample = new ActivityExample();
        activityExample.or();

        List<Activity> activityList = activityService.getAllActivity(activityExample);

        //显示几个页号
        PageInfo<Activity> page = new PageInfo<>(activityList,5);
        model.addAttribute("pageInfo", page);

        return "admin/activity";
    }

    @RequestMapping("/showjson")
    @ResponseBody
    public Msg showActivityJson(@RequestParam(value = "page", defaultValue = "1") Integer pn, HttpSession session) {

        Admin admin = (Admin) session.getAttribute("admin");
        if (admin == null) {
            return Msg.fail("请先登录");
        }

        ActivityExample activityExample = new ActivityExample();
        activityExample.or();

        List<Activity> activityList = activityService.getAllActivity(activityExample);

        return Msg.success("获取活动信息成功").add("activity",activityList);
    }

    @RequestMapping("/add")
    public String showAddActivity(HttpSession session) {
        Admin admin = (Admin) session.getAttribute("admin");
        if (admin == null) {
            return "admin/adminLogin";
        }
        return "admin/addActivity";
    }

    @RequestMapping("/addResult")
    public String addActivity(Activity activity) {

        activityService.insertActivitySelective(activity);

        return "redirect:/admin/activity/show";
    }

    @RequestMapping("/update")
    @ResponseBody
    public Msg updateActivity(Integer goodsid, Integer activityid, HttpSession session) {
        Admin admin = (Admin) session.getAttribute("admin");
        if (admin == null) {
            return Msg.fail("请先登录");
        }
        Goods goods = new Goods();
        goods.setActivityid(activityid);
        goods.setGoodsid(goodsid);
        goodsService.updateGoodsById(goods);
        return Msg.success("更新商品活动成功");
    }

    @RequestMapping("delete")
    public String deleteActivity(Integer activityid, HttpSession session) {
        Admin admin = (Admin) session.getAttribute("admin");
        if (admin == null) {
            return "admin/adminLogin";
        }

        activityService.deleteByActivityId(activityid);
        return "redirect:/admin/activity/show";
    }
}
