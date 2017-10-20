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

    public ServerResponse fallback(){
        return ServerResponse.createErrorResponse(500,"Server is busy.Try later.");
    }

    @Override
    @HystrixCommand(fallbackMethod = "fallback")
    public ServerResponse login(String name, String pwd) {
        return personDao.ifExists(name,pwd)==1?ServerResponse.createSuccessResponse("Login Success"):ServerResponse.createErrorResponse(404,"Wrong Pwd");
    }

    @Override
    @HystrixCommand(fallbackMethod = "fallback")
    public ServerResponse listLogin() {
        List<Person> people=personDao.loginSelectList();
        return !people.isEmpty()?ServerResponse.createSuccessResponse(people):ServerResponse.createErrorResponse(404,"No Data");
    }

    @Override
    @HystrixCommand(fallbackMethod = "fallback")
    public ServerResponse listVisitor() {
        List<Person> people=personDao.visitorSelectList();
        return !people.isEmpty()?ServerResponse.createSuccessResponse(people):ServerResponse.createErrorResponse(404,"No Data");
    }

    @Override
    @HystrixCommand(fallbackMethod = "fallback")
    public ServerResponse addPerson(Person person) {
        return personDao.insert(person)>0?ServerResponse.createSuccessResponse("add success"):ServerResponse.createErrorResponse(500,"add failed");
    }

    @Override
    @HystrixCommand(fallbackMethod = "fallback")
    public ServerResponse updatePerson(Person person) {
        return personDao.updateByPrimaryKey(person)>0?ServerResponse.createSuccessResponse("update success"):ServerResponse.createErrorResponse(500,"update failed");
    }

    @Override
    @HystrixCommand(fallbackMethod = "fallback")
    public ServerResponse deletePerson(Long id) {
        return personDao.deleteByPrimaryKey(id)>0?ServerResponse.createSuccessResponse("delete success"):ServerResponse.createErrorResponse(500,"delete failed");
    }
}
