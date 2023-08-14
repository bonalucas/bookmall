package com.aba.service;

import com.aba.pojo.Category;
import com.aba.pojo.CategoryExample;
import org.springframework.stereotype.Service;

import java.util.List;

@Service("CateService")
public interface CateService {
    List<Category> selectByExample(CategoryExample example);
    void insertSelective(Category category);

    List<Category> selectByExampleLimit(CategoryExample digCategoryExample);

    Category selectById(Integer category);

    void updateByPrimaryKeySelective(Category category);

    void deleteByPrimaryKey(Integer cateid);
}
