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

 Date: 20/12/2023 15:22:46
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
) ENGINE = InnoDB AUTO_INCREMENT = 21 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of car
-- ----------------------------
INSERT INTO `car` VALUES (13, '奥迪', 'a7', 10, 41, 'upload\\奥迪-a7.jpg');
INSERT INTO `car` VALUES (14, '大众', 'GTD', 20, 34, 'upload\\大众-GTD.jpg');
INSERT INTO `car` VALUES (15, '奥迪', 's7', 5, 103, 'upload\\奥迪-s7.jpg');
INSERT INTO `car` VALUES (16, '宝马', 'x5', 10, 59, 'upload\\宝马-x5.webp');
INSERT INTO `car` VALUES (17, '比亚迪', '海豹', 20, 18, 'upload\\比亚迪-海豹.jpg');
INSERT INTO `car` VALUES (18, '比亚迪', '王朝plus', 15, 22, 'upload\\比亚迪-王朝plus.jpg');
INSERT INTO `car` VALUES (19, '马自达', '新款', 100, 45, 'upload\\马自达-新款.jpg');
INSERT INTO `car` VALUES (20, '长安', 'uni', 2, 25, 'upload\\长安-uni.png');

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
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of order
-- ----------------------------
INSERT INTO `order` VALUES (7, '已完成', '客户：客户1;\n店员：zhangsan;\n车辆：奥迪 s7', 5, 15, '2023-12-20 15:22:11');

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
