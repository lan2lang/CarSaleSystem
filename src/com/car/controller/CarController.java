package com.car.controller;

import com.alibaba.fastjson.JSON;
import com.car.dao.impl.CarDao;
import com.car.entity.Car;
import com.car.entity.dto.CarDto;
import com.car.result.Result;
import com.car.utils.Utils;
import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/** 车辆管理 */
@WebServlet("/car")
public class CarController extends HttpServlet {
  CarDao carDao = new CarDao();

  /**
   * 查询车辆列表
   *
   * @param req
   * @param res
   */
  @Override
  protected void doGet(HttpServletRequest req, HttpServletResponse res)
      throws ServletException, IOException {
    // 设置编码格式
    req.setCharacterEncoding("UTF-8");
    res.setCharacterEncoding("UTF-8");
    // 设置响应头的编码
    res.setHeader("Content-Type", "application/json;charset=utf-8");

    // 解析请求
    CarDto carDto = JSON.parseObject(Utils.parse(req), CarDto.class);

    // 调用dao
    try {
      List<Car> cars = carDao.selectALLCar(carDto);
      Utils.returnJson(res, Result.success(cars));
    } catch (Exception e) {
      e.printStackTrace();
    }
  }

  /**
   * 新增车辆
   *
   * @param req
   * @param res
   */
  @Override
  protected void doPost(HttpServletRequest req, HttpServletResponse res)
      throws ServletException, IOException {
    // 设置编码格式
    req.setCharacterEncoding("UTF-8");
    res.setCharacterEncoding("UTF-8");

    // 解析请求
    Car car = JSON.parseObject(Utils.parse(req), Car.class);

    // 设置响应头的编码
    res.setHeader("Content-Type", "application/json;charset=utf-8");

    // 新增车辆
    try {
      carDao.insert(car);
      Utils.returnJson(res, Result.success());
    } catch (Exception e) {
      Utils.returnJson(res, Result.error("新增失败"));
      e.printStackTrace();
    }
  }

  /**
   * 修改车辆
   *
   * @param req
   * @param res
   */
  @Override
  protected void doPut(HttpServletRequest req, HttpServletResponse res)
      throws ServletException, IOException {
    // 设置编码格式
    req.setCharacterEncoding("UTF-8");
    res.setCharacterEncoding("UTF-8");

    // 解析请求
    Car car = JSON.parseObject(Utils.parse(req), Car.class);

    // 设置响应头的编码
    res.setHeader("Content-Type", "application/json;charset=utf-8");

    // 调用dao层方法
    try {
      carDao.update(car);
      Utils.returnJson(res, Result.success());
    } catch (Exception e) {
      Utils.returnJson(res, Result.error("修改失败"));
    }
  }
}
