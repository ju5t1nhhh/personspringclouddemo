package com.justin.person.controller;

import com.justin.person.service.PersonService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;

/**
 * Created by Justin on 2017/10/21.
 */
@Controller
public class IndexController {

    @Autowired
    private PersonService personService;

    @GetMapping("/")
    public String index(){
        return "index";
    }
}
