package com.justin.person.dao;

import com.justin.person.domain.Person;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;

import javax.annotation.Resource;

import java.util.List;

import static org.junit.Assert.*;

/**
 * Created by Justin on 2017/10/20.
 */
@RunWith(SpringRunner.class)
@SpringBootTest
public class PersonDaoTest {

    @Autowired
    private PersonDao personDao;

    @Test
    public void insert() throws Exception {
        Person person=new Person();
        person.setName("Cat");
        person.setPwd("666");
        personDao.insert(person);
    }

    @Test
    public void deleteByPrimaryKey() throws Exception {
        personDao.deleteByPrimaryKey(2L);
    }

    @Test
    public void updateByPrimaryKey() throws Exception {
        Person person=new Person();
        person.setId(1008L);
        person.setName("Hahaha");
        person.setPwd("abc");
        personDao.updateByPrimaryKey(person);
    }

    @Test
    public void ifExists() throws Exception {
        personDao.ifExists("Cat","666");
    }

    @Test
    public void loginSelectList() throws Exception {
        List<Person> people=personDao.loginSelectList();
        for(Person person:people){
            System.out.println(person);
        }
    }

    @Test
    public void visitorSelectList() throws Exception {
        List<Person> people=personDao.visitorSelectList();
        for(Person person:people){
            System.out.println(person);
        }
    }

}