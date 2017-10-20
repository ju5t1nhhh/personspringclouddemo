package com.justin.person.controller;

import com.justin.person.service.PersonService;
import com.justin.person.vo.ServerResponse;
import lombok.extern.slf4j.Slf4j;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.cloud.client.ServiceInstance;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cloud.client.discovery.DiscoveryClient;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.annotation.Resource;

/**
 * Created by Justin on 2017/10/20.
 */
@Slf4j
@RestController
public class PersonController {

    private final Logger logger= LoggerFactory.getLogger(this.getClass());

    @Resource
    private PersonService personService;

    @Autowired
    private DiscoveryClient discoveryClient;

    @GetMapping("/visitorList")
    public ServerResponse visitorList(){

        return personService.listVisitor();
    }

    @PostMapping("/login")
    public ServerResponse login(String name,String pwd){
    }
}
