package com.aba.service;

import com.aba.pojo.*;

import java.util.List;

public interface OrderService {
    void insertOrder(Order order);

    void deleteById(Integer orderid);

    List<Order> selectOrderByExample(OrderExample orderExample);

    List<OrderItem> getOrderItemByExample(OrderItemExample orderItemExample);

    Address getAddressByKey(Integer addressid);

    void updateOrderByKey(Order order);

    Order selectByPrimaryKey(Integer orderid);

    void insertOrderItem(OrderItem orderItem);
}
