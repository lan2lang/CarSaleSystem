package com.car.dao.impl;

import java.sql.*;
import java.util.Properties;

/** 获取数据库连接 */
public class DbUtils {
  public static String url = null; // "jdbc:oracle:thin:@127.0.0.1:1521:orcl";
  public static String user = null; // "scott";
  public static String pwd = null; // "6666";

  static {
    try {
      Properties p = new Properties();

      p.load(DbUtils.class.getClassLoader().getResourceAsStream("/com/car/database.properties"));

      url = p.getProperty("url");
      user = p.getProperty("user");
      pwd = p.getProperty("pwd");
      Class.forName(p.getProperty("driver"));

    } catch (Exception e) {

      e.printStackTrace();
    }
  }

  public static Connection getConnection() {
    Connection con = null;
    try {
      con = DriverManager.getConnection(url, user, pwd);

    } catch (SQLException e) {
      e.printStackTrace();
    }

    return con;
  }

  public static void close(ResultSet rs, Connection con, PreparedStatement ps) {
    try {
      if (rs != null) {
        rs.close();
      }

    } catch (SQLException e) {

      e.printStackTrace();
    }

    try {
      if (ps != null) {
        ps.close();
      }
    } catch (SQLException e) {
      // TODO Auto-generated catch block
      e.printStackTrace();
    }

    try {
      if (con != null) {
        con.close();
      }

    } catch (SQLException e) {
      // TODO Auto-generated catch block
      e.printStackTrace();
    }
  }
}
