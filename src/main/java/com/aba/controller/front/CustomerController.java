package com.aba.controller.front;

import com.aba.pojo.*;
import com.aba.service.AddressService;
import com.aba.service.GoodsService;
import com.aba.service.OrderService;
import com.aba.service.UserService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@Controller
public class CustomerController {

    @Autowired
    private UserService userService;

    @Autowired
    private AddressService addressService;

    @Autowired
    private OrderService orderService;

    @Autowired
    private GoodsService goodsService;

    @RequestMapping("/login")
    public String loginView(){
        return "front/login";
    }

    @RequestMapping("/register")
    public String register(){
        return "front/register";
    }

    @RequestMapping("/registerresult")
    public String registerResult(User user, Model registerResult){
        UserExample userExample = new UserExample();
        // 判断是否有相同用户名
        userExample.or().andUsernameLike(user.getUsername());
        List<User> userList = userService.selectByExample(userExample);
        if (!userList.isEmpty()) {
            registerResult.addAttribute("errorMsg","用户名被占用");
            return "front/register";
        }else {
            Date RegTime = new Date();
            user.setRegtime(RegTime);
            userService.insertSelective(user);
            return "front/login";
        }
    }

    @RequestMapping("/loginconfirm")
    public String loginConfirm(User user,Model loginResult,HttpServletRequest request,@RequestParam("confirmlogo") String confirmlogo){
        HttpSession session=request.getSession();
        String verificationCode = (String) session.getAttribute("certCode");
        if (!confirmlogo.equals(verificationCode)) {
            loginResult.addAttribute("errorMsg","验证码错误");
            return "front/login";
        }
        UserExample userExample = new UserExample();
        userExample.or().andUsernameEqualTo(user.getUsername()).andPasswordEqualTo(user.getPassword());
        List<User> userList = userService.selectByExample(userExample);
        if (!userList.isEmpty()) {
            session.setAttribute("user",userList.get(0));
            // 重定向发起请求
            return "redirect:/main";
        }else {
            loginResult.addAttribute("errorMsg","用户名与密码不匹配");
            return "front/login";
        }
    }

    @RequestMapping("/information")
    public String information(Model userModel,HttpServletRequest request){
        HttpSession session = request.getSession();
        User user;
        Integer userId;
        user = (User) session.getAttribute("user");
        if (user == null) {
            return "front/login";
        }
        userId = user.getUserid();
        user = userService.selectByPrimaryKey(userId);
        userModel.addAttribute("user",user);
        return "front/information";
    }

    @RequestMapping("/saveInfo")
    @ResponseBody
    public Msg saveInfo(String name, String email, String telephone, HttpServletRequest request){
        HttpSession session = request.getSession();
        UserExample userExample = new UserExample();
        User user,updateUser = new User();
        List<User> userList;
        Integer userid;
        user = (User)session.getAttribute("user");
        userid = user.getUserid();
        userExample.or().andUseridEqualTo(userid);
        userList = userService.selectByExample(userExample);
        if (!userList.isEmpty()) {
            updateUser.setUserid(userid);
            updateUser.setUsername(name);
            updateUser.setEmail(email);
            updateUser.setTelephone(telephone);
            userService.updateByPrimaryKeySelective(updateUser);
            return Msg.success("更新成功");
        }else {
            return Msg.fail("更新失败");
        }
    }

    @RequestMapping("/info/address")
    public String address(HttpServletRequest request,Model addressModel){
        HttpSession session = request.getSession();
        User user = (User)session.getAttribute("user");
        if (user == null) {
            return "front/login";
        }
        AddressExample addressExample = new AddressExample();
        addressExample.or().andUseridEqualTo(user.getUserid());
        List<Address> addressList = addressService.getAllAddressByExample(addressExample);
        addressModel.addAttribute("addressList",addressList);
        return "front/address";
    }

    @RequestMapping("/saveAddr")
    @ResponseBody
    public Msg saveAddr(Address address){
        addressService.updateByPrimaryKeySelective(address);
        return Msg.success("修改成功");
    }

    @RequestMapping("/deleteAddr")
    @ResponseBody
    public Msg deleteAddr(Address address){
        addressService.deleteByPrimaryKey(address.getAddressid());
        return Msg.success("删除成功");
    }

    @RequestMapping("/insertAddr")
    @ResponseBody
    public Msg insertAddr(Address address,HttpServletRequest request){
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        address.setUserid(user.getUserid());
        addressService.insertSelective(address);
        return Msg.success("添加成功");
    }

    @RequestMapping("/savePsw")
    @ResponseBody
    public Msg savePsw(String Psw,HttpServletRequest request)
    {
        HttpSession session=request.getSession();
        User user=(User) session.getAttribute("user");
        user.setPassword(Psw);
        userService.updateByPrimaryKeySelective(user);
        return Msg.success("修改密码成功");
    }

    @RequestMapping("/info/list")
    public String list(HttpServletRequest request,Model orderModel){
        HttpSession session = request.getSession();
        User user;
        user = (User)session.getAttribute("user");
        if (user == null) {
            return "front/login";
        }
        OrderExample orderExample = new OrderExample();
        // 通过用户id获取所有订单信息
        orderExample.or().andUseridEqualTo(user.getUserid());
        List<Order> orderList = orderService.selectOrderByExample(orderExample);
        orderModel.addAttribute("orderList",orderList);
        Order order;
        OrderItem orderItem;
        List<OrderItem> orderItemList;
        Address address;
        // 遍历所有订单信息
        for (int i = 0; i < orderList.size(); i++) {
            order = orderList.get(i);
            OrderItemExample orderItemExample = new OrderItemExample();
            orderItemExample.or().andOrderidEqualTo(order.getOrderid());
            // 通过订单信息编号获取订单详情
            orderItemList = orderService.getOrderItemByExample(orderItemExample);
            List<Goods> goodsList;
            List<Integer> goodsIdList = new ArrayList<>();
            // 将订单详情的商品按商品编号加入列表
            for (OrderItem item : orderItemList) {
                orderItem = item;
                goodsIdList.add(orderItem.getGoodsid());
            }
            GoodsExample goodsExample = new GoodsExample();
            // 按商品编号列表中的商品编号范围查询商品
            goodsExample.or().andGoodsidIn(goodsIdList);
            goodsList = goodsService.selectByExample(goodsExample);
            // 将查询出的商品重新添加回对应的订单
            order.setGoodsInfo(goodsList);
            // 通过地址编号查询当前订单的地址
            address = addressService.selectByPrimaryKey(order.getAddressid());
            // 将地址信息加入订单
            order.setAddress(address);
            // 根据索引更新订单
            orderList.set(i, order);
        }

        orderModel.addAttribute("orderList",orderList);

        return "front/list";
    }

    @RequestMapping("/deleteList")
    @ResponseBody
    public Msg deleteList(Order order){
        orderService.deleteById(order.getOrderid());
        return Msg.success("删除成功");
    }

    @RequestMapping("/info/favorite")
    public String showFavorite(@RequestParam(value = "page",defaultValue = "1") Integer pn, HttpServletRequest request,Model model){
        HttpSession session=request.getSession();
        User user=(User)session.getAttribute("user");
        if (user == null) {
            return "front/login";
        }
        //一页显示15条数据
        PageHelper.startPage(pn, 15);
        FavoriteExample favoriteExample = new FavoriteExample();
        // 找到对应的用户id对饮的收藏夹
        favoriteExample.or().andUseridEqualTo(user.getUserid());
        List<Favorite> favoriteList = goodsService.selectFavByExample(favoriteExample);
        List<Integer> goodsIdList = new ArrayList<>();
        for (Favorite tmp : favoriteList) {
            goodsIdList.add(tmp.getGoodsid());
        }
        GoodsExample goodsExample = new GoodsExample();
        List<Goods> goodsList = new ArrayList<>();
        if (!goodsIdList.isEmpty()) {
            goodsExample.or().andGoodsidIn(goodsIdList);
            goodsList = goodsService.selectByExample(goodsExample);
        }
        //获取图片地址
        for (int i = 0; i < goodsList.size(); i++) {
            Goods goods = goodsList.get(i);
            List<ImagePath> imagePathList = goodsService.findImagePath(goods.getGoodsid());
            goods.setImagePaths(imagePathList);
            //判断是否收藏
            goods.setFav(true);
            //更新列表
            goodsList.set(i, goods);
        }
        //显示几个页号
        PageInfo<Goods> page = new PageInfo<>(goodsList,5);
        model.addAttribute("pageInfo", page);

        return "front/favorite";
    }

    @RequestMapping("/finishList")
    @ResponseBody
    public Msg finishiList(Integer orderid){
        Order order=orderService.selectByPrimaryKey(orderid);
        order.setIsreceive(true);
        order.setIscomplete(true);
        orderService.updateOrderByKey(order);
        return Msg.success("完成订单成功");
    }

    @RequestMapping("/logout")
    public String logout(HttpServletRequest request){
        HttpSession session=request.getSession();
        session.removeAttribute("user");
        return "front/login";
    }

}
