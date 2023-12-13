package com.car.entity;

import java.io.Serializable;
import java.time.LocalDateTime;

import com.car.anno.PK;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/** 订单实体类 */
@Data
@AllArgsConstructor
@NoArgsConstructor
public class Order implements Serializable {

  /** */
  @PK
  private Integer orderId;

  /**订单状态；默认、待确认、待付款、已完成 */
  private String status;

  /**订单描述*/
  private String desc;

  /** 客户ID */
  private Integer clientId;

  /**车辆ID */
  private Integer carId;

  /** 订单时间 */
  private LocalDateTime orderTime;
}
