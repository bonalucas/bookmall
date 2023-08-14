package com.aba.controller.admin;

import com.aba.pojo.*;
import com.aba.service.GoodsService;
import com.aba.service.OrderService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;

@Controller
@RequestMapping("/admin/order")
public class AdminOrderController {

    @Autowired
    private OrderService orderService;

    @Autowired
    private GoodsService goodsService;

    @RequestMapping("/send")
    public String sendOrder(@RequestParam(value = "page",defaultValue = "1")Integer pn, Model model, HttpSession session) {
        Admin admin = (Admin) session.getAttribute("admin");
        if (admin == null) {
            return "admin/adminLogin";
        }
        // 一页显示2个数据
        PageHelper.startPage(pn, 2);
        // 查询未发货订单
        OrderExample orderExample = new OrderExample();
        orderExample.or().andIssendEqualTo(false);
        List<Order> orderList = orderService.selectOrderByExample(orderExample);
        model.addAttribute("sendOrder", orderList);

        // 查询该订单中的商品
        for (int i = 0; i < orderList.size(); i++) {
            //获取订单项中的goodsid
            Order order = orderList.get(i);
            OrderItemExample orderItemExample = new OrderItemExample();
            orderItemExample.or().andOrderidEqualTo(order.getOrderid());
            List<OrderItem> orderItemList = orderService.getOrderItemByExample(orderItemExample);

            // 创建商品列表，获取订单详情中的商品加入列表
            List<Goods> goodsList = new ArrayList<>();
            for (OrderItem orderItem : orderItemList) {
                Goods goods = goodsService.selectById(orderItem.getGoodsid());
                goods.setNum(orderItem.getNum());
                goodsList.add(goods);
            }
            // 加入商品信息
            order.setGoodsInfo(goodsList);

            //查询地址
            Address address = orderService.getAddressByKey(order.getAddressid());
            // 加入地址信息
            order.setAddress(address);
            // 根据索引将原先订单列表的值替换为新订单值
            orderList.set(i, order);
        }

        //显示几个页号
        PageInfo<Order> page = new PageInfo<>(orderList, 5);
        model.addAttribute("pageInfo", page);

        return "admin/adminAllOrder";
    }

    @RequestMapping("/sendGoods")
    public String sendGoods(Integer orderid, HttpSession session) {
        Admin admin = (Admin) session.getAttribute("admin");
        if (admin == null) {
            return "admin/adminLogin";
        }
        Order order = new Order();
        order.setOrderid(orderid);
        order.setIssend(true);
        orderService.updateOrderByKey(order);
        return "redirect:/admin/order/send";
    }

    @RequestMapping("/receiver")
    public String receiveOrder(@RequestParam(value = "page",defaultValue = "1")Integer pn, Model model,HttpSession session) {
        Admin admin = (Admin) session.getAttribute("admin");
        if (admin == null) {
            return "admin/adminLogin";
        }
        //一页显示2个数据
        PageHelper.startPage(pn, 2);

        //查询未收货订单
        OrderExample orderExample = new OrderExample();
        orderExample.or().andIssendEqualTo(true).andIsreceiveEqualTo(false);
        List<Order> orderList = orderService.selectOrderByExample(orderExample);
        model.addAttribute("sendOrder", orderList);

        //查询该订单中的商品
        for (int i = 0; i < orderList.size(); i++) {
            //获取订单项中的goodsid
            Order order = orderList.get(i);
            OrderItemExample orderItemExample = new OrderItemExample();
            orderItemExample.or().andOrderidEqualTo(order.getOrderid());
            List<OrderItem> orderItemList = orderService.getOrderItemByExample(orderItemExample);

            // 创建商品列表，获取订单详情中的商品加入列表
            List<Goods> goodsList = new ArrayList<>();
            for (OrderItem orderItem : orderItemList) {
                Goods goods = goodsService.selectById(orderItem.getGoodsid());
                goods.setNum(orderItem.getNum());
                goodsList.add(goods);
            }
            // 加入商品信息
            order.setGoodsInfo(goodsList);
            //查询地址
            Address address = orderService.getAddressByKey(order.getAddressid());
            // 加入地址信息
            order.setAddress(address);
            // 根据索引将原先订单列表的值替换为新订单值
            orderList.set(i, order);
        }

        //显示几个页号
        PageInfo<Order> page = new PageInfo<>(orderList,5);
        model.addAttribute("pageInfo", page);

        return "admin/adminOrderReceive";
    }

    @RequestMapping("/complete")
    public String completeOrder(@RequestParam(value = "page", defaultValue = "1") Integer pn, Model model, HttpSession session) {
        Admin admin = (Admin) session.getAttribute("admin");
        if (admin == null) {
            return "admin/adminLogin";
        }
        //一页显示2个数据
        PageHelper.startPage(pn, 2);

        //查询已完成订单
        OrderExample orderExample = new OrderExample();
        orderExample.or().andIssendEqualTo(true).andIsreceiveEqualTo(true).andIscompleteEqualTo(true);
        List<Order> orderList = orderService.selectOrderByExample(orderExample);
        model.addAttribute("sendOrder", orderList);

        //查询该订单中的商品
        for (int i = 0; i < orderList.size(); i++) {
            //获取订单项中的goodsid
            Order order = orderList.get(i);
            OrderItemExample orderItemExample = new OrderItemExample();
            orderItemExample.or().andOrderidEqualTo(order.getOrderid());
            List<OrderItem> orderItemList = orderService.getOrderItemByExample(orderItemExample);
            List<Integer> goodsIdList = new ArrayList<>();
            // 创建商品列表，获取订单详情中的商品加入列表
            List<Goods> goodsList = new ArrayList<>();
            for (OrderItem orderItem : orderItemList) {
                Goods goods = goodsService.selectById(orderItem.getGoodsid());
                goods.setNum(orderItem.getNum());
                goodsList.add(goods);
            }
            // 加入商品信息
            order.setGoodsInfo(goodsList);
            //查询地址
            Address address = orderService.getAddressByKey(order.getAddressid());
            // 加入地址信息
            order.setAddress(address);
            // 根据索引将原先订单列表的值替换为新订单值
            orderList.set(i, order);
        }
        //显示几个页号
        PageInfo<Order> page = new PageInfo<>(orderList, 5);
        model.addAttribute("pageInfo", page);

        return "admin/adminOrderComplete";
    }
}
