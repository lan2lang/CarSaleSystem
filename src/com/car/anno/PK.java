package com.car.anno;

import java.lang.annotation.*;

/**
 *主键注解
 */
@Documented
@Inherited
@Target(ElementType.FIELD)
@Retention(RetentionPolicy.RUNTIME)
public @interface PK {
}
