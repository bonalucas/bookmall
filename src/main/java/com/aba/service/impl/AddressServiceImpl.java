package com.aba.service.impl;

import com.aba.dao.AddressMapper;
import com.aba.pojo.Address;
import com.aba.pojo.AddressExample;
import com.aba.service.AddressService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service("addressService")
public class AddressServiceImpl implements AddressService {

    @Autowired(required = false)
    private AddressMapper addressMapper;

    @Override
    public List<Address> getAllAddressByExample(AddressExample addressExample) {
        return addressMapper.selectByExample(addressExample);
    }

    @Override
    public void updateByPrimaryKeySelective(Address address) {
        addressMapper.updateByPrimaryKeySelective(address);
    }

    @Override
    public void deleteByPrimaryKey(Integer addressid) {
        addressMapper.deleteByPrimaryKey(addressid);
    }

    @Override
    public void insert(Address address) {
        addressMapper.insert(address);
    }

    @Override
    public void insertSelective(Address address) {
        addressMapper.insertSelective(address);
    }

    @Override
    public Address selectByPrimaryKey(Integer addressid) {
        return addressMapper.selectByPrimaryKey(addressid);
    }
}
