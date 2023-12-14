package com.car.controller;

import com.car.dao.impl.CarDao;
import com.car.dao.impl.StaffDao;
import com.car.entity.Car;
import com.car.entity.Staff;
import com.car.result.Result;
import com.car.utils.Utils;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/** 获取详情信息 */
@WebServlet("/detail")
public class GetDetailController extends HttpServlet {

  /**
   * 查询员工详细
   *
   * @param req
   * @param resp
   * @throws ServletException
   * @throws IOException
   */
  @Override
  protected void doGet(HttpServletRequest req, HttpServletResponse resp)
      throws ServletException, IOException {
    // 设置编码格式
    req.setCharacterEncoding("UTF-8");
    resp.setCharacterEncoding("UTF-8");

    // 解析请求
    //        Staff staff = JSON.parseObject(Utils.parse(req), Staff.class);

    // 设置响应头的编码
    resp.setHeader("Content-Type", "application/json;charset=utf-8");

    String id = req.getParameter("id");

    try {
      Staff staff = new StaffDao().selectById(id);
      Utils.returnJson(resp, Result.success(staff));
    } catch (Exception e) {
      Utils.returnJson(resp,Result.error("查询失败"));
      e.printStackTrace();
    }
  }

  /**
   * 查询车辆详细
   *
   * @param req
   * @param resp
   * @throws ServletException
   * @throws IOException
   */
  @Override
  protected void doPost(HttpServletRequest req, HttpServletResponse resp)
      throws ServletException, IOException {
    // 设置编码格式
    req.setCharacterEncoding("UTF-8");
    resp.setCharacterEncoding("UTF-8");

    // 解析请求
    //        Staff staff = JSON.parseObject(Utils.parse(req), Staff.class);

    // 设置响应头的编码
    resp.setHeader("Content-Type", "application/json;charset=utf-8");

    String id = req.getParameter("id");

    try {
      Car car = new CarDao().selectById(id);
      Utils.returnJson(resp, Result.success(car));
    } catch (Exception e) {
      Utils.returnJson(resp,Result.error("查询失败"));
      e.printStackTrace();
    }
  }
}
