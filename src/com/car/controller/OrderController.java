package com.car.controller;

import com.car.dao.impl.OrderDao;
import com.car.entity.Order;
import com.car.result.Result;
import com.car.utils.Utils;

import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/** 订单 */
@WebServlet("/order")
public class OrderController extends HttpServlet {
  OrderDao orderDao = new OrderDao();

  /**
   * 查询订单列表 客户查询自己的订单 店员查询他客户的订单 管理员查询所有订单
   *
   * @param req
   * @param resp
   */
  @Override
  protected void doGet(HttpServletRequest req, HttpServletResponse resp)
      throws ServletException, IOException {
    // 设置编码格式
    req.setCharacterEncoding("UTF-8");
    resp.setCharacterEncoding("UTF-8");
    // 设置响应头的编码
    resp.setHeader("Content-Type", "application/json;charset=utf-8");

    String optId = req.getParameter("optId");
    String type = req.getParameter("type");

    // dao
    try {
      List<Order> list = orderDao.selectOrdersByType(type, optId);
      Utils.returnJson(resp, Result.success(list));
    } catch (Exception e) {
      e.printStackTrace();
    }
  }
}
