package com.car.controller;

import com.alibaba.fastjson.JSON;
import com.car.dao.impl.ClientDao;
import com.car.dao.impl.StaffDao;
import com.car.entity.Client;
import com.car.entity.Staff;
import com.car.entity.dto.LoginDto;
import com.car.result.Result;
import com.car.utils.Utils;
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
  ClientDao clientDao = new ClientDao();
  StaffDao staffDao = new StaffDao();

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

    // 解析请求体
    LoginDto loginDto = JSON.parseObject(Utils.parse(req), LoginDto.class);

    Object loginVo = null;
    if (loginDto.getRole().equals("0")) {
      // 查询客户表
      try {
        loginVo = clientDao.login(new Client(loginDto.getUsername(), loginDto.getPassword()));

      } catch (Exception e) {
        throw new RuntimeException(e);
      }
    } else {
      // 查询店员表
      try {
        loginVo = staffDao.login(new Staff(loginDto.getUsername(), loginDto.getPassword()));

      } catch (Exception e) {
        throw new RuntimeException(e);
      }
    }

    if (loginVo != null) {
      // 设置session
      HttpSession session = req.getSession();
      session.setAttribute("role", loginDto.getRole());
      session.setAttribute("userinfo", loginVo);

      // 返回成功
      Utils.returnJson(res, Result.success(loginVo));
    } else {
      // 转发
      //    req.getRequestDispatcher("/View/main.jsp").forward(req, res);

      // 登录失败，返回登录失败
      res.getWriter().append(JSON.toJSONString(Result.error("用户名或密码错误")));
    }
  }
}
