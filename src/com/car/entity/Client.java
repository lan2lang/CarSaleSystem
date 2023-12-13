package com.car.entity;


import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;


/**
* 客户实体类
* @TableName client
*/
@Data
@AllArgsConstructor
@NoArgsConstructor
public class Client implements Serializable {

    /**
    *
    */
    private Integer clientId;
    /**
    *
    */
    private String clientNo;
    /**
    *
    */
    private String clientName;
    /**
    *
    */
    private String password;
    /**
    *
    */
    private String sex;
    /**
    *
    */
    private String phone;
    /**
    * 所属员工id
    */
    private Integer staffId;

    public Client(String clientNo, String password) {
        this.clientNo = clientNo;
        this.password = password;
    }
}
