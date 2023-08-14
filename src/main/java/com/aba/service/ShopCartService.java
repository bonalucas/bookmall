package com.aba.service;

import com.aba.pojo.ShopCart;
import com.aba.pojo.ShopCartExample;
import com.aba.pojo.ShopCartKey;

import java.util.List;

public interface ShopCartService {
    void addShopCart(ShopCart shopCart);

    List<ShopCart> selectByExample(ShopCartExample shopCartExample);

    void deleteByKey(ShopCartKey shopCartKey);

    void updateCartByKey(ShopCart shopCart);

    ShopCart selectCartByKey(ShopCartKey shopCartKey);
}
