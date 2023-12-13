package com.car.entity;


import java.io.Serializable;

import com.car.anno.PK;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
* 店员实体类
* @TableName staff
*/
@Data
@AllArgsConstructor
@NoArgsConstructor
public class Staff implements Serializable {

    /**
    *
    */
    @PK
    private Integer staffId;
    /**
    *
    */
    private String staffNo;
    /**
    *
    */
    private String staffName;
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

    public Staff(String staffNo, String password) {
        this.staffNo = staffNo;
        this.password = password;
    }
}
