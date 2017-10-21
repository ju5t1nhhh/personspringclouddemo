package com.justin.person.controller;

import com.justin.person.domain.Person;
import com.justin.person.service.PersonService;
import com.justin.person.vo.ServerResponse;
import com.netflix.hystrix.contrib.javanica.annotation.HystrixCommand;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

/**
 * Created by Justin on 2017/10/20.
 */
@Slf4j
@RestController
public class PersonController {

    @Resource
    private PersonService personService;

    private boolean checkLogin(HttpSession session){
        String name= (String) session.getAttribute("name");
        String pwd= (String) session.getAttribute("pwd");
        return personService.login(name,pwd).getStatus()==200;
    }

    /**
     * 游客浏览列表
     * @return
     */
    @GetMapping("/visitorList")
    public ServerResponse visitorList(){
        return personService.listVisitor();
    }

    /**
     * 登录
     * @param name
     * @param pwd
     * @param session
     * @return
     */
    @PostMapping("/login")
    public ServerResponse login(String name, String pwd, HttpSession session){
        ServerResponse serverResponse= personService.login(name,pwd);
        if(serverResponse.getStatus()==200){
            session.setAttribute("name",name);
            session.setAttribute("pwd",pwd);
        }//验证用户名和密码 如果正确则写入Session
        return serverResponse;
    }

    /**
     * 登录用户浏览列表
     * @param session
     * @return
     */
    @PostMapping("/loginList")
    public ServerResponse loginList(HttpSession session){
        return checkLogin(session)?personService.listLogin():ServerResponse.createErrorResponse(401,"Login First.");
    }

    /**
     * 更新用户信息
     * @param person
     * @param session
     * @return
     */
    @PostMapping("/update")
    public ServerResponse update(Person person,HttpSession session){
        return checkLogin(session)?personService.updatePerson(person):ServerResponse.createErrorResponse(401,"Login First.");
    }

    /**
     * 新增用户
     * @param person
     * @param session
     * @return
     */
    @PostMapping("/add")
    public ServerResponse add(Person person,HttpSession session){
        return checkLogin(session)?personService.addPerson(person):ServerResponse.createErrorResponse(401,"Login First.");
    }

    /**
     * 删除用户
     * @param id
     * @param session
     * @return
     */
    @PostMapping("/del")
    public ServerResponse del(Long id,HttpSession session){
        return checkLogin(session)?personService.deletePerson(id):ServerResponse.createErrorResponse(401,"Login First.");
    }
}
