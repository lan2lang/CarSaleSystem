package com.car.entity.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * 登录数据体
 */
@Data
@AllArgsConstructor
@NoArgsConstructor
public class LoginDto {
    /**
     *
     */
    private String username;
    /**
     *
     */
    private String password;
    /**
     * 角色 0为客户、1为店员
     */
    private String role;
}
