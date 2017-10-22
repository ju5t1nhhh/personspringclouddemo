package com.justin.person.controller;

import com.justin.person.domain.Person;
import com.justin.person.service.PersonService;
import com.justin.person.util.FileUploadUtil;
import com.justin.person.vo.ServerResponse;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.commons.CommonsMultipartResolver;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.IOException;

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
        if(name==null||pwd==null)return false;
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

    @PostMapping("/logout")
    public ServerResponse logout(HttpSession session){
        try{
            session.removeAttribute("name");
            session.removeAttribute("pwd");
        }catch(Exception e){
            return ServerResponse.createErrorResponse(500,"Server is busy.Try later.");
        }
        return ServerResponse.createSuccessResponse("Logout Success");
    }

    /**
     * 登录用户浏览列表
     * @param session
     * @return
     */
    @PostMapping("/loginList")
    public ServerResponse loginList(HttpSession session){
        return checkLogin(session)?personService.listLogin():ServerResponse.createErrorResponse(401,"Login Please.");
    }

    /**
     * 获取一个person的属性
     * @param id
     * @param session
     * @return
     */
    @PostMapping("/select")
    public ServerResponse select(Long id,HttpSession session){
        return checkLogin(session)?personService.selectOne(id):ServerResponse.createErrorResponse(401,"Login Please.");
    }

    /**
     * 更新用户信息
     * @param person
     * @param session
     * @return
     */
    @PostMapping("/update")
    public ServerResponse update(Person person,MultipartFile avatarFile,HttpSession session){
        if(person.getName().isEmpty()||person.getPwd().isEmpty()){
            return ServerResponse.createErrorResponse(400,"Name or Pwd is null.");
        }
        if(!checkLogin(session)){
            return ServerResponse.createErrorResponse(401,"Login Please.");
        }
        if(!avatarFile.isEmpty()){
            ServerResponse serverResponse=upload(avatarFile);
            if(serverResponse.getStatus()!=200){
                return serverResponse;
            }else{
                person.setAvatar((String) serverResponse.getData());
            }
        }
        return personService.updatePerson(person);
    }



    /**
     * 新增用户
     * @param person
     * @param session
     * @return
     */
    @PostMapping("/add")
    public ServerResponse add(Person person,MultipartFile avatarFile,HttpSession session,HttpServletRequest request){
        if(person.getName().isEmpty()||person.getPwd().isEmpty()){
            return ServerResponse.createErrorResponse(400,"Name or Pwd is null.");
        }
        if(!checkLogin(session)){
            return ServerResponse.createErrorResponse(401,"Login Please.");
        }
        if(!avatarFile.isEmpty()){
            ServerResponse serverResponse=upload(avatarFile);
            if(serverResponse.getStatus()!=200){
                return serverResponse;
            }else{
                person.setAvatar((String) serverResponse.getData());
            }
        }
        return personService.addPerson(person);
    }

    /**
     * 删除用户
     * @param id
     * @param session
     * @return
     */
    @PostMapping("/del")
    public ServerResponse del(Long id,HttpSession session){
        return checkLogin(session)?personService.deletePerson(id):ServerResponse.createErrorResponse(401,"Login Please.");
    }

    private ServerResponse upload(MultipartFile avatar){
        String contentType = avatar.getContentType();//获取上传文件的格式
        String fileName=avatar.getOriginalFilename();
        //检验上传文件的格式
        if (!contentType.equals("image/jpeg") && !contentType.equals("image/png")) {
            return ServerResponse.createErrorResponse(400,"Img must be *.jpg/jpeg/png");
        }
        try {
            fileName=FileUploadUtil.upload(avatar.getBytes(),fileName);
        } catch (IOException e) {
            return ServerResponse.createErrorResponse(500,e.getMessage());
        }
        return ServerResponse.createSuccessResponse(fileName);
    }

}
