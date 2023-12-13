package com.car.dao.impl;

import com.car.entity.Car;
import com.car.entity.dto.CarDto;
import java.util.ArrayList;
import java.util.List;

/** 车辆数据层 */
public class CarDao extends BaseDaoImpl<Car> {

  /**
   * 查询所有车辆（带条件） clientId、brand、price
   *
   * @param carDto
   */
  public List<Car> selectALLCar(CarDto carDto) throws Exception {
    String sql = "select * from car where";
    ArrayList<String> list = new ArrayList<>();
    if (!carDto.getClientId().isEmpty()) {
      list.add(carDto.getClientId());
      sql += " carId in (select carId from `order` where clientId=? )";
    } else if (!carDto.getBrand().isEmpty()) {
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
