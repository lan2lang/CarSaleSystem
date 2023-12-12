package com.car.controller;

import com.car.dao.impl.UserDao;
import com.car.entity.User;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/** 登录控制 */
@WebServlet("/login")
public class LoginController extends HttpServlet {
  UserDao userDao = new UserDao();

  @Override
  protected void doGet(HttpServletRequest req, HttpServletResponse resp)
      throws ServletException, IOException {
    super.doGet(req, resp);
  }

  @Override
  protected void doPost(HttpServletRequest req, HttpServletResponse res)
      throws ServletException, IOException {
    // 设置编码格式
    req.setCharacterEncoding("UTF-8");
    res.setCharacterEncoding("UTF-8");

    // 设置响应头的编码
    res.setHeader("Content-Type", "text/html;charset=utf-8");

    // 获取用户名与密码
    String userName = req.getParameter("userName");
    String passWord = req.getParameter("passWord");

    // 不区分大小写
    userName = userName.toUpperCase();

    // 验证
    try {
      System.out.println(userDao.verify(new User(userName, passWord)));
    } catch (Exception e) {
      throw new RuntimeException(e);
    }
  }
}
