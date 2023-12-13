package com.car.dao.impl;

import com.car.entity.Order;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;

/** 订单数据层 */
public class OrderDao extends BaseDaoImpl<Order> {

  /**
   * 新增订单
   *
   * @param order 插入的对象
   * @return
   * @throws Exception
   */
  @Override
  public int insert(Order order) throws Exception {

    String sql = "";

    // 查询客户名称、店员名称、车辆品牌型号
    sql =
        " select  clientName, staffName from client  join staff on client.staffId=staff.staffId where clientId=?";

    executeQuery(sql, order.getClientId());
    rs.next();
    String clientName = rs.getString("clientName");
    String staffName = rs.getString("staffName");

    sql = "select brand ,model  from car  where carId=?";
    executeQuery(sql, order.getCarId());
    rs.next();
    String brand = rs.getString("brand");
    String model = rs.getString("model");

    // 拼接desc
    String desc = "客户：" + clientName + ";\n店员：" + staffName + ";\n车辆：" + brand + " " + model;

    order.setDesc(desc);
    sql = "insert into `order` (status, `desc`, clientId, carId) VALUES (?, ?, ?, ?)";
    order.setStatus("待确认");

    return executeUpdate(
        sql, order.getStatus(), order.getDesc(), order.getClientId(), order.getCarId());
  }

  /**
   * 店员确认订单
   *
   * @param orderId
   */
  public void confirm(int orderId) throws Exception {
    String sql = "update `order` set status=? where orderId=?";
    executeUpdate(sql, "待付款", orderId);
  }

  /**
   * 客户付款
   *
   * @param orderId
   */
  public void pay(int orderId) throws Exception {
    String sql = "update `order` set status=? where orderId=?";
    executeUpdate(sql, "已完成", orderId);
  }

  /**
   * 取消订单
   *
   * @param orderId
   */
  public void cancel(int orderId) throws Exception {
    String sql = "update `order` set status=? where orderId=?";
    executeUpdate(sql, "已取消", orderId);
  }

  /** 查询订单（根据权限） */
  public List<Order> selectOrdersByType(String type, String optId) throws Exception {

    if (type.equals("admin")) {
      String sql = "select * from `order`";
      executeQuery(sql);
      return getOrders();
    } else if (type.equals("client")) {
      String sql = "select * from `order` where clientId=?";
      executeQuery(sql, optId);
      return getOrders();
    } else if (type.equals("staff")) {
      String sql = "select * from `order` where clientId in (select clientId from client where staffId = ?)";
      executeQuery(sql, optId);
      return getOrders();
    }
    return null;
  }

  /**
   * 解析订单到list
   *
   * @return
   * @throws SQLException
   */
  private List<Order> getOrders() throws SQLException {
    ArrayList<Order> list = new ArrayList<>();
    while (rs.next()) {
      Order order = new Order();
      DateTimeFormatter ftf = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
      order.setOrderTime(LocalDateTime.parse(rs.getString("orderTime"), ftf));
      order.setOrderId(rs.getInt("orderId"));
      order.setStatus(rs.getString("status"));
      order.setDesc(rs.getString("desc"));

      list.add(order);
    }
    return list;
  }
}
