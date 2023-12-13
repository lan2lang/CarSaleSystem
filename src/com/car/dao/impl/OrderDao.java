package com.car.dao.impl;

import com.car.entity.Order;

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
//    String sql = "insert into `order` (status,desc,clientId,carId) values (?,?,?,?)";
    String sql = "insert into `order` (status, `desc`, clientId, carId) VALUES (?, ?, ?, ?)";
    order.setStatus("待确认");
    return executeUpdate(
        sql, order.getStatus(), order.getDesc(), order.getClientId(), order.getCarId());
  }
}
