package com.car.controller;

import com.alibaba.fastjson.JSON;
import com.car.dao.impl.StaffDao;
import com.car.entity.PageList;
import com.car.entity.Staff;
import com.car.result.Result;
import com.car.utils.Utils;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/** 员工管理 */
@WebServlet("/staff")
public class StaffController extends HttpServlet {
  StaffDao staffDao = new StaffDao();

  /**
   * 查询员工列表
   *
   * @param req
   * @param res
   */
  @Override
  protected void doGet(HttpServletRequest req, HttpServletResponse res)
      throws ServletException, IOException {
    // 设置编码格式
    req.setCharacterEncoding("UTF-8");
    res.setCharacterEncoding("UTF-8");

//    HashMap map = JSON.parseObject(Utils.parse(req), HashMap.class);

    // 设置响应头的编码
    res.setHeader("Content-Type", "application/json;charset=utf-8");

    try {
      List<Staff> list = staffDao.selectAllStaff();
      Utils.returnJson(res, Result.success(list));
    } catch (Exception e) {
      e.printStackTrace();
      Utils.returnJson(res, Result.error("查询失败"));
    }
  }

  /**
   * 修改员工
   *
   * @param req
   * @param res
   */
  @Override
  protected void doPut(HttpServletRequest req, HttpServletResponse res)
      throws ServletException, IOException {
    // 设置编码格式
    req.setCharacterEncoding("UTF-8");
    res.setCharacterEncoding("UTF-8");

    // 解析请求
    Staff staff = JSON.parseObject(Utils.parse(req), Staff.class);

    // 设置响应头的编码
    res.setHeader("Content-Type", "application/json;charset=utf-8");

    try {
      staffDao.update(staff);
      Utils.returnJson(res, Result.success());
    } catch (Exception e) {
      e.printStackTrace();
      Utils.returnJson(res, Result.error("修改失败，用户编号已存在"));
    }
  }

  /**
   * 新增员工
   *
   * @param req
   * @param res
   */
  @Override
  protected void doPost(HttpServletRequest req, HttpServletResponse res)
      throws ServletException, IOException {
    // 设置编码格式
    req.setCharacterEncoding("UTF-8");
    res.setCharacterEncoding("UTF-8");

    // 解析请求
    Staff staff = JSON.parseObject(Utils.parse(req), Staff.class);

    // 设置响应头的编码
    res.setHeader("Content-Type", "application/json;charset=utf-8");

    try {
      staffDao.insert(staff);
      Utils.returnJson(res, Result.success());

    } catch (Exception e) {
      Utils.returnJson(res, Result.error("员工编号已存在"));
      //      e.printStackTrace();
    }
  }
}
