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

 Date: 13/12/2023 20:32:27
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
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of car
-- ----------------------------
INSERT INTO `car` VALUES (1, '宝马', 'x5', 80, 55, 'upload\\48063.jpg');
INSERT INTO `car` VALUES (2, '保时捷', '991', 10, 85, 'upload\\48063.jpg');

-- ----------------------------
-- Table structure for client
-- ----------------------------
DROP TABLE IF EXISTS `client`;
CREATE TABLE `client`  (
  `clientId` int NOT NULL AUTO_INCREMENT,
  `clientNo` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `clientName` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `sex` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `phone` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `staffId` int NULL DEFAULT NULL,
  PRIMARY KEY (`clientId`) USING BTREE,
  UNIQUE INDEX `client_pk`(`clientNo` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of client
-- ----------------------------
INSERT INTO `client` VALUES (1, '000001', '李富', '123456', '男', '77712341234', 2);
INSERT INTO `client` VALUES (3, '000002', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `client` VALUES (6, 'asd', 'qwe', '1234', '女', '18652744755', 2);

-- ----------------------------
-- Table structure for order
-- ----------------------------
DROP TABLE IF EXISTS `order`;
CREATE TABLE `order`  (
  `     orderId` int NOT NULL AUTO_INCREMENT,
  `status` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `desc` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `clientId` int NULL DEFAULT NULL,
  `carId` int NULL DEFAULT NULL,
  `orderTime` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`     orderId`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of order
-- ----------------------------
INSERT INTO `order` VALUES (1, '待确认', NULL, 1, 1, '2023-12-13 20:26:08');
INSERT INTO `order` VALUES (2, NULL, NULL, 1, 2, NULL);
INSERT INTO `order` VALUES (3, NULL, NULL, NULL, 2, '2023-12-13 20:25:38');
INSERT INTO `order` VALUES (4, '待确认', 'dasd', 1, 1, NULL);
INSERT INTO `order` VALUES (5, '待确认', 'dassdd', 1, 1, '2023-12-13 20:27:44');
INSERT INTO `order` VALUES (6, '待确认', 'sit culpa', 1, 1, '2023-12-13 20:30:15');

-- ----------------------------
-- Table structure for staff
-- ----------------------------
DROP TABLE IF EXISTS `staff`;
CREATE TABLE `staff`  (
  `staffId` int NOT NULL AUTO_INCREMENT,
  `staffNo` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `staffName` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `sex` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `phone` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  PRIMARY KEY (`staffId`) USING BTREE,
  UNIQUE INDEX `staffNo`(`staffNo` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of staff
-- ----------------------------
INSERT INTO `staff` VALUES (1, '111111', 'admin', 'admin123', '男', '11144445555');
INSERT INTO `staff` VALUES (2, '000001', 'zhangsan', '123456', '女', '12355556666');
INSERT INTO `staff` VALUES (3, '000002', 'lisi', '123456', '女', '12344445555');
INSERT INTO `staff` VALUES (4, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `staff` VALUES (5, 'staff3', '转工院才品', '1234', '男', '18186522568');
INSERT INTO `staff` VALUES (7, 'staff4', '市高业业东', '1234', '男', '18121353620');

SET FOREIGN_KEY_CHECKS = 1;
