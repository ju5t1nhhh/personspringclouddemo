package com.justin.person.dao;

import com.justin.person.domain.Person;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Created by Justin on 2017/10/20.
 */
@Repository
public interface PersonDao {
    int insert(Person person);
    int deleteByPrimaryKey(Long id);
    int updateByPrimaryKey(Person person);
    int ifExists(Long id);
    List<Person> loginSelectList();
    List<Person> visitorSelectList();
}
