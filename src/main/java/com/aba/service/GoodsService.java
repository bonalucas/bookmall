package com.aba.service;

import com.aba.pojo.*;

import java.util.List;


public interface GoodsService {
    Integer addGoods(Goods goods);

    void addImagePath(ImagePath imagePath);

    List<Goods> selectByExample(GoodsExample example);

    void deleteGoodsById(Integer goodsid);

    void updateGoodsById(Goods goods);

    List<ImagePath> findImagePath(Integer goodsid);

    Goods selectById(Integer goodsid);

    List<Goods> selectByExampleLimit(GoodsExample digGoodsExample);

    void addFavorite(Favorite favorite);

    Favorite selectFavByKey(FavoriteKey favoriteKey);

    void deleteFavByKey(FavoriteKey favoriteKey);

    List<Favorite> selectFavByExample(FavoriteExample favoriteExample);
}
