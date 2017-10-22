package com.justin.person.controller;

import com.justin.person.service.PersonService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;

/**
 * Created by Justin on 2017/10/21.
 */
@Controller
public class IndexController {

    @Autowired
    private PersonService personService;

    private boolean checkLogin(HttpSession session){
        String name= (String) session.getAttribute("name");
        String pwd= (String) session.getAttribute("pwd");
        if(name==null||pwd==null)return false;
        return personService.login(name,pwd).getStatus()==200;
    }

    @GetMapping("/")
    public String index(HttpSession session, ModelMap modelMap){
        if(checkLogin(session)){
            return "login";
        }
        modelMap.addAttribute("people",personService.listVisitor().getData());
        return "visitor";
    }
}
