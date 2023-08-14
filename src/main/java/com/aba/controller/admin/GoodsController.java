package com.aba.controller.admin;

import com.aba.pojo.*;
import com.aba.service.CateService;
import com.aba.service.GoodsService;
import com.aba.utils.FileNameUtil;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.IOException;
import java.util.*;

@Controller
@RequestMapping("/admin/goods")
public class GoodsController {

    @Autowired
    private GoodsService goodsService;

    @Autowired
    private CateService cateService;

    @RequestMapping("/showjson")
    @ResponseBody
    public Msg getAllGoods(@RequestParam(value = "page", defaultValue = "1") Integer pn, HttpServletResponse response, Model model, HttpSession session) {
        Admin admin = (Admin) session.getAttribute("admin");
        if (admin == null) {
            return Msg.fail("请先登录");
        }
        //一页显示10条数据
        PageHelper.startPage(pn, 10);
        //查询所有商品信息
        List<Goods> employees = goodsService.selectByExample(new GoodsExample());
        //显示几个页号
        PageInfo<Goods> page = new PageInfo<>(employees, 5);
        //将商品信息加入request作用域
        model.addAttribute("pageInfo", page);
        return Msg.success("查询成功!").add("pageInfo", page);
    }

    @RequestMapping("/show")
    public String goodsManage(@RequestParam(value = "page",defaultValue = "1") Integer pn, HttpServletResponse response, Model model, HttpSession session) {
        Admin admin = (Admin) session.getAttribute("admin");
        if (admin == null) {
            return "admin/adminLogin";
        }
        // 获取所有分类信息
        List<Category> categoryList = cateService.selectByExample(new CategoryExample());
        model.addAttribute("categoryList",categoryList);
        return "admin/adminAllGoods";
    }

    @RequestMapping("/add")
    public String showAdd(@ModelAttribute("succeseMsg") String msg, Model model, HttpSession session) {
        Admin admin = (Admin) session.getAttribute("admin");
        if (admin == null) {
            return "admin/adminLogin";
        }
        if(!msg.equals("")) {
            model.addAttribute("msg", msg);
        }
        // 获取分类并回显
        List<Category> categoryList = cateService.selectByExample(new CategoryExample());
        model.addAttribute("categoryList",categoryList);
        return "admin/addGoods";
    }

    @RequestMapping(value = "/update", method = RequestMethod.POST)
    @ResponseBody
    public Msg updateGoods(Goods goods, HttpSession session) {
        Admin admin = (Admin) session.getAttribute("admin");
        if (admin == null) {
            return Msg.fail("请先登录");
        }
        goodsService.updateGoodsById(goods);
        return Msg.success("更新成功!");
    }

    @RequestMapping(value = "/delete/{goodsid}", method = RequestMethod.DELETE)
    @ResponseBody
    public Msg deleteGoods(@PathVariable("goodsid")Integer goodsid) {
        goodsService.deleteGoodsById(goodsid);
        return Msg.success("删除成功!");
    }

    @RequestMapping("/addGoodsSuccess")
    public String addGoods(Goods goods,
                           @RequestParam MultipartFile[] fileToUpload,
                           HttpServletRequest request,
                           RedirectAttributes redirectAttributes) throws IOException {
        goods.setUptime(new Date());
        goods.setActivityid(1);
        goodsService.addGoods(goods);

        for(MultipartFile multipartFile:fileToUpload){
            if (multipartFile != null){
                // 提取生成文件名UUID+上传图片的后缀.jpg  .png
                String saveFileName = FileNameUtil.getUUIDFileName() + FileNameUtil.getFileType(Objects.requireNonNull(multipartFile.getOriginalFilename()));
                // 得到项目中图片存储的路径
                String path = request.getServletContext().getRealPath("/shopImage");
                // 组合最中的路径
                String imagePath = path + File.separator + saveFileName;
                // 把图片路径存入数据库中
                goodsService.addImagePath(new ImagePath(null, goods.getGoodsid(), saveFileName));
                // 存图片
                multipartFile.transferTo(new File(imagePath));
            }
        }

        redirectAttributes.addFlashAttribute("succeseMsg","商品添加成功!");

        return "redirect:/admin/goods/add";
    }

    @RequestMapping("/addCategory")
    public String addcategory(@ModelAttribute("succeseMsg") String msg, Model model, HttpSession session) {
        Admin admin = (Admin) session.getAttribute("admin");
        if (admin == null) {
            return "admin/adminLogin";
        }
        CategoryExample categoryExample = new CategoryExample();
        categoryExample.or();
        List<Category> categoryList;
        categoryList = cateService.selectByExample(categoryExample);
        model.addAttribute("categoryList", categoryList);
        if (!msg.equals("")) {
            model.addAttribute("msg", msg);
        }
        return "admin/addCategory";
    }

    @RequestMapping("/addCategoryResult")
    public String addCategoryResult(Category category, RedirectAttributes redirectAttributes){
        List<Category> categoryList;
        CategoryExample categoryExample = new CategoryExample();
        categoryExample.or().andCatenameEqualTo(category.getCatename());
        categoryList = cateService.selectByExample(categoryExample);
        if (!categoryList.isEmpty()) {
            redirectAttributes.addAttribute("succeseMsg","分类已存在");
            return "redirect:/admin/goods/addCategory";
        }else {
            cateService.insertSelective(category);
            redirectAttributes.addFlashAttribute("succeseMsg","分类添加成功!");
            return "redirect:/admin/goods/addCategory";
        }
    }

    @RequestMapping("/saveCate")
    @ResponseBody
    public Msg saveCate(Category category){
        CategoryExample categoryExample = new CategoryExample();
        categoryExample.or().andCatenameEqualTo(category.getCatename());
        List<Category> categoryList = cateService.selectByExample(categoryExample);
        if (categoryList.isEmpty()) {
            cateService.updateByPrimaryKeySelective(category);
            return Msg.success("更新成功");
        }else {
            return Msg.success("名字已经存在");
        }
    }

    @RequestMapping("/deleteCate")
    @ResponseBody
    public Msg deleteCate(Category category){
        cateService.deleteByPrimaryKey(category.getCateid());
        return Msg.success("删除成功");
    }
}
