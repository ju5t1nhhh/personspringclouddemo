package com.justin.person.domain;

import lombok.Data;

import java.util.Date;

/**
 * Created by Justin on 2017/10/20.
 */
@Data
public class Person {
    private Long id;
    private String name;
    private String pwd;
    private Character sex;
    private String mobile;
    private String email;
    private String avatar;
    private Integer status;
    private Date createTime;
    private Date updateTime;
}
