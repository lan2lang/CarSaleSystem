package com.car.dao.impl;

import com.car.anno.PK;
import com.car.anno.TableName;
import com.car.dao.BaseDao;
import com.car.entity.PageList;
import java.lang.reflect.Field;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class BaseDaoImpl<T> implements BaseDao<T> {
  // 数据库连接对象
  protected Connection con = null;
  // 保存查询结果，使用子类直接访问
  protected ResultSet rs = null;

  // 执行存储过程
  // private CallableStatement cs = null;
  // sql语句
  protected String sql;
  // 执行SQL命令对象
  private PreparedStatement ps = null;

  /**
   * 初始化PreparedStatement对象
   *
   * @param sql sql语句
   * @param objs 参数
   * @throws Exception 异常处理
   */
  private void initPreparedStatement(String sql, Object... objs) throws Exception {
    con = null;
    if (con == null) {
      //      con = DbUtils.getConnection();
      con = DruidUtils.getConnection();
    }
    System.out.println("sql:" + sql);
    ps = con.prepareStatement(sql);

    // 设置未知参的值
    for (int i = 0; i < objs.length; i++) {
      // 日期特殊处理
      if ("java.util.Date".equals(objs[i].getClass().getTypeName())) {
        ps.setTimestamp(i + 1, new java.sql.Timestamp(((Date) objs[i]).getTime()));
      } else {
        ps.setObject(i + 1, objs[i]);
      }
    }
  }

  /**
   * 执行添加删除修改操作方法
   *
   * @param sql
   * @param objs
   * @return
   * @throws Exception
   */
  public int executeUpdate(String sql, Object... objs) throws Exception {
    initPreparedStatement(sql, objs);

    return ps.executeUpdate();
  }

  /**
   * 执行查询操作方法 给rs赋值
   *
   * @param sql
   * @param objs
   * @throws Exception
   */
  public void executeQuery(String sql, Object... objs) throws Exception {
    initPreparedStatement(sql, objs);

    rs = ps.executeQuery();
  }

  public void close() {
    DbUtils.close(rs, con, ps);
  }

  /**
   * 将对象插入到对应的数据库 约定1：对象对应的类名需要与表名保持一致（不区分大小写） 约定2：对象中的属性必须与表中的字段名一致（不区分大小写）
   * 约定3：表中的主键需要与对象中的被"@PK"注解的字段对应（主键使用“S_表名.nextVal”序列自动生成）
   * 扩展1：如果表名或字段名与对象对应类中的名称或属性名称不一致的情况，可以使用@TableName(name="字段名")注解，使其对应。
   * 其它备注：本方法主要是根据传过来的对象，获取对应的Class类型对象，解析并获取其中成员信息，拼接出insert Sql语句，将对象的数据插入到对象对应表中
   *
   * @param t 插入的对象
   * @return 返回影响的行数
   * @throws Exception 调用本方法需要自行处理异常
   */
  public int insert(T t) throws Exception {
    // 保存Sql字符串
    StringBuilder sql = new StringBuilder();

    // 获取对象对应的字节码类型对象(Class对象)
    Class<?> c = t.getClass();

    // 获取表名(如果使用@TableName(name=表名)，则以注释中的name作为表名，如果没有注解，则使用当前类名作为表名)
    String tableName = null;
    if (c.isAnnotationPresent(TableName.class)) {
      // 获取注解中的名称
      tableName = c.getAnnotation(TableName.class).name();
    } else {
      // 获取类名
      tableName = c.getSimpleName();
    }

    // 获取序列号（序列号为S_表名）
    int seq = getSequence("S_" + tableName);

    // 拼接插入的Sql语句
    sql.append("insert into " + tableName + " (");

    // 获取类型中所有的属性(也叫字段)对象数组
    Field[] fields = c.getDeclaredFields();

    // 拼接插入的列名（按约定：列名=字段名）
    for (Field f : fields) {
      // 字段为私有，需要暴力访问
      f.setAccessible(true);

      // (如果使用@TableName(name=列名)，则以注释中的name作为列名，如果没有注解，则使用当前字段名作为列名)
      if (f.isAnnotationPresent(TableName.class)) {
        // 获取注解中的列名
        sql.append(f.getAnnotation(TableName.class).name());
      } else {
        // 获取字段名
        sql.append(f.getName());
        sql.append(",");
      }
    }

    // 去掉列名最后面的一个 "," 号
    sql = sql.deleteCharAt(sql.length() - 1);

    // 拼接 Sql字符串
    sql.append(") values (");

    // 拼接未知参数(也叫编译参数，都使用?代替)
    for (int i = 0; i < fields.length; i++) {
      /*// 当对象中的属性被@PK注解了，说明它是主键，需要作用对应的序列S_表名.nextVal
      if(fields[i].isAnnotationPresent(PK.class))
      {
      	sql.append("S_");
      	sql.append(tableName);
      	sql.append(".nextVal,");
      }
      else
      {
      	// 如果不是主键，则使用?代替
          sql.append("?,");
      }*/
      // 如果不是主键，则使用?代替
      sql.append("?,");
    }

    // 去掉最后一个,号
    sql = sql.deleteCharAt(sql.length() - 1);

    // 拼接插入语句的最后一个).
    sql.append(")");

    // 由于插入语句我们使用的是PerperedStatement,SQL中的参数使用的是?（防止SQL注入）
    // 以下是获取对象中的数据，组装成一个对象集合，传递给执行SQL语句的方法executeUpdate(Sql,参数)
    // 初始化参数对象数组，个数为属性个数-1, 因为主键是用序列生成。其它的数据使用对象中的数据
    Object[] objs = new Object[fields.length];
    // i:控制循环次数据，有几个字段的就要循环几次
    for (int i = 0; i < fields.length; i++) {
      // 字段集合中有一个是主键字段， 如果是主键，则不需要管，因为有序列生成
      if (fields[i].isAnnotationPresent(PK.class)) {
        // 设置主键对应的序列号
        objs[i] = seq;

        // 给对象赋插入的ID(主 键) 便于返回
        fields[i].set(t, seq);
      }

      // 通过字段对象，获取某个对象中该字段的值，并将值赋值给对象数组（将下标向下移动一位j++）
      objs[i] = fields[i].get(t);
    }

    // 调用执行添加删除修改的方法，执行该Sql语句，并将参数传递过去

    return executeUpdate(sql.toString(), objs);
  }

  /**
   * 根据主键删除数据
   *
   * @param t 泛型类的对象
   * @return 操作的行数
   * @throws Exception 异常处理
   */
  public int delete(T t) throws Exception {
    // 创建StringBuilder对象sql
    StringBuilder sql = new StringBuilder();

    // 使用append方法添加字符串
    sql.append("delete from ");

    // 获取t对象的Class对象
    Class<?> c = t.getClass();

    // 定义一个变量存储表名
    String tbName;

    // 判断表名是否与类名一致
    if (c.isAnnotationPresent(TableName.class)) {
      tbName = c.getAnnotation(TableName.class).name();
    } else {
      tbName = c.getSimpleName();
    }

    // 获取对象的名字添加到sql中
    sql.append(tbName);

    sql.append(" where ");

    // 获取t对象中的所有字段，存到Field数组中
    Field[] fields = c.getDeclaredFields();

    // 定义一个变量存储主键的值
    Object obj = new Object();

    for (int i = 0; i < fields.length; i++) {
      // 允许通过反射访问访问私有变量
      fields[i].setAccessible(true);

      if (fields[i].isAnnotationPresent(PK.class)) {
        // 获取字段的名字，并用append方法添加sql中
        sql.append(fields[i].getName());

        // 将主键的值赋给obj
        obj = fields[i].get(t);
        break;
      }
    }

    sql.append(" = ?");

    // 调用executeUpdate方法，并return其操作的数据行数
    return executeUpdate(sql.toString(), obj);
  }

  /**
   * 根据主键修改对应表中行数据
   *
   * @param t 泛型类的对象
   * @return 操作的行数
   * @throws Exception 异常处理
   */
  public int update(T t) throws Exception {
    // 创建StringBuilder对象sql
    StringBuilder sql = new StringBuilder();

    // 使用append方法添加字符串
    sql.append("update ");

    // 获取t对象的Class对象
    Class<?> c = t.getClass();

    // 定义一个变量存储表名
    String tbName;

    // 判断表名是否与类名一致
    if (c.isAnnotationPresent(TableName.class)) {
      tbName = c.getAnnotation(TableName.class).name();
    } else {
      tbName = c.getSimpleName();
    }

    // 获取对象的名字添加到sql中
    sql.append(tbName);

    sql.append(" set ");

    // 获取t对象中的所有字段，存到Field数组中
    Field[] fields = c.getDeclaredFields();

    // 定义一个变量pkIndex存储主键下标
    int pkIndex = -1;

    // 创建一个Object数组
    Object[] obj = new Object[fields.length];

    // fields数组的字段名从第二个开始添加到sql语句中
    for (int i = 0, j = 0; i < fields.length; i++) {
      // 允许通过反射访问访问私有变量
      fields[i].setAccessible(true);

      // 判断主键所在的位置
      if (fields[i].isAnnotationPresent(PK.class)) {
        // 记录主键所在的下标
        pkIndex = i;

        // 将主键对应的值添加obj数组的最后一个位置
        obj[obj.length - 1] = fields[i].get(t);
      } else {
        // 获取字段的名字，并用append方法添加sql中
        sql.append(fields[i].getName());
        sql.append(" = ?,");

        // 向obj中添加t对象字段对应的值
        obj[j++] = fields[i].get(t);
      }
    }

    // 删除sql最后一个字符
    sql.deleteCharAt(sql.length() - 1);

    sql.append(" where ");

    // 将fields数组的主键名添加到sql语句中
    fields[pkIndex].setAccessible(true);
    sql.append(fields[pkIndex].getName());

    sql.append(" = ?");

    // 调用executeUpdate方法，并return其操作的数据行数
    return executeUpdate(sql.toString(), obj);
  }

  /**
   * 根据主键ID 查询当前T类型对应表中的一行数据
   *
   * @param
   * @return T类型对象 （使用的时候，只需要将主键的ID赋值就可以了）
   * @throws Exception
   */
  public T selectById(T t) throws Exception {
    // 获取T类型对象
    Class<?> c = t.getClass();

    // 表名
    String tableName = null;

    // 获取表名(如果使用@TableName(name=表名)，则以注释中的name作为表名，如果没有注解，则使用当前类名作为表名)
    if (c.isAnnotationPresent(TableName.class)) {
      tableName = c.getAnnotation(TableName.class).name();
    } else {
      tableName = c.getSimpleName();
    }

    // 存储Sql字符串
    StringBuilder sql = new StringBuilder();

    sql.append("select ");

    // 拼接查询的列名
    Field[] fields = c.getDeclaredFields();

    // 保存主键Field
    Field pkField = null;

    for (Field f : fields) {
      sql.append(f.getName()).append(",");

      // 获取主键
      if (f.isAnnotationPresent(PK.class)) {
        pkField = f;
      }
    }

    // 设置暴力访问
    pkField.setAccessible(true);

    // 删除最后一个字符
    sql.deleteCharAt(sql.length() - 1);

    sql.append(" from ").append(tableName).append(" where ");

    // where 查询 条件 为主键
    sql.append(pkField.getName()).append(" = ?");

    // 调用本类中的查询方法，将返回结果放在本类中的ResultSet rs对象中
    executeQuery(sql.toString(), pkField.get(t));

    // 读取查询结果
    while (rs.next()) {
      // 根据类型对象，创建该类型的对象（该类型必须包含无参数的构造方法）

      for (Field f : fields) {
        f.setAccessible(true);
        // 通过字段对象，给字段对应的对象赋值值
        // 根据数据类型来获取表中的值，赋值给对象中的字段（保证数据类型一致）
        setFieldValue(f, t);
      }

      break;
    }

    return t;
  }

  /**
   * 根据字段类型，取ResultSet中对应数据类型的值 并设置到对象的属性中
   *
   * @param f 字段对象
   * @param t 对象
   * @throws Exception
   */
  private void setFieldValue(Field f, Object t) throws Exception {
    if (f.getType().getName().equals(int.class.getName())) {
      f.set(t, rs.getInt(f.getName()));
    } else if (f.getType().getName().equals(String.class.getName())) {
      f.set(t, rs.getString(f.getName()));
    } else if (f.getType().getName().equals(double.class.getName())) {
      f.set(t, rs.getDouble(f.getName()));
    } else if (f.getType().getName().equals(Date.class.getName())) {
      // 日期类型：java.sql.date=>java.util.date
      // rs.getTimestamp(f.getName()) 获取的是java.sql.timestamp类型
      // java.sql.Date.getTime() 返回的是java.util.Date =>long类型
      // new Date(long)
      f.set(t, new Date(rs.getTimestamp(f.getName()).getTime()));
    }
    // 其它类型用到了再作补充
  }

  /**
   * 查询当前T类型对应表中的所有数据
   *
   * @param c 对象的类类型对象
   * @return T类型对象集合
   * @throws Exception
   */
  public List<T> selectAll(Class<T> c) throws Exception {
    // 定义T类型的集合
    List<T> lst = new ArrayList<T>();

    // 表名
    String tableName = null;

    // 获取表名(如果使用@TableName(name=表名)，则以注释中的name作为表名，如果没有注解，则使用当前类名作为表名)
    if (c.isAnnotationPresent(TableName.class)) {
      tableName = c.getAnnotation(TableName.class).name();
    } else {
      tableName = c.getSimpleName();
    }

    // 存储Sql字符串
    StringBuilder sql = new StringBuilder();

    sql.append("select ");

    // 拼接查询的列名
    Field[] fields = c.getDeclaredFields();
    for (Field f : fields) {
      sql.append(f.getName()).append(",");
    }

    // 删除最后一个字符
    sql.deleteCharAt(sql.length() - 1);

    sql.append(" from ").append(tableName);

    // 调用本类中的查询方法，将返回结果放在本类中的ResultSet rs对象中
    executeQuery(sql.toString());

    // 读取查询结果
    while (rs.next()) {
      // 根据类型对象，创建该类型的对象（该类型必须包含无参数的构造方法）
      T obj = c.newInstance();

      for (Field f : fields) {
        f.setAccessible(true);
        // 通过字段对象，给字段对应的对象赋值值
        // 根据数据类型来获取表中的值，赋值给对象中的字段（保证数据类型一致）
        setFieldValue(f, obj);
      }

      lst.add(obj);
    }

    return lst;
  }

  /**
   * 按SQL语句查询，返回T类型对象集合
   *
   * @param c
   * @return T类型对象集合
   * @throws Exception
   */
  public List<T> selectAll(Class<T> c, String sql, Object... objs) throws Exception {
    // 定义T类型的集合
    List<T> lst = new ArrayList<T>();

    // 拼接查询的列名
    Field[] fields = c.getDeclaredFields();

    // 执行查询
    executeQuery(sql, objs);

    // 读取查询结果
    while (rs.next()) {
      // 根据类型对象，创建该类型的对象（该类型必须包含无参数的构造方法）
      T obj = c.newInstance();

      for (Field f : fields) {
        f.setAccessible(true);
        // 通过字段对象，给字段对应的对象赋值值
        // 根据数据类型来获取表中的值，赋值给对象中的字段（保证数据类型一致）
        setFieldValue(f, obj);
      }

      lst.add(obj);
    }

    return lst;
  }

  /**
   * 获取分页查询SQL
   *
   * @param sql
   * @return
   */
  protected String getSqlPage(String sql, int pageSize, int pageIndex) {
    StringBuilder sb = new StringBuilder();

    sb.append("select * from (select rownum rn, s.* from ( ")
        .append(sql)
        .append(" ) s) t where t.rn between ")
        .append(pageSize * (pageIndex - 1) + 1)
        .append(" and ")
        .append(pageSize * pageIndex);

    return sb.toString();
  }

  /**
   * 传入一个类类型，根据类中的注解和字段得到sql语句
   *
   * @param c 类类型
   * @return String类型的字符串
   */
  public String getSql(Class<T> c) {

    // 表名
    String tableName = null;

    // 获取表名(如果使用@TableName(name=表名)，则以注释中的name作为表名，如果没有注解，则使用当前类名作为表名)
    if (c.isAnnotationPresent(TableName.class)) {
      tableName = c.getAnnotation(TableName.class).name();
    } else {
      tableName = c.getSimpleName();
    }

    // 存储Sql字符串
    StringBuilder sql = new StringBuilder();

    sql.append("select ");

    // 拼接查询的列名
    Field[] fields = c.getDeclaredFields();
    for (Field f : fields) {
      sql.append(f.getName()).append(",");
    }

    // 删除最后一个字符
    sql.deleteCharAt(sql.length() - 1);

    sql.append(" from ").append(tableName);

    return sql.toString();
  }

  /**
   * 按SQL语句分页查询,返回T类型对象集合
   *
   * @param c
   * @return T类型对象集合
   * @throws Exception
   */
  public void selectByPage(Class<T> c, String sql, PageList<T> pageList, Object... objs)
      throws Exception {
    // 定义T类型的集合
    List<T> lst = new ArrayList<T>();

    // 拼接查询的列名
    Field[] fields = c.getDeclaredFields();

    // 获取总数量
    pageList.setCount(
        Integer.valueOf(executeQueryObj("select count(1) from (" + sql + ")").toString()));

    // 调用本类中的查询方法，将返回结果放在本类中的ResultSet rs对象中
    executeQuery(getSqlPage(sql, pageList.getPageSize(), pageList.getPageIndex()), objs);

    // 读取查询结果
    while (rs.next()) {
      // 根据类型对象，创建该类型的对象（该类型必须包含无参数的构造方法）
      T obj = c.newInstance();

      for (Field f : fields) {
        f.setAccessible(true);
        // 通过字段对象，给字段对应的对象赋值值
        // 根据数据类型来获取表中的值，赋值给对象中的字段（保证数据类型一致）
        setFieldValue(f, obj);
      }

      lst.add(obj);
    }

    pageList.setData(lst);
  }

  /**
   * 返回查询结果中的第一行，第一列的结果
   *
   * @param sql
   * @param params
   * @return 对象（自己获取到了数据之后，根据实际情况再作转换）
   * @throws Exception
   */
  public Object executeQueryObj(String sql, Object... params) throws Exception {
    Object obj = null;

    try {
      this.executeQuery(sql, params);

      if (rs.next()) {
        obj = rs.getObject(1);
      }

    } catch (Exception e) {
      e.printStackTrace();
    } finally {
      close();
    }

    return obj;
  }

  /**
   * 获取序列号
   *
   * @param seqName
   * @return
   */
  public int getSequence(String seqName) {
    int obj = 0;

    try {
      this.executeQuery("select " + seqName + ".nextVal from dual");

      if (rs.next()) {
        obj = rs.getInt(1);
      }

    } catch (Exception e) {
      e.printStackTrace();
    } finally {
      close();
    }

    return obj;
  }
}
