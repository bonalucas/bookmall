package com.aba.controller.front;

import com.aba.pojo.*;
import com.aba.service.*;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.*;

@Controller
public class FrontGoodsController {

    @Autowired
    private GoodsService goodsService;

    @Autowired
    private CateService cateService;

    @Autowired
    private CommentService commentService;

    @Autowired
    private UserService userService;

    @Autowired
    private ActivityService activityService;

    @RequestMapping(value = "/detail",method = RequestMethod.GET)
    public String detailGoods(Integer goodsid, Model model, HttpSession session) {
        if(goodsid == null) {
            return "front/main";
        }
        User user = (User) session.getAttribute("user");
        //要传回的数据存在HashMap中
        Map<String,Object> goodsInfo = new HashMap<>();
        //查询商品的基本信息
        Goods goods = goodsService.selectById(goodsid);
        if (user == null) {
            goods.setFav(false);
        } else {
            Favorite favorite = goodsService.selectFavByKey(new FavoriteKey(user.getUserid(), goodsid));
            goods.setFav(favorite != null);
        }
        //查询商品类别
        Category category = cateService.selectById(goods.getCategory());
        //商品图片
        List<ImagePath> imagePath = goodsService.findImagePath(goodsid);
        //商品折扣信息
        Activity activity = activityService.selectByKey(goods.getActivityid());
        goods.setActivity(activity);
        //返回数据
        goodsInfo.put("goods", goods);
        goodsInfo.put("cate", category);
        goodsInfo.put("image", imagePath);
        model.addAttribute("goodsInfo",goodsInfo);
        //评论信息
        CommentExample commentExample=new CommentExample();
        commentExample.or().andGoodsidEqualTo(goods.getGoodsid());
        List<Comment> commentList=commentService.selectByExample(commentExample);
        for (int i = 0; i<commentList.size(); i++)
        {
            Comment comment=commentList.get(i);
            User commentUser=userService.selectByPrimaryKey(comment.getUserid());
            comment.setUserName(commentUser.getUsername());
            commentList.set(i,comment);
        }
        model.addAttribute("commentList",commentList);
        return "front/detail";
    }

    @RequestMapping(value = "/search", method = RequestMethod.GET)
    public String searchGoods(@RequestParam(value = "page",defaultValue = "1") Integer pn, String keyword, Model model, HttpSession session) {
        User user = (User) session.getAttribute("user");
        //一页显示15条数据
        PageHelper.startPage(pn, 15);
        //查询数据
        GoodsExample goodsExample = new GoodsExample();
        //模糊查询
        goodsExample.or().andGoodsnameLike("%" + keyword + "%");
        List<Goods> goodsList = goodsService.selectByExample(goodsExample);
        //获取图片地址
        for (int i = 0; i < goodsList.size(); i++) {
            Goods goods = goodsList.get(i);
            List<ImagePath> imagePathList = goodsService.findImagePath(goods.getGoodsid());
            goods.setImagePaths(imagePathList);
            //判断是否收藏
            if (user == null) {
                goods.setFav(false);
            } else {
                Favorite favorite = goodsService.selectFavByKey(new FavoriteKey(user.getUserid(), goods.getGoodsid()));
                goods.setFav(favorite != null);
            }
            goodsList.set(i, goods);
        }
        //显示几个页号
        PageInfo<Goods> page = new PageInfo<>(goodsList,5);
        model.addAttribute("pageInfo", page);
        model.addAttribute("keyword", keyword);
        return "front/search";
    }

    @RequestMapping("/collect")
    @ResponseBody
    public Msg collectGoods(Integer goodsid, HttpSession session) {
        //取登录用户信息,未登录重定向至登录页面
        User user = (User) session.getAttribute("user");
        if(user == null) {
            return Msg.fail("收藏失败");
        }
        //添加收藏
        Favorite favorite = new Favorite();
        favorite.setCollecttime(new Date());
        favorite.setGoodsid(goodsid);
        favorite.setUserid(user.getUserid());
        goodsService.addFavorite(favorite);

        return Msg.success("收藏成功");
    }

    @RequestMapping("/deleteCollect")
    @ResponseBody
    public Msg deleteFavGoods(Integer goodsid, HttpSession session) {
        User user = (User) session.getAttribute("user");
        if (user == null) {
            return Msg.fail("取消收藏失败");
        }

        //删除收藏
        goodsService.deleteFavByKey(new FavoriteKey(user.getUserid(),goodsid));

        return Msg.success("取消收藏成功");
    }

    @RequestMapping("/category")
    public String getCateGoods(String cate, @RequestParam(value = "page",defaultValue = "1") Integer pn, Model model, HttpSession session) {
        User user = (User) session.getAttribute("user");
        //一页显示几个数据
        PageHelper.startPage(pn, 15);
        //查询分类id
        CategoryExample categoryExample = new CategoryExample();
        categoryExample.or().andCatenameLike(cate);
        List<Category> categoryList = cateService.selectByExample(categoryExample);
        //获取查出的类别id
        List<Integer> cateId = new ArrayList<>();
        for (Category category : categoryList) {
            cateId.add(category.getCateid());
        }
        //查询数据
        GoodsExample goodsExample = new GoodsExample();
        // 根据商品的详细分类去查找商品（模糊查询）
        goodsExample.or().andDetailcateLike("%" + cate + "%");
        if (!cateId.isEmpty()) {
            // 根据具体范围查询商品
            goodsExample.or().andCategoryIn(cateId);
        }
        List<Goods> goodsList = goodsService.selectByExample(goodsExample);
        //获取图片地址
        for (int i = 0; i < goodsList.size(); i++) {
            Goods goods = goodsList.get(i);
            List<ImagePath> imagePathList = goodsService.findImagePath(goods.getGoodsid());
            goods.setImagePaths(imagePathList);
            //判断是否收藏
            if (user == null) {
                goods.setFav(false);
            } else {
                Favorite favorite = goodsService.selectFavByKey(new FavoriteKey(user.getUserid(), goods.getGoodsid()));
                goods.setFav(favorite != null);
            }
            goodsList.set(i, goods);
        }
        //显示几个页号
        PageInfo<Goods> page = new PageInfo<>(goodsList,5);
        model.addAttribute("pageInfo", page);
        model.addAttribute("cate", cate);
        return "front/category";
    }



    @RequestMapping("/comment")
    @ResponseBody
    public Msg comment(Comment comment, HttpServletRequest request){
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        if (user == null) {
            return Msg.fail("评论失败");
        }
        comment.setUserid(user.getUserid());
        Date date = new Date();
        comment.setCommenttime(date);
        commentService.insertSelective(comment);
        return Msg.success("评论成功");
    }
}
