package com.lyx.services.impl;

import com.lyx.dao.CustomerDao;
import com.lyx.entity.Customer;
import com.lyx.services.CustomerServices;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * @author liao
 */
@Service
@Transactional
public class CustomerServicesImpl implements CustomerServices {

    @Autowired
    private CustomerDao customerdao;

    @Override
    public List<Customer> findAll() {
        return customerdao.findAll();
    }

    @Override
    public Integer saveCustomer(Customer customer) {
        if(customer.getId()!=null){
            return customerdao.update(customer);
        }else{
            return customerdao.saveCustomer(customer);
        }
    }

    @Override
    public Customer findById(Integer id) {
        return customerdao.findById(id);
    }

    @Override
    public Integer delete(String[] ids) {
        return customerdao.delete(ids);
    }
}
