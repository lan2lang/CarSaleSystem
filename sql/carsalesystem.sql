/*
 Navicat Premium Data Transfer

 Source Server         : 本地
 Source Server Type    : MySQL
 Source Server Version : 80030 (8.0.30)
 Source Host           : localhost:3306
 Source Schema         : carsalesystem

 Target Server Type    : MySQL
 Target Server Version : 80030 (8.0.30)
 File Encoding         : 65001

 Date: 14/12/2023 20:50:54
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for car
-- ----------------------------
DROP TABLE IF EXISTS `car`;
CREATE TABLE `car`  (
  `carId` int NOT NULL AUTO_INCREMENT,
  `brand` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `model` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `count` int NULL DEFAULT NULL,
  `price` int NULL DEFAULT NULL,
  `pic` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  PRIMARY KEY (`carId`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 12 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of car
-- ----------------------------
INSERT INTO `car` VALUES (1, '比亚迪', '王朝2023年冠军版', 20, 20, '/upload/bydwangchaoplus.jpg');
INSERT INTO `car` VALUES (2, '比亚迪', '海豹', 40, 10, '/upload/bydhaibao.jpg');
INSERT INTO `car` VALUES (3, '保时捷', '991', 10, 85, 'upload\\bydhaibao.jpg');
INSERT INTO `car` VALUES (4, '保时捷', '991', 10, 85, 'upload\\bydwangchaoplus.jpg');
INSERT INTO `car` VALUES (5, '奥迪', 'a7', 20, 65, 'upload\\aodia7.jpg');
INSERT INTO `car` VALUES (6, '奥迪', 's7', 10, 105, 'upload\\aodis7.jpg');
INSERT INTO `car` VALUES (7, '宝马', 'X5', 30, 75, 'upload\\baomax5.webp');
INSERT INTO `car` VALUES (8, '宝马', 'X6', 25, 80, 'upload\\baomax5.webp');
INSERT INTO `car` VALUES (9, '长安', 'uni', 50, 35, 'upload\\changan-uni.png');
INSERT INTO `car` VALUES (10, '大众', 'GTD', 10, 100, 'upload\\dazhong-gtd.jpg');
INSERT INTO `car` VALUES (11, '马自达', 'new', 20, 45, 'upload\\mazida-new.jpg');

-- ----------------------------
-- Table structure for client
-- ----------------------------
DROP TABLE IF EXISTS `client`;
CREATE TABLE `client`  (
  `clientId` int NOT NULL AUTO_INCREMENT,
  `clientNo` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `clientName` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `sex` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `phone` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `staffId` int NULL DEFAULT NULL,
  PRIMARY KEY (`clientId`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of client
-- ----------------------------
INSERT INTO `client` VALUES (1, '000001', '李富', '123456', '男', '77712341234', 2);
INSERT INTO `client` VALUES (2, 'ccc', 'ccc1', '123456', '男', '11177778888', 2);
INSERT INTO `client` VALUES (3, 'aaa', 'aaa1', '123456', '男', '22233334444', 2);
INSERT INTO `client` VALUES (4, 'orando', '张三', '1234', '男', '13260166090', 3);
INSERT INTO `client` VALUES (5, 'client1', '客户1', '1234', '男', '18978882321', 2);
INSERT INTO `client` VALUES (6, 'client2', '客户2', '1234', '男', '18977778888', 4);

-- ----------------------------
-- Table structure for order
-- ----------------------------
DROP TABLE IF EXISTS `order`;
CREATE TABLE `order`  (
  `orderId` int NOT NULL AUTO_INCREMENT,
  `status` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `desc` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `clientId` int NULL DEFAULT NULL,
  `carId` int NULL DEFAULT NULL,
  `orderTime` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`orderId`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of order
-- ----------------------------
INSERT INTO `order` VALUES (2, '已取消', '客户：李富;\n店员：zhangsan;\n车辆：比亚迪 王朝2023年冠军版', 1, 1, '2023-12-14 15:41:07');
INSERT INTO `order` VALUES (3, '已取消', '客户：李富;\n店员：zhangsan;\n车辆：比亚迪 王朝2023年冠军版', 1, 1, '2023-12-14 16:01:09');
INSERT INTO `order` VALUES (4, '待确认', '客户：李富;\n店员：zhangsan;\n车辆：比亚迪 王朝2023年冠军版', 1, 1, '2023-12-14 16:01:13');
INSERT INTO `order` VALUES (5, '待确认', '客户：李富;\n店员：zhangsan;\n车辆：比亚迪 海豹', 1, 2, '2023-12-14 16:01:19');
INSERT INTO `order` VALUES (6, '待确认', '客户：客户1;\n店员：zhangsan;\n车辆：保时捷 991', 5, 3, '2023-12-14 18:41:41');

-- ----------------------------
-- Table structure for staff
-- ----------------------------
DROP TABLE IF EXISTS `staff`;
CREATE TABLE `staff`  (
  `staffId` int NOT NULL AUTO_INCREMENT,
  `staffNo` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `staffName` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `sex` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `phone` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  PRIMARY KEY (`staffId`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of staff
-- ----------------------------
INSERT INTO `staff` VALUES (1, 'admin', 'admin', 'admin123', '男', '11144445555');
INSERT INTO `staff` VALUES (2, '000001', 'zhangsan', '123456', '女', '12355556666');
INSERT INTO `staff` VALUES (3, '000002', 'lisi', '123456', '女', '12344445555');
INSERT INTO `staff` VALUES (4, 'staff1', '店员1', '1234', '男', '12344445555');
INSERT INTO `staff` VALUES (5, 'staff5', '员工5', '1234', '男', '18121353620');

SET FOREIGN_KEY_CHECKS = 1;
