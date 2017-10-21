package com.justin.person.service.impl;

import com.justin.person.dao.PersonDao;
import com.justin.person.domain.Person;
import com.justin.person.service.PersonService;
import com.justin.person.vo.ServerResponse;
import com.netflix.hystrix.contrib.javanica.annotation.HystrixCommand;
import org.apache.catalina.Server;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * Created by Justin on 2017/10/20.
 */
@Service
public class PersonServiceImpl implements PersonService {

    @Autowired
    PersonDao personDao;

    public ServerResponse fallbackNoArgs(){
        return ServerResponse.createErrorResponse(500,"Server is busy.Try later.");
    }

    public ServerResponse fallbackPerson(Person person){
        return ServerResponse.createErrorResponse(500,"Server is busy.Try later.");
    }

    public ServerResponse fallbackId(Long id){
        return ServerResponse.createErrorResponse(500,"Server is busy.Try later.");
    }

    public ServerResponse fallbackLogin(String name,String pwd){
        return ServerResponse.createErrorResponse(500,"Server is busy.Try later.");
    }

    @HystrixCommand(fallbackMethod = "fallbackLogin")
    @Override
    public ServerResponse login(String name, String pwd) {
        return personDao.ifExists(name,pwd)==1?ServerResponse.createSuccessResponse("Login Success"):ServerResponse.createErrorResponse(404,"Wrong Pwd");
    }

    @HystrixCommand(fallbackMethod = "fallbackNoArgs")
    @Override
    public ServerResponse listLogin() {
        List<Person> people=personDao.loginSelectList();
        return !people.isEmpty()?ServerResponse.createSuccessResponse(people):ServerResponse.createErrorResponse(404,"No Data");
    }

    @HystrixCommand(fallbackMethod = "fallbackNoArgs")
    @Override
    public ServerResponse listVisitor() {
        List<Person> people=personDao.visitorSelectList();
        return !people.isEmpty()?ServerResponse.createSuccessResponse(people):ServerResponse.createErrorResponse(404,"No Data");
    }

    @HystrixCommand(fallbackMethod = "fallbackPerson")
    @Override
    public ServerResponse addPerson(Person person) {
        return personDao.insert(person)>0?ServerResponse.createSuccessResponse("add success"):ServerResponse.createErrorResponse(500,"add failed");
    }

    @HystrixCommand(fallbackMethod = "fallbackPerson")
    @Override
    public ServerResponse updatePerson(Person person) {
        return personDao.updateByPrimaryKey(person)>0?ServerResponse.createSuccessResponse("update success"):ServerResponse.createErrorResponse(500,"update failed");
    }

    @HystrixCommand(fallbackMethod = "fallbackId")
    @Override
    public ServerResponse deletePerson(Long id) {
        return personDao.deleteByPrimaryKey(id)>0?ServerResponse.createSuccessResponse("delete success"):ServerResponse.createErrorResponse(500,"delete failed");
    }
}
