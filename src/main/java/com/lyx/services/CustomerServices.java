package com.lyx.services;

import com.lyx.entity.Customer;

import java.util.List;

/**
 * @author liao
 */
public interface CustomerServices {
    /**
     * 查询所有
     * @return
     */
    public List<Customer> findAll();

    /**
     * 保存用户
     * @return
     */
    public Integer saveCustomer(Customer customer);

    /**
     * 通过id查找
     * @param id
     * @return
     */
    public Customer findById(Integer id);


    /**
     * 根据id批量删除
     * @param ids
     * @return
     */
    public Integer delete(String[] ids);
}
