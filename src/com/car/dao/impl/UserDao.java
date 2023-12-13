package com.car.dao.impl;

import com.car.entity.User;

public class UserDao extends BaseDaoImpl<User> {

  /** 验证用户名密码是否正确 */
  public int verify(User user) throws Exception {
    sql = "update user set username=? where username=? and password=?";
    try {
      return executeUpdate(sql,user.getUserName(), user.getUserName(), user.getPassword());

    } catch (Exception e) {
      e.printStackTrace();
    }

    return 0;
  }
}
