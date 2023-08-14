package com.aba.controller.front;

import com.aba.pojo.*;
import com.aba.service.CateService;
import com.aba.service.GoodsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;

@Controller
public class MainController {

    @Autowired
    private CateService cateService;

    @Autowired
    private GoodsService goodsService;

    @RequestMapping("/main")
    public String showAllGoods(Model model, HttpSession session) {

        Integer userid;
        User user = (User) session.getAttribute("user");
        if (user == null) {
            userid = null;
        } else {
            userid = user.getUserid();
        }
        //文学
        List<Goods> ltGoods = getCateGoods("文学", userid);
        model.addAttribute("ltGoods", ltGoods);
        //经济
        List<Goods> emGoods = getCateGoods("经济", userid);
        model.addAttribute("emGoods", emGoods);
        //艺术
        List<Goods> artGoods = getCateGoods("艺术", userid);
        model.addAttribute("artGoods", artGoods);
        //数理科学
        List<Goods> msGoods = getCateGoods("数理科学", userid);
        model.addAttribute("msGoods", msGoods);
        //计算机科学
        List<Goods> csGoods = getCateGoods("计算机科学", userid);
        model.addAttribute("csGoods", csGoods);
        //工业技术
        List<Goods> itGoods = getCateGoods("工业技术", userid);
        model.addAttribute("itGoods", itGoods);
        //综合性图书
        List<Goods> othGoods = getCateGoods("综合性图书", userid);
        model.addAttribute("othGoods", othGoods);

        return "front/main";
    }

    public List<Goods> getCateGoods(String cate, Integer userid) {

        //查询分类
        CategoryExample digCategoryExample = new CategoryExample();
        digCategoryExample.or().andCatenameLike(cate);
        List<Category> digCategoryList = cateService.selectByExample(digCategoryExample);
        // 判空
        if (digCategoryList.size() == 0) {
            return null;
        }
        //查询属于刚查到的分类的商品
        GoodsExample digGoodsExample = new GoodsExample();
        List<Integer> digCateId = new ArrayList<>();
        for (Category tmp : digCategoryList) {
            digCateId.add(tmp.getCateid());
        }
        digGoodsExample.or().andCategoryIn(digCateId);
        // 获取对应商品列表
        List<Goods> goodsList = goodsService.selectByExampleLimit(digGoodsExample);
        List<Goods> goodsAndImage = new ArrayList<>();
        //获取每个商品的图片
        for (Goods goods : goodsList) {
            //判断是否为登录状态
            if (userid == null) {
                // 设置无法加入收藏夹
                goods.setFav(false);
            } else {
                // 根据用户id和商品id判断商品是否被加入收藏夹
                Favorite favorite = goodsService.selectFavByKey(new FavoriteKey(userid, goods.getGoodsid()));
                // 根据收藏夹信息设置商品是否被加入收藏夹
                goods.setFav(favorite != null);
            }
            // 获取图片路径
            List<ImagePath> imagePathList = goodsService.findImagePath(goods.getGoodsid());
            goods.setImagePaths(imagePathList);
            // 列表加入图片信息
            goodsAndImage.add(goods);
        }
        // 返回商品和图片列表
        return goodsAndImage;
    }
}
