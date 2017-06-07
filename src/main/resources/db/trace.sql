/*
Navicat MySQL Data Transfer

Source Server         : localhost
Source Server Version : 50520
Source Host           : localhost:3306
Source Database       : trace

Target Server Type    : MYSQL
Target Server Version : 50520
File Encoding         : 65001

Date: 2017-06-07 17:54:16
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for address
-- ----------------------------
DROP TABLE IF EXISTS `address`;
CREATE TABLE `address` (
  `address_id` varchar(50) NOT NULL,
  `member_id` varchar(50) DEFAULT NULL,
  `sheng` varchar(50) DEFAULT NULL,
  `shi` varchar(50) DEFAULT NULL,
  `qu` varchar(50) DEFAULT NULL,
  `address_detail` varchar(255) DEFAULT NULL,
  `zipcode` varchar(50) DEFAULT NULL,
  `phone` varchar(11) DEFAULT NULL,
  `status` varchar(1) DEFAULT NULL,
  PRIMARY KEY (`address_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of address
-- ----------------------------

-- ----------------------------
-- Table structure for banner
-- ----------------------------
DROP TABLE IF EXISTS `banner`;
CREATE TABLE `banner` (
  `banner_id` varchar(50) NOT NULL,
  `banner_path` varchar(255) DEFAULT NULL,
  `banner_url` varchar(255) DEFAULT NULL,
  `bannner_index` varchar(1) DEFAULT NULL,
  `createtime` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`banner_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of banner
-- ----------------------------

-- ----------------------------
-- Table structure for comment
-- ----------------------------
DROP TABLE IF EXISTS `comment`;
CREATE TABLE `comment` (
  `comment_id` varchar(50) NOT NULL,
  `goods_id` varchar(50) DEFAULT NULL,
  `order_id` varchar(50) DEFAULT NULL,
  `member_id` varchar(50) DEFAULT NULL,
  `content` varchar(1000) DEFAULT NULL,
  `file_path` varchar(255) DEFAULT NULL,
  `createtime` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`comment_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of comment
-- ----------------------------

-- ----------------------------
-- Table structure for dict
-- ----------------------------
DROP TABLE IF EXISTS `dict`;
CREATE TABLE `dict` (
  `dict_id` varchar(50) NOT NULL,
  `dict_name` varchar(100) DEFAULT NULL,
  `dict_type` varchar(5) DEFAULT NULL,
  `parentid` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`dict_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of dict
-- ----------------------------

-- ----------------------------
-- Table structure for farmer
-- ----------------------------
DROP TABLE IF EXISTS `farmer`;
CREATE TABLE `farmer` (
  `farmer_id` varchar(50) NOT NULL,
  `farmer_name` varchar(50) DEFAULT NULL,
  `farmer_phone` varchar(11) DEFAULT NULL,
  `video_id` varchar(200) DEFAULT NULL,
  `farmer_hzs` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`farmer_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of farmer
-- ----------------------------
INSERT INTO `farmer` VALUES ('53c84b1e-49fe-4012-a039-6788235070d6', 'w11', '15764222357', null, 'w');

-- ----------------------------
-- Table structure for goods
-- ----------------------------
DROP TABLE IF EXISTS `goods`;
CREATE TABLE `goods` (
  `goods_id` varchar(50) NOT NULL,
  `goods_name` varchar(50) DEFAULT NULL,
  `goods_type` varchar(10) DEFAULT NULL,
  `goods_description` varchar(255) DEFAULT NULL,
  `shop_id` varchar(50) DEFAULT NULL,
  `new_price` decimal(10,2) DEFAULT NULL,
  `old_price` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`goods_id`),
  KEY `idx_goods_type` (`goods_type`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of goods
-- ----------------------------

-- ----------------------------
-- Table structure for goods_pic
-- ----------------------------
DROP TABLE IF EXISTS `goods_pic`;
CREATE TABLE `goods_pic` (
  `pic_id` varchar(50) NOT NULL,
  `goods_id` varchar(50) DEFAULT NULL,
  `pic_path` varchar(255) DEFAULT NULL,
  `index` varchar(5) DEFAULT NULL,
  `createtime` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`pic_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of goods_pic
-- ----------------------------

-- ----------------------------
-- Table structure for member
-- ----------------------------
DROP TABLE IF EXISTS `member`;
CREATE TABLE `member` (
  `member` varchar(50) NOT NULL,
  `name` varchar(50) DEFAULT NULL,
  `phone` varchar(11) DEFAULT NULL,
  `mail` varchar(50) DEFAULT NULL,
  `type` varchar(1) DEFAULT NULL,
  `sex` varchar(1) DEFAULT NULL,
  `photo` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`member`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of member
-- ----------------------------

-- ----------------------------
-- Table structure for order
-- ----------------------------
DROP TABLE IF EXISTS `order`;
CREATE TABLE `order` (
  `order_id` varchar(50) NOT NULL,
  `member_id` varchar(50) DEFAULT NULL,
  `number` int(11) DEFAULT NULL,
  `goods_id` varchar(50) DEFAULT NULL,
  `createtime` varchar(20) DEFAULT NULL,
  `current_status` varchar(1) DEFAULT NULL COMMENT '当前状态  购物车 创建  交钱  收获  评价',
  PRIMARY KEY (`order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of order
-- ----------------------------

-- ----------------------------
-- Table structure for purchase
-- ----------------------------
DROP TABLE IF EXISTS `purchase`;
CREATE TABLE `purchase` (
  `purchase_id` varchar(50) NOT NULL,
  `purchase_name` varchar(50) DEFAULT NULL,
  `purchase_time` varchar(50) DEFAULT NULL,
  `purchase_num` double DEFAULT NULL,
  `purchase_video` varchar(200) DEFAULT NULL,
  `purchase_type` varchar(100) DEFAULT NULL,
  `purchase_parentid` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`purchase_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of purchase
-- ----------------------------
INSERT INTO `purchase` VALUES ('91b98e7f-3eeb-40a0-8d6d-13027b91d7be', '李明', '2017-06-03 21:15:15', '1', 'fc1a0fff-6400-48f6-90ff-c572e0e4a196', '1', null);

-- ----------------------------
-- Table structure for qrcode
-- ----------------------------
DROP TABLE IF EXISTS `qrcode`;
CREATE TABLE `qrcode` (
  `qrcode_id` varchar(50) NOT NULL,
  `qrcode_path` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`qrcode_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of qrcode
-- ----------------------------
INSERT INTO `qrcode` VALUES ('701450be-5303-4346-addf-06b7565f326f', '6e930d0f-5d96-4411-b011-b428e8990897.jpg');

-- ----------------------------
-- Table structure for role
-- ----------------------------
DROP TABLE IF EXISTS `role`;
CREATE TABLE `role` (
  `role_id` varchar(50) NOT NULL,
  `role_name` varchar(50) DEFAULT NULL,
  `role_description` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of role
-- ----------------------------

-- ----------------------------
-- Table structure for shop
-- ----------------------------
DROP TABLE IF EXISTS `shop`;
CREATE TABLE `shop` (
  `shop_id` varchar(50) NOT NULL,
  `member_id` int(11) DEFAULT NULL,
  `address` varchar(500) DEFAULT NULL,
  `coordinate` varchar(50) DEFAULT NULL,
  `createtime` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`shop_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of shop
-- ----------------------------

-- ----------------------------
-- Table structure for shop_goods
-- ----------------------------
DROP TABLE IF EXISTS `shop_goods`;
CREATE TABLE `shop_goods` (
  `shop_goods_id` varchar(50) NOT NULL,
  `shop_id` varchar(50) DEFAULT NULL,
  `goods_id` varchar(50) DEFAULT NULL,
  `goods_num` double DEFAULT NULL,
  `createtime` varchar(20) DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`shop_goods_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of shop_goods
-- ----------------------------

-- ----------------------------
-- Table structure for test
-- ----------------------------
DROP TABLE IF EXISTS `test`;
CREATE TABLE `test` (
  `test_id` varchar(50) NOT NULL,
  `test_time` varchar(50) DEFAULT NULL,
  `test_machine` varchar(50) DEFAULT NULL,
  `test_result` varchar(50) DEFAULT NULL,
  `test_influence` varchar(5000) DEFAULT NULL,
  `test_type` varchar(1) DEFAULT NULL COMMENT '0 是检验 1 是抽检',
  `test_name` varchar(50) DEFAULT NULL,
  `test_video` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`test_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of test
-- ----------------------------
INSERT INTO `test` VALUES ('7801d29c-4f21-4420-b052-3c23368ca7e0', '2017-06-03 23:42:14', '123', '1', '1', '1', '刘琦', '20170603233736.mp4');
INSERT INTO `test` VALUES ('bd546a7f-d99a-4985-8616-bae440196d34', '2017-06-03 21:15:17', '1', '1', '1', '0', '刘琦', '');

-- ----------------------------
-- Table structure for trace_flow
-- ----------------------------
DROP TABLE IF EXISTS `trace_flow`;
CREATE TABLE `trace_flow` (
  `trace_id` varchar(50) NOT NULL,
  `farmer_id` varchar(50) DEFAULT NULL COMMENT '农户id',
  `purchase_id` varchar(50) DEFAULT NULL COMMENT '采购id',
  `test_id` varchar(50) DEFAULT NULL COMMENT '检验id',
  `sampling_id` varchar(50) DEFAULT NULL COMMENT '抽检id',
  `transport_id` varchar(50) DEFAULT NULL COMMENT '运输id',
  `sale_id` varchar(50) DEFAULT NULL COMMENT '销售id',
  `trace_status` varchar(1) DEFAULT NULL COMMENT '追溯状态 0是未完成  1是完成',
  `qrcode` varchar(100) DEFAULT NULL COMMENT '二维码',
  `createtime` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`trace_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of trace_flow
-- ----------------------------
INSERT INTO `trace_flow` VALUES ('8c5b1fac-752d-4428-9b08-23291803a8c6', '53c84b1e-49fe-4012-a039-6788235070d6', '91b98e7f-3eeb-40a0-8d6d-13027b91d7be', 'bd546a7f-d99a-4985-8616-bae440196d34', '7801d29c-4f21-4420-b052-3c23368ca7e0', '59db3483-a8b7-41da-b524-aa0d02e65030', null, '6', '701450be-5303-4346-addf-06b7565f326f', '2017-06-03 22:04:59');

-- ----------------------------
-- Table structure for transport
-- ----------------------------
DROP TABLE IF EXISTS `transport`;
CREATE TABLE `transport` (
  `transport_id` varchar(50) NOT NULL,
  `transport_truck` varchar(50) DEFAULT NULL,
  `transport_user` varchar(50) DEFAULT NULL,
  `transport_destination` varchar(50) DEFAULT NULL,
  `transport_coordinate` varchar(100) DEFAULT NULL COMMENT '坐标',
  `transport_pic` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`transport_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of transport
-- ----------------------------
INSERT INTO `transport` VALUES ('59db3483-a8b7-41da-b524-aa0d02e65030', '1', '1', '1', null, '');

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `userid` varchar(50) NOT NULL,
  `password` varchar(50) DEFAULT NULL,
  `username` varchar(50) DEFAULT NULL,
  `usertype` varchar(1) DEFAULT NULL,
  `phone` varchar(11) DEFAULT NULL,
  PRIMARY KEY (`userid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES ('1', '670b14728ad9902aecba32e22fa4f6bd', 'admin', '0', null);
INSERT INTO `user` VALUES ('5967274e-9742-4db8-a440-0492113537a8', '670b14728ad9902aecba32e22fa4f6bd', '刘琦', '2', '');
INSERT INTO `user` VALUES ('f24a7977-32c9-46e2-8216-6ff235571a82', '670b14728ad9902aecba32e22fa4f6bd', '李明', '1', '15764234135');

-- ----------------------------
-- Table structure for user_role
-- ----------------------------
DROP TABLE IF EXISTS `user_role`;
CREATE TABLE `user_role` (
  `id` varchar(50) NOT NULL,
  `userid` varchar(50) NOT NULL,
  `roleid` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of user_role
-- ----------------------------

-- ----------------------------
-- Table structure for vegetables
-- ----------------------------
DROP TABLE IF EXISTS `vegetables`;
CREATE TABLE `vegetables` (
  `vegetables_id` varchar(50) NOT NULL,
  `vegetables_name` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`vegetables_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of vegetables
-- ----------------------------

-- ----------------------------
-- Table structure for video
-- ----------------------------
DROP TABLE IF EXISTS `video`;
CREATE TABLE `video` (
  `video_id` varchar(50) NOT NULL,
  `video_path` varchar(255) DEFAULT NULL,
  `createtime` varchar(50) DEFAULT NULL,
  `video_type` varchar(1) DEFAULT NULL COMMENT '0 是农户 1是检验过程中',
  `username` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`video_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of video
-- ----------------------------
INSERT INTO `video` VALUES ('fc1a0fff-6400-48f6-90ff-c572e0e4a196', '', '2017-06-03 22:04:59', '1', '');
