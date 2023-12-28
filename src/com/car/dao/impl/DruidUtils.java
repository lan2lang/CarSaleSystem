package com.car.dao.impl;

import com.alibaba.druid.pool.DruidDataSourceFactory;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Properties;
import javax.sql.DataSource;

public class DruidUtils {
  /** 使用Druid数据库连接池技术 */
  private static DataSource source;

  static {
    try {
      Properties pros = new Properties();

      pros.load(DruidUtils.class.getClassLoader().getResourceAsStream("/com/car/druid.properties"));

      source = DruidDataSourceFactory.createDataSource(pros);
    } catch (Exception e) {
      e.printStackTrace();
    }
  }

  public static Connection getConnection() throws SQLException {

    Connection conn = source.getConnection();
    return conn;
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
