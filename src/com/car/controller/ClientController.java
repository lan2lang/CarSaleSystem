package com.car.controller;

import com.car.dao.impl.ClientDao;
import com.car.entity.Client;
import com.car.result.Result;
import com.car.utils.Utils;
import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/** 客户管理 */
@WebServlet("/client")
public class ClientController extends HttpServlet {
  ClientDao clientDao = new ClientDao();

  /**
   * 查询客户列表 店员查询它的客户、管理员查询所有客户 根据有没有员工id字段判断
   *
   * @param req
   */
  @Override
  protected void doGet(HttpServletRequest req, HttpServletResponse res)
      throws ServletException, IOException {
    // 设置编码格式
    req.setCharacterEncoding("UTF-8");
    res.setCharacterEncoding("UTF-8");

    //    HashMap map = JSON.parseObject(Utils.parse(req), HashMap.class);
    //    int staffId = (int) map.get("staffId");

    // 不带条件查询
    if (req.getParameter("staffId") == null) {
      try {
        List<Client> list = clientDao.selectAll(Client.class);
        Utils.returnJson(res, Result.success(list));
      } catch (Exception e) {
        e.printStackTrace();
        Utils.returnJson(res, Result.error("查询失败"));
      }
    }

    // 查询指定员工的客户
    int staffId = Integer.parseInt(req.getParameter("staffId"));

    try {
      List<Client> list = clientDao.selectClientsByStaff(staffId);
      Utils.returnJson(res, Result.success(list));
    } catch (Exception e) {
      e.printStackTrace();
      Utils.returnJson(res, Result.error("查询失败"));
    }
  }
}
