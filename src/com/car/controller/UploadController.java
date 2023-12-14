package com.car.controller;

import com.car.result.Result;
import com.car.utils.Utils;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

/** 车辆图片上传 */
@WebServlet("/upload")
public class UploadController extends HttpServlet {
  // 上传文件存储目录
  private static final String UPLOAD_DIRECTORY = "upload";

  // 上传配置
  private static final int MEMORY_THRESHOLD = 1024 * 1024 * 10; // 3MB
  private static final int MAX_FILE_SIZE = 1024 * 1024 * 40; // 40MB
  private static final int MAX_REQUEST_SIZE = 1024 * 1024 * 50; // 50MB

  public static void main(String[] args) {
    new UploadController().setUploadDirectory();
  }

  public void setUploadDirectory() {
    File directory = new File(""); // 参数为空
    try {
      String courseFile = directory.getCanonicalPath();
      System.out.println(courseFile);
    } catch (IOException e) {
      throw new RuntimeException(e);
    }
    System.out.println();
  }

  /** 上传车辆图片 上传到本地目录，返回图片地址给前端 */
  @Override
  protected void doPost(HttpServletRequest request, HttpServletResponse response)
      throws ServletException, IOException {

    // 检测是否为多媒体上传
    if (!ServletFileUpload.isMultipartContent(request)) {
      // 如果不是则停止
      PrintWriter writer = response.getWriter();
      writer.println("Error: 表单必须包含 enctype=multipart/form-data");
      writer.flush();
      return;
    }

    // 配置上传参数
    DiskFileItemFactory factory = new DiskFileItemFactory();

    // 设置内存临界值 - 超过后将产生临时文件并存储于临时目录中
    factory.setSizeThreshold(MEMORY_THRESHOLD);

    // 设置临时存储目录
    factory.setRepository(new File(System.getProperty("java.io.tmpdir")));

    ServletFileUpload upload = new ServletFileUpload(factory);

    // 设置最大文件上传值
    upload.setFileSizeMax(MAX_FILE_SIZE);

    // 设置最大请求值 (包含文件和表单数据)
    upload.setSizeMax(MAX_REQUEST_SIZE);

    // 中文处理
    upload.setHeaderEncoding("UTF-8");

    // 构造临时路径来存储上传的文件
    // 这个路径相对当前应用的目录
    String uploadPath =
        request.getServletContext().getRealPath("./") + File.separator + UPLOAD_DIRECTORY;
    // 当前项目路径
    //    String path = new File("").getCanonicalPath();
    //    String uploadPath = path + File.separator + "web" + File.separator + "upload";

    // 如果目录不存在则创建
    File uploadDir = new File(uploadPath);
    if (!uploadDir.exists()) {
      uploadDir.mkdir();
    }

    try {
      // 解析请求的内容提取文件数据
      @SuppressWarnings("unchecked")
      List<FileItem> formItems = upload.parseRequest(request);

      if (formItems != null && !formItems.isEmpty()) {
        // 迭代表单数据
        for (FileItem item : formItems) {
          // 处理不在表单中的字段
          if (!item.isFormField()) {
            String fileName = new File(item.getName()).getName();
            String filePath = uploadPath + File.separator + fileName;
            File storeFile = new File(filePath);
            // 在控制台输出文件的上传路径
            System.out.println(filePath);
            // 保存文件到硬盘
            item.write(storeFile);
            request.getSession().setAttribute("pic", UPLOAD_DIRECTORY + File.separator + fileName);
            Utils.returnJson(
                response, Result.success(UPLOAD_DIRECTORY + File.separator + fileName));
          }
        }
      }
    } catch (Exception ex) {
      //      request.setAttribute("message", "错误信息: " + ex.getMessage());
      Utils.returnJson(response, Result.error("上传失败"));
      ex.printStackTrace();
    }
  }
}
