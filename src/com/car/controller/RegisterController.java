package com.car.controller;

import com.alibaba.fastjson.JSON;
import com.car.result.Result;
import com.car.utils.Utils;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/** 注册控制 */
@WebServlet("/register")
public class RegisterController extends HttpServlet {


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
    // 解析请求
    Utils.parse(req);

    // 设置编码格式
    req.setCharacterEncoding("UTF-8");
    res.setCharacterEncoding("UTF-8");

    // 设置响应头的编码
    res.setHeader("Content-Type", "application/json;charset=utf-8");
    //    res.setHeader("Content-Type", "text/html;charset=utf-8");

    // 解析请求体

    // 新增客户

    // 注册成功
    Result.success();

    // 注册失败
    res.getWriter().append(JSON.toJSONString(Result.error("用户名已存在")));
  }
}
