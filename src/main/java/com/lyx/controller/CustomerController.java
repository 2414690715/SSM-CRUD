package com.lyx.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.lyx.entity.Customer;
import com.lyx.services.CustomerServices;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @author liao
 */
@Controller
@RequestMapping("/customer")
public class CustomerController {
    @Autowired
    private CustomerServices customerServices;

    private Map<String,Object> map = new HashMap<>();

    /**
     * 查询所有
     * @return
     */
    @RequestMapping(value = "/list",method = RequestMethod.GET)
    @ResponseBody
    public List findAll(){
        List<Customer> all = customerServices.findAll();
        return all;
    }

    /**
     * 当前页码
     * @param page
     * 几条数据
     * @param rows
     * @return
     */
    @RequestMapping(value="listByPage",method = RequestMethod.POST)
    @ResponseBody
    public Map<String,Object> findAllByPage(Integer page,Integer rows){
        PageHelper.startPage(page,rows);
        //查询所有数据
        List<Customer> all = customerServices.findAll();
        //有参构造方法
        PageInfo<Customer> customerPageInfo = new PageInfo<Customer>(all);
        //从pageinfo里面去除查询结果
        long total = customerPageInfo.getTotal();
        List<Customer> list = customerPageInfo.getList();
        map.put("total",total);
        map.put("rows",list);
        return map;
    }

    /**
     * 保存客户
     * @param customer
     * @return
     */
    @RequestMapping(value = "/save",method = RequestMethod.POST)
    @ResponseBody
    public Map<String,Object> save(Customer customer){
        try {
            customerServices.saveCustomer(customer);
            map.put("success",true);
        }catch (Exception e){
            e.printStackTrace();
            map.put("success",false);
        }
        return map;
    }

    /**
     * 根据id查找
     * @param id
     * @return
     */
    @RequestMapping(value = "findById",method = RequestMethod.GET)
    @ResponseBody
    public Customer findById(@RequestParam("id") Integer id){
        Customer customer = customerServices.findById(id);
        return customer;
    }

    /**
     * 根据id批量删除
     * @param ids
     * @return
     */
    @RequestMapping(value="/delete",method = RequestMethod.POST)
    @ResponseBody
    public Map<String,Object> delete(@RequestParam("ids") String[] ids){
        System.out.println(ids);
//        StringBuffer sb = new StringBuffer();
//        sb.append("(");
//        sb.append(ids);
//        sb.append(")");
        Integer delete = customerServices.delete(ids);
        if(delete!=0){
            map.put("success",true);
            return map;
        }
        else{
            map.put("success",false);
            return map;
        }
    }

}
