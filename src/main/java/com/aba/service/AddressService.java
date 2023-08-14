package com.aba.service;

import com.aba.pojo.Address;
import com.aba.pojo.AddressExample;

import java.util.List;

public interface AddressService {
    List<Address> getAllAddressByExample(AddressExample addressExample);

    void updateByPrimaryKeySelective(Address address);

    void deleteByPrimaryKey(Integer addressid);

    void insert(Address address);

    void  insertSelective(Address address);

    Address selectByPrimaryKey(Integer addressid);
}
