package com.aba.dao;

import com.aba.pojo.ImagePath;
import com.aba.pojo.ImagePathExample;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface ImagePathMapper {
    long countByExample(ImagePathExample example);

    int deleteByExample(ImagePathExample example);

    int deleteByPrimaryKey(Integer pathid);

    int insert(ImagePath record);

    int insertSelective(ImagePath record);

    List<ImagePath> selectByExample(ImagePathExample example);

    ImagePath selectByPrimaryKey(Integer pathid);

    int updateByExampleSelective(@Param("record") ImagePath record, @Param("example") ImagePathExample example);

    int updateByExample(@Param("record") ImagePath record, @Param("example") ImagePathExample example);

    int updateByPrimaryKeySelective(ImagePath record);

    int updateByPrimaryKey(ImagePath record);
}