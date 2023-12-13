package com.car.utils;

import com.alibaba.fastjson.JSONObject;
import java.io.BufferedReader;
import java.io.IOException;
import java.util.HashMap;
import javax.servlet.http.HttpServletRequest;

/** 工具类 */
public class Utils<T> {

  /** 根据返回行数判读是否为真 */
  public static boolean judge(int i) {
    return i != 0;
  }

  /**
   * 解析前端传过来的json
   */
  public static HashMap  parse(HttpServletRequest req ) throws IOException {
    //  request.getReader();方法返回一个包含body体数据的BufferedReader；
    BufferedReader reader = req.getReader();

    String readerStr = ""; // 接收用户端传来的JSON字符串（body体里的数据）
    String line;
    while ((line = reader.readLine()) != null) {
      readerStr = readerStr.concat(line);
    }

    // 使用阿里的fastjson jar包处理json数据（这里是用map进行接收的，你也可以定义vo层容器类接收）
    HashMap map = JSONObject.parseObject(readerStr, HashMap.class);

    System.out.println(map.get("user"));

    return map;
  }
}
