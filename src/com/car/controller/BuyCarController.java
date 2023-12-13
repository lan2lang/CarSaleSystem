package com.car.controller;

import com.alibaba.fastjson.JSON;
import com.car.dao.impl.OrderDao;
import com.car.entity.Car;
import com.car.entity.Order;
import com.car.result.Result;
import com.car.utils.Utils;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.time.LocalDateTime;
import java.util.Date;

/** 买车控制器 */
@WebServlet("/buyCar")
public class BuyCarController extends HttpServlet {
  OrderDao orderDao = new OrderDao();

  /**
   * 店员确认订单 修改订单状态为待付款
   *
   * @param req
   * @param resp
   * @throws ServletException
   * @throws IOException
   */
  @Override
  protected void doGet(HttpServletRequest req, HttpServletResponse resp)
      throws ServletException, IOException {
    super.doGet(req, resp);
  }

  /**
   * 客户下单 新增订单（订单状态为待确认）
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
    Order order = JSON.parseObject(Utils.parse(req), Order.class);

    // 设置响应头的编码
    resp.setHeader("Content-Type", "application/json;charset=utf-8");

    // 设置订单时间
//    order.setOrderTime(LocalDateTime.now());
    // dao
    try {
      orderDao.insert(order);
      Utils.returnJson(resp, Result.success());
    } catch (Exception e) {
      e.printStackTrace();
//      Utils.returnJson(resp,Result.error("失败"));
    }
  }

  /**
   * 客户付款 修改订单状态为已完成
   *
   * @param req
   * @param resp
   * @throws ServletException
   * @throws IOException
   */
  @Override
  protected void doPut(HttpServletRequest req, HttpServletResponse resp)
      throws ServletException, IOException {
    super.doPut(req, resp);
  }

  /**
   * 订单取消 修改订单状态为已取消
   *
   * @param req
   * @param resp
   * @throws ServletException
   * @throws IOException
   */
  @Override
  protected void doDelete(HttpServletRequest req, HttpServletResponse resp)
      throws ServletException, IOException {
    super.doDelete(req, resp);
  }
}
