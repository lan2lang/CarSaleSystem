package com.car.dao.impl;

import com.alibaba.druid.pool.DruidDataSourceFactory;
import java.io.InputStream;
import java.sql.Connection;
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
}
