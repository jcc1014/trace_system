/*
Navicat MySQL Data Transfer

Source Server         : localhost
Source Server Version : 50022
Source Host           : 127.0.0.1:3306
Source Database       : trace

Target Server Type    : MYSQL
Target Server Version : 50022
File Encoding         : 65001

Date: 2017-06-21 11:27:03
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for address
-- ----------------------------
DROP TABLE IF EXISTS `address`;
CREATE TABLE `address` (
  `address_id` varchar(50) NOT NULL,
  `member_id` varchar(50) default NULL,
  `sheng` varchar(50) default NULL,
  `shi` varchar(50) default NULL,
  `qu` varchar(50) default NULL,
  `address_detail` varchar(255) default NULL,
  `zipcode` varchar(50) default NULL,
  `phone` varchar(11) default NULL,
  `status` varchar(1) default '0',
  `name` varchar(50) default NULL,
  PRIMARY KEY  (`address_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of address
-- ----------------------------
INSERT INTO `address` VALUES ('1', '94eb1473-7931-430f-b27d-eb9675e188af', '山东省', '济南市', '历下区', '泉城路169号', '25001', '18866860838', '1', '小明');
INSERT INTO `address` VALUES ('2', '94eb1473-7931-430f-b27d-eb9675e188af', '山东省', '济南市', '历下区', '科院路19号', '25002', '18866860838', '0', '小花');

-- ----------------------------
-- Table structure for banner
-- ----------------------------
DROP TABLE IF EXISTS `banner`;
CREATE TABLE `banner` (
  `banner_id` varchar(50) NOT NULL,
  `banner_title` varchar(255) default NULL,
  `banner_path` varchar(255) default NULL,
  `banner_url` varchar(255) default NULL,
  `banner_index` varchar(1) default NULL,
  `banner_type` varchar(1) default NULL,
  `createtime` varchar(20) default NULL,
  PRIMARY KEY  (`banner_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of banner
-- ----------------------------
INSERT INTO `banner` VALUES ('bb6298ed-d021-4d7f-a85b-7e8f94839fcb', '图片2', '20170617000302.jpg', 'www.hao123.com', '2', '1', '2017-06-17 00:03:12');
INSERT INTO `banner` VALUES ('c9535e88-23bd-482c-abe6-6e29029e5478', '轮播图1', '20170617000214.jpg', 'www.baidu.com', '1', '1', '2017-06-17 00:02:17');

-- ----------------------------
-- Table structure for comment
-- ----------------------------
DROP TABLE IF EXISTS `comment`;
CREATE TABLE `comment` (
  `comment_id` varchar(50) NOT NULL,
  `goods_id` varchar(50) default NULL,
  `order_id` varchar(50) default NULL,
  `member_id` varchar(50) default NULL,
  `content` varchar(1000) default NULL,
  `file_path` varchar(255) default NULL,
  `createtime` varchar(20) default NULL,
  PRIMARY KEY  (`comment_id`)
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
  `dict_name` varchar(100) default NULL,
  `dict_type` varchar(20) default NULL,
  `parentid` varchar(50) default NULL,
  `dict_index` varchar(10) default NULL,
  PRIMARY KEY  (`dict_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of dict
-- ----------------------------
INSERT INTO `dict` VALUES ('1', '蔬菜', 'vegetable', '0', '1');
INSERT INTO `dict` VALUES ('2', '肉类', 'meat', '0', '2');
INSERT INTO `dict` VALUES ('854efd95-3c17-4ade-b310-6f9f9f2f2bef', '调料', 'seasoning', '0', '3');

-- ----------------------------
-- Table structure for farmer
-- ----------------------------
DROP TABLE IF EXISTS `farmer`;
CREATE TABLE `farmer` (
  `farmer_id` varchar(50) NOT NULL,
  `farmer_name` varchar(50) default NULL,
  `farmer_phone` varchar(11) default NULL,
  `video_id` varchar(200) default NULL,
  `farmer_hzs` varchar(100) default NULL,
  PRIMARY KEY  (`farmer_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of farmer
-- ----------------------------
INSERT INTO `farmer` VALUES ('30d9ed52-418f-4ce3-91e3-e9f37b28ab2d', '老咯', '15764222357', null, '对对对');
INSERT INTO `farmer` VALUES ('53c84b1e-49fe-4012-a039-6788235070d6', 'w11', '15764222357', null, 'w');

-- ----------------------------
-- Table structure for goods
-- ----------------------------
DROP TABLE IF EXISTS `goods`;
CREATE TABLE `goods` (
  `goods_id` varchar(50) NOT NULL,
  `goods_name` varchar(50) default NULL,
  `goods_type` varchar(50) default NULL,
  `goods_description` varchar(255) default NULL,
  `shop_id` varchar(50) default NULL,
  `new_price` decimal(10,2) default NULL,
  `old_price` decimal(10,2) default NULL,
  `create_time` timestamp NULL default CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY  (`goods_id`),
  KEY `idx_goods_type` (`goods_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of goods
-- ----------------------------
INSERT INTO `goods` VALUES ('1c8fc856-f1f8-4144-a633-ed414fe0e888', '西红柿', '1', '西红柿', null, '6.00', '6.50', null);
INSERT INTO `goods` VALUES ('bd6a775c-7fb6-46c1-ade0-0afdac543a77', '胡萝卜', '1', '胡萝卜', null, '5.00', '6.00', null);
INSERT INTO `goods` VALUES ('e8e9dc25-4cbd-4cd5-bfd5-4f6099e13477', '樱桃', '1', '樱桃', null, '10.00', '12.00', null);

-- ----------------------------
-- Table structure for goods_order
-- ----------------------------
DROP TABLE IF EXISTS `goods_order`;
CREATE TABLE `goods_order` (
  `order_id` varchar(50) NOT NULL,
  `member_id` varchar(50) default NULL,
  `number` double(11,0) default NULL,
  `goods_id` varchar(50) default NULL,
  `createtime` varchar(20) default NULL,
  `current_status` varchar(1) default NULL COMMENT '当前状态  0购物车 1未完成 2预付款  3实结',
  `price` double default NULL,
  `real_amount` double default NULL,
  `amount` double default NULL,
  `sub_amount` double default NULL,
  `rebate` double default '10',
  `address_id` varchar(50) default NULL,
  PRIMARY KEY  (`order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of goods_order
-- ----------------------------
INSERT INTO `goods_order` VALUES ('2842e3eb-a1b7-451f-a344-4f0a7116462b', '94eb1473-7931-430f-b27d-eb9675e188af', '2', '1c8fc856-f1f8-4144-a633-ed414fe0e888', '2017-06-20 00:08:04', '0', '6', '0', '12', '0', '0', null);
INSERT INTO `goods_order` VALUES ('720eebd4-fe10-498b-8c6a-c695482d5b41', '94eb1473-7931-430f-b27d-eb9675e188af', '2', 'bd6a775c-7fb6-46c1-ade0-0afdac543a77', '2017-06-20 00:08:12', '0', '5', '0', '10', '0', '0', null);

-- ----------------------------
-- Table structure for goods_pic
-- ----------------------------
DROP TABLE IF EXISTS `goods_pic`;
CREATE TABLE `goods_pic` (
  `pic_id` varchar(50) NOT NULL,
  `goods_id` varchar(50) default NULL,
  `pic_path` varchar(255) default NULL,
  `real_path` varchar(500) default NULL,
  `pic_index` varchar(5) default NULL,
  `create_time` varchar(20) default NULL,
  PRIMARY KEY  (`pic_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of goods_pic
-- ----------------------------
INSERT INTO `goods_pic` VALUES ('0690ce4c-099e-4fe5-9f6b-50ba203881d4', 'e8e9dc25-4cbd-4cd5-bfd5-4f6099e13477', '/trace_system/uploadPic/201706200007453036.jpg', 'C:\\JavaWorkspace\\workspace2\\.metadata\\.plugins\\org.eclipse.wst.server.core\\tmp0\\wtpwebapps\\trace_system\\uploadPic\\201706200007453036.jpg', '0', '2017-06-20 00:07:47');
INSERT INTO `goods_pic` VALUES ('18934bd9-e8ad-4d96-8a38-8a3c574e60b5', '9d80a7dc-5888-4c08-bc27-0a7052d3e2bc', '/trace_system/uploadPic/201706162353531800.jpg', 'C:\\JavaWorkspace\\workspace2\\.metadata\\.plugins\\org.eclipse.wst.server.core\\tmp0\\wtpwebapps\\trace_system\\uploadPic\\201706162353531800.jpg', '0', '2017-06-16 23:54:04');
INSERT INTO `goods_pic` VALUES ('28cc1379-1c2e-412b-bcd4-26850dbc2258', 'bf4ed179-1d06-4172-ab72-897256e63029', '/trace_system/uploadPic/201706171901455568.jpg', 'C:\\JavaWorkspace\\workspace2\\.metadata\\.plugins\\org.eclipse.wst.server.core\\tmp0\\wtpwebapps\\trace_system\\uploadPic\\201706171901455568.jpg', '0', '2017-06-17 19:01:47');
INSERT INTO `goods_pic` VALUES ('325f37ad-c77c-4f0f-9a97-8e119991f96b', '62392e82-ba5f-4691-aab4-4ab7c1824539', '/trace_system/uploadPic/201706170054268596.jpg', 'C:\\JavaWorkspace\\workspace2\\.metadata\\.plugins\\org.eclipse.wst.server.core\\tmp0\\wtpwebapps\\trace_system\\uploadPic\\201706170054268596.jpg', '0', '2017-06-17 00:54:28');
INSERT INTO `goods_pic` VALUES ('acd47a42-c036-488d-863c-8b1923f5501c', '434be0da-85f2-4d3f-ad8e-1016a0daf719', '/trace_system/uploadPic/20170617000020831.jpg', 'C:\\JavaWorkspace\\workspace2\\.metadata\\.plugins\\org.eclipse.wst.server.core\\tmp0\\wtpwebapps\\trace_system\\uploadPic\\20170617000020831.jpg', '0', '2017-06-17 00:00:33');
INSERT INTO `goods_pic` VALUES ('e8f4282c-bcd5-4af8-b820-56b133d0044c', 'bd6a775c-7fb6-46c1-ade0-0afdac543a77', '/trace_system/uploadPic/20170620000716511.jpg', 'C:\\JavaWorkspace\\workspace2\\.metadata\\.plugins\\org.eclipse.wst.server.core\\tmp0\\wtpwebapps\\trace_system\\uploadPic\\20170620000716511.jpg', '0', '2017-06-20 00:07:24');
INSERT INTO `goods_pic` VALUES ('fc02b7a5-5733-42d3-ba78-05574d8c892e', '1c8fc856-f1f8-4144-a633-ed414fe0e888', '/trace_system/uploadPic/201706200006557291.jpg', 'C:\\JavaWorkspace\\workspace2\\.metadata\\.plugins\\org.eclipse.wst.server.core\\tmp0\\wtpwebapps\\trace_system\\uploadPic\\201706200006557291.jpg', '0', '2017-06-20 00:06:56');

-- ----------------------------
-- Table structure for member
-- ----------------------------
DROP TABLE IF EXISTS `member`;
CREATE TABLE `member` (
  `member` varchar(50) NOT NULL,
  `name` varchar(50) default NULL,
  `phone` varchar(11) default NULL,
  `mail` varchar(50) default NULL,
  `type` varchar(1) default NULL,
  `sex` varchar(1) default NULL,
  `photo` varchar(255) default NULL,
  PRIMARY KEY  (`member`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of member
-- ----------------------------
INSERT INTO `member` VALUES ('1', '尚景', '1886680838', '1416119268@qq.com', '1', '1', '');
INSERT INTO `member` VALUES ('94eb1473-7931-430f-b27d-eb9675e188af', null, '15764222357', null, '4', null, null);

-- ----------------------------
-- Table structure for purchase
-- ----------------------------
DROP TABLE IF EXISTS `purchase`;
CREATE TABLE `purchase` (
  `purchase_id` varchar(50) NOT NULL,
  `purchase_name` varchar(50) default NULL,
  `purchase_time` varchar(50) default NULL,
  `purchase_num` double default NULL,
  `purchase_video` varchar(200) default NULL,
  `purchase_type` varchar(100) default NULL,
  `purchase_parentid` varchar(50) default NULL,
  PRIMARY KEY  (`purchase_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of purchase
-- ----------------------------
INSERT INTO `purchase` VALUES ('46a687b4-587b-4f77-a1cb-5ec37e221c40', '李明', '2017-06-09 19:51:44', '11', '07e9cf04-5e0d-41ae-b5ef-b7fb31e3d713', '改改', null);
INSERT INTO `purchase` VALUES ('91b98e7f-3eeb-40a0-8d6d-13027b91d7be', '李明', '2017-06-03 21:15:15', '1', 'fc1a0fff-6400-48f6-90ff-c572e0e4a196', '1', null);

-- ----------------------------
-- Table structure for qrcode
-- ----------------------------
DROP TABLE IF EXISTS `qrcode`;
CREATE TABLE `qrcode` (
  `qrcode_id` varchar(50) NOT NULL,
  `qrcode_path` varchar(100) default NULL,
  PRIMARY KEY  (`qrcode_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of qrcode
-- ----------------------------
INSERT INTO `qrcode` VALUES ('701450be-5303-4346-addf-06b7565f326f', '6e930d0f-5d96-4411-b011-b428e8990897.jpg');
INSERT INTO `qrcode` VALUES ('da3cb544-4fe8-4dcf-a2e5-a12bd3f81768', 'd7438e13-cf8d-4ff1-aef2-0dc104deac9a.jpg');

-- ----------------------------
-- Table structure for role
-- ----------------------------
DROP TABLE IF EXISTS `role`;
CREATE TABLE `role` (
  `role_id` varchar(50) NOT NULL,
  `role_name` varchar(50) default NULL,
  `role_description` varchar(255) default NULL,
  PRIMARY KEY  (`role_id`)
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
  `member_id` varchar(50) default NULL,
  `address` varchar(500) default NULL,
  `coordinate` varchar(50) default NULL,
  `createtime` varchar(50) default NULL,
  `shop_name` varchar(50) default NULL,
  `shop_order` int(11) default NULL,
  `shop_phone` varchar(11) default NULL,
  PRIMARY KEY  (`shop_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of shop
-- ----------------------------
INSERT INTO `shop` VALUES ('932229c8-c6ff-4c01-98ca-401d0f267aaf', '8fa8bc32-152c-4b7b-83e7-cf68ae66e522', '山东省济南市历下区科院路19号', '117.051729;36.649665', '2017-06-21 10:56:22', 'jjj', '0', '15764222357');
INSERT INTO `shop` VALUES ('c5c803d8-990f-4b2c-94ac-97a8948ae55e', '1', '山东省济南市历下区泉城路169号', '36.66553292519261;117.01756606637083', '2017-06-16 21:50:28', '尚景', null, '18866860838');

-- ----------------------------
-- Table structure for shop_goods
-- ----------------------------
DROP TABLE IF EXISTS `shop_goods`;
CREATE TABLE `shop_goods` (
  `shop_goods_id` varchar(50) NOT NULL,
  `shop_id` varchar(50) default NULL,
  `goods_id` varchar(50) default NULL,
  `goods_num` double default NULL,
  `createtime` varchar(20) default NULL COMMENT '创建时间',
  `goods_name` varchar(50) default NULL,
  `shop_name` varchar(50) default NULL,
  `goods_remain` double default NULL,
  PRIMARY KEY  (`shop_goods_id`)
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
  `test_time` varchar(50) default NULL,
  `test_machine` varchar(50) default NULL,
  `test_result` varchar(50) default NULL,
  `test_influence` varchar(5000) default NULL,
  `test_type` varchar(1) default NULL COMMENT '0 是检验 1 是抽检',
  `test_name` varchar(50) default NULL,
  `test_video` varchar(255) default NULL,
  PRIMARY KEY  (`test_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of test
-- ----------------------------
INSERT INTO `test` VALUES ('5ed4a59f-c1c2-47df-9c34-0772da24b31e', '', '', '', '', '1', '', '');
INSERT INTO `test` VALUES ('7801d29c-4f21-4420-b052-3c23368ca7e0', '2017-06-03 23:42:14', '123', '1', '1', '1', '刘琦', '20170603233736.mp4');
INSERT INTO `test` VALUES ('b6708616-bc07-43e6-be40-8511659e47e8', '2017-06-09 19:51:53', '11', '11', '11', '0', '刘琦', '');
INSERT INTO `test` VALUES ('bd546a7f-d99a-4985-8616-bae440196d34', '2017-06-03 21:15:17', '1', '1', '1', '0', '刘琦', '');

-- ----------------------------
-- Table structure for trace_flow
-- ----------------------------
DROP TABLE IF EXISTS `trace_flow`;
CREATE TABLE `trace_flow` (
  `trace_id` varchar(50) NOT NULL,
  `farmer_id` varchar(50) default NULL COMMENT '农户id',
  `purchase_id` varchar(50) default NULL COMMENT '采购id',
  `test_id` varchar(50) default NULL COMMENT '检验id',
  `sampling_id` varchar(50) default NULL COMMENT '抽检id',
  `transport_id` varchar(50) default NULL COMMENT '运输id',
  `sale_id` varchar(50) default NULL COMMENT '销售id',
  `trace_status` varchar(1) default NULL COMMENT '追溯状态 0是未完成  1是完成',
  `qrcode` varchar(100) default NULL COMMENT '二维码',
  `createtime` varchar(20) default NULL,
  PRIMARY KEY  (`trace_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of trace_flow
-- ----------------------------
INSERT INTO `trace_flow` VALUES ('17d3423b-ebb7-4090-b5d7-0425dc344648', '30d9ed52-418f-4ce3-91e3-e9f37b28ab2d', '46a687b4-587b-4f77-a1cb-5ec37e221c40', 'b6708616-bc07-43e6-be40-8511659e47e8', '5ed4a59f-c1c2-47df-9c34-0772da24b31e', 'b74f71a4-741a-45cd-9c4f-30b7ff9c43ff', null, '6', 'da3cb544-4fe8-4dcf-a2e5-a12bd3f81768', '2017-06-09 19:52:56');
INSERT INTO `trace_flow` VALUES ('8c5b1fac-752d-4428-9b08-23291803a8c6', '53c84b1e-49fe-4012-a039-6788235070d6', '91b98e7f-3eeb-40a0-8d6d-13027b91d7be', 'bd546a7f-d99a-4985-8616-bae440196d34', '7801d29c-4f21-4420-b052-3c23368ca7e0', '59db3483-a8b7-41da-b524-aa0d02e65030', null, '6', '701450be-5303-4346-addf-06b7565f326f', '2017-06-03 22:04:59');

-- ----------------------------
-- Table structure for transport
-- ----------------------------
DROP TABLE IF EXISTS `transport`;
CREATE TABLE `transport` (
  `transport_id` varchar(50) NOT NULL,
  `transport_truck` varchar(50) default NULL,
  `transport_user` varchar(50) default NULL,
  `transport_destination` varchar(50) default NULL,
  `transport_coordinate` varchar(100) default NULL COMMENT '坐标',
  `transport_pic` varchar(255) default NULL,
  PRIMARY KEY  (`transport_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of transport
-- ----------------------------
INSERT INTO `transport` VALUES ('59db3483-a8b7-41da-b524-aa0d02e65030', '1', '1', '1', null, '');
INSERT INTO `transport` VALUES ('b74f71a4-741a-45cd-9c4f-30b7ff9c43ff', '对的', '对的', '对的', null, '');

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `userid` varchar(50) NOT NULL,
  `password` varchar(50) default NULL,
  `username` varchar(50) default NULL,
  `usertype` varchar(1) default NULL COMMENT '0是管理员，1是采购，2是检验，3是店家，4是会员',
  `phone` varchar(11) default NULL,
  PRIMARY KEY  (`userid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES ('1', '670b14728ad9902aecba32e22fa4f6bd', 'admin', '0', null);
INSERT INTO `user` VALUES ('5967274e-9742-4db8-a440-0492113537a8', '670b14728ad9902aecba32e22fa4f6bd', '刘琦', '2', '');
INSERT INTO `user` VALUES ('8fa8bc32-152c-4b7b-83e7-cf68ae66e522', '670b14728ad9902aecba32e22fa4f6bd', '小晶', '3', '15764222357');
INSERT INTO `user` VALUES ('94eb1473-7931-430f-b27d-eb9675e188af', '670b14728ad9902aecba32e22fa4f6bd', '15764222357', '4', '15764222357');
INSERT INTO `user` VALUES ('f24a7977-32c9-46e2-8216-6ff235571a82', '670b14728ad9902aecba32e22fa4f6bd', '李明', '1', '15764234135');

-- ----------------------------
-- Table structure for user_role
-- ----------------------------
DROP TABLE IF EXISTS `user_role`;
CREATE TABLE `user_role` (
  `id` varchar(50) NOT NULL,
  `userid` varchar(50) NOT NULL,
  `roleid` varchar(50) NOT NULL,
  PRIMARY KEY  (`id`)
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
  `vegetables_name` varchar(100) default NULL,
  PRIMARY KEY  (`vegetables_id`)
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
  `video_path` varchar(255) default NULL,
  `createtime` varchar(50) default NULL,
  `video_type` varchar(1) default NULL COMMENT '0 是农户 1是检验过程中',
  `username` varchar(50) default NULL,
  PRIMARY KEY  (`video_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of video
-- ----------------------------
INSERT INTO `video` VALUES ('07e9cf04-5e0d-41ae-b5ef-b7fb31e3d713', '', '2017-06-09 19:52:56', '1', '');
INSERT INTO `video` VALUES ('fc1a0fff-6400-48f6-90ff-c572e0e4a196', '', '2017-06-03 22:04:59', '1', '');
