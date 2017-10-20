package com.justin.person.vo;

import java.io.Serializable;

/**
 * Created by Justin on 2017/10/20.
 */
public class ServerResponse<T> implements Serializable{
    private int status;
    private String msg;
    private T data;

    public ServerResponse(int status, T data) {
        this.status = status;
        this.data = data;
    }

    public ServerResponse(int status, String msg) {
        this.status = status;
        this.msg = msg;
    }

    public static <T> ServerResponse<T> createSuccessResponse(T data){
        return new ServerResponse<T>(200,data);
    }
    public static <T> ServerResponse<T> createErrorResponse(int status,String msg){
        return new ServerResponse<T>(status,msg);
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public String getMsg() {
        return msg;
    }

    public void setMsg(String msg) {
        this.msg = msg;
    }

    public T getData() {
        return data;
    }

    public void setData(T data) {
        this.data = data;
    }
}
