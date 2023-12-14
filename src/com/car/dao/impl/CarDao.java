package com.car.dao.impl;

import com.car.entity.Car;
import com.car.entity.dto.CarDto;
import java.util.ArrayList;
import java.util.List;

/** 车辆数据层 */
public class CarDao extends BaseDaoImpl<Car> {

  /** 查询车辆详情 carId */
  public Car selectById(String carId) throws Exception {
    String sql = "select * from car where carId=?";
    executeQuery(sql, carId);

    if (rs.next()) {
      Car car = new Car();
      car.setCarId(rs.getInt("carId"));
      car.setBrand(rs.getString("brand"));
      car.setModel(rs.getString("model"));
      car.setCount(rs.getInt("count"));
      car.setPrice(rs.getInt("price"));
      car.setPic(rs.getString("pic"));
      return car;
    }
    return null;
  }

  /**
   * 查询所有车辆（带条件） brand、price
   *
   * @param carDto
   */
  public List<Car> selectALLCar(CarDto carDto) throws Exception {
    String sql = "select * from car where";
    ArrayList<String> list = new ArrayList<>();

    if (!carDto.getBrand().isEmpty()) {
      list.add(carDto.getBrand());
      sql += " brand=?";
    }
    if (!carDto.getPrice().isEmpty()) {
      if (sql.charAt(sql.length() - 1) == '?') {
        sql += " and";
      }
      list.add(carDto.getPrice());
      sql += " price <?";
    }

    if (sql.charAt(sql.length() - 1) == 'e') {
      sql = sql.replace("where", "");
    }

    executeQuery(sql, list.toArray());

    ArrayList<Car> result = new ArrayList<>();
    while (rs.next()) {
      Car car = new Car();
      car.setCarId(rs.getInt("carId"));
      car.setBrand(rs.getString("brand"));
      car.setModel(rs.getString("model"));
      car.setCount(rs.getInt("count"));
      car.setPrice(rs.getInt("price"));
      car.setPic(rs.getString("pic"));
      result.add(car);
    }
    return result;
  }
}
