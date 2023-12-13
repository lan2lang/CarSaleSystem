package com.car.dao.impl;

import com.car.entity.Client;
import com.car.entity.Staff;
import java.lang.reflect.Field;

/** 客户数据层 */
public class StaffDao extends BaseDaoImpl<Client> {

  /** 登录 */
  public Staff login(Staff staff) throws Exception {
    String sql = "select * from staff where staffNo=? and password=?";

    executeQuery(sql, staff.getStaffNo(), staff.getPassword());
    staff = new Staff();
    if (rs.next()) {
      // 拼接查询的列名
      Field[] fields = Staff.class.getDeclaredFields();
      for (Field f : fields) {
        f.setAccessible(true);
        // 通过字段对象，给字段对应的对象赋值值
        // 根据数据类型来获取表中的值，赋值给对象中的字段（保证数据类型一致）
        setFieldValue(f, staff);
      }
      return staff;
    } else {
      return null;
    }
  }
}
