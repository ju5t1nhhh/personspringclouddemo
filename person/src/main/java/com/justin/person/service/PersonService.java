package com.justin.person.service;

import com.justin.person.domain.Person;
import com.justin.person.vo.ServerResponse;

/**
 * Created by Justin on 2017/10/20.
 */
public interface PersonService {

    ServerResponse login(String name, String pwd);

    ServerResponse listLogin();

    ServerResponse listVisitor();

    ServerResponse addPerson(Person person);

    ServerResponse updatePerson(Person person);

    ServerResponse deletePerson(Long id);

    ServerResponse selectOne(Long id);
}
