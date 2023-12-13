package com.car.utils;

import com.alibaba.fastjson.JSON;
import com.car.result.Result;
import java.io.BufferedReader;
import java.io.IOException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/** 工具类 */
public class Utils {

  /** 返回json */
  public static void returnJson(HttpServletResponse res, Result result) throws IOException {
    res.getWriter().append(JSON.toJSONString(result));
  }

  /** 根据返回行数判读是否为真 */
  public static boolean judge(int i) {
    return i != 0;
  }

  /** 解析前端传过来的json */
  public static String parse(HttpServletRequest req) throws IOException {
    //  request.getReader();方法返回一个包含body体数据的BufferedReader；
    BufferedReader reader = req.getReader();

    String readerStr = ""; // 接收用户端传来的JSON字符串（body体里的数据）
    String line;
    while ((line = reader.readLine()) != null) {
      readerStr = readerStr.concat(line);
    }

    return readerStr;
  }
}
