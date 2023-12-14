package com.car.entity.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * 车辆列表数据体
 */
@Data
@AllArgsConstructor
@NoArgsConstructor
public class CarDto {
    private String carId;
    private String brand;
    private String price;

}
