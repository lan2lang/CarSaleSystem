package com.car.entity;

import com.car.anno.PK;

/**
 *用户实体类
 */
public class User {
    //用户Id
    @PK
    private int userId;
    private String userName;

    //密码
    private String password;

    /**
     * 无参构造方法
     */
    public User() {
    }

    public User(String userName, String password) {
        this.userName = userName;
        this.password = password;
    }

    /**
     * 设置用户编号
     * @param user_no
     */
    public void setUser_no(String user_no) {
        this.userName = user_no;
    }

    public int getUser_id() {
        return userId;
    }

    /**
     * 设置用户Id
     * @param user_id
     */
    public void setUser_id(int user_id) {
        this.userId = user_id;
    }

    public String getUserName() {
        return userName;
    }

    public String getPassword() {
        return password;
    }

    /**
     * 设置密码
     * @param password
     */
    public void setPassword(String password) {
        this.password = password;
    }
}
