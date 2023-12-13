package com.car.dao.impl;

import com.car.entity.Client;
import java.lang.reflect.Field;

/** 客户数据层 */
public class ClientDao extends BaseDaoImpl<Client> {
  @Override
  public int insert(Client client) throws Exception {
    String sql =
        "insert into Client (clientNo,clientName,password,sex,phone,staffId) values (?,?,?,?,?,?)";
    return executeUpdate(
        sql,
        client.getClientNo(),
        client.getClientName(),
        client.getPassword(),
        client.getSex(),
        client.getPhone(),
        client.getStaffId());
  }

  /** 登录 */
  public Client login(Client client) throws Exception {
    String sql = "select * from client where clientNo=? and password=?";

    executeQuery(sql, client.getClientNo(), client.getPassword());
    client = new Client();
    if (rs.next()) {
      // 拼接查询的列名
      Field[] fields = Client.class.getDeclaredFields();
      for (Field f : fields) {
        f.setAccessible(true);
        // 通过字段对象，给字段对应的对象赋值值
        // 根据数据类型来获取表中的值，赋值给对象中的字段（保证数据类型一致）
        setFieldValue(f, client);
      }
      return client;
    } else {
      return null;
    }
  }
}
