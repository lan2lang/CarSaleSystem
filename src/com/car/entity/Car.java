package com.car.entity;

import java.io.Serializable;

import com.car.anno.PK;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/** 车辆实体类 */
@Data
@AllArgsConstructor
@NoArgsConstructor
public class Car implements Serializable {

  /** */
  @PK private Integer carId;

  /**品牌 */
  private String brand;

  /**型号 */
  private String model;

  /** 库存数量 */
  private Integer count;

  /**价格（万） */
  private Integer price;

  /** 车辆图片地址 */
  private String pic;
}
