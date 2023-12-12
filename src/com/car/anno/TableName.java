package com.car.anno;

import java.lang.annotation.*;

/**
 * 表名注解
 */

// javadoc
@Documented

// 子类是否也具有该注解
@Inherited

// 指定注解在使用范围
@Target(ElementType.TYPE)
@Retention(RetentionPolicy.RUNTIME)
public @interface TableName {
    String name();
}
