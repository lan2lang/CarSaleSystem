package com.car.controller;

import com.alibaba.fastjson.JSON;
import com.car.dao.impl.UserDao;
import com.car.result.Result;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/** 登录控制 */
@WebServlet("/login")
public class LoginController extends HttpServlet {
  UserDao userDao = new UserDao();

  @Override
  protected void doGet(HttpServletRequest req, HttpServletResponse resp)
      throws ServletException, IOException {
    super.doGet(req, resp);
  }

  /**
   * username、password、role
   *
   * @param req
   * @param res
   * @throws ServletException
   * @throws IOException
   */
  @Override
  protected void doPost(HttpServletRequest req, HttpServletResponse res)
      throws ServletException, IOException {
    // 设置编码格式
    req.setCharacterEncoding("UTF-8");
    res.setCharacterEncoding("UTF-8");

    // 设置响应头的编码
    res.setHeader("Content-Type", "application/json;charset=utf-8");
    //    res.setHeader("Content-Type", "text/html;charset=utf-8");

    // 获取用户名与密码
    String username = req.getParameter("username");
    String password = req.getParameter("password");

    //     0为客户、1为店员
    int role = Integer.parseInt(req.getParameter("role"));

    if (role == 0) {
      // 查询客户表
    } else {
      // 查询店员表
    }

    // 登录成功设置session，并跳转页面
    Result.success();
    HttpSession session = req.getSession();
    session.setAttribute("role",0);
    //设置客户id或店员id

    //转发
    req.getRequestDispatcher("/View/main.jsp").forward(req,res);

//    res.

    // 登录失败，返回登录失败
    res.getWriter().append(JSON.toJSONString(Result.error("用户名或密码错误")));
  }
}
