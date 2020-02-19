/*
 Navicat Premium Data Transfer

 Source Server         : localhost
 Source Server Type    : MySQL
 Source Server Version : 50527
 Source Host           : localhost:3306
 Source Schema         : bookstore

 Target Server Type    : MySQL
 Target Server Version : 50527
 File Encoding         : 65001

 Date: 19/02/2020 17:30:04
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for book
-- ----------------------------
DROP TABLE IF EXISTS `book`;
CREATE TABLE `book`  (
  `bid` char(32) CHARACTER SET gbk COLLATE gbk_chinese_ci NOT NULL,
  `bname` varchar(100) CHARACTER SET gbk COLLATE gbk_chinese_ci NULL DEFAULT NULL,
  `price` decimal(5, 1) NULL DEFAULT NULL,
  `author` varchar(20) CHARACTER SET gbk COLLATE gbk_chinese_ci NULL DEFAULT NULL,
  `image` varchar(200) CHARACTER SET gbk COLLATE gbk_chinese_ci NULL DEFAULT NULL,
  `cid` char(32) CHARACTER SET gbk COLLATE gbk_chinese_ci NULL DEFAULT NULL,
  `del` tinyint(1) NULL DEFAULT NULL,
  PRIMARY KEY (`bid`) USING BTREE,
  INDEX `cid`(`cid`) USING BTREE,
  CONSTRAINT `book_ibfk_1` FOREIGN KEY (`cid`) REFERENCES `category` (`cid`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = gbk COLLATE = gbk_chinese_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of book
-- ----------------------------
INSERT INTO `book` VALUES ('1', 'Java编程思想（第4版）', 75.6, 'qdmmy6', 'book_img/9317290-1_l.jpg', '1', 0);
INSERT INTO `book` VALUES ('10', '五年高考三年模拟', 100.0, '柳岩', 'book_img/11223344-5.jpg', '3', 0);
INSERT INTO `book` VALUES ('2', 'Java核心技术卷1', 68.5, 'qdmmy6', 'book_img/20285763-1_l.jpg', '1', 0);
INSERT INTO `book` VALUES ('3', 'Java就业培训教程', 39.9, '张孝祥', 'book_img/8758723-1_l.jpg', '1', 0);
INSERT INTO `book` VALUES ('4', 'Head First java', 47.5, '（美）塞若', 'book_img/9265169-1_l.jpg', '1', 0);
INSERT INTO `book` VALUES ('5', 'JavaWeb开发详解', 83.3, '孙鑫', 'book_img/22788412-1_l.jpg', '2', 0);
INSERT INTO `book` VALUES ('6', 'Struts2深入详解', 63.2, '孙鑫', 'book_img/20385925-1_l.jpg', '2', 0);
INSERT INTO `book` VALUES ('7', '精通Hibernate', 30.0, '孙卫琴', 'book_img/8991366-1_l.jpg', '2', 0);
INSERT INTO `book` VALUES ('8', '精通Spring2.x', 63.2, '陈华雄', 'book_img/20029394-1_l.jpg', '2', 0);
INSERT INTO `book` VALUES ('9', 'Javascript权威指南', 93.6, '（美）弗兰纳根', 'book_img/22722790-1_l.jpg', '3', 0);

-- ----------------------------
-- Table structure for category
-- ----------------------------
DROP TABLE IF EXISTS `category`;
CREATE TABLE `category`  (
  `cid` char(32) CHARACTER SET gbk COLLATE gbk_chinese_ci NOT NULL,
  `cname` varchar(100) CHARACTER SET gbk COLLATE gbk_chinese_ci NOT NULL,
  PRIMARY KEY (`cid`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = gbk COLLATE = gbk_chinese_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of category
-- ----------------------------
INSERT INTO `category` VALUES ('1', 'JavaSE');
INSERT INTO `category` VALUES ('2', 'JavaEE');
INSERT INTO `category` VALUES ('3', 'Javascript');
INSERT INTO `category` VALUES ('4', '三五模拟');
INSERT INTO `category` VALUES ('6B286A7573614804B6C7D4667F9BBA7C', 'JavaWeb');

-- ----------------------------
-- Table structure for orderitem
-- ----------------------------
DROP TABLE IF EXISTS `orderitem`;
CREATE TABLE `orderitem`  (
  `iid` char(32) CHARACTER SET gbk COLLATE gbk_chinese_ci NOT NULL,
  `count` int(11) NULL DEFAULT NULL,
  `subtotal` decimal(10, 2) NULL DEFAULT NULL,
  `oid` char(32) CHARACTER SET gbk COLLATE gbk_chinese_ci NULL DEFAULT NULL,
  `bid` char(32) CHARACTER SET gbk COLLATE gbk_chinese_ci NULL DEFAULT NULL,
  PRIMARY KEY (`iid`) USING BTREE,
  INDEX `oid`(`oid`) USING BTREE,
  INDEX `bid`(`bid`) USING BTREE,
  CONSTRAINT `orderitem_ibfk_1` FOREIGN KEY (`oid`) REFERENCES `orders` (`oid`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `orderitem_ibfk_2` FOREIGN KEY (`bid`) REFERENCES `book` (`bid`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = gbk COLLATE = gbk_chinese_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of orderitem
-- ----------------------------
INSERT INTO `orderitem` VALUES ('0877289ACE5D412E8EC25158B65DAB1B', 2, 151.20, '94180B7A9970478186B04D240E6E1548', '1');
INSERT INTO `orderitem` VALUES ('181773885DEA4548A111C3AB74EB6DEF', 3, 300.00, 'E25D91E8D3874656B8AD3AE3BE308BCA', '10');
INSERT INTO `orderitem` VALUES ('2BC52754256E4F71B4173A845E2C1FA4', 1, 83.30, '94180B7A9970478186B04D240E6E1548', '5');
INSERT INTO `orderitem` VALUES ('353A7BBD2A174AB196F14713830B5625', 1, 75.60, '0150076080F44518B9FB6560A0A42ABF', '1');
INSERT INTO `orderitem` VALUES ('63D5731F29564FFEAA7E407EF61C7770', 3, 189.60, '0150076080F44518B9FB6560A0A42ABF', '6');
INSERT INTO `orderitem` VALUES ('895C3A0DA0414587ACD2BF268984052E', 3, 249.90, 'EA2EEFB880274677979E7276412C3947', '5');
INSERT INTO `orderitem` VALUES ('9657B56F6BFE4B3C880D1C77102F88B9', 2, 200.00, '0150076080F44518B9FB6560A0A42ABF', '10');
INSERT INTO `orderitem` VALUES ('97F6F16267DE4E52A872C21FA0A9993F', 1, 100.00, '94180B7A9970478186B04D240E6E1548', '10');
INSERT INTO `orderitem` VALUES ('9A39630DDB4B4E8185F68F53BD821A72', 3, 226.80, 'B38FA4A38A9246488BA2AD5E46A2691E', '1');
INSERT INTO `orderitem` VALUES ('C01DE62F3DA64210AEF9064736C65361', 3, 226.80, 'B0CF29847EAB41CC84C31AFCE24FD22D', '1');
INSERT INTO `orderitem` VALUES ('C578D58E262549AC9F8BF1DAE765A02A', 3, 249.90, 'B0CF29847EAB41CC84C31AFCE24FD22D', '5');
INSERT INTO `orderitem` VALUES ('D0632E0C35944603A1468C5C3EEEFDF1', 1, 100.00, 'B38FA4A38A9246488BA2AD5E46A2691E', '10');
INSERT INTO `orderitem` VALUES ('E9CA8F1CB0F14CB2ABC0CF468FE7A564', 2, 151.20, 'EA2EEFB880274677979E7276412C3947', '1');
INSERT INTO `orderitem` VALUES ('EA13A095B67C4781A41E5EF831F0DBBD', 3, 249.90, 'B38FA4A38A9246488BA2AD5E46A2691E', '5');
INSERT INTO `orderitem` VALUES ('EA706D6A8A994036A1D81B160A2A0856', 1, 75.60, 'E25D91E8D3874656B8AD3AE3BE308BCA', '1');
INSERT INTO `orderitem` VALUES ('EB3D9B11001044588609887D4D1DE072', 1, 100.00, '6343D396E6CE4FE0872825D5000AEFC5', '10');
INSERT INTO `orderitem` VALUES ('FE41EE75A53D4AEDB3F3E8F56BC7E203', 2, 151.20, '6343D396E6CE4FE0872825D5000AEFC5', '1');

-- ----------------------------
-- Table structure for orders
-- ----------------------------
DROP TABLE IF EXISTS `orders`;
CREATE TABLE `orders`  (
  `oid` char(32) CHARACTER SET gbk COLLATE gbk_chinese_ci NOT NULL,
  `ordertime` datetime NULL DEFAULT NULL,
  `total` decimal(10, 2) NULL DEFAULT NULL,
  `state` smallint(1) NULL DEFAULT NULL,
  `uid` char(32) CHARACTER SET gbk COLLATE gbk_chinese_ci NULL DEFAULT NULL,
  `address` varchar(200) CHARACTER SET gbk COLLATE gbk_chinese_ci NULL DEFAULT NULL,
  PRIMARY KEY (`oid`) USING BTREE,
  INDEX `uid`(`uid`) USING BTREE,
  CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`uid`) REFERENCES `tb_user` (`uid`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = gbk COLLATE = gbk_chinese_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of orders
-- ----------------------------
INSERT INTO `orders` VALUES ('0150076080F44518B9FB6560A0A42ABF', '2020-02-12 19:46:10', 465.20, 4, '23E5690F52DE4FF9A33D2064C46E96E0', NULL);
INSERT INTO `orders` VALUES ('6343D396E6CE4FE0872825D5000AEFC5', '2020-02-13 12:10:50', 251.20, 4, '23E5690F52DE4FF9A33D2064C46E96E0', NULL);
INSERT INTO `orders` VALUES ('94180B7A9970478186B04D240E6E1548', '2020-02-13 12:11:01', 334.50, 4, '23E5690F52DE4FF9A33D2064C46E96E0', NULL);
INSERT INTO `orders` VALUES ('B0CF29847EAB41CC84C31AFCE24FD22D', '2020-02-12 20:01:17', 476.70, 4, '23E5690F52DE4FF9A33D2064C46E96E0', NULL);
INSERT INTO `orders` VALUES ('B38FA4A38A9246488BA2AD5E46A2691E', '2020-02-12 20:02:29', 576.70, 4, '23E5690F52DE4FF9A33D2064C46E96E0', NULL);
INSERT INTO `orders` VALUES ('E25D91E8D3874656B8AD3AE3BE308BCA', '2020-02-12 19:57:02', 375.60, 4, '23E5690F52DE4FF9A33D2064C46E96E0', NULL);
INSERT INTO `orders` VALUES ('EA2EEFB880274677979E7276412C3947', '2020-02-12 19:57:49', 401.10, 2, '23E5690F52DE4FF9A33D2064C46E96E0', NULL);

-- ----------------------------
-- Table structure for tb_user
-- ----------------------------
DROP TABLE IF EXISTS `tb_user`;
CREATE TABLE `tb_user`  (
  `uid` char(32) CHARACTER SET gbk COLLATE gbk_chinese_ci NOT NULL,
  `username` varchar(50) CHARACTER SET gbk COLLATE gbk_chinese_ci NOT NULL,
  `password` varchar(50) CHARACTER SET gbk COLLATE gbk_chinese_ci NOT NULL,
  `email` varchar(50) CHARACTER SET gbk COLLATE gbk_chinese_ci NOT NULL,
  `code` char(64) CHARACTER SET gbk COLLATE gbk_chinese_ci NOT NULL,
  `state` tinyint(1) NULL DEFAULT NULL,
  PRIMARY KEY (`uid`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = gbk COLLATE = gbk_chinese_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of tb_user
-- ----------------------------
INSERT INTO `tb_user` VALUES ('23E5690F52DE4FF9A33D2064C46E96E0', 'liuyouquan', '865437', '1656389800@qq.com', '10351344AAFF401B937F65CCEBC7B43C17D18707630B4BEDA06F25597BFCD4BD', 1);
INSERT INTO `tb_user` VALUES ('AFDFDF5F88FA406AA2BCA2513309A75D', 'zhangsan', '865437', '926471395@qq.com', '959F9C5C940E4EC68CBB4F0567B1FD01EED3B83BEAA643C7AF71756829EB98DB', 1);

SET FOREIGN_KEY_CHECKS = 1;
