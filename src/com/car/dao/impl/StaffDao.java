package com.car.dao.impl;

import com.car.entity.PageList;
import com.car.entity.Staff;
import java.lang.reflect.Field;
import java.util.ArrayList;
import java.util.List;

/** 客户数据层 */
public class StaffDao extends BaseDaoImpl<Staff> {

  /**
   * 查询指定员工id的业绩和排名
   */

  /** 查询所有员工 */
  public List<Staff> selectAllStaff() throws Exception {
    String sql = "select staffId,staffNo,staffName,password,sex,phone from Staff where staffId!=1;";
    executeQuery(sql);
    ArrayList<Staff> list = new ArrayList<>();
    while (rs.next()) {
      Staff staff = new Staff();
      staff.setStaffId(rs.getInt("staffId"));
      staff.setStaffNo(rs.getString("staffNo"));
      staff.setStaffName(rs.getString("staffName"));
      staff.setPassword(rs.getString("password"));
      staff.setSex(rs.getString("sex"));
      staff.setPhone(rs.getString("phone"));
      list.add(staff);
    }
    return list;
  }

  /** 查询员工列表（分页） */
  public PageList selectStaffList(int index, int size) throws Exception {
    PageList<Staff> list = new PageList<>(index, size);
    selectByPage(Staff.class, "Staff", list);

    return list;
  }

  /** 新增员工 */
  @Override
  public int insert(Staff staff) throws Exception {
    String sql =
        "insert into staff(staffNo, staffName, password, sex, phone) VALUES (?, ?, ?, ?, ?) ";
    return executeUpdate(
        sql,
        staff.getStaffNo(),
        staff.getStaffName(),
        staff.getPassword(),
        staff.getSex(),
        staff.getPhone());
  }

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
      // 查询客户ID
      sql = "select staffId from staff where staffNo=?";
      executeQuery(sql, staff.getStaffNo());

      rs.next();
      staff.setStaffId(rs.getInt("staffId"));
      return staff;
    } else {
      return null;
    }
  }
}
