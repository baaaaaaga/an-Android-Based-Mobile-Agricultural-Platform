/*
 Navicat Premium Data Transfer

 Source Server         : localhost_3306
 Source Server Type    : MySQL
 Source Server Version : 50732
 Source Host           : localhost:3306
 Source Schema         : project_db

 Target Server Type    : MySQL
 Target Server Version : 50732
 File Encoding         : 65001

 Date: 10/05/2025 09:57:28
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for access_token
-- ----------------------------
DROP TABLE IF EXISTS `access_token`;
CREATE TABLE `access_token`  (
  `token_id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '临时访问牌ID',
  `token` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '临时访问牌',
  `info` text CHARACTER SET utf8 COLLATE utf8_general_ci COMMENT '信息',
  `maxage` int(2) NOT NULL DEFAULT 2 COMMENT '最大寿命：默认2小时',
  `create_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间',
  `user_id` int(11) UNSIGNED NOT NULL DEFAULT 0 COMMENT '用户编号',
  PRIMARY KEY (`token_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 102 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '登陆访问时长' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of access_token
-- ----------------------------
INSERT INTO `access_token` VALUES (57, '5accf85cb6a7f06f0aa2968deadaec1b', NULL, 2, '2025-03-31 18:21:49', '2025-03-31 18:21:49', 1);
INSERT INTO `access_token` VALUES (58, '46ff1d4d07714f046ba07b34bffe0af9', NULL, 2, '2025-03-31 18:21:49', '2025-03-31 18:21:49', 1);
INSERT INTO `access_token` VALUES (59, 'ed9d6cba9826fda1beafcd9326be7a86', NULL, 2, '2025-03-31 18:21:49', '2025-03-31 18:21:49', 1);
INSERT INTO `access_token` VALUES (60, 'c99763c1833ea0785d9e2b81da3fd28f', NULL, 2, '2025-03-31 18:21:49', '2025-03-31 18:21:49', 1);
INSERT INTO `access_token` VALUES (61, '33fbfaccd6d1cb9143e4129bd919d4b0', NULL, 2, '2025-03-31 18:21:49', '2025-03-31 18:21:49', 1);
INSERT INTO `access_token` VALUES (62, '493e13da5f293ba67a56a0fe3e1fa6cf', NULL, 2, '2025-03-31 18:21:49', '2025-03-31 18:21:49', 1);
INSERT INTO `access_token` VALUES (63, 'c4b48e9e2160db09c703041a8fee0a1f', NULL, 2, '2025-03-31 18:21:49', '2025-03-31 18:21:49', 1);
INSERT INTO `access_token` VALUES (64, 'd13cdaefd3823c360c959a02a262f71d', NULL, 2, '2025-03-31 18:21:49', '2025-03-31 18:21:49', 1);
INSERT INTO `access_token` VALUES (65, '6c6ff426fd77ea5a2025ce5ed2e42c8a', NULL, 2, '2025-03-31 18:21:49', '2025-03-31 18:21:49', 1);
INSERT INTO `access_token` VALUES (66, '80930065a61ffcdd5cbb75f60932973c', NULL, 2, '2025-03-31 18:21:49', '2025-03-31 18:21:49', 1);
INSERT INTO `access_token` VALUES (67, '94114763cf2e3b020495d8a27096d4ef', NULL, 2, '2025-03-31 18:21:49', '2025-03-31 18:21:49', 1);
INSERT INTO `access_token` VALUES (68, '761052c551c97c9317bc3aa475c85b84', NULL, 2, '2025-03-31 18:21:49', '2025-03-31 18:21:49', 1);
INSERT INTO `access_token` VALUES (69, '7c44ef14131a0ba7c16aa16cef104065', NULL, 2, '2025-03-31 18:21:49', '2025-03-31 18:21:49', 1);
INSERT INTO `access_token` VALUES (70, '96380f3d9542c80d04bdade1cf7635a5', NULL, 2, '2025-03-31 18:21:49', '2025-03-31 18:21:49', 1);
INSERT INTO `access_token` VALUES (71, 'bfdc7acfcbf5763fda81945b60961222', NULL, 2, '2025-03-31 18:21:49', '2025-03-31 18:21:49', 1);
INSERT INTO `access_token` VALUES (72, '170a598e51ae8ae2badde20a42fe171d', NULL, 2, '2025-03-31 18:21:49', '2025-03-31 18:21:49', 1);
INSERT INTO `access_token` VALUES (73, 'c82c357488c75926a92d8a9608d4b367', NULL, 2, '2025-03-31 18:21:49', '2025-03-31 18:21:49', 1);
INSERT INTO `access_token` VALUES (74, '4d35290c023f407a820f37dbbb1ceb09', NULL, 2, '2025-03-31 18:21:49', '2025-03-31 18:21:49', 1);
INSERT INTO `access_token` VALUES (75, '8d19162776682b695c0f62f3c7a92fec', NULL, 2, '2025-03-31 18:21:49', '2025-03-31 18:21:49', 1);
INSERT INTO `access_token` VALUES (76, 'a7ea2cdc9a2be179e19200e593ad5a69', NULL, 2, '2025-03-31 18:21:49', '2025-03-31 18:21:49', 1);
INSERT INTO `access_token` VALUES (77, 'c79a554f9832adc01f19682c5d576bc4', NULL, 2, '2025-03-31 18:21:49', '2025-03-31 18:21:49', 1);
INSERT INTO `access_token` VALUES (78, '1c7d95001fa09951a679841c8100ad1f', NULL, 2, '2025-03-31 18:21:49', '2025-03-31 18:21:49', 1);
INSERT INTO `access_token` VALUES (79, '776da1bcdd01ddb3cbf0a37fa13fc5b0', NULL, 2, '2025-03-31 18:21:49', '2025-03-31 18:21:49', 1);
INSERT INTO `access_token` VALUES (80, 'd336e88e57c329d0166931292c1fac41', NULL, 2, '2025-03-31 18:21:49', '2025-03-31 18:21:49', 1);
INSERT INTO `access_token` VALUES (81, '37a40f526a6c82fc6110b512802d35bf', NULL, 2, '2025-03-31 18:21:49', '2025-03-31 18:21:49', 1);
INSERT INTO `access_token` VALUES (82, '691ad331771f4109206d58aeee572371', NULL, 2, '2025-03-31 18:21:49', '2025-03-31 18:21:49', 1);
INSERT INTO `access_token` VALUES (83, '9942e458886219960d3344b4a6a6fbec', NULL, 2, '2025-03-31 18:21:49', '2025-03-31 18:21:49', 1);
INSERT INTO `access_token` VALUES (84, 'e9939a8b7ccf9f548f0bbb5664981f96', NULL, 2, '2025-03-31 18:21:49', '2025-03-31 18:21:49', 1);
INSERT INTO `access_token` VALUES (85, 'f5b27912060d1909bef61fab9d96faae', NULL, 2, '2025-03-31 18:21:49', '2025-03-31 18:21:49', 1);
INSERT INTO `access_token` VALUES (86, '7c5888682f1d449eb1b62f0054a79fbf', NULL, 2, '2025-03-31 18:21:49', '2025-03-31 18:21:49', 1);
INSERT INTO `access_token` VALUES (87, '00dfdc6ac21c4a9da80fd71c990764d1', NULL, 2, '2025-03-31 18:21:49', '2025-03-31 18:21:49', 1);
INSERT INTO `access_token` VALUES (88, '3cce592bc72840ab932ce96d85a194da', NULL, 2, '2025-03-31 18:21:49', '2025-03-31 18:21:49', 1);
INSERT INTO `access_token` VALUES (89, '43fdaa989a644ad683ef4b4d488e8629', NULL, 2, '2025-03-31 18:21:49', '2025-03-31 18:21:49', 1);
INSERT INTO `access_token` VALUES (90, 'd6a3cecadacff0dbd6b43b25372cc2a2', NULL, 2, '2025-03-31 18:21:49', '2025-03-31 18:21:49', 1);
INSERT INTO `access_token` VALUES (91, '5570bc5b07b3589f4ef8553bd46eb0d1', NULL, 2, '2025-03-31 18:21:49', '2025-03-31 18:21:49', 1);
INSERT INTO `access_token` VALUES (92, '5570bc5b07b3589f4ef8553bd46eb0d1', NULL, 2, '2025-03-31 18:21:49', '2025-03-31 18:21:49', 1);
INSERT INTO `access_token` VALUES (93, '26c553bd2ee2ab6605d18dfd310d85f9', NULL, 2, '2025-03-31 18:21:49', '2025-03-31 18:21:49', 1);
INSERT INTO `access_token` VALUES (94, '3fd52f81236ed2c37ff91a6696d4e47a', NULL, 2, '2025-03-31 18:21:49', '2025-03-31 18:21:49', 1);
INSERT INTO `access_token` VALUES (95, '893332e9ee67d60d8312b3700c58a359', NULL, 2, '2025-03-31 18:21:49', '2025-03-31 18:21:49', 1);
INSERT INTO `access_token` VALUES (96, 'b7844068ade535b2e517df4a40948703', NULL, 2, '2025-03-31 18:21:49', '2025-03-31 18:21:49', 1);
INSERT INTO `access_token` VALUES (97, '179b37a5e1893c3af6b946bd5a1c8625', NULL, 2, '2025-03-31 18:21:49', '2025-03-31 18:21:49', 1);
INSERT INTO `access_token` VALUES (98, '3a47b8a040a83ebbc9194cb255dc668c', NULL, 2, '2025-03-31 18:21:49', '2025-03-31 18:21:49', 1);
INSERT INTO `access_token` VALUES (99, 'afa60196afb77dcc2b520ed13a817560', NULL, 2, '2025-03-31 18:21:49', '2025-03-31 18:21:49', 1);
INSERT INTO `access_token` VALUES (100, '7fc6d9b324f8c0a3a1784d04ef132692', NULL, 2, '2025-03-31 18:21:49', '2025-03-31 18:21:49', 1);
INSERT INTO `access_token` VALUES (101, '84e31b291f2bde6b7ceb27af5fe8eee3', NULL, 2, '2025-03-31 18:21:49', '2025-03-31 18:21:49', 1);

-- ----------------------------
-- Table structure for address
-- ----------------------------
DROP TABLE IF EXISTS `address`;
CREATE TABLE `address`  (
  `address_id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '收货地址',
  `name` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '姓名',
  `phone` varchar(13) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '手机',
  `postcode` varchar(8) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '邮编',
  `address` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '地址',
  `user_id` mediumint(8) UNSIGNED NOT NULL COMMENT '用户ID',
  `create_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间',
  `default` tinyint(1) NOT NULL DEFAULT 0 COMMENT '默认判断',
  PRIMARY KEY (`address_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '收货地址' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of address
-- ----------------------------
INSERT INTO `address` VALUES (3, '田七', '13590509090', NULL, '广州市越秀区东风西路187号', 1, '2025-03-31 18:21:49', '2025-03-31 18:21:49', 1);
INSERT INTO `address` VALUES (4, '1213', '13713771377', NULL, '32132132', 8, '2025-04-03 16:20:06', '2025-04-03 16:20:19', 1);
INSERT INTO `address` VALUES (5, '采购部 陈主管', '13733335555', NULL, '河北省 承德市 围场满族蒙古族自治县 御道口风景区 雪松温泉度假酒店 后勤收货处', 15, '2025-04-24 16:36:19', '2025-04-24 16:36:30', 1);
INSERT INTO `address` VALUES (6, '王女士', '17344445555', NULL, '广东省 深圳市 南山区 科技园 XX小区 3栋 10A', 11, '2025-04-24 16:41:40', '2025-04-24 16:41:42', 1);

-- ----------------------------
-- Table structure for agricultural_products
-- ----------------------------
DROP TABLE IF EXISTS `agricultural_products`;
CREATE TABLE `agricultural_products`  (
  `agricultural_products_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '农产品ID',
  `product_specifications` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '产品规格',
  `farmers_merchants` int(11) DEFAULT 0 COMMENT '农户商家',
  `business_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '商家名称',
  `contact_number` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '联系号码',
  `business_address` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '商家地址',
  `hits` int(11) NOT NULL DEFAULT 0 COMMENT '点击数',
  `collect_len` int(11) NOT NULL DEFAULT 0 COMMENT '收藏数',
  `comment_len` int(11) NOT NULL DEFAULT 0 COMMENT '评论数',
  `recommend` int(11) NOT NULL DEFAULT 0 COMMENT '智能推荐',
  `cart_title` varchar(125) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '标题',
  `cart_img` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci COMMENT '封面图',
  `cart_description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '描述',
  `cart_price_ago` double(8, 2) UNSIGNED NOT NULL DEFAULT 0.00 COMMENT '原价',
  `cart_price` double(8, 2) UNSIGNED NOT NULL DEFAULT 0.00 COMMENT '卖价',
  `cart_inventory` int(11) NOT NULL DEFAULT 0 COMMENT '商品库存',
  `cart_type` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '未分类' COMMENT '商品分类',
  `cart_content` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci COMMENT '正文',
  `cart_img_1` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci COMMENT '主图1',
  `cart_img_2` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci COMMENT '主图2',
  `cart_img_3` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci COMMENT '主图3',
  `cart_img_4` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci COMMENT '主图4',
  `cart_img_5` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci COMMENT '主图5',
  `create_time` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间',
  PRIMARY KEY (`agricultural_products_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '农产品' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of agricultural_products
-- ----------------------------
INSERT INTO `agricultural_products` VALUES (1, '元/500g', 16, '鲜海润肉业有限公司', '17617661755', '广东省珠海市金湾区红旗镇工业大道18号', 0, 0, 0, 0, '鲜海润 - 雪花五花肉片 (肥瘦相间 烧烤火锅优选)', '/api/upload/1051269_20170126122010684070_0-2610040877.jpg', '精选五花肉，肥瘦黄金比例，口感香嫩，烤涮皆宜', 38.00, 35.00, 650, '生鲜', '<p><strong>【烧烤火锅灵魂伴侣 - 鲜海润雪花五花肉片】</strong></p><p>鲜海润肉业为您呈献精心挑选、切割的雪花五花肉片。我们选用猪腹部精华部位，肥瘦层次分明，呈现诱人的“雪花”纹理。</p><p><strong>【产品亮点】</strong></p><ul><li><strong>黄金肥瘦比：</strong>&nbsp;肥肉甘香，瘦肉鲜嫩，完美结合带来丰富口感。</li><li><strong>均匀切片：</strong>&nbsp;标准厚度约3mm，无论烧烤还是涮烫，都能快速熟透，保持最佳口感。</li><li><strong>鲜嫩多汁：</strong>&nbsp;脂肪在加热后滋润瘦肉，入口香浓不柴，汁水丰盈。</li><li><strong>锁鲜包装：</strong>&nbsp;采用先进的气调包装技术，最大程度保持肉质的新鲜度和色泽。</li></ul><p><strong>【适用场景】</strong></p><ul><li><strong>韩式/日式烧烤：</strong>&nbsp;烤后滋滋作响，香气扑鼻。</li><li><strong>各式火锅：</strong>&nbsp;轻涮几秒即可捞出，鲜嫩爽滑。</li><li><strong>家常小炒：</strong>&nbsp;如蒜苔炒肉、回锅肉等，增添风味。</li></ul><p>鲜海润承诺，为您提供安全、高品质的鲜肉产品。这款雪花五花肉片是家庭聚餐、朋友聚会的理想选择，让美味时刻更加精彩！</p>', '/api/upload/25556641_131901495085_2-904342886.jpg', '/api/upload/1051269_20170126122010684070_0-2610040877.jpg', '/api/upload/25556641_131901495085_2-904342886.jpg', '/api/upload/1051269_20170126122010684070_0-2610040877.jpg', '/api/upload/25556641_131901495085_2-904342886.jpg', '2025-04-24 16:09:48', '2025-04-24 16:09:48');
INSERT INTO `agricultural_products` VALUES (2, '约500g/份，真空锁鲜包装', 16, '鲜海润肉业有限公司', '17617661755', '广东省珠海市金湾区红旗镇工业大道18号', 0, 0, 0, 0, '鲜海润 - 精选新鲜猪前腿肉', '/api/upload/ea3926085a790570-1917441911.jpg', '肉质紧实，肥瘦适中，炖煮香浓，绞馅鲜美', 25.00, 22.00, 800, '生鲜', '<p><strong>鲜海润品质保证，源自自家鲜肉加工厂！</strong></p><p>我们为您带来新鲜宰杀的优质猪前腿肉。这部分肉活动量大，因此肉质紧实，略带筋络，肥瘦比例恰到好处。</p><p><strong>【产品特点】</strong></p><ul><li><strong>新鲜直供：</strong>&nbsp;每日凌晨宰杀处理，冷链配送，确保新鲜。</li><li><strong>肉质优良：</strong>&nbsp;口感丰富有嚼劲，炖煮后汤汁浓郁，肉香四溢。</li><li><strong>用途广泛：</strong>&nbsp;非常适合长时间炖煮（如红烧肉、卤肉）、煲汤，也是制作饺子、包子、肉丸等馅料的绝佳选择。</li><li><strong>安全卫生：</strong>&nbsp;严格执行检疫标准，真空包装有效隔绝污染，锁住营养和风味。</li></ul><p><strong>【烹饪建议】</strong></p><ul><li>红烧、慢炖：充分释放肉质香味。</li><li>绞碎制馅：制作饺子、包子、肉饼等。</li><li>切块煲汤：搭配蔬菜或药材，营养丰富。</li></ul><p>选择鲜海润，就是选择新鲜、安全、美味！即刻下单，为您的餐桌增添一份安心好滋味！</p>', '/api/upload/ea3926085a790570-1917441911.jpg', '/api/upload/41a32c8b04759f73-3374360799.jpg', '/api/upload/41a32c8b04759f73-3374360799.jpg', '/api/upload/ea3926085a790570-1917441911.jpg', '/api/upload/41a32c8b04759f73-3374360799.jpg', '2025-04-24 16:11:36', '2025-04-24 16:11:36');
INSERT INTO `agricultural_products` VALUES (3, '约2.5公斤/份 (约5-7穗，根据单穗大小调整)，带苞叶发货', 18, '果然甜生态农业有限公司', '13811112222', '广西百色市田阳县生态果园产业园12号', 0, 0, 0, 0, '果然金穗 - 生态甜糯玉米', '/api/upload/b94e-kcpxnww0586161-394684502.jpg', '源自广西田阳生态农场，自然农法种植，鲜嫩软糯与清甜多汁的完美结合！', 28.00, 25.00, 1000, '果蔬', '<p><strong>【来自果然金穗农场的甜蜜馈赠 - 生态种植甜糯玉米】</strong></p><p>大家好！我们是“果然甜生态农业”，非常自豪地为您带来产自我们广西百色市田阳县“果然金穗农场”的当季新鲜甜糯玉米！</p><p><strong>【生态种植，自然之味】</strong></p><p>在果然金穗农场，我们坚持生态种植理念：</p><ul><li><strong>尊重土地：</strong>&nbsp;使用有机肥改良土壤，不使用化学除草剂，让土地保持活力。</li><li><strong>自然生长：</strong>&nbsp;遵循玉米自然生长周期，不催熟，享受充足的阳光和雨露。</li><li><strong>物理防治：</strong>&nbsp;采用物理和生物方法防治虫害，最大程度减少人为干预，确保玉米的天然纯粹。</li></ul><p><strong>【产品特点】</strong></p><ul><li><strong>品种优选：</strong>&nbsp;精心挑选甜糯玉米品种，兼具水果玉米的清甜多汁和糯玉米的软糯口感。</li><li><strong>口感上乘：</strong>&nbsp;颗粒饱满，皮薄无渣，入口软糯香甜，回味无穷。无论是蒸、煮、烤，还是煲汤，都风味绝佳。</li><li><strong>新鲜采摘：</strong>&nbsp;坚持“从田间到餐桌”的新鲜承诺，订单后新鲜采摘，带着能锁住水分和新鲜度的苞叶为您发出。</li></ul><p><strong>【食用建议】</strong></p><ul><li><strong>原味蒸煮：</strong>&nbsp;清水煮或蒸15-20分钟，最能品尝到玉米本身的香甜软糯。</li><li><strong>烧烤风味：</strong>&nbsp;刷上酱料进行烧烤，外焦里糯，别有风味。</li><li><strong>营养煲汤：</strong>&nbsp;与排骨、胡萝卜等一同煲汤，汤汁鲜甜，营养丰富。</li></ul><p>选择果然甜，就是选择一份来自大自然的安心与美味。现在下单，让这份来自果然金穗农场的甜蜜滋味，丰富您的健康餐桌！</p><p><strong>温馨提示：</strong>&nbsp;生鲜产品，请收到后尽快食用或冷藏保存（建议3-5天内食用完毕以保最佳风味）。</p>', '/api/upload/34599220_203844395105_2-2969986085.jpg', '/api/upload/b94e-kcpxnww0586161-394684502.jpg', '/api/upload/34599220_203844395105_2-2969986085.jpg', '/api/upload/b94e-kcpxnww0586161-394684502.jpg', '/api/upload/34599220_203844395105_2-2969986085.jpg', '2025-04-24 16:19:55', '2025-04-24 16:19:55');
INSERT INTO `agricultural_products` VALUES (4, ' 约500g/份 (约4-6只，单只约80-125g)，鲜活带壳', 17, '海珍鲜坊食品有限公司', '15200223456', '山东省烟台市莱山区海港工业园5号', 0, 0, 0, 0, '海珍鲜坊 - 渤海湾深海鲜活鲍鱼 ', '/api/upload/01xytqlxclkdtcxsjo5fsf3433-1870885558.jpg', '源自海珍深海养殖场，渤海湾优质海域馈赠，每日鲜捞，急速锁鲜直达餐桌！', 198.00, 178.00, 300, '海鲜', '<p><strong>【源自渤海湾的深海珍品——海珍鲜坊·鲜活鲍鱼】</strong></p><p>尊敬的顾客，您好！海珍鲜坊食品有限公司，依托自有**【海珍·深海养殖场】**，为您呈献来自渤海湾核心优质海域的顶级鲜活鲍鱼！</p><p><strong>【得天独厚的生长环境】</strong></p><ul><li><strong>渤海湾优质海域：</strong>&nbsp;水质纯净，营养丰富，盐度适中，是鲍鱼等高端海产得天独厚的生长天堂。</li><li><strong>深海网箱养殖：</strong>&nbsp;远离近岸污染，采用海上深水网箱，模拟鲍鱼自然生长环境，让鲍鱼活动空间更大，肉质更紧实、更鲜美。</li></ul><p><strong>【从大海到餐桌，锁住极致新鲜】</strong></p><p>我们深知“鲜”是海产的灵魂，因此我们郑重承诺：</p><ul><li><strong>每日鲜捞：</strong>&nbsp;专业团队每日根据订单捕捞，确保您收到的每一只鲍鱼都充满活力。</li><li><strong>急速锁鲜：</strong>&nbsp;捕捞上岸后，鲍鱼立即进入岸基急速降温仓库处理，快速降低鲍鱼新陈代谢，最大限度锁住鲜活与营养。</li><li><strong>当日发货：</strong>&nbsp;采用专业鲜活水产包装（泡沫箱+冰袋+氧气袋），与顺丰冷链等优质物流合作，实现当日发货，次日/隔日即达（视距离而定），鲜活到家！</li></ul><p><strong>【品质上乘，口感绝佳】</strong></p><ul><li><strong>个大肉厚：</strong>&nbsp;精选4-6头/斤的优质规格，鲍鱼肉柱肥厚饱满。</li><li><strong>Q弹鲜甜：</strong>&nbsp;口感紧实Q弹，味道鲜美甘甜，无腥味，是海味中的上品。</li><li><strong>营养丰富：</strong>&nbsp;富含蛋白质、多种维生素和微量元素，是滋补佳品。</li></ul><p><strong>【推荐食法】</strong></p><p>清蒸、蒜蓉粉丝蒸、捞饭、煲汤、刺身（需确保绝对新鲜且处理得当）等，简单的烹饪最能体现其原汁原味的鲜美。</p><p>选择海珍鲜坊，就是选择一份来自深海的纯净、新鲜与尊贵。立即下单，让这份渤海湾的馈赠，为您的餐桌增添一道亮丽的风景线！</p><p><strong>【温馨提示】</strong>&nbsp;收到鲜活鲍鱼后，请尽快处理或置于冰箱冷藏（0-4℃），并尽快食用，以保证最佳口感和品质。如需暂养，请用海水或配置接近海水盐度的盐水，并打氧。</p>', '/api/upload/TB2S9w3aH9YBuNjy0FgXXcxcXXa_!!33656204-3533739786.jpg', '/api/upload/TB2S9w3aH9YBuNjy0FgXXcxcXXa_!!33656204-3533739786.jpg', '/api/upload/01xytqlxclkdtcxsjo5fsf3433-1870885558.jpg', '/api/upload/01xytqlxclkdtcxsjo5fsf3433-1870885558.jpg', '/api/upload/TB2S9w3aH9YBuNjy0FgXXcxcXXa_!!33656204-3533739786.jpg', '2025-04-24 16:24:33', '2025-04-24 16:24:33');
INSERT INTO `agricultural_products` VALUES (5, '一级大果，单果重约250-300g (约7-9个/箱)，净重约4.5-5斤，礼盒装', 19, '丰果季农业科技有限公司', '15700001111', '河北邯郸市涉县现代农业科技产业园区22号', 0, 0, 0, 0, '桃源仙谷 - 正宗阳山爆汁水蜜桃 (一级大果)', '/api/upload/304a434d476d77557061-2762687778.jpg', '来自水蜜桃之乡阳山的甜蜜问候，皮薄肉厚，一口爆汁，甜过初恋！', 138.00, 118.00, 999, '果蔬', '<p><strong>【夏日限定的甜蜜暴击——桃源仙谷·阳山水蜜桃】</strong></p><p>您是否在期待那一口，能让整个夏天都变得温柔起来的滋味？</p><p>来自正宗水蜜桃核心产区——<strong>江苏无锡阳山</strong>的【桃源仙谷】水蜜桃，带着太湖的温润和江南的灵秀，如约而至！</p><p><strong>【得天独厚的自然恩赐】</strong></p><p>阳山，亿万年前的古火山，留下了独特的火山灰土壤，富含多种微量元素，滋养出与众不同的水蜜桃风味。这里气候温和，雨水充沛，光照适宜，是水蜜桃生长的理想天堂。</p><p><strong>【我们用心，只为您口中的那份甜】</strong></p><ul><li><strong>精心培育：</strong>&nbsp;坚持绿色种植理念，施用农家肥和有机肥，物理方法防治虫害，让每一颗桃子都自然成熟，健康安全。</li><li><strong>人工精选：</strong>&nbsp;只挑选达到一级大果标准、成熟度恰到好处（约8-9分熟，兼顾口感与运输）、外观粉嫩、绒毛均匀的“甜心宝贝”。</li><li><strong>成熟采摘：</strong>&nbsp;绝不提前采摘催熟，只在桃子风味和甜度达到巅峰时，由经验丰富的果农手工采摘。</li></ul><p><strong>【无法抗拒的味蕾诱惑】</strong></p><ul><li><strong>外观：</strong>&nbsp;粉里透红，绒毛细腻，像少女娇羞的脸庞。</li><li><strong>香气：</strong>&nbsp;凑近一闻，浓郁的桃香扑鼻而来，清新自然。</li><li><strong>口感：</strong>&nbsp;轻轻撕开薄如蝉翼的外皮，饱满的汁水几乎要溢出！果肉细腻软糯，<strong>入口即化</strong>，几乎无渣。</li><li><strong>味道：</strong>&nbsp;甜度高而不腻，恰到好处的微酸更添风味层次，满口都是清甜的桃汁和软嫩的果肉，幸福感爆棚！</li></ul><p><strong>【新鲜直达，锁住枝头风味】</strong></p><ul><li><strong>专业包装：</strong>&nbsp;每颗桃子都套上柔软的保护网套，稳固放入带有缓冲隔断的特制礼盒中，最大程度减少运输磕碰。</li><li><strong>快速物流：</strong>&nbsp;采摘后尽快发出，与顺丰/京东等优质快递合作，将枝头的新鲜尽快送到您手中。</li></ul><p>无论是犒劳自己，还是与家人分享，或是作为一份充满心意的夏日礼物，【桃源仙谷】阳山水蜜桃都是绝佳的选择！</p><p><strong>【温馨提示】</strong></p><p>水蜜桃娇嫩，请收到后立即开箱检查。常温放置1-2天可追熟，口感更佳。若想延长保存期，可用保鲜袋包裹后放入冰箱冷藏（非冷冻），并尽快食用。食用前请轻轻清洗。</p><p>现在就下单，开启您的甜蜜一夏吧！</p>', '/api/upload/GDZ4MWd2-SEO-內圖-8-1765660813.jpg', '/api/upload/304a434d476d77557061-2762687778.jpg', '/api/upload/GDZ4MWd2-SEO-內圖-8-1765660813.jpg', '/api/upload/304a434d476d77557061-2762687778.jpg', '/api/upload/GDZ4MWd2-SEO-內圖-8-1765660813.jpg', '2025-04-24 16:28:05', '2025-04-24 16:28:05');

-- ----------------------------
-- Table structure for article
-- ----------------------------
DROP TABLE IF EXISTS `article`;
CREATE TABLE `article`  (
  `article_id` mediumint(8) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '文章id',
  `title` varchar(125) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '标题',
  `type` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '0' COMMENT '文章分类',
  `hits` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '点击数',
  `praise_len` int(11) NOT NULL DEFAULT 0 COMMENT '点赞数',
  `create_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间',
  `source` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '来源',
  `url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '来源地址',
  `tag` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '标签',
  `content` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci COMMENT '正文',
  `img` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '封面图',
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci COMMENT '文章描述',
  PRIMARY KEY (`article_id`, `title`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '文章' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of article
-- ----------------------------
INSERT INTO `article` VALUES (1, '人民网评：智慧农业为农业现代化插上翅膀', '农业', 494, 200, '2025-03-31 15:46:37', '2025-05-08 22:39:13', NULL, NULL, NULL, '<p class=\"ql-align-justify\">	近日，农业农村部发布《农业农村部关于大力发展智慧农业的指导意见》（以下简称《指导意见》）与《全国智慧农业行动计划（2024—2028年）》（以下简称《行动计划》），明确了今后一段时期推进智慧农业的工作思路和重点任务，为我国农业的转型升级和高质量发展绘制了宏伟蓝图。</p><p class=\"ql-align-justify\">	智慧农业的关键是“智慧”。《指导意见》强调，要加力推进智慧农业技术创新和先行先试。既要加快技术装备研发攻关，加快农业传感器与专用芯片、农业核心算法、农业机器人等关键核心技术研发攻关；也要建设智慧农业引领区，强化政策创设，推动机制创新，集中用好各类支持措施，打造智慧农业发展高地；还要健全技术推广服务体系，智慧农业技术装备纳入农技推广范围，加强智慧农业技术指导和推广。这些举措，不仅能提升我国农业技术装备的自主创新能力，有助于打破国际技术壁垒，更能进一步推动农业生产提质增效，有力推动智慧农业技术的快速普及与高效利用。</p><p class=\"ql-align-justify\">	农业基础设施建设是智慧农业的前提和基础，其现代化程度直接关乎农业生产的效率与可持续性。《指导意见》明确提出，要全方位提升智慧农业应用水平。从推进主要作物种植精准化，到设施种植数字化；从畜牧养殖智慧化，到渔业生产智能化；从育制种智能化，到农业全产业链数字化及农业农村管理服务数字化等7项重点任务，旨在通过科技赋能，引领我国农业迈向更高层次的发展阶段，为农业现代化插上科技的翅膀。</p><p class=\"ql-align-justify\">	粮食稳产增产，根本出路还是在科技。近年来，我国智慧农业正不断取得新的突破和进展。如今，仅需一部手机，便能对上千亩耕地的生产设施进行管控；“一键操作”即可完成田地灌溉、施肥等日常管理；育秧机、旋耕机、插秧机、抛秧机、收割机、无人植保机、烘干机等十余种智慧农机，逐渐实现了农业生产线的全流程机械化、智能化……智能科技的广泛应用，极大提升了农业作业精度和效率，为农业增产、农民增收提供了有力支撑。智慧农业，让科学种田从梦想照进现实。</p><p class=\"ql-align-justify\">	在公共服务能力建设上，加快打造国家农业农村大数据平台、农业农村用地“一张图”和基础模型算法等公共服务产品；在产业布局上，着力推动主要作物大面积单产提升，培育一批智慧农场、智慧牧场、智慧渔场，推进全产业链数字化改造；在示范带动上，大力推进智慧农业先行先试、探索智慧农业未来方向……随着《指导意见》与《行动计划》的深入实施，将进一步推动智慧农业与现代农业的深度融合，我国智慧农业将迎来前所未有的发展机遇，为实现农业强、农村美、农民富的美好愿景提供强大的科技支撑和动力源泉。</p><p><br></p>', '/api/upload/1888759338097442816.jpg', NULL);
INSERT INTO `article` VALUES (2, '践行大农业观发展现代农业', '农业', 961, 50, '2025-03-31 15:46:37', '2025-05-08 22:39:24', NULL, NULL, NULL, '<p>	大农业是朝着多功能、开放式、综合性方向发展的立体农业，发展现代农业是新时代新征程农业发展的重点方向。今年中央一号文件提出要把农业建成现代化大产业，去年底召开的中央经济工作会议提出“树立大农业观、大食物观”，为进一步推进乡村全面振兴、建设农业强国提供了理论遵循和行动指南。</p><p>	大农业观是党在领导新时代“三农”工作中形成的重大理论创新成果，具有鲜明的“整体性”内涵特征。一是农业产业领域的整体性，强调农林牧渔并举、产前产中产后全产业链贯通、一二三产业融合发展；二是农业资源的整体性，强调耕地、草地、林地、江河湖海等各类国土空间的统筹发展；三是农业功能的整体性，强调粮食和重要农产品的供给保障与生态涵养、休闲观光、文化传承等多维度功能的有机统一；四是农业发展方式的整体性，强调坚持生产生活生态并重、数量质量效益并重、当前利益与长远利益并重、发展方式与相关政策举措取向的一致性。</p><p>	<strong>大农业观为发展现代农业提供重要引领</strong></p><p>	大农业观强调充分挖掘各类农业资源，推动粮经饲统筹、农林牧渔并举，开发农业多种功能和乡村多元价值，促进绿色低碳循环发展，不断提升现代农业的供给能力和产业韧性，为发展现代农业提供重要引领。</p><p>	引领农业大产业协调发展。农业领域内各产业之间相互依存，其融合水平和协调程度与现代农业的健康发展密切相关。树立大农业观，有利于引领农业各产业着眼生产、加工、保鲜储藏、运输销售等环节，通过纵向一体化和横向一体化等模式延链、补链、强链、融链，形成协调发展、共生互利的产业集群。</p><p>	引领农业资源要素统筹利用。要素高效组合、顺畅流动是发展现代农业的重要依托。树立大农业观，有利于在充分利用耕地资源的同时，拓展传统农业生产边界，向整个国土资源要食物、要效益，也有利于各地各类农业经营主体立足本地资源优势，着眼国内外农业资源开发利用，寻门路、谋发展。</p><p>	引领农业整体功能充分发挥。现代农业的多元功能属性相互联系、相互依存。保障粮食和重要农产品稳定安全供给是农业发展的必然要求，增加农民收入是农业发展的重要任务，发挥好农业生态和文化传承等功能是农业发展的重要使命。树立大农业观，有利于农业多元功能充分挖掘、协调发挥，形成农业综合效益提升的强大合力。</p><p>	引领农业发展方式整体转变。在传统农业观下，通过消耗资源、大量投入生产资料的方式，尽管可以解决粮食供给短缺问题，但也要付出极大生态代价。树立大农业观，有利于从根本上转变农业发展方式，摒弃以牺牲生态环境为代价换取一时一地的经济增长的做法，实现绿色可持续发展。</p><p>	<strong>坚持系统观念推进农业农村现代化</strong></p><p>	当前和今后一个时期，国内外环境发生深刻复杂变化，现代农业发展全过程和各领域众多关系纷繁复杂，各类农产品的供需形势、各种农业资源的承载力以及农业各类功能的实现情况等处于动态变化中。必须深入学习贯彻习近平总书记关于“三农”工作的重要论述，坚持系统观念，牢固树立和践行大农业观，为推进农业农村现代化提供重要支撑。</p><p>	统筹保障粮食安全与食物安全。粮食安全是“国之大者”。当前，居民膳食结构发生改变，肉蛋奶在膳食结构中的比例不断增加，粮食需求仍然呈刚性增长的态势，粮食供求紧平衡的格局短期内难以改变，必须始终将粮食安全作为现代农业建设的首要任务。要坚守18亿亩耕地红线，坚决遏制耕地“非农化”、有效防止“非粮化”。坚持良田粮用大原则，良田好土要优先保粮食，果树苗木尽量上山上坡，蔬菜园艺更多靠设施农业和工厂化种植。食物安全是对粮食安全的拓展，粮食安全是食物安全的基础。统筹发挥耕地、草地、林地、江河湖海等多种农业资源对多元食物供给和多种功能实现的支撑作用，借助现代科学技术多途径拓展食物来源，全方位保障食物安全。</p><p>	协同推进高质量发展和高水平保护。现阶段，面对巨大的农产品供给和需求，资源环境承载力已达到或接近上限，这就要求发展农业必须践行大农业观，系统兼顾生产发展和生态保护，实现经济效益、社会效益和环境效益的统一。在生产发展方面，把坚持高质量发展作为新时代的硬道理，积极发展新质生产力，加快推进农业关键核心技术攻关和科技成果转化利用，改善农业农村基础设施条件，提升水土资源利用效率，确保粮食和重要农产品供给安全。在生态保护方面，牢固树立绿水青山就是金山银山的理念，加大力度推进水土流失治理、农业污染治理、循环农业发展，不仅要杜绝生态环境欠新账，而且要逐步还旧账，提升农业可持续发展能力。</p><p>	兼顾鼓励要素下乡和保护农民利益。人才、技术、资本、信息、数据等各类要素资源是城乡产业、农村一二三产业融合发展的重要推动力量。践行大农业观，既要追求效率也要兼顾公平，既要加强激励也要强化约束。一方面，优化营商环境，稳定政策预期，加快吸引要素下乡，强化产品和服务供给，积极服务各类农业经营主体，大力激发其积极性。另一方面，加强规范引导，强化资本下乡引入、使用、退出的全过程监管，切实保护农民收益。发挥要素集聚带来的综合优势，积极延伸和拓展农业产业链、提升价值链，促进城乡产业、农村一二三产业融合发展，增强产业链供应链韧性。建立和完善联农带农利益联结机制，把小农生产引入现代农业发展轨道，让农民和农村更多分享产业增值收益。</p><p>	推动有效市场和有为政府更好结合。一方面，农业的弱质性、粮食等基本农产品的准公共品属性，决定了农业发展离不开政策支持；另一方面，通过对接市场需求、推动农业产业化市场化数字化是实现农民增收的重要途径，要素资源合理配置和产业活力充分迸发更有赖于市场驱动。践行大农业观，既要更好发挥政府在规划引导、政策支持、市场监管、法治保障等方面的积极作用，提升政策的稳定性、科学性、可操作性，强化管理的系统性、整体性、协同性，有效匹配现代农业发展需求，又要充分发挥市场在资源配置中的决定性作用，持续优化市场调节机制，提高要素配置效率，进一步激发经营主体的创造力和活力。</p>', '/api/upload/1888759831968350209.jpg', NULL);
INSERT INTO `article` VALUES (3, '智慧农业——引领现代农业产业园新风貌', '农业', 498, 20, '2025-03-31 15:46:37', '2025-05-04 17:30:50', NULL, NULL, NULL, '<p class=\"ql-align-justify\">	在距离北京市区仅50公里的房山区石楼镇，一座集农产品加工、存储、销售、农业信息化、农业科技创新于一体的现代化农业产业园正拔地而起。这里，不仅是房山区的农业大镇，更是北京市农业产业升级和农村价值释放的重要探索地。</p><p class=\"ql-align-justify\">	<strong>绿色循环，生态引领</strong></p><p class=\"ql-align-justify\">	石楼镇地势平坦，土地肥沃，耕地面积超过14000亩，是京畿地区的重要粮仓。为了充分利用这一资源优势，石楼镇以“产业双带动·农业大循环”为基本定位，以“生猪养殖+蔬菜”为主导，发展生态循环立体种养模式，推动农业产业联动与融合发展。</p><p class=\"ql-align-justify\">	在产业园区，一座五层高的崭新楼房拔地而起，为生猪养殖提供了更绿色、更科学的环境。同时，新建的智慧蔬菜大棚整齐排列，内部安装了先进的智慧系统，实现了环境数据的实时监测与远程操控。这些大棚不仅提高了蔬菜的产量与质量，还大大减轻了农户的劳动强度。</p><p class=\"ql-align-justify\">	<strong>智慧农业，创新驱动</strong></p><p class=\"ql-align-justify\">	走进石楼镇现代农业产业园的大数据信息中心，一幅幅生动的农业数据可视化画面映入眼帘。大数据可视化系统，可以看到石楼镇当前的种植情况统计，9820亩粮食作物、314栋大棚蔬菜在石楼镇的地图上分布开来。这里，是整个园区的智慧大脑，致力于数据的汇聚与标准化，为农业生产提供科学依据。</p><p class=\"ql-align-justify\">	通过物联网、大数据、云计算等先进技术的运用，产业园已经实现了实时监测和农业生产环境分析。农户们只需通过手机，就能轻松管理自己的蔬菜大棚，调节温度、浇水等操作均可实现自动化。这一智慧农业系统的应用，不仅提高了农业生产的精准化和智能化水平，还大幅降低了生产成本，平均节省成本在20%以上。</p><p class=\"ql-align-justify\">	<strong>产业集聚，效益显著</strong></p><p class=\"ql-align-justify\">	目前，石楼镇现代农业产业园核心区的各个功能分区皆已投入应用，农产品加工中心、双创研发中心、质量安全中心等空间，装备齐全。已经吸引了22家农业企业和14家农业专业合作社入驻。这些企业涵盖了农业生产、加工、销售、物流等多个环节，形成了相对完善的产业链条。在产业园的推动下，石楼镇的农业总产值不断攀升，预计今年产业园总产值超11亿元，其中生猪养殖产业和蔬菜产业这两大主导产业的产值超7亿元。</p><p class=\"ql-align-justify\">	为了保障产业园的长效运行，石楼镇还创新推动了产业园发展与农民增收的利益联结机制。通过这一机制，农户们能够分享全产业链的利益，实现持续稳定增收。</p><p class=\"ql-align-justify\">	随着石楼镇现代农业产业园的不断发展壮大，一个集绿色农业、生态农业、循环农业于一体的现代农业产业园正在逐步形成。石楼镇将继续深化智慧农业的应用与推广，利用数字技术集聚各方资源要素，发展科技内生动力。同时，进一步探索农业产业升级的新路径、新动能，为北京市乃至全国的农业高质量发展注入新的活力。</p><p><br></p>', '/api/upload/1888758695966277632.jpg', NULL);
INSERT INTO `article` VALUES (4, '二〇二四全球粮食安全峰会在阿联酋闭幕——  “共同促进农业可持续发展”', '进出口贸易', 504, 1, '2025-03-31 15:46:37', '2025-05-04 17:30:51', '', '', '', '<p class=\"ql-align-justify\">日前，2024全球粮食安全峰会在阿联酋首都阿布扎比闭幕。本届峰会以“携手共进 造福人类”为主题，旨在促进全球粮食领域的包容性对话及合作，为实现全球粮食安全提供可持续的解决方案。来自70多个国家和地区的600多名政府官员、国际组织代表以及专家学者和企业负责人围绕建设可持续的粮食体系、维护粮食供应链安全、推动农业技术创新等议题进行深入探讨。</p><p class=\"ql-align-justify\">当前，全球粮食安全面临严峻挑战，需要各方共同应对。埃及农业和土地改良部部长阿拉·法鲁克认为，极端天气、地区冲突等因素交织，使得全球粮食产业链供应链极易受到冲击，实现全球粮食安全面临较大困难。喀麦隆农业和乡村发展部部长加布里埃尔表示，粮食安全问题是各国面临的共同挑战，“各方应深化合作，引入更多先进技术，共同促进农业可持续发展”。</p><p class=\"ql-align-justify\">与会人士认为，促进农业创新和粮食系统可持续发展是维护粮食安全的重要手段。阿联酋气候变化和环境部部长阿米娜表示，在全球气候变化的大背景下，各国需加强专业知识的分享与协作，共同推动全球粮食系统实现包容性和可持续转型。阿联酋经济部部长阿卜杜拉·马里介绍，阿联酋已实施了多项促进粮食安全的举措，在科技研发和价值链整合等方面实施了超过30项倡议。阿拉·法鲁克认为，各国应积极开展农业科学研究与合作，创新投融资机制，畅通粮食产业链供应链，以实际行动提升全球粮食安全水平。</p><p class=\"ql-align-justify\">促进粮食系统的投融资也成为本届会议的重要议题。阿拉伯农业投资和发展管理局分享了通过小额信贷模式助力农户生产的案例。该机构专门为小农户提供融资计划，包括提供必要的资金及种子、肥料等前期投入，与农业研究中心合作提供生产技术支持，为农产品进入市场提供便利。“小农户生产在阿拉伯国家农业生产中占据重要地位，对地区粮食安全至关重要。”阿拉伯农业投资和发展管理局董事会主席奥贝德表示，将继续为小农户提供与其能力相符的便捷融资服务，助力地区粮食生产。</p><p class=\"ql-align-justify\">粮食系统的净零排放同样受到关注。根据世界银行在会上发布的相关研究报告，为实现2030年全球粮食系统温室气体排放减半、2050年前净零排放的目标，全球每年需要投入2600亿美元。到2030年，可带来健康、经济和环境等方面的收益约4.3万亿美元。报告建议，各国应抓住这一投资机遇，在保障粮食安全的同时，促进粮食系统净零排放。在具体路径上，世界银行建议低收入国家避免过度砍伐森林；中等收入国家增加相关投资，减少粮食浪费；高收入国家采取更多措施推动粮食相关部门使用可再生能源，并为中低收入国家发展低排放粮食系统提供更多支持。</p><p class=\"ql-align-justify\">与会代表对中国在维护全球粮食安全、推动农业可持续发展方面所作贡献给予高度评价。阿联酋大学农业与兽医学院院长穆罕默德·雅菲表示，中国在防治沙漠化和促进农业生产等领域取得积极成果，“阿联酋和中国都高度重视粮食安全和农业科技发展与创新，双方取得了一系列务实合作成果，期待未来双方进一步深化在农业领域的合作，为维护全球粮食安全提供助力”。联合国粮食及农业组织驻海合会国家和也门分区域办事处代表卡扬·贾夫在接受本报记者采访时表示，中国加大对农业科技创新的投入，加快创新成果应用，并与各国进行分享，在推动全球粮食安全与农业可持续发展方面发挥了重要作用。此外，中国还是粮农组织南南合作计划的重要合作伙伴，“通过南南合作和三方合作，粮农组织和中国可以更好地支持贫困农户、推广创新技术应用，助力打造全球粮食系统可持续的未来”。</p>', '/api/upload/1888760136579678208.jpg', '');
INSERT INTO `article` VALUES (5, '农业农村部：我国农业种质资源“家底”已全面摸清', '农业', 954, 0, '2025-03-31 15:46:37', '2025-03-31 15:46:37', NULL, NULL, NULL, '<p class=\"ql-align-justify\">	人民网北京12月10日电 （记者李栋）农业种质资源保护利用是种业振兴行动的重要内容，资源普查是“三年打基础”的首要任务。在农业农村部就全国农业种质资源普查情况举行的发布会上，农业农村部种业管理司司长刘莉华介绍，全国第三次农业种质资源普查工作全面完成，通过三年普查工作，我国已摸清农作物、畜禽、水产养殖种质资源的种类数量、区域分布、特征特性等“家底”。</p><p class=\"ql-align-justify\">	优异种质资源是培育优良品种的关键前提。2021年3月，农业农村部会同各地、各有关部门启动了全国农业种质资源普查工作。据介绍，本次是我国实施规模最大、覆盖范围最广、参与人数最多的全国农业种质资源普查。</p><p class=\"ql-align-justify\">	“从范围上看，这次普查覆盖了31个省份和新疆生产建设兵团。”刘莉华介绍，农作物以县域为单元，对全国2323个农业县（市、区）开展了全方位普查，其中包括了前两次普查未涉及的332个农业县，填补了干旱与高原等特殊生态区、边境及少数民族区域的空白。</p><p class=\"ql-align-justify\">	畜禽以行政村为单元，对全国62.5万个行政村开展了拉网式摸排，针对前两次普查未覆盖到的青藏高原区域启动了重点调查，做到了应查尽查。</p><p class=\"ql-align-justify\">	水产以养殖场户为重点，对全国92万多个养殖主体开展全面普查，做到水产养殖区域全覆盖。</p><p class=\"ql-align-justify\">	刘莉华表示，普查成果超出预期。在农作物方面，新收集种质资源13.9万份，覆盖了粮棉油糖、果菜茶桑等，99%为种植历史久远、类型丰富、性状多样的传统地方品种和野生近缘种，目前已全部移交国家库圃安全保存，实现了应收尽收、应保尽保。</p><p class=\"ql-align-justify\">	在畜禽方面，全面查清了畜禽、蜂和蚕资源家底，新发现鉴定地方品种资源51个，采集制作遗传材料107万份，同步对61个濒危资源开展抢救性保护，目前159个国家级保护品种都实现了活体保护。</p><p class=\"ql-align-justify\">	完成普查不是重点，而是资源保护利用工作的新起点。“与第二次普查结果相比，我国原有畜禽地方品种一个没少，还找回了曾经宣布灭绝的10个品种。”刘莉华表示，下一步，将锚定实现种业科技自立自强、种源自主可控的战略目标，进一步加强种质资源收集保护，为加力加快推进种业振兴打下坚实的资源基础。</p><p><br></p>', '/api/upload/1888758933728788481.jpg', NULL);
INSERT INTO `article` VALUES (6, '加快发展现代化大农业', '农业', 820, 0, '2025-03-31 15:46:37', '2025-04-03 16:18:57', NULL, NULL, NULL, '<p>	<strong>【学思践悟】</strong></p><p>	“务农重本，国之大纲。”农业是国民经济的基础。在新时代推动东北全面振兴座谈会上，习近平总书记强调：“要以发展现代化大农业为主攻方向，加快推进农业农村现代化。”新时代新征程，发展现代化大农业是突破农业高质量发展瓶颈的关键举措、推进乡村全面振兴的重要引擎，更是保障我国粮食安全的内在要求、建设农业强国的必然选择。</p><p>	加强耕地资源保护利用。良田是粮之本，沃土是农之基。土地是农业生产最重要的物质载体，是现代化大农业发展的根基。我国作为一个有着14亿多人口的大国，解决好吃饭问题始终是关系国计民生的一个重大问题，保障粮食和重要农产品稳定安全供给始终是建设农业强国的头等大事。耕地是粮食生产的命根子，要依靠自己力量端牢饭碗，保护耕地是根本任务。习近平总书记强调，“要像保护大熊猫那样保护耕地，严防死守18亿亩耕地红线”，“耕地保护要求要非常明确，18亿亩耕地必须实至名归，农田就是农田，而且必须是良田”。因此，必须落实最严格的耕地保护制度，牢牢守住18亿亩耕地红线，保护土地生产能力不受损，将现有农田变成良田，坚决遏制耕地“非农化”，防止永久基本农田“非粮化”，千方百计实现耕地稳定永续利用。</p><p>	土地不仅是农业生产的基础，更是城乡产业链接、农民增收的纽带，能为推进现代化大农业提供资源保障。发展现代化大农业，要注重运用科技手段，实现土地资源精细化管理与高效利用。确保耕地数量不减少、质量有提升，落实藏粮于地、藏粮于技战略，以永久基本农田保护为抓手，注重退化土地生态修复与土壤改良，提升耕地质量和产出能力，让有限的土地产出更大效益，提升农业综合生产能力，筑牢国家粮食安全底线。在此基础上，有序推进土地流转和适度规模经营，促进永久基本农田集中连片，打破在分散细碎的耕地上不方便进行农业机械化生产的桎梏，促进解决农业生产中的负外部性问题。</p><p>	深入推进种业振兴。国以农为本，农以种为先。推进农业现代化，种业是基础。习近平总书记强调，“中国人的饭碗要牢牢端在自己手中，就必须把种子牢牢攥在自己手里”，“种源安全关系到国家安全，必须下决心把我国种业搞上去，实现种业科技自立自强、种源自主可控”。农业生产提质增效得益于单产的提高，而单产提高的条件在于种质。提高种子产量和品质，除加强农田基础设施建设外，还要建立健全现代种业体系，加强种质资源保护利用和种子库建设，提高资源保护、育种创新、品种测试、良种繁育能力，实施农业生物育种重大科技项目，以科技创新驱动种业振兴，努力实现重要农产品的种源自主可控。在尊重科学、严格监管的前提下，有序推进生物育种产业化应用。围绕保障粮食安全和重要农产品供给集中攻关，在基础研究领域，强化种质资源收集、保护与开发利用；在应用领域，强化种业企业创新主体地位，实现种源自主可控，用中国种子保障中国粮食安全。</p><p>	科技赋能，培育农业新质生产力。以科技创新为引领，发展农业新质生产力，对于加快发展现代化大农业具有重要意义。农业生产涉及耕地、种子、农机、农艺、耕作技术、农药化肥、水利设施等诸多领域，这些领域要实现关键性突破都高度依赖科技创新。通过广泛应用大数据、物联网、人工智能等先进技术，对农业生产进行全方位、全过程精准监测，实现智能分析和科学决策，能够让农业生产更加集约、绿色、智能，进而提升农业综合产能、改善农产品品质、降低农业生产成本，实现丰产丰收。</p><p>	发展现代化大农业，必须加快推进生物技术、人工智能技术等与农业产业的深度融合，实现“生物+”现代农业、“人工智能+”现代农业等，挖掘农业发展新动能，开辟农业发展新赛道。大力推进农业工程发展，特别是在数字农业领域，推广智慧农业、精准农业、农业物联网等现代农业技术，完善农业大数据平台建设，通过数字化手段实现农业生产全流程管控，提升生产效率与资源利用率。推进农业无人机等科技装备的普及，助力农业生产智能化发展。培育新质生产力不仅体现在技术应用上，而且要求生产组织模式创新。通过发展农业合作社联合经营、农业企业化运营等模式，实现农业资源整合与产业协同发展。</p><p>	加快建立现代农业产业体系。现代化大农业不仅要在生产端，更要贯穿从生产到加工再到消费的全产业链过程，通过纵向延伸产业链条、横向拓展产业功能和纵深提升价值链层次，形成链条完整、功能复合、价值增值的现代农业产业体系。应从区域特征出发，充分考虑农业资源、气候条件、发展阶段、功能定位、经营习惯等相关因素，因地制宜探索现代化大农业发展的路径和模式，将农业经济效益、社会效益、生态效益有机结合起来。一是延伸产业链，提升农业综合效益。坚持大农业观、大食物观，积极发展特色农业和农产品加工业，提升农业产业化水平。促进农产品加工业升级，协同推进农产品初加工、精深加工和综合利用加工发展，重点培育产业集群，推动由“种得好”向“卖得好”转变，提升农业附加值。二是拓展农业功能性，培育新产业新业态。推动农村一二三产业深度融合，发展生物农业、生态农业、休闲农业等新产业新业态，打破农业产业边界，拓展农业多功能性。三是提升价值链，实现农业全链增值。依托科技创新、政策支持与产业协调，通过精深加工和品牌建设提升农业产品市场竞争力，让农业增值收益更多惠及农民。</p><p>	<strong>（作者：张向达，系东北财经大学社会政策研究中心主任、教授）</strong></p>', '/api/upload/1888759153648730113.jpg', NULL);
INSERT INTO `article` VALUES (7, '【农业新闻】科技赋能乡村振兴，智慧农场加速推动绿色发展', '农业', 1, 0, '2025-04-24 15:57:41', '2025-04-24 16:33:03', '', '', '推广', '<h3>一、河北“金穗农场”：精准滴灌提升粮食品质</h3><p>河北省隆尧县“果然·金穗农场”在传统农作物种植基础上，引入土壤湿度传感器和气象站联网系统。传感器实时监测土壤含水量，气象站提供精细化天气预报，后台大数据平台自动计算作物需水量并精确控制滴灌阀门开闭。</p><ul><li><strong>成效</strong>：玉米亩产较去年提升12%，小麦千粒重提升8%；</li><li><strong>亮点</strong>：全程无公害，已获“绿色食品AA级”认证。</li></ul><h3>二、山东“阳光果园”：智能温室全年无休采摘</h3><p>山东烟台市蓬莱区“丰果·阳光果园”围绕高端苹果和樱桃，建设了5万平方米智能温室。园区搭载环境监测机器人与远程控制系统，可24小时自动调节温度、湿度及CO₂浓度。在冬季仍能保证果实正常生长，并通过扫码即可查看每颗果实的生长日志。</p><ul><li><strong>成效</strong>：寒冬季节果实不受冻害，年收入同比增长15%；</li><li><strong>亮点</strong>：消费者线上下单，最快可实现48小时内果园直采直发。</li></ul><h3>三、四川“山野果庄”：生态种植与旅游采摘相结合</h3><p>四川雅安“果然·山野果庄”依托瓦屋山国家森林公园，推广生态种植理念，将猕猴桃、油桃等特色水果与乡村旅游深度融合。游客可参与果树修剪、授粉体验，并品尝现场鲜果。园区同时建设了有机肥发酵场，实现种养循环、零化肥使用。</p><ul><li><strong>成效</strong>：年接待游客超3万人次，农产品直销增收约200万元；</li><li><strong>亮点</strong>：获评“国家乡村旅游重点村”称号，农旅融合模式走在全省前列。</li></ul><h3>四、吉林“生态牧场”：草饲模式助力肉品升级</h3><p>吉林长春市“鲜海·生态牧场”率先推广欧式草饲放养模式，引进优质草种并配备自动化饲草配送系统，牧场牛猪在无围栏大草原中自由活动。屠宰加工车间同步实施全程可追溯系统，日处理能力达800头。</p><ul><li><strong>成效</strong>：草饲牛肉与传统浓缩饲喂肉品相比，脂肪含量降低20%，口感更佳；</li><li><strong>亮点</strong>：通过HACCP、GMP+及ISO9001认证，产品远销国内外。</li></ul><p><strong>记者点评</strong></p><p> 从北方粮田到南国果园，再到山地生态农庄和生态牧场，智能化、绿色化和多元化成为我国现代农业发展的显著特征。下一步，可进一步推广“农—旅—文”融合、深化数字化农业服务平台建设，用创新驱动乡村全面振兴。</p><p><strong>来源</strong></p><p> 本报记者实地调研并采访相关项目负责人整理。</p>', '/api/upload/2020041037861993-1071151443.jpg', '付费推广');

-- ----------------------------
-- Table structure for article_type
-- ----------------------------
DROP TABLE IF EXISTS `article_type`;
CREATE TABLE `article_type`  (
  `type_id` smallint(5) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '分类ID',
  `display` smallint(4) UNSIGNED NOT NULL DEFAULT 100 COMMENT '显示顺序',
  `name` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '分类名称',
  `father_id` smallint(5) UNSIGNED NOT NULL DEFAULT 0 COMMENT '上级分类ID',
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '描述',
  `icon` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci COMMENT '分类图标',
  `url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '外链地址',
  `create_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间',
  PRIMARY KEY (`type_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '文章分类' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of article_type
-- ----------------------------
INSERT INTO `article_type` VALUES (1, 100, '农业', 0, NULL, NULL, NULL, '2025-03-31 15:46:37', '2025-03-31 15:46:37');
INSERT INTO `article_type` VALUES (2, 100, '进出口贸易', 0, '', '', '', '2025-04-05 11:32:39', '2025-04-05 11:32:39');

-- ----------------------------
-- Table structure for auth
-- ----------------------------
DROP TABLE IF EXISTS `auth`;
CREATE TABLE `auth`  (
  `auth_id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '授权ID',
  `user_group` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '用户组',
  `mod_name` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '模块名',
  `table_name` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '表名',
  `page_title` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '页面标题',
  `path` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '路由路径',
  `parent` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '父级菜单',
  `parent_sort` int(10) NOT NULL DEFAULT 0 COMMENT '父级菜单排序',
  `position` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '位置',
  `mode` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '_blank' COMMENT '跳转方式',
  `add` tinyint(1) UNSIGNED NOT NULL DEFAULT 1 COMMENT '是否可增加',
  `del` tinyint(1) UNSIGNED NOT NULL DEFAULT 1 COMMENT '是否可删除',
  `set` tinyint(1) UNSIGNED NOT NULL DEFAULT 1 COMMENT '是否可修改',
  `get` tinyint(1) UNSIGNED NOT NULL DEFAULT 1 COMMENT '是否可查看',
  `field_add` text CHARACTER SET utf8 COLLATE utf8_general_ci COMMENT '添加字段',
  `field_set` text CHARACTER SET utf8 COLLATE utf8_general_ci COMMENT '修改字段',
  `field_get` text CHARACTER SET utf8 COLLATE utf8_general_ci COMMENT '查询字段',
  `table_nav_name` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '跨表导航名称',
  `table_nav` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '跨表导航',
  `option` text CHARACTER SET utf8 COLLATE utf8_general_ci COMMENT '配置',
  `create_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间',
  PRIMARY KEY (`auth_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 233 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '用户权限管理' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of auth
-- ----------------------------
INSERT INTO `auth` VALUES (1, '管理员', '农户商家', 'farmers_merchants', '农户商家', '/farmers_merchants/table', '', 0, '', '_blank', 1, 1, 1, 1, 'business_name,contact_number,business_address,business_license,certification_application', 'business_name,contact_number,business_address,business_license,certification_application', 'business_name,contact_number,business_address,business_license,certification_application', NULL, '0', '{\"examine\":true}', '2025-03-31 15:46:36', '2025-03-31 15:46:36');
INSERT INTO `auth` VALUES (2, '管理员', '农户商家', 'farmers_merchants', '商家详情', '/farmers_merchants/view', '', 0, '', '_blank', 1, 1, 1, 1, 'business_name,contact_number,business_address,business_license,certification_application', 'business_name,contact_number,business_address,business_license,certification_application', 'business_name,contact_number,business_address,business_license,certification_application', NULL, '0', '{}', '2025-03-31 15:46:36', '2025-03-31 15:46:36');
INSERT INTO `auth` VALUES (3, '管理员', '消费者', 'consumer', '消费者', '/consumer/table', '', 0, '', '_blank', 1, 1, 1, 1, 'user_name,mobile_phone_number', 'user_name,mobile_phone_number', 'user_name,mobile_phone_number', NULL, '0', '{}', '2025-03-31 15:46:36', '2025-03-31 15:46:36');
INSERT INTO `auth` VALUES (4, '管理员', '消费者', 'consumer', '费者详情', '/consumer/view', '', 0, '', '_blank', 1, 1, 1, 1, 'user_name,mobile_phone_number', 'user_name,mobile_phone_number', 'user_name,mobile_phone_number', NULL, '0', '{}', '2025-03-31 15:46:36', '2025-03-31 15:46:36');
INSERT INTO `auth` VALUES (5, '管理员', '农产品', 'agricultural_products', '农产品', '/agricultural_products/table', '', 0, '', '_blank', 1, 1, 1, 1, 'product_specifications,farmers_merchants,business_name,contact_number,business_address', 'product_specifications,farmers_merchants,business_name,contact_number,business_address', 'product_specifications,farmers_merchants,business_name,contact_number,business_address', NULL, '0', '{\"can_show_comment\":true}', '2025-03-31 15:46:36', '2025-03-31 15:46:36');
INSERT INTO `auth` VALUES (6, '管理员', '农产品', 'agricultural_products', '产品详情', '/agricultural_products/view', '', 0, '', '_blank', 1, 1, 1, 1, 'product_specifications,farmers_merchants,business_name,contact_number,business_address', 'product_specifications,farmers_merchants,business_name,contact_number,business_address', 'product_specifications,farmers_merchants,business_name,contact_number,business_address', NULL, '0', '{}', '2025-03-31 15:46:36', '2025-03-31 15:46:36');
INSERT INTO `auth` VALUES (7, '管理员', '农产品', 'agricultural_products', '农产品', '/agricultural_products/list', '', 0, '', '_blank', 1, 1, 1, 1, 'product_specifications,farmers_merchants,business_name,contact_number,business_address', 'product_specifications,farmers_merchants,business_name,contact_number,business_address', 'product_specifications,farmers_merchants,business_name,contact_number,business_address', NULL, '0', '{\"cart_page\":true}', '2025-03-31 15:46:36', '2025-03-31 15:46:36');
INSERT INTO `auth` VALUES (8, '管理员', '农产品', 'agricultural_products', '产品详情', '/agricultural_products/details', '', 0, '', '_blank', 1, 1, 1, 1, 'product_specifications,farmers_merchants,business_name,contact_number,business_address', 'product_specifications,farmers_merchants,business_name,contact_number,business_address', 'product_specifications,farmers_merchants,business_name,contact_number,business_address', NULL, '0', '{\"can_comment\":true,\"can_show_comment\":true,\"cart_page\":true}', '2025-03-31 15:46:36', '2025-03-31 15:46:36');
INSERT INTO `auth` VALUES (9, '管理员', '产地展示', 'origin_display', '产地展示', '/origin_display/table', '', 0, '', '_blank', 1, 1, 1, 1, 'name_of_place_of_origin,cover_chart,place_of_origin_address,type_of_place_of_origin,scale_of_origin,introduction_of_origin,farmers_merchants,business_name,contact_number,business_address', 'name_of_place_of_origin,cover_chart,place_of_origin_address,type_of_place_of_origin,scale_of_origin,introduction_of_origin,farmers_merchants,business_name,contact_number,business_address', 'name_of_place_of_origin,cover_chart,place_of_origin_address,type_of_place_of_origin,scale_of_origin,introduction_of_origin,farmers_merchants,business_name,contact_number,business_address', NULL, '0', '{\"can_show_comment\":true}', '2025-03-31 15:46:36', '2025-03-31 15:46:36');
INSERT INTO `auth` VALUES (10, '管理员', '产地展示', 'origin_display', '展示详情', '/origin_display/view', '', 0, '', '_blank', 1, 1, 1, 1, 'name_of_place_of_origin,cover_chart,place_of_origin_address,type_of_place_of_origin,scale_of_origin,introduction_of_origin,farmers_merchants,business_name,contact_number,business_address', 'name_of_place_of_origin,cover_chart,place_of_origin_address,type_of_place_of_origin,scale_of_origin,introduction_of_origin,farmers_merchants,business_name,contact_number,business_address', 'name_of_place_of_origin,cover_chart,place_of_origin_address,type_of_place_of_origin,scale_of_origin,introduction_of_origin,farmers_merchants,business_name,contact_number,business_address', NULL, '0', '{}', '2025-03-31 15:46:36', '2025-03-31 15:46:36');
INSERT INTO `auth` VALUES (11, '管理员', '产地展示', 'origin_display', '产地展示', '/origin_display/list', '', 0, 'top', '_blank', 1, 1, 1, 1, 'name_of_place_of_origin,cover_chart,place_of_origin_address,type_of_place_of_origin,scale_of_origin,introduction_of_origin,farmers_merchants,business_name,contact_number,business_address', 'name_of_place_of_origin,cover_chart,place_of_origin_address,type_of_place_of_origin,scale_of_origin,introduction_of_origin,farmers_merchants,business_name,contact_number,business_address', 'name_of_place_of_origin,cover_chart,place_of_origin_address,type_of_place_of_origin,scale_of_origin,introduction_of_origin,farmers_merchants,business_name,contact_number,business_address', NULL, '0', '{}', '2025-03-31 15:46:36', '2025-03-31 15:46:36');
INSERT INTO `auth` VALUES (12, '管理员', '产地展示', 'origin_display', '展示详情', '/origin_display/details', '', 0, '', '_blank', 1, 1, 1, 1, 'name_of_place_of_origin,cover_chart,place_of_origin_address,type_of_place_of_origin,scale_of_origin,introduction_of_origin,farmers_merchants,business_name,contact_number,business_address', 'name_of_place_of_origin,cover_chart,place_of_origin_address,type_of_place_of_origin,scale_of_origin,introduction_of_origin,farmers_merchants,business_name,contact_number,business_address', 'name_of_place_of_origin,cover_chart,place_of_origin_address,type_of_place_of_origin,scale_of_origin,introduction_of_origin,farmers_merchants,business_name,contact_number,business_address', NULL, '0', '{\"can_comment\":true,\"can_show_comment\":true}', '2025-03-31 15:46:36', '2025-03-31 15:46:36');
INSERT INTO `auth` VALUES (13, '管理员', '产地类型', 'type_of_place_of_origin', '产地类型', '/type_of_place_of_origin/table', '', 0, '', '_blank', 1, 1, 1, 1, 'type_of_place_of_origin', 'type_of_place_of_origin', 'type_of_place_of_origin', NULL, '0', '{}', '2025-03-31 15:46:36', '2025-03-31 15:46:36');
INSERT INTO `auth` VALUES (14, '管理员', '产地类型', 'type_of_place_of_origin', '类型详情', '/type_of_place_of_origin/view', '', 0, '', '_blank', 1, 1, 1, 1, 'type_of_place_of_origin', 'type_of_place_of_origin', 'type_of_place_of_origin', NULL, '0', '{}', '2025-03-31 15:46:36', '2025-03-31 15:46:36');
INSERT INTO `auth` VALUES (15, '管理员', '互动咨询', 'interactive_consultation', '互动咨询', '/interactive_consultation/table', '', 0, '', '_blank', 1, 1, 0, 1, 'consultation_number,farmers_merchants,business_name,contact_number,business_address,date_of_consultation,consulting_users,consulting_content', 'consultation_number,farmers_merchants,business_name,contact_number,business_address,date_of_consultation,consulting_users,consulting_content', 'consultation_number,farmers_merchants,business_name,contact_number,business_address,date_of_consultation,consulting_users,consulting_content', NULL, '0', '{}', '2025-03-31 15:46:36', '2025-03-31 15:46:36');
INSERT INTO `auth` VALUES (16, '管理员', '互动咨询', 'interactive_consultation', '咨询详情', '/interactive_consultation/view', '', 0, '', '_blank', 1, 1, 0, 1, 'consultation_number,farmers_merchants,business_name,contact_number,business_address,date_of_consultation,consulting_users,consulting_content', 'consultation_number,farmers_merchants,business_name,contact_number,business_address,date_of_consultation,consulting_users,consulting_content', 'consultation_number,farmers_merchants,business_name,contact_number,business_address,date_of_consultation,consulting_users,consulting_content', NULL, '0', '{\"can_limits\":true}', '2025-03-31 15:46:36', '2025-03-31 15:46:36');
INSERT INTO `auth` VALUES (17, '管理员', '互动咨询', 'interactive_consultation', '互动咨询', '/interactive_consultation/edit', '', 0, '', '_blank', 1, 1, 1, 1, 'consultation_number,farmers_merchants,business_name,contact_number,business_address,date_of_consultation,consulting_users,consulting_content', 'consultation_number,farmers_merchants,business_name,contact_number,business_address,date_of_consultation,consulting_users,consulting_content', 'consultation_number,farmers_merchants,business_name,contact_number,business_address,date_of_consultation,consulting_users,consulting_content', NULL, '0', '{}', '2025-03-31 15:46:36', '2025-03-31 15:46:36');
INSERT INTO `auth` VALUES (18, '管理员', '咨询回复', 'consultation_reply', '咨询回复', '/consultation_reply/table', '', 0, '', '_blank', 0, 1, 0, 1, 'consultation_number,farmers_merchants,business_name,contact_number,business_address,date_of_consultation,consulting_users,consulting_content,reply_content', 'consultation_number,farmers_merchants,business_name,contact_number,business_address,date_of_consultation,consulting_users,consulting_content,reply_content', 'consultation_number,farmers_merchants,business_name,contact_number,business_address,date_of_consultation,consulting_users,consulting_content,reply_content', NULL, '0', '{}', '2025-03-31 15:46:36', '2025-03-31 15:46:36');
INSERT INTO `auth` VALUES (19, '管理员', '咨询回复', 'consultation_reply', '回复详情', '/consultation_reply/view', '', 0, '', '_blank', 0, 1, 0, 1, 'consultation_number,farmers_merchants,business_name,contact_number,business_address,date_of_consultation,consulting_users,consulting_content,reply_content', 'consultation_number,farmers_merchants,business_name,contact_number,business_address,date_of_consultation,consulting_users,consulting_content,reply_content', 'consultation_number,farmers_merchants,business_name,contact_number,business_address,date_of_consultation,consulting_users,consulting_content,reply_content', NULL, '0', '{}', '2025-03-31 15:46:36', '2025-03-31 15:46:36');
INSERT INTO `auth` VALUES (20, '管理员', '生产计划', 'production_planning', '生产计划', '/production_planning/table', '', 0, '', '_blank', 0, 1, 0, 1, 'plan_no,schedule_title,planned_date,plan_content,farmers_merchants', 'plan_no,schedule_title,planned_date,plan_content,farmers_merchants', 'plan_no,schedule_title,planned_date,plan_content,farmers_merchants', NULL, '0', '{}', '2025-03-31 15:46:36', '2025-03-31 15:46:36');
INSERT INTO `auth` VALUES (21, '管理员', '生产计划', 'production_planning', '计划详情', '/production_planning/view', '', 0, '', '_blank', 0, 1, 0, 1, 'plan_no,schedule_title,planned_date,plan_content,farmers_merchants', 'plan_no,schedule_title,planned_date,plan_content,farmers_merchants', 'plan_no,schedule_title,planned_date,plan_content,farmers_merchants', NULL, '0', '{}', '2025-03-31 15:46:36', '2025-03-31 15:46:36');
INSERT INTO `auth` VALUES (22, '管理员', '经验分享', 'experience_sharing', '经验分享', '/experience_sharing/table', '', 0, '', '_blank', 0, 1, 0, 1, 'title,share_type,experience_content', 'title,share_type,experience_content', 'title,share_type,experience_content', NULL, '0', '{}', '2025-03-31 15:46:36', '2025-03-31 15:46:36');
INSERT INTO `auth` VALUES (23, '管理员', '经验分享', 'experience_sharing', '分享详情', '/experience_sharing/view', '', 0, '', '_blank', 0, 1, 0, 1, 'title,share_type,experience_content', 'title,share_type,experience_content', 'title,share_type,experience_content', NULL, '0', '{}', '2025-03-31 15:46:36', '2025-03-31 15:46:36');
INSERT INTO `auth` VALUES (24, '管理员', '分享类型', 'share_type', '分享类型', '/share_type/table', '', 0, '', '_blank', 1, 1, 1, 1, 'share_type', 'share_type', 'share_type', NULL, '0', '{}', '2025-03-31 15:46:36', '2025-03-31 15:46:36');
INSERT INTO `auth` VALUES (25, '管理员', '分享类型', 'share_type', '类型详情', '/share_type/view', '', 0, '', '_blank', 1, 1, 1, 1, 'share_type', 'share_type', 'share_type', NULL, '0', '{}', '2025-03-31 15:46:36', '2025-03-31 15:46:36');
INSERT INTO `auth` VALUES (26, '管理员', '我的收藏', 'collect', '我的收藏', '/collect/list', '', 0, '', '_blank', 1, 1, 1, 1, '', '', '', NULL, '0', '{}', '2025-03-31 15:46:36', '2025-03-31 15:46:36');
INSERT INTO `auth` VALUES (27, '管理员', '订单', 'order', '订单列表', '/order/table', '', 0, '', '_blank', 1, 1, 1, 1, '', '', '', NULL, '0', '{\"figure\":true,\"print\":true,\"export_db\":true}', '2025-03-31 15:46:36', '2025-03-31 15:46:36');
INSERT INTO `auth` VALUES (28, '管理员', '订单', 'order', '订单详情', '/order/view', '', 0, '', '_blank', 1, 1, 1, 1, '', '', '', NULL, '0', '{\"print\":true}', '2025-03-31 15:46:36', '2025-03-31 15:46:36');
INSERT INTO `auth` VALUES (29, '管理员', '订单', 'order', '我的订单', '/order/list', '', 0, '', '_blank', 1, 1, 1, 1, '', '', '', NULL, '0', '{}', '2025-03-31 15:46:36', '2025-03-31 15:46:36');
INSERT INTO `auth` VALUES (30, '管理员', '订单', 'order', '订单详情', '/order/details', '', 0, '', '_blank', 1, 1, 1, 1, '', '', '', NULL, '0', '{\"can_comment\":true,\"can_score\":true,\"can_show_comment\":true,\"can_show_score\":true}', '2025-03-31 15:46:36', '2025-03-31 15:46:36');
INSERT INTO `auth` VALUES (31, '管理员', '商品', 'goods', '商品列表', '/goods/table', '', 0, '', '_blank', 1, 1, 1, 1, '', '', '', NULL, '0', '{\"seller\":true,\"print\":true,\"export_db\":true,\"import_db\":true}', '2025-03-31 15:46:36', '2025-03-31 15:46:36');
INSERT INTO `auth` VALUES (32, '管理员', '商品', 'goods', '商品详情', '/goods/view', '', 0, '', '_blank', 1, 1, 1, 1, '', '', '', NULL, '0', '{\"print\":true}', '2025-03-31 15:46:36', '2025-03-31 15:46:36');
INSERT INTO `auth` VALUES (33, '管理员', '商品', 'goods', '商品列表', '/goods/list', '', 0, '', '_blank', 1, 1, 1, 1, '', '', '', NULL, '0', '{}', '2025-03-31 15:46:36', '2025-03-31 15:46:36');
INSERT INTO `auth` VALUES (34, '管理员', '商品', 'goods', '商品详情', '/goods/details', '', 0, '', '_blank', 1, 1, 1, 1, '', '', '', NULL, '0', '{\"can_comment\":true,\"can_score\":true,\"can_show_comment\":true,\"can_show_score\":true}', '2025-03-31 15:46:36', '2025-03-31 15:46:36');
INSERT INTO `auth` VALUES (35, '管理员', '收货地址', 'address', '收货地址', '/address/list', '', 0, '', '_blank', 1, 1, 1, 1, '', '', '', NULL, '0', '{}', '2025-03-31 15:46:36', '2025-03-31 15:46:36');
INSERT INTO `auth` VALUES (36, '管理员', '收货地址', 'address', '地址详情', '/address/details', '', 0, '', '_blank', 1, 1, 1, 1, '', '', '', NULL, '0', '{}', '2025-03-31 15:46:36', '2025-03-31 15:46:36');
INSERT INTO `auth` VALUES (37, '管理员', '配送', 'logistics_delivery', '订单配送', '/logistics_delivery/table', '', 0, '', '_blank', 1, 1, 1, 1, '', '', '', NULL, '0', '{\"sign_for\":true}', '2025-03-31 15:46:36', '2025-03-31 15:46:36');
INSERT INTO `auth` VALUES (38, '管理员', '配送', 'logistics_delivery', '订单配送', '/logistics_delivery/view', '', 0, '', '_blank', 1, 1, 1, 1, '', '', '', NULL, '0', '{}', '2025-03-31 15:46:36', '2025-03-31 15:46:36');
INSERT INTO `auth` VALUES (39, '管理员', '评论', 'comment', '评论列表', '/comment/table', '', 0, '', '_blank', 1, 1, 1, 1, '', '', '', NULL, '0', '{}', '2025-03-31 15:46:36', '2025-03-31 15:46:36');
INSERT INTO `auth` VALUES (40, '管理员', '评论', 'comment', '评论详情', '/comment/view', '', 0, '', '_blank', 1, 1, 1, 1, '', '', '', NULL, '0', '{}', '2025-03-31 15:46:36', '2025-03-31 15:46:36');
INSERT INTO `auth` VALUES (41, '管理员', '评论', 'comment', '我的评论', '/comment/list', '', 0, '', '_blank', 1, 1, 1, 1, '', '', '', NULL, '0', '{}', '2025-03-31 15:46:36', '2025-03-31 15:46:36');
INSERT INTO `auth` VALUES (42, '管理员', '评论', 'comment', '评论详情', '/comment/details', '', 0, '', '_blank', 1, 1, 1, 1, '', '', '', NULL, '0', '{}', '2025-03-31 15:46:36', '2025-03-31 15:46:36');
INSERT INTO `auth` VALUES (43, '管理员', '交流论坛', 'forum', '交流论坛', '/forum/table', '', 0, '', '_blank', 1, 1, 1, 1, '', '', '', NULL, '0', '{\"print\":true,\"export_db\":true,\"import_db\":true}', '2025-03-31 15:46:36', '2025-03-31 15:46:36');
INSERT INTO `auth` VALUES (44, '管理员', '交流论坛', 'forum', '论坛详情', '/forum/view', '', 0, '', '_blank', 1, 1, 1, 1, '', '', '', NULL, '0', '{\"print\":true}', '2025-03-31 15:46:36', '2025-03-31 15:46:36');
INSERT INTO `auth` VALUES (45, '管理员', '交流论坛', 'forum', '交流论坛', '/forum/list', '', 0, '', '_blank', 1, 1, 1, 1, '', '', '', NULL, '0', '{}', '2025-03-31 15:46:36', '2025-03-31 15:46:36');
INSERT INTO `auth` VALUES (46, '管理员', '交流论坛', 'forum', '论坛详情', '/forum/details', '', 0, '', '_blank', 1, 1, 1, 1, '', '', '', NULL, '0', '{\"can_comment\":true,\"can_show_comment\":true}', '2025-03-31 15:46:36', '2025-03-31 15:46:36');
INSERT INTO `auth` VALUES (47, '管理员', '论坛分类', 'forum_type', '论坛分类', '/forum_type/table', '', 0, '', '_blank', 1, 1, 1, 1, '', '', '', NULL, '0', '{}', '2025-03-31 15:46:36', '2025-03-31 15:46:36');
INSERT INTO `auth` VALUES (48, '管理员', '论坛分类', 'forum_type', '分类详情', '/forum_type/view', '', 0, '', '_blank', 1, 1, 1, 1, '', '', '', NULL, '0', '{}', '2025-03-31 15:46:36', '2025-03-31 15:46:36');
INSERT INTO `auth` VALUES (49, '管理员', '农业知识', 'article', '农业知识', '/article/table', '', 0, '', '_blank', 1, 1, 1, 1, '', '', '', NULL, '0', '{\"print\":true,\"export_db\":true,\"import_db\":true}', '2025-03-31 15:46:36', '2025-03-31 15:46:36');
INSERT INTO `auth` VALUES (50, '管理员', '农业知识', 'article', '知识详情', '/article/view', '', 0, '', '_blank', 1, 1, 1, 1, '', '', '', NULL, '0', '{\"print\":true}', '2025-03-31 15:46:36', '2025-03-31 15:46:36');
INSERT INTO `auth` VALUES (51, '管理员', '农业知识', 'article', '农业知识', '/article/list', '', 0, '', '_blank', 1, 1, 1, 1, '', '', '', NULL, '0', '{}', '2025-03-31 15:46:36', '2025-03-31 15:46:36');
INSERT INTO `auth` VALUES (52, '管理员', '农业知识', 'article', '知识详情', '/article/details', '', 0, '', '_blank', 1, 1, 1, 1, '', '', '', NULL, '0', '{\"can_comment\":true,\"can_show_comment\":true}', '2025-03-31 15:46:36', '2025-03-31 15:46:36');
INSERT INTO `auth` VALUES (53, '管理员', '知识分类', 'article_type', '知识分类', '/article_type/table', '', 0, '', '_blank', 1, 1, 1, 1, '', '', '', NULL, '0', '{}', '2025-03-31 15:46:36', '2025-03-31 15:46:36');
INSERT INTO `auth` VALUES (54, '管理员', '知识分类', 'article_type', '分类详情', '/article_type/view', '', 0, '', '_blank', 1, 1, 1, 1, '', '', '', NULL, '0', '{}', '2025-03-31 15:46:36', '2025-03-31 15:46:36');
INSERT INTO `auth` VALUES (55, '管理员', '留言投诉', 'message', '留言投诉', '/message/table', '', 0, '', '_blank', 1, 1, 1, 1, '', '', '', NULL, '0', '{}', '2025-03-31 15:46:36', '2025-03-31 15:46:36');
INSERT INTO `auth` VALUES (56, '管理员', '留言投诉', 'message', '投诉详情', '/message/view', '', 0, '', '_blank', 1, 1, 1, 1, '', '', '', NULL, '0', '{}', '2025-03-31 15:46:36', '2025-03-31 15:46:36');
INSERT INTO `auth` VALUES (57, '管理员', '留言投诉', 'message', '留言投诉', '/message/list', '', 0, '', '_blank', 1, 1, 1, 1, '', '', '', NULL, '0', '{}', '2025-03-31 15:46:36', '2025-03-31 15:46:36');
INSERT INTO `auth` VALUES (58, '管理员', '留言投诉', 'message', '提交留言', '/message/edit', '', 0, '', '_blank', 1, 1, 1, 1, '', '', '', NULL, '0', '{}', '2025-03-31 15:46:36', '2025-03-31 15:46:36');
INSERT INTO `auth` VALUES (59, '游客', '农户商家', 'farmers_merchants', '农户商家', '/farmers_merchants/table', '', 0, '', '_blank', 1, 0, 0, 0, 'business_name,contact_number,business_address,business_license,certification_application', 'business_name,contact_number,business_address,business_license,certification_application', 'business_name,contact_number,business_address,business_license,certification_application', NULL, '0', '{\"examine\":false}', '2025-03-31 15:46:36', '2025-03-31 15:46:36');
INSERT INTO `auth` VALUES (60, '游客', '农户商家', 'farmers_merchants', '商家详情', '/farmers_merchants/view', '', 0, '', '_blank', 1, 0, 0, 0, 'business_name,contact_number,business_address,business_license,certification_application', 'business_name,contact_number,business_address,business_license,certification_application', 'business_name,contact_number,business_address,business_license,certification_application', NULL, '0', '{}', '2025-03-31 15:46:36', '2025-03-31 15:46:36');
INSERT INTO `auth` VALUES (61, '游客', '消费者', 'consumer', '消费者', '/consumer/table', '', 0, '', '_blank', 1, 0, 0, 0, 'user_name,mobile_phone_number', 'user_name,mobile_phone_number', 'user_name,mobile_phone_number', NULL, '0', '{}', '2025-03-31 15:46:36', '2025-03-31 15:46:36');
INSERT INTO `auth` VALUES (62, '游客', '消费者', 'consumer', '费者详情', '/consumer/view', '', 0, '', '_blank', 1, 0, 0, 0, 'user_name,mobile_phone_number', 'user_name,mobile_phone_number', 'user_name,mobile_phone_number', NULL, '0', '{}', '2025-03-31 15:46:36', '2025-03-31 15:46:36');
INSERT INTO `auth` VALUES (63, '游客', '农产品', 'agricultural_products', '农产品', '/agricultural_products/table', '', 0, '', '_blank', 0, 0, 0, 0, 'product_specifications,farmers_merchants,business_name,contact_number,business_address', 'product_specifications,farmers_merchants,business_name,contact_number,business_address', 'product_specifications,farmers_merchants,business_name,contact_number,business_address', NULL, '0', '{\"can_show_comment\":false}', '2025-03-31 15:46:36', '2025-03-31 15:46:36');
INSERT INTO `auth` VALUES (64, '游客', '农产品', 'agricultural_products', '产品详情', '/agricultural_products/view', '', 0, '', '_blank', 0, 0, 0, 0, 'product_specifications,farmers_merchants,business_name,contact_number,business_address', 'product_specifications,farmers_merchants,business_name,contact_number,business_address', 'product_specifications,farmers_merchants,business_name,contact_number,business_address', NULL, '0', '{}', '2025-03-31 15:46:36', '2025-03-31 15:46:36');
INSERT INTO `auth` VALUES (65, '游客', '农产品', 'agricultural_products', '农产品', '/agricultural_products/list', '', 0, '', '_blank', 0, 0, 0, 1, 'product_specifications,farmers_merchants,business_name,contact_number,business_address', 'product_specifications,farmers_merchants,business_name,contact_number,business_address', 'product_specifications,farmers_merchants,business_name,contact_number,business_address', NULL, '0', '{\"cart_page\":false}', '2025-03-31 15:46:36', '2025-03-31 15:46:36');
INSERT INTO `auth` VALUES (66, '游客', '农产品', 'agricultural_products', '产品详情', '/agricultural_products/details', '', 0, '', '_blank', 0, 0, 0, 1, 'product_specifications,farmers_merchants,business_name,contact_number,business_address', 'product_specifications,farmers_merchants,business_name,contact_number,business_address', 'product_specifications,farmers_merchants,business_name,contact_number,business_address', NULL, '0', '{\"can_comment\":false,\"can_show_comment\":true,\"cart_page\":false}', '2025-03-31 15:46:36', '2025-03-31 15:46:36');
INSERT INTO `auth` VALUES (67, '游客', '产地展示', 'origin_display', '产地展示', '/origin_display/table', '', 0, '', '_blank', 0, 0, 0, 0, 'name_of_place_of_origin,cover_chart,place_of_origin_address,type_of_place_of_origin,scale_of_origin,introduction_of_origin,farmers_merchants,business_name,contact_number,business_address', 'name_of_place_of_origin,cover_chart,place_of_origin_address,type_of_place_of_origin,scale_of_origin,introduction_of_origin,farmers_merchants,business_name,contact_number,business_address', 'name_of_place_of_origin,cover_chart,place_of_origin_address,type_of_place_of_origin,scale_of_origin,introduction_of_origin,farmers_merchants,business_name,contact_number,business_address', NULL, '0', '{\"can_show_comment\":false}', '2025-03-31 15:46:36', '2025-03-31 15:46:36');
INSERT INTO `auth` VALUES (68, '游客', '产地展示', 'origin_display', '展示详情', '/origin_display/view', '', 0, '', '_blank', 0, 0, 0, 0, 'name_of_place_of_origin,cover_chart,place_of_origin_address,type_of_place_of_origin,scale_of_origin,introduction_of_origin,farmers_merchants,business_name,contact_number,business_address', 'name_of_place_of_origin,cover_chart,place_of_origin_address,type_of_place_of_origin,scale_of_origin,introduction_of_origin,farmers_merchants,business_name,contact_number,business_address', 'name_of_place_of_origin,cover_chart,place_of_origin_address,type_of_place_of_origin,scale_of_origin,introduction_of_origin,farmers_merchants,business_name,contact_number,business_address', NULL, '0', '{}', '2025-03-31 15:46:36', '2025-03-31 15:46:36');
INSERT INTO `auth` VALUES (69, '游客', '产地展示', 'origin_display', '产地展示', '/origin_display/list', '', 0, 'top', '_blank', 0, 0, 0, 1, 'name_of_place_of_origin,cover_chart,place_of_origin_address,type_of_place_of_origin,scale_of_origin,introduction_of_origin,farmers_merchants,business_name,contact_number,business_address', 'name_of_place_of_origin,cover_chart,place_of_origin_address,type_of_place_of_origin,scale_of_origin,introduction_of_origin,farmers_merchants,business_name,contact_number,business_address', 'name_of_place_of_origin,cover_chart,place_of_origin_address,type_of_place_of_origin,scale_of_origin,introduction_of_origin,farmers_merchants,business_name,contact_number,business_address', NULL, '0', '{}', '2025-03-31 15:46:36', '2025-03-31 15:46:36');
INSERT INTO `auth` VALUES (70, '游客', '产地展示', 'origin_display', '展示详情', '/origin_display/details', '', 0, '', '_blank', 0, 0, 0, 1, 'name_of_place_of_origin,cover_chart,place_of_origin_address,type_of_place_of_origin,scale_of_origin,introduction_of_origin,farmers_merchants,business_name,contact_number,business_address', 'name_of_place_of_origin,cover_chart,place_of_origin_address,type_of_place_of_origin,scale_of_origin,introduction_of_origin,farmers_merchants,business_name,contact_number,business_address', 'name_of_place_of_origin,cover_chart,place_of_origin_address,type_of_place_of_origin,scale_of_origin,introduction_of_origin,farmers_merchants,business_name,contact_number,business_address', NULL, '0', '{\"can_comment\":false,\"can_show_comment\":true}', '2025-03-31 15:46:36', '2025-03-31 15:46:36');
INSERT INTO `auth` VALUES (71, '游客', '产地类型', 'type_of_place_of_origin', '产地类型', '/type_of_place_of_origin/table', '', 0, '', '_blank', 0, 0, 0, 0, 'type_of_place_of_origin', 'type_of_place_of_origin', 'type_of_place_of_origin', NULL, '0', '{}', '2025-03-31 15:46:36', '2025-03-31 15:46:36');
INSERT INTO `auth` VALUES (72, '游客', '产地类型', 'type_of_place_of_origin', '类型详情', '/type_of_place_of_origin/view', '', 0, '', '_blank', 0, 0, 0, 0, 'type_of_place_of_origin', 'type_of_place_of_origin', 'type_of_place_of_origin', NULL, '0', '{}', '2025-03-31 15:46:36', '2025-03-31 15:46:36');
INSERT INTO `auth` VALUES (73, '游客', '互动咨询', 'interactive_consultation', '互动咨询', '/interactive_consultation/table', '', 0, '', '_blank', 0, 0, 0, 0, 'consultation_number,farmers_merchants,business_name,contact_number,business_address,date_of_consultation,consulting_users,consulting_content', 'consultation_number,farmers_merchants,business_name,contact_number,business_address,date_of_consultation,consulting_users,consulting_content', 'consultation_number,farmers_merchants,business_name,contact_number,business_address,date_of_consultation,consulting_users,consulting_content', NULL, '0', '{}', '2025-03-31 15:46:36', '2025-03-31 15:46:36');
INSERT INTO `auth` VALUES (74, '游客', '互动咨询', 'interactive_consultation', '咨询详情', '/interactive_consultation/view', '', 0, '', '_blank', 0, 0, 0, 0, 'consultation_number,farmers_merchants,business_name,contact_number,business_address,date_of_consultation,consulting_users,consulting_content', 'consultation_number,farmers_merchants,business_name,contact_number,business_address,date_of_consultation,consulting_users,consulting_content', 'consultation_number,farmers_merchants,business_name,contact_number,business_address,date_of_consultation,consulting_users,consulting_content', NULL, '0', '{\"can_limits\":false}', '2025-03-31 15:46:36', '2025-03-31 15:46:36');
INSERT INTO `auth` VALUES (75, '游客', '互动咨询', 'interactive_consultation', '互动咨询', '/interactive_consultation/edit', '', 0, '', '_blank', 0, 0, 0, 0, 'consultation_number,farmers_merchants,business_name,contact_number,business_address,date_of_consultation,consulting_users,consulting_content', 'consultation_number,farmers_merchants,business_name,contact_number,business_address,date_of_consultation,consulting_users,consulting_content', 'consultation_number,farmers_merchants,business_name,contact_number,business_address,date_of_consultation,consulting_users,consulting_content', NULL, '0', '{}', '2025-03-31 15:46:36', '2025-03-31 15:46:36');
INSERT INTO `auth` VALUES (76, '游客', '咨询回复', 'consultation_reply', '咨询回复', '/consultation_reply/table', '', 0, '', '_blank', 0, 0, 0, 0, 'consultation_number,farmers_merchants,business_name,contact_number,business_address,date_of_consultation,consulting_users,consulting_content,reply_content', 'consultation_number,farmers_merchants,business_name,contact_number,business_address,date_of_consultation,consulting_users,consulting_content,reply_content', 'consultation_number,farmers_merchants,business_name,contact_number,business_address,date_of_consultation,consulting_users,consulting_content,reply_content', NULL, '0', '{}', '2025-03-31 15:46:36', '2025-03-31 15:46:36');
INSERT INTO `auth` VALUES (77, '游客', '咨询回复', 'consultation_reply', '回复详情', '/consultation_reply/view', '', 0, '', '_blank', 0, 0, 0, 0, 'consultation_number,farmers_merchants,business_name,contact_number,business_address,date_of_consultation,consulting_users,consulting_content,reply_content', 'consultation_number,farmers_merchants,business_name,contact_number,business_address,date_of_consultation,consulting_users,consulting_content,reply_content', 'consultation_number,farmers_merchants,business_name,contact_number,business_address,date_of_consultation,consulting_users,consulting_content,reply_content', NULL, '0', '{}', '2025-03-31 15:46:36', '2025-03-31 15:46:36');
INSERT INTO `auth` VALUES (78, '游客', '生产计划', 'production_planning', '生产计划', '/production_planning/table', '', 0, '', '_blank', 0, 0, 0, 0, 'plan_no,schedule_title,planned_date,plan_content,farmers_merchants', 'plan_no,schedule_title,planned_date,plan_content,farmers_merchants', 'plan_no,schedule_title,planned_date,plan_content,farmers_merchants', NULL, '0', '{}', '2025-03-31 15:46:36', '2025-03-31 15:46:36');
INSERT INTO `auth` VALUES (79, '游客', '生产计划', 'production_planning', '计划详情', '/production_planning/view', '', 0, '', '_blank', 0, 0, 0, 0, 'plan_no,schedule_title,planned_date,plan_content,farmers_merchants', 'plan_no,schedule_title,planned_date,plan_content,farmers_merchants', 'plan_no,schedule_title,planned_date,plan_content,farmers_merchants', NULL, '0', '{}', '2025-03-31 15:46:36', '2025-03-31 15:46:36');
INSERT INTO `auth` VALUES (80, '游客', '经验分享', 'experience_sharing', '经验分享', '/experience_sharing/table', '', 0, '', '_blank', 0, 0, 0, 0, 'title,share_type,experience_content', 'title,share_type,experience_content', 'title,share_type,experience_content', NULL, '0', '{}', '2025-03-31 15:46:36', '2025-03-31 15:46:36');
INSERT INTO `auth` VALUES (81, '游客', '经验分享', 'experience_sharing', '分享详情', '/experience_sharing/view', '', 0, '', '_blank', 0, 0, 0, 0, 'title,share_type,experience_content', 'title,share_type,experience_content', 'title,share_type,experience_content', NULL, '0', '{}', '2025-03-31 15:46:36', '2025-03-31 15:46:36');
INSERT INTO `auth` VALUES (82, '游客', '分享类型', 'share_type', '分享类型', '/share_type/table', '', 0, '', '_blank', 0, 0, 0, 0, 'share_type', 'share_type', 'share_type', NULL, '0', '{}', '2025-03-31 15:46:36', '2025-03-31 15:46:36');
INSERT INTO `auth` VALUES (83, '游客', '分享类型', 'share_type', '类型详情', '/share_type/view', '', 0, '', '_blank', 0, 0, 0, 0, 'share_type', 'share_type', 'share_type', NULL, '0', '{}', '2025-03-31 15:46:36', '2025-03-31 15:46:36');
INSERT INTO `auth` VALUES (84, '游客', '我的收藏', 'collect', '我的收藏', '/collect/list', '', 0, '', '_blank', 0, 0, 0, 0, '', '', '', NULL, '0', '{}', '2025-03-31 15:46:36', '2025-03-31 15:46:36');
INSERT INTO `auth` VALUES (85, '游客', '订单', 'order', '订单列表', '/order/table', '', 0, '', '_blank', 0, 0, 0, 0, '', '', '', NULL, '0', '{\"figure\":false,\"print\":false,\"export_db\":false}', '2025-03-31 15:46:36', '2025-03-31 15:46:36');
INSERT INTO `auth` VALUES (86, '游客', '订单', 'order', '订单详情', '/order/view', '', 0, '', '_blank', 0, 0, 0, 0, '', '', '', NULL, '0', '{\"print\":false}', '2025-03-31 15:46:36', '2025-03-31 15:46:36');
INSERT INTO `auth` VALUES (87, '游客', '订单', 'order', '我的订单', '/order/list', '', 0, '', '_blank', 0, 0, 0, 1, '', '', '', NULL, '0', '{}', '2025-03-31 15:46:36', '2025-03-31 15:46:36');
INSERT INTO `auth` VALUES (88, '游客', '订单', 'order', '订单详情', '/order/details', '', 0, '', '_blank', 0, 0, 0, 1, '', '', '', NULL, '0', '{\"can_comment\":false,\"can_score\":false,\"can_show_comment\":true,\"can_show_score\":false}', '2025-03-31 15:46:36', '2025-03-31 15:46:36');
INSERT INTO `auth` VALUES (89, '游客', '商品', 'goods', '商品列表', '/goods/table', '', 0, '', '_blank', 0, 0, 0, 0, '', '', '', NULL, '0', '{\"seller\":false,\"print\":false,\"export_db\":false,\"import_db\":false}', '2025-03-31 15:46:36', '2025-03-31 15:46:36');
INSERT INTO `auth` VALUES (90, '游客', '商品', 'goods', '商品详情', '/goods/view', '', 0, '', '_blank', 0, 0, 0, 0, '', '', '', NULL, '0', '{\"print\":false}', '2025-03-31 15:46:36', '2025-03-31 15:46:36');
INSERT INTO `auth` VALUES (91, '游客', '商品', 'goods', '商品列表', '/goods/list', '', 0, '', '_blank', 0, 0, 0, 1, '', '', '', NULL, '0', '{}', '2025-03-31 15:46:36', '2025-03-31 15:46:36');
INSERT INTO `auth` VALUES (92, '游客', '商品', 'goods', '商品详情', '/goods/details', '', 0, '', '_blank', 0, 0, 0, 1, '', '', '', NULL, '0', '{\"can_comment\":false,\"can_score\":false,\"can_show_comment\":true,\"can_show_score\":false}', '2025-03-31 15:46:36', '2025-03-31 15:46:36');
INSERT INTO `auth` VALUES (93, '游客', '收货地址', 'address', '收货地址', '/address/list', '', 0, '', '_blank', 0, 0, 0, 0, '', '', '', NULL, '0', '{}', '2025-03-31 15:46:36', '2025-03-31 15:46:36');
INSERT INTO `auth` VALUES (94, '游客', '收货地址', 'address', '地址详情', '/address/details', '', 0, '', '_blank', 0, 0, 0, 0, '', '', '', NULL, '0', '{}', '2025-03-31 15:46:36', '2025-03-31 15:46:36');
INSERT INTO `auth` VALUES (95, '游客', '配送', 'logistics_delivery', '订单配送', '/logistics_delivery/table', '', 0, '', '_blank', 0, 0, 0, 0, '', '', '', NULL, '0', '{\"sign_for\":false}', '2025-03-31 15:46:36', '2025-03-31 15:46:36');
INSERT INTO `auth` VALUES (96, '游客', '配送', 'logistics_delivery', '订单配送', '/logistics_delivery/view', '', 0, '', '_blank', 0, 0, 0, 0, '', '', '', NULL, '0', '{}', '2025-03-31 15:46:36', '2025-03-31 15:46:36');
INSERT INTO `auth` VALUES (97, '游客', '评论', 'comment', '评论列表', '/comment/table', '', 0, '', '_blank', 0, 0, 0, 0, '', '', '', NULL, '0', '{}', '2025-03-31 15:46:36', '2025-03-31 15:46:36');
INSERT INTO `auth` VALUES (98, '游客', '评论', 'comment', '评论详情', '/comment/view', '', 0, '', '_blank', 0, 0, 0, 0, '', '', '', NULL, '0', '{}', '2025-03-31 15:46:36', '2025-03-31 15:46:36');
INSERT INTO `auth` VALUES (99, '游客', '评论', 'comment', '我的评论', '/comment/list', '', 0, '', '_blank', 0, 0, 0, 1, '', '', '', NULL, '0', '{}', '2025-03-31 15:46:36', '2025-03-31 15:46:36');
INSERT INTO `auth` VALUES (100, '游客', '评论', 'comment', '评论详情', '/comment/details', '', 0, '', '_blank', 0, 0, 0, 1, '', '', '', NULL, '0', '{}', '2025-03-31 15:46:36', '2025-03-31 15:46:36');
INSERT INTO `auth` VALUES (101, '游客', '交流论坛', 'forum', '交流论坛', '/forum/table', '', 0, '', '_blank', 0, 0, 0, 0, '', '', '', NULL, '0', '{\"print\":false,\"export_db\":false,\"import_db\":false}', '2025-03-31 15:46:36', '2025-03-31 15:46:36');
INSERT INTO `auth` VALUES (102, '游客', '交流论坛', 'forum', '论坛详情', '/forum/view', '', 0, '', '_blank', 0, 0, 0, 0, '', '', '', NULL, '0', '{\"print\":false}', '2025-03-31 15:46:36', '2025-03-31 15:46:36');
INSERT INTO `auth` VALUES (103, '游客', '交流论坛', 'forum', '交流论坛', '/forum/list', '', 0, '', '_blank', 0, 0, 0, 1, '', '', '', NULL, '0', '{}', '2025-03-31 15:46:36', '2025-03-31 15:46:36');
INSERT INTO `auth` VALUES (104, '游客', '交流论坛', 'forum', '论坛详情', '/forum/details', '', 0, '', '_blank', 0, 0, 0, 1, '', '', '', NULL, '0', '{\"can_comment\":false,\"can_show_comment\":true}', '2025-03-31 15:46:36', '2025-03-31 15:46:36');
INSERT INTO `auth` VALUES (105, '游客', '论坛分类', 'forum_type', '论坛分类', '/forum_type/table', '', 0, '', '_blank', 0, 0, 0, 0, '', '', '', NULL, '0', '{}', '2025-03-31 15:46:36', '2025-03-31 15:46:36');
INSERT INTO `auth` VALUES (106, '游客', '论坛分类', 'forum_type', '分类详情', '/forum_type/view', '', 0, '', '_blank', 0, 0, 0, 0, '', '', '', NULL, '0', '{}', '2025-03-31 15:46:36', '2025-03-31 15:46:36');
INSERT INTO `auth` VALUES (107, '游客', '农业知识', 'article', '农业知识', '/article/table', '', 0, '', '_blank', 0, 0, 0, 0, '', '', '', NULL, '0', '{\"print\":false,\"export_db\":false,\"import_db\":false}', '2025-03-31 15:46:36', '2025-03-31 15:46:36');
INSERT INTO `auth` VALUES (108, '游客', '农业知识', 'article', '知识详情', '/article/view', '', 0, '', '_blank', 0, 0, 0, 0, '', '', '', NULL, '0', '{\"print\":false}', '2025-03-31 15:46:36', '2025-03-31 15:46:36');
INSERT INTO `auth` VALUES (109, '游客', '农业知识', 'article', '农业知识', '/article/list', '', 0, '', '_blank', 0, 0, 0, 1, '', '', '', NULL, '0', '{}', '2025-03-31 15:46:36', '2025-03-31 15:46:36');
INSERT INTO `auth` VALUES (110, '游客', '农业知识', 'article', '知识详情', '/article/details', '', 0, '', '_blank', 0, 0, 0, 1, '', '', '', NULL, '0', '{\"can_comment\":false,\"can_show_comment\":true}', '2025-03-31 15:46:36', '2025-03-31 15:46:36');
INSERT INTO `auth` VALUES (111, '游客', '知识分类', 'article_type', '知识分类', '/article_type/table', '', 0, '', '_blank', 0, 0, 0, 0, '', '', '', NULL, '0', '{}', '2025-03-31 15:46:36', '2025-03-31 15:46:36');
INSERT INTO `auth` VALUES (112, '游客', '知识分类', 'article_type', '分类详情', '/article_type/view', '', 0, '', '_blank', 0, 0, 0, 0, '', '', '', NULL, '0', '{}', '2025-03-31 15:46:36', '2025-03-31 15:46:36');
INSERT INTO `auth` VALUES (113, '游客', '留言投诉', 'message', '留言投诉', '/message/table', '', 0, '', '_blank', 0, 0, 0, 0, '', '', '', NULL, '0', '{}', '2025-03-31 15:46:36', '2025-03-31 15:46:36');
INSERT INTO `auth` VALUES (114, '游客', '留言投诉', 'message', '投诉详情', '/message/view', '', 0, '', '_blank', 0, 0, 0, 0, '', '', '', NULL, '0', '{}', '2025-03-31 15:46:36', '2025-03-31 15:46:36');
INSERT INTO `auth` VALUES (115, '游客', '留言投诉', 'message', '留言投诉', '/message/list', '', 0, '', '_blank', 0, 0, 0, 1, '', '', '', NULL, '0', '{}', '2025-03-31 15:46:36', '2025-03-31 15:46:36');
INSERT INTO `auth` VALUES (116, '游客', '留言投诉', 'message', '提交留言', '/message/edit', '', 0, '', '_blank', 0, 0, 0, 0, '', '', '', NULL, '0', '{}', '2025-03-31 15:46:36', '2025-03-31 15:46:36');
INSERT INTO `auth` VALUES (117, '农户商家', '农户商家', 'farmers_merchants', '农户商家', '/farmers_merchants/table', '', 0, '', '_blank', 0, 0, 0, 0, 'business_name,contact_number,business_address,business_license,certification_application', 'business_name,contact_number,business_address,business_license,certification_application', 'business_name,contact_number,business_address,business_license,certification_application', NULL, '0', '{\"examine\":false}', '2025-03-31 15:46:36', '2025-03-31 15:46:36');
INSERT INTO `auth` VALUES (118, '农户商家', '农户商家', 'farmers_merchants', '商家详情', '/farmers_merchants/view', '', 0, '', '_blank', 0, 0, 1, 1, 'business_name,contact_number,business_address,business_license,certification_application', 'business_name,contact_number,business_address,business_license,certification_application', 'business_name,contact_number,business_address,business_license,certification_application', NULL, '0', '{}', '2025-03-31 15:46:36', '2025-03-31 15:46:36');
INSERT INTO `auth` VALUES (119, '农户商家', '消费者', 'consumer', '消费者', '/consumer/table', '', 0, '', '_blank', 0, 0, 0, 0, 'user_name,mobile_phone_number', 'user_name,mobile_phone_number', 'user_name,mobile_phone_number', NULL, '0', '{}', '2025-03-31 15:46:36', '2025-03-31 15:46:36');
INSERT INTO `auth` VALUES (120, '农户商家', '消费者', 'consumer', '费者详情', '/consumer/view', '', 0, '', '_blank', 0, 0, 0, 0, 'user_name,mobile_phone_number', 'user_name,mobile_phone_number', 'user_name,mobile_phone_number', NULL, '0', '{}', '2025-03-31 15:46:36', '2025-03-31 15:46:36');
INSERT INTO `auth` VALUES (121, '农户商家', '农产品', 'agricultural_products', '农产品', '/agricultural_products/table', '', 0, '', '_blank', 1, 1, 1, 1, 'product_specifications,farmers_merchants,business_name,contact_number,business_address', 'product_specifications,farmers_merchants,business_name,contact_number,business_address', 'product_specifications,farmers_merchants,business_name,contact_number,business_address', NULL, '0', '{\"can_show_comment\":true}', '2025-03-31 15:46:36', '2025-03-31 15:46:36');
INSERT INTO `auth` VALUES (122, '农户商家', '农产品', 'agricultural_products', '产品详情', '/agricultural_products/view', '', 0, '', '_blank', 1, 1, 1, 1, 'product_specifications,farmers_merchants,business_name,contact_number,business_address', 'product_specifications,farmers_merchants,business_name,contact_number,business_address', 'product_specifications,farmers_merchants,business_name,contact_number,business_address', NULL, '0', '{}', '2025-03-31 15:46:36', '2025-03-31 15:46:36');
INSERT INTO `auth` VALUES (123, '农户商家', '农产品', 'agricultural_products', '农产品', '/agricultural_products/list', '', 0, '', '_blank', 1, 1, 1, 1, 'product_specifications,farmers_merchants,business_name,contact_number,business_address', 'product_specifications,farmers_merchants,business_name,contact_number,business_address', 'product_specifications,farmers_merchants,business_name,contact_number,business_address', NULL, '0', '{\"cart_page\":true}', '2025-03-31 15:46:36', '2025-03-31 15:46:36');
INSERT INTO `auth` VALUES (124, '农户商家', '农产品', 'agricultural_products', '产品详情', '/agricultural_products/details', '', 0, '', '_blank', 1, 1, 1, 1, 'product_specifications,farmers_merchants,business_name,contact_number,business_address', 'product_specifications,farmers_merchants,business_name,contact_number,business_address', 'product_specifications,farmers_merchants,business_name,contact_number,business_address', NULL, '0', '{\"can_comment\":true,\"can_show_comment\":true,\"cart_page\":true}', '2025-03-31 15:46:36', '2025-03-31 15:46:36');
INSERT INTO `auth` VALUES (125, '农户商家', '产地展示', 'origin_display', '产地展示', '/origin_display/table', '', 0, '', '_blank', 1, 1, 1, 1, 'name_of_place_of_origin,cover_chart,place_of_origin_address,type_of_place_of_origin,scale_of_origin,introduction_of_origin,farmers_merchants,business_name,contact_number,business_address', 'name_of_place_of_origin,cover_chart,place_of_origin_address,type_of_place_of_origin,scale_of_origin,introduction_of_origin,farmers_merchants,business_name,contact_number,business_address', 'name_of_place_of_origin,cover_chart,place_of_origin_address,type_of_place_of_origin,scale_of_origin,introduction_of_origin,farmers_merchants,business_name,contact_number,business_address', NULL, '0', '{\"can_show_comment\":true}', '2025-03-31 15:46:36', '2025-03-31 15:46:36');
INSERT INTO `auth` VALUES (126, '农户商家', '产地展示', 'origin_display', '展示详情', '/origin_display/view', '', 0, '', '_blank', 1, 1, 1, 1, 'name_of_place_of_origin,cover_chart,place_of_origin_address,type_of_place_of_origin,scale_of_origin,introduction_of_origin,farmers_merchants,business_name,contact_number,business_address', 'name_of_place_of_origin,cover_chart,place_of_origin_address,type_of_place_of_origin,scale_of_origin,introduction_of_origin,farmers_merchants,business_name,contact_number,business_address', 'name_of_place_of_origin,cover_chart,place_of_origin_address,type_of_place_of_origin,scale_of_origin,introduction_of_origin,farmers_merchants,business_name,contact_number,business_address', NULL, '0', '{}', '2025-03-31 15:46:36', '2025-03-31 15:46:36');
INSERT INTO `auth` VALUES (127, '农户商家', '产地展示', 'origin_display', '产地展示', '/origin_display/list', '', 0, 'top', '_blank', 1, 1, 1, 1, 'name_of_place_of_origin,cover_chart,place_of_origin_address,type_of_place_of_origin,scale_of_origin,introduction_of_origin,farmers_merchants,business_name,contact_number,business_address', 'name_of_place_of_origin,cover_chart,place_of_origin_address,type_of_place_of_origin,scale_of_origin,introduction_of_origin,farmers_merchants,business_name,contact_number,business_address', 'name_of_place_of_origin,cover_chart,place_of_origin_address,type_of_place_of_origin,scale_of_origin,introduction_of_origin,farmers_merchants,business_name,contact_number,business_address', NULL, '0', '{}', '2025-03-31 15:46:36', '2025-03-31 15:46:36');
INSERT INTO `auth` VALUES (128, '农户商家', '产地展示', 'origin_display', '展示详情', '/origin_display/details', '', 0, '', '_blank', 1, 1, 1, 1, 'name_of_place_of_origin,cover_chart,place_of_origin_address,type_of_place_of_origin,scale_of_origin,introduction_of_origin,farmers_merchants,business_name,contact_number,business_address', 'name_of_place_of_origin,cover_chart,place_of_origin_address,type_of_place_of_origin,scale_of_origin,introduction_of_origin,farmers_merchants,business_name,contact_number,business_address', 'name_of_place_of_origin,cover_chart,place_of_origin_address,type_of_place_of_origin,scale_of_origin,introduction_of_origin,farmers_merchants,business_name,contact_number,business_address', NULL, '0', '{\"can_comment\":true,\"can_show_comment\":true}', '2025-03-31 15:46:36', '2025-03-31 15:46:36');
INSERT INTO `auth` VALUES (129, '农户商家', '产地类型', 'type_of_place_of_origin', '产地类型', '/type_of_place_of_origin/table', '', 0, '', '_blank', 0, 0, 0, 0, 'type_of_place_of_origin', 'type_of_place_of_origin', 'type_of_place_of_origin', NULL, '0', '{}', '2025-03-31 15:46:36', '2025-03-31 15:46:36');
INSERT INTO `auth` VALUES (130, '农户商家', '产地类型', 'type_of_place_of_origin', '类型详情', '/type_of_place_of_origin/view', '', 0, '', '_blank', 0, 0, 0, 0, 'type_of_place_of_origin', 'type_of_place_of_origin', 'type_of_place_of_origin', NULL, '0', '{}', '2025-03-31 15:46:36', '2025-03-31 15:46:36');
INSERT INTO `auth` VALUES (131, '农户商家', '互动咨询', 'interactive_consultation', '互动咨询', '/interactive_consultation/table', '', 0, '', '_blank', 0, 1, 0, 1, 'consultation_number,farmers_merchants,business_name,contact_number,business_address,date_of_consultation,consulting_users,consulting_content', 'consultation_number,farmers_merchants,business_name,contact_number,business_address,date_of_consultation,consulting_users,consulting_content', 'consultation_number,farmers_merchants,business_name,contact_number,business_address,date_of_consultation,consulting_users,consulting_content', NULL, '0', '{}', '2025-03-31 15:46:36', '2025-03-31 15:46:36');
INSERT INTO `auth` VALUES (132, '农户商家', '互动咨询', 'interactive_consultation', '咨询详情', '/interactive_consultation/view', '', 0, '', '_blank', 0, 1, 0, 1, 'consultation_number,farmers_merchants,business_name,contact_number,business_address,date_of_consultation,consulting_users,consulting_content', 'consultation_number,farmers_merchants,business_name,contact_number,business_address,date_of_consultation,consulting_users,consulting_content', 'consultation_number,farmers_merchants,business_name,contact_number,business_address,date_of_consultation,consulting_users,consulting_content', NULL, '0', '{\"can_limits\":false}', '2025-03-31 15:46:36', '2025-03-31 15:46:36');
INSERT INTO `auth` VALUES (133, '农户商家', '互动咨询', 'interactive_consultation', '互动咨询', '/interactive_consultation/edit', '', 0, '', '_blank', 0, 0, 0, 0, 'consultation_number,farmers_merchants,business_name,contact_number,business_address,date_of_consultation,consulting_users,consulting_content', 'consultation_number,farmers_merchants,business_name,contact_number,business_address,date_of_consultation,consulting_users,consulting_content', 'consultation_number,farmers_merchants,business_name,contact_number,business_address,date_of_consultation,consulting_users,consulting_content', NULL, '0', '{}', '2025-03-31 15:46:36', '2025-03-31 15:46:36');
INSERT INTO `auth` VALUES (134, '农户商家', '咨询回复', 'consultation_reply', '咨询回复', '/consultation_reply/table', '', 0, '', '_blank', 1, 1, 0, 1, 'consultation_number,farmers_merchants,business_name,contact_number,business_address,date_of_consultation,consulting_users,consulting_content,reply_content', 'consultation_number,farmers_merchants,business_name,contact_number,business_address,date_of_consultation,consulting_users,consulting_content,reply_content', 'consultation_number,farmers_merchants,business_name,contact_number,business_address,date_of_consultation,consulting_users,consulting_content,reply_content', NULL, '0', '{}', '2025-03-31 15:46:36', '2025-03-31 15:46:36');
INSERT INTO `auth` VALUES (135, '农户商家', '咨询回复', 'consultation_reply', '回复详情', '/consultation_reply/view', '', 0, '', '_blank', 1, 1, 0, 1, 'consultation_number,farmers_merchants,business_name,contact_number,business_address,date_of_consultation,consulting_users,consulting_content,reply_content', 'consultation_number,farmers_merchants,business_name,contact_number,business_address,date_of_consultation,consulting_users,consulting_content,reply_content', 'consultation_number,farmers_merchants,business_name,contact_number,business_address,date_of_consultation,consulting_users,consulting_content,reply_content', NULL, '0', '{}', '2025-03-31 15:46:36', '2025-03-31 15:46:36');
INSERT INTO `auth` VALUES (136, '农户商家', '生产计划', 'production_planning', '生产计划', '/production_planning/table', '', 0, '', '_blank', 1, 1, 1, 1, 'plan_no,schedule_title,planned_date,plan_content,farmers_merchants', 'plan_no,schedule_title,planned_date,plan_content,farmers_merchants', 'plan_no,schedule_title,planned_date,plan_content,farmers_merchants', NULL, '0', '{}', '2025-03-31 15:46:36', '2025-03-31 15:46:36');
INSERT INTO `auth` VALUES (137, '农户商家', '生产计划', 'production_planning', '计划详情', '/production_planning/view', '', 0, '', '_blank', 1, 1, 1, 1, 'plan_no,schedule_title,planned_date,plan_content,farmers_merchants', 'plan_no,schedule_title,planned_date,plan_content,farmers_merchants', 'plan_no,schedule_title,planned_date,plan_content,farmers_merchants', NULL, '0', '{}', '2025-03-31 15:46:36', '2025-03-31 15:46:36');
INSERT INTO `auth` VALUES (138, '农户商家', '经验分享', 'experience_sharing', '经验分享', '/experience_sharing/table', '', 0, '', '_blank', 1, 0, 0, 1, 'title,share_type,experience_content', 'title,share_type,experience_content', 'title,share_type,experience_content', NULL, '0', '{}', '2025-03-31 15:46:36', '2025-03-31 15:46:36');
INSERT INTO `auth` VALUES (139, '农户商家', '经验分享', 'experience_sharing', '分享详情', '/experience_sharing/view', '', 0, '', '_blank', 1, 0, 0, 1, 'title,share_type,experience_content', 'title,share_type,experience_content', 'title,share_type,experience_content', NULL, '0', '{}', '2025-03-31 15:46:36', '2025-03-31 15:46:36');
INSERT INTO `auth` VALUES (140, '农户商家', '分享类型', 'share_type', '分享类型', '/share_type/table', '', 0, '', '_blank', 0, 0, 0, 0, 'share_type', 'share_type', 'share_type', NULL, '0', '{}', '2025-03-31 15:46:36', '2025-03-31 15:46:36');
INSERT INTO `auth` VALUES (141, '农户商家', '分享类型', 'share_type', '类型详情', '/share_type/view', '', 0, '', '_blank', 0, 0, 0, 0, 'share_type', 'share_type', 'share_type', NULL, '0', '{}', '2025-03-31 15:46:36', '2025-03-31 15:46:36');
INSERT INTO `auth` VALUES (142, '农户商家', '我的收藏', 'collect', '我的收藏', '/collect/list', '', 0, '', '_blank', 1, 1, 1, 1, '', '', '', NULL, '0', '{}', '2025-03-31 15:46:36', '2025-03-31 15:46:36');
INSERT INTO `auth` VALUES (143, '农户商家', '订单', 'order', '订单列表', '/order/table', '', 0, '', '_blank', 1, 1, 1, 1, '', '', '', NULL, '0', '{\"figure\":true,\"print\":true,\"export_db\":true}', '2025-03-31 15:46:36', '2025-03-31 15:46:36');
INSERT INTO `auth` VALUES (144, '农户商家', '订单', 'order', '订单详情', '/order/view', '', 0, '', '_blank', 1, 1, 1, 1, '', '', '', NULL, '0', '{\"print\":true}', '2025-03-31 15:46:36', '2025-03-31 15:46:36');
INSERT INTO `auth` VALUES (145, '农户商家', '订单', 'order', '我的订单', '/order/list', '', 0, '', '_blank', 1, 1, 1, 1, '', '', '', NULL, '0', '{}', '2025-03-31 15:46:36', '2025-03-31 15:46:36');
INSERT INTO `auth` VALUES (146, '农户商家', '订单', 'order', '订单详情', '/order/details', '', 0, '', '_blank', 1, 1, 1, 1, '', '', '', NULL, '0', '{\"can_comment\":true,\"can_score\":true,\"can_show_comment\":true,\"can_show_score\":true}', '2025-03-31 15:46:36', '2025-03-31 15:46:36');
INSERT INTO `auth` VALUES (147, '农户商家', '商品', 'goods', '商品列表', '/goods/table', '', 0, '', '_blank', 1, 1, 1, 1, '', '', '', NULL, '0', '{\"seller\":true,\"print\":true,\"export_db\":true,\"import_db\":true}', '2025-03-31 15:46:36', '2025-03-31 15:46:36');
INSERT INTO `auth` VALUES (148, '农户商家', '商品', 'goods', '商品详情', '/goods/view', '', 0, '', '_blank', 1, 1, 1, 1, '', '', '', NULL, '0', '{\"print\":true}', '2025-03-31 15:46:36', '2025-03-31 15:46:36');
INSERT INTO `auth` VALUES (149, '农户商家', '商品', 'goods', '商品列表', '/goods/list', '', 0, '', '_blank', 1, 1, 1, 1, '', '', '', NULL, '0', '{}', '2025-03-31 15:46:36', '2025-03-31 15:46:36');
INSERT INTO `auth` VALUES (150, '农户商家', '商品', 'goods', '商品详情', '/goods/details', '', 0, '', '_blank', 1, 1, 1, 1, '', '', '', NULL, '0', '{\"can_comment\":true,\"can_score\":true,\"can_show_comment\":true,\"can_show_score\":true}', '2025-03-31 15:46:36', '2025-03-31 15:46:36');
INSERT INTO `auth` VALUES (151, '农户商家', '收货地址', 'address', '收货地址', '/address/list', '', 0, '', '_blank', 1, 1, 1, 1, '', '', '', NULL, '0', '{}', '2025-03-31 15:46:36', '2025-03-31 15:46:36');
INSERT INTO `auth` VALUES (152, '农户商家', '收货地址', 'address', '地址详情', '/address/details', '', 0, '', '_blank', 1, 1, 1, 1, '', '', '', NULL, '0', '{}', '2025-03-31 15:46:36', '2025-03-31 15:46:36');
INSERT INTO `auth` VALUES (153, '农户商家', '配送', 'logistics_delivery', '订单配送', '/logistics_delivery/table', '', 0, '', '_blank', 0, 1, 0, 1, '', '', '', NULL, '0', '{\"sign_for\":true}', '2025-03-31 15:46:36', '2025-03-31 15:46:36');
INSERT INTO `auth` VALUES (154, '农户商家', '配送', 'logistics_delivery', '订单配送', '/logistics_delivery/view', '', 0, '', '_blank', 0, 1, 0, 1, '', '', '', NULL, '0', '{}', '2025-03-31 15:46:36', '2025-03-31 15:46:36');
INSERT INTO `auth` VALUES (155, '农户商家', '评论', 'comment', '评论列表', '/comment/table', '', 0, '', '_blank', 0, 1, 0, 1, '', '', '', NULL, '0', '{}', '2025-03-31 15:46:36', '2025-03-31 15:46:36');
INSERT INTO `auth` VALUES (156, '农户商家', '评论', 'comment', '评论详情', '/comment/view', '', 0, '', '_blank', 0, 1, 0, 1, '', '', '', NULL, '0', '{}', '2025-03-31 15:46:36', '2025-03-31 15:46:36');
INSERT INTO `auth` VALUES (157, '农户商家', '评论', 'comment', '我的评论', '/comment/list', '', 0, '', '_blank', 1, 1, 1, 1, '', '', '', NULL, '0', '{}', '2025-03-31 15:46:36', '2025-03-31 15:46:36');
INSERT INTO `auth` VALUES (158, '农户商家', '评论', 'comment', '评论详情', '/comment/details', '', 0, '', '_blank', 1, 1, 1, 1, '', '', '', NULL, '0', '{}', '2025-03-31 15:46:36', '2025-03-31 15:46:36');
INSERT INTO `auth` VALUES (159, '农户商家', '交流论坛', 'forum', '交流论坛', '/forum/table', '', 0, '', '_blank', 0, 0, 0, 0, '', '', '', NULL, '0', '{\"print\":false,\"export_db\":false,\"import_db\":false}', '2025-03-31 15:46:36', '2025-03-31 15:46:36');
INSERT INTO `auth` VALUES (160, '农户商家', '交流论坛', 'forum', '论坛详情', '/forum/view', '', 0, '', '_blank', 0, 0, 0, 0, '', '', '', NULL, '0', '{\"print\":false}', '2025-03-31 15:46:36', '2025-03-31 15:46:36');
INSERT INTO `auth` VALUES (161, '农户商家', '交流论坛', 'forum', '交流论坛', '/forum/list', '', 0, '', '_blank', 1, 1, 1, 1, '', '', '', NULL, '0', '{}', '2025-03-31 15:46:36', '2025-03-31 15:46:36');
INSERT INTO `auth` VALUES (162, '农户商家', '交流论坛', 'forum', '论坛详情', '/forum/details', '', 0, '', '_blank', 1, 1, 1, 1, '', '', '', NULL, '0', '{\"can_comment\":true,\"can_show_comment\":true}', '2025-03-31 15:46:36', '2025-03-31 15:46:36');
INSERT INTO `auth` VALUES (163, '农户商家', '论坛分类', 'forum_type', '论坛分类', '/forum_type/table', '', 0, '', '_blank', 0, 0, 0, 0, '', '', '', NULL, '0', '{}', '2025-03-31 15:46:36', '2025-03-31 15:46:36');
INSERT INTO `auth` VALUES (164, '农户商家', '论坛分类', 'forum_type', '分类详情', '/forum_type/view', '', 0, '', '_blank', 0, 0, 0, 0, '', '', '', NULL, '0', '{}', '2025-03-31 15:46:36', '2025-03-31 15:46:36');
INSERT INTO `auth` VALUES (165, '农户商家', '农业知识', 'article', '农业知识', '/article/table', '', 0, '', '_blank', 0, 0, 0, 0, '', '', '', NULL, '0', '{\"print\":false,\"export_db\":false,\"import_db\":false}', '2025-03-31 15:46:36', '2025-03-31 15:46:36');
INSERT INTO `auth` VALUES (166, '农户商家', '农业知识', 'article', '知识详情', '/article/view', '', 0, '', '_blank', 0, 0, 0, 0, '', '', '', NULL, '0', '{\"print\":false}', '2025-03-31 15:46:36', '2025-03-31 15:46:36');
INSERT INTO `auth` VALUES (167, '农户商家', '农业知识', 'article', '农业知识', '/article/list', '', 0, '', '_blank', 1, 1, 1, 1, '', '', '', NULL, '0', '{}', '2025-03-31 15:46:36', '2025-03-31 15:46:36');
INSERT INTO `auth` VALUES (168, '农户商家', '农业知识', 'article', '知识详情', '/article/details', '', 0, '', '_blank', 1, 1, 1, 1, '', '', '', NULL, '0', '{\"can_comment\":true,\"can_show_comment\":true}', '2025-03-31 15:46:36', '2025-03-31 15:46:36');
INSERT INTO `auth` VALUES (169, '农户商家', '知识分类', 'article_type', '知识分类', '/article_type/table', '', 0, '', '_blank', 0, 0, 0, 0, '', '', '', NULL, '0', '{}', '2025-03-31 15:46:36', '2025-03-31 15:46:36');
INSERT INTO `auth` VALUES (170, '农户商家', '知识分类', 'article_type', '分类详情', '/article_type/view', '', 0, '', '_blank', 0, 0, 0, 0, '', '', '', NULL, '0', '{}', '2025-03-31 15:46:36', '2025-03-31 15:46:36');
INSERT INTO `auth` VALUES (171, '农户商家', '留言投诉', 'message', '留言投诉', '/message/table', '', 0, '', '_blank', 0, 0, 0, 0, '', '', '', NULL, '0', '{}', '2025-03-31 15:46:36', '2025-03-31 15:46:36');
INSERT INTO `auth` VALUES (172, '农户商家', '留言投诉', 'message', '投诉详情', '/message/view', '', 0, '', '_blank', 0, 0, 0, 0, '', '', '', NULL, '0', '{}', '2025-03-31 15:46:36', '2025-03-31 15:46:36');
INSERT INTO `auth` VALUES (173, '农户商家', '留言投诉', 'message', '留言投诉', '/message/list', '', 0, '', '_blank', 0, 0, 0, 0, '', '', '', NULL, '0', '{}', '2025-03-31 15:46:36', '2025-03-31 15:46:36');
INSERT INTO `auth` VALUES (174, '农户商家', '留言投诉', 'message', '提交留言', '/message/edit', '', 0, '', '_blank', 0, 0, 0, 0, '', '', '', NULL, '0', '{}', '2025-03-31 15:46:36', '2025-03-31 15:46:36');
INSERT INTO `auth` VALUES (175, '消费者', '农户商家', 'farmers_merchants', '农户商家', '/farmers_merchants/table', '', 0, '', '_blank', 0, 0, 0, 0, 'business_name,contact_number,business_address,business_license,certification_application', 'business_name,contact_number,business_address,business_license,certification_application', 'business_name,contact_number,business_address,business_license,certification_application', NULL, '0', '{\"examine\":false}', '2025-03-31 15:46:36', '2025-03-31 15:46:36');
INSERT INTO `auth` VALUES (176, '消费者', '农户商家', 'farmers_merchants', '商家详情', '/farmers_merchants/view', '', 0, '', '_blank', 0, 0, 0, 0, 'business_name,contact_number,business_address,business_license,certification_application', 'business_name,contact_number,business_address,business_license,certification_application', 'business_name,contact_number,business_address,business_license,certification_application', NULL, '0', '{}', '2025-03-31 15:46:36', '2025-03-31 15:46:36');
INSERT INTO `auth` VALUES (177, '消费者', '消费者', 'consumer', '消费者', '/consumer/table', '', 0, '', '_blank', 0, 0, 0, 0, 'user_name,mobile_phone_number', 'user_name,mobile_phone_number', 'user_name,mobile_phone_number', NULL, '0', '{}', '2025-03-31 15:46:36', '2025-03-31 15:46:36');
INSERT INTO `auth` VALUES (178, '消费者', '消费者', 'consumer', '费者详情', '/consumer/view', '', 0, '', '_blank', 0, 0, 1, 1, 'user_name,mobile_phone_number', 'user_name,mobile_phone_number', 'user_name,mobile_phone_number', NULL, '0', '{}', '2025-03-31 15:46:36', '2025-03-31 15:46:36');
INSERT INTO `auth` VALUES (179, '消费者', '农产品', 'agricultural_products', '农产品', '/agricultural_products/table', '', 0, '', '_blank', 0, 0, 0, 0, 'product_specifications,farmers_merchants,business_name,contact_number,business_address', 'product_specifications,farmers_merchants,business_name,contact_number,business_address', 'product_specifications,farmers_merchants,business_name,contact_number,business_address', NULL, '0', '{\"can_show_comment\":false}', '2025-03-31 15:46:36', '2025-03-31 15:46:36');
INSERT INTO `auth` VALUES (180, '消费者', '农产品', 'agricultural_products', '产品详情', '/agricultural_products/view', '', 0, '', '_blank', 0, 0, 0, 0, 'product_specifications,farmers_merchants,business_name,contact_number,business_address', 'product_specifications,farmers_merchants,business_name,contact_number,business_address', 'product_specifications,farmers_merchants,business_name,contact_number,business_address', NULL, '0', '{}', '2025-03-31 15:46:36', '2025-03-31 15:46:36');
INSERT INTO `auth` VALUES (181, '消费者', '农产品', 'agricultural_products', '农产品', '/agricultural_products/list', '', 0, '', '_blank', 1, 1, 1, 1, 'product_specifications,farmers_merchants,business_name,contact_number,business_address', 'product_specifications,farmers_merchants,business_name,contact_number,business_address', 'product_specifications,farmers_merchants,business_name,contact_number,business_address', NULL, '0', '{\"cart_page\":true}', '2025-03-31 15:46:36', '2025-03-31 15:46:36');
INSERT INTO `auth` VALUES (182, '消费者', '农产品', 'agricultural_products', '产品详情', '/agricultural_products/details', '', 0, '', '_blank', 1, 1, 1, 1, 'product_specifications,farmers_merchants,business_name,contact_number,business_address', 'product_specifications,farmers_merchants,business_name,contact_number,business_address', 'product_specifications,farmers_merchants,business_name,contact_number,business_address', NULL, '0', '{\"can_comment\":true,\"can_show_comment\":true,\"cart_page\":true}', '2025-03-31 15:46:36', '2025-03-31 15:46:36');
INSERT INTO `auth` VALUES (183, '消费者', '产地展示', 'origin_display', '产地展示', '/origin_display/table', '', 0, '', '_blank', 0, 0, 0, 0, 'name_of_place_of_origin,cover_chart,place_of_origin_address,type_of_place_of_origin,scale_of_origin,introduction_of_origin,farmers_merchants,business_name,contact_number,business_address', 'name_of_place_of_origin,cover_chart,place_of_origin_address,type_of_place_of_origin,scale_of_origin,introduction_of_origin,farmers_merchants,business_name,contact_number,business_address', 'name_of_place_of_origin,cover_chart,place_of_origin_address,type_of_place_of_origin,scale_of_origin,introduction_of_origin,farmers_merchants,business_name,contact_number,business_address', NULL, '0', '{\"can_show_comment\":false}', '2025-03-31 15:46:36', '2025-03-31 15:46:36');
INSERT INTO `auth` VALUES (184, '消费者', '产地展示', 'origin_display', '展示详情', '/origin_display/view', '', 0, '', '_blank', 0, 0, 0, 0, 'name_of_place_of_origin,cover_chart,place_of_origin_address,type_of_place_of_origin,scale_of_origin,introduction_of_origin,farmers_merchants,business_name,contact_number,business_address', 'name_of_place_of_origin,cover_chart,place_of_origin_address,type_of_place_of_origin,scale_of_origin,introduction_of_origin,farmers_merchants,business_name,contact_number,business_address', 'name_of_place_of_origin,cover_chart,place_of_origin_address,type_of_place_of_origin,scale_of_origin,introduction_of_origin,farmers_merchants,business_name,contact_number,business_address', NULL, '0', '{}', '2025-03-31 15:46:36', '2025-03-31 15:46:36');
INSERT INTO `auth` VALUES (185, '消费者', '产地展示', 'origin_display', '产地展示', '/origin_display/list', '', 0, 'top', '_blank', 1, 1, 1, 1, 'name_of_place_of_origin,cover_chart,place_of_origin_address,type_of_place_of_origin,scale_of_origin,introduction_of_origin,farmers_merchants,business_name,contact_number,business_address', 'name_of_place_of_origin,cover_chart,place_of_origin_address,type_of_place_of_origin,scale_of_origin,introduction_of_origin,farmers_merchants,business_name,contact_number,business_address', 'name_of_place_of_origin,cover_chart,place_of_origin_address,type_of_place_of_origin,scale_of_origin,introduction_of_origin,farmers_merchants,business_name,contact_number,business_address', NULL, '0', '{}', '2025-03-31 15:46:36', '2025-03-31 15:46:36');
INSERT INTO `auth` VALUES (186, '消费者', '产地展示', 'origin_display', '展示详情', '/origin_display/details', '', 0, '', '_blank', 1, 1, 1, 1, 'name_of_place_of_origin,cover_chart,place_of_origin_address,type_of_place_of_origin,scale_of_origin,introduction_of_origin,farmers_merchants,business_name,contact_number,business_address', 'name_of_place_of_origin,cover_chart,place_of_origin_address,type_of_place_of_origin,scale_of_origin,introduction_of_origin,farmers_merchants,business_name,contact_number,business_address', 'name_of_place_of_origin,cover_chart,place_of_origin_address,type_of_place_of_origin,scale_of_origin,introduction_of_origin,farmers_merchants,business_name,contact_number,business_address', NULL, '0', '{\"can_comment\":true,\"can_show_comment\":true}', '2025-03-31 15:46:36', '2025-03-31 15:46:36');
INSERT INTO `auth` VALUES (187, '消费者', '产地类型', 'type_of_place_of_origin', '产地类型', '/type_of_place_of_origin/table', '', 0, '', '_blank', 0, 0, 0, 0, 'type_of_place_of_origin', 'type_of_place_of_origin', 'type_of_place_of_origin', NULL, '0', '{}', '2025-03-31 15:46:36', '2025-03-31 15:46:36');
INSERT INTO `auth` VALUES (188, '消费者', '产地类型', 'type_of_place_of_origin', '类型详情', '/type_of_place_of_origin/view', '', 0, '', '_blank', 0, 0, 0, 0, 'type_of_place_of_origin', 'type_of_place_of_origin', 'type_of_place_of_origin', NULL, '0', '{}', '2025-03-31 15:46:36', '2025-03-31 15:46:36');
INSERT INTO `auth` VALUES (189, '消费者', '互动咨询', 'interactive_consultation', '互动咨询', '/interactive_consultation/table', '', 0, '', '_blank', 0, 1, 0, 1, 'consultation_number,farmers_merchants,business_name,contact_number,business_address,date_of_consultation,consulting_users,consulting_content', 'consultation_number,farmers_merchants,business_name,contact_number,business_address,date_of_consultation,consulting_users,consulting_content', 'consultation_number,farmers_merchants,business_name,contact_number,business_address,date_of_consultation,consulting_users,consulting_content', NULL, '0', '{}', '2025-03-31 15:46:36', '2025-03-31 15:46:36');
INSERT INTO `auth` VALUES (190, '消费者', '互动咨询', 'interactive_consultation', '咨询详情', '/interactive_consultation/view', '', 0, '', '_blank', 0, 1, 0, 1, 'consultation_number,farmers_merchants,business_name,contact_number,business_address,date_of_consultation,consulting_users,consulting_content', 'consultation_number,farmers_merchants,business_name,contact_number,business_address,date_of_consultation,consulting_users,consulting_content', 'consultation_number,farmers_merchants,business_name,contact_number,business_address,date_of_consultation,consulting_users,consulting_content', NULL, '0', '{\"can_limits\":false}', '2025-03-31 15:46:36', '2025-03-31 15:46:36');
INSERT INTO `auth` VALUES (191, '消费者', '互动咨询', 'interactive_consultation', '互动咨询', '/interactive_consultation/edit', '', 0, '', '_blank', 1, 1, 1, 1, 'consultation_number,farmers_merchants,business_name,contact_number,business_address,date_of_consultation,consulting_users,consulting_content', 'consultation_number,farmers_merchants,business_name,contact_number,business_address,date_of_consultation,consulting_users,consulting_content', 'consultation_number,farmers_merchants,business_name,contact_number,business_address,date_of_consultation,consulting_users,consulting_content', NULL, '0', '{}', '2025-03-31 15:46:36', '2025-03-31 15:46:36');
INSERT INTO `auth` VALUES (192, '消费者', '咨询回复', 'consultation_reply', '咨询回复', '/consultation_reply/table', '', 0, '', '_blank', 0, 1, 0, 1, 'consultation_number,farmers_merchants,business_name,contact_number,business_address,date_of_consultation,consulting_users,consulting_content,reply_content', 'consultation_number,farmers_merchants,business_name,contact_number,business_address,date_of_consultation,consulting_users,consulting_content,reply_content', 'consultation_number,farmers_merchants,business_name,contact_number,business_address,date_of_consultation,consulting_users,consulting_content,reply_content', NULL, '0', '{}', '2025-03-31 15:46:36', '2025-03-31 15:46:36');
INSERT INTO `auth` VALUES (193, '消费者', '咨询回复', 'consultation_reply', '回复详情', '/consultation_reply/view', '', 0, '', '_blank', 0, 1, 0, 1, 'consultation_number,farmers_merchants,business_name,contact_number,business_address,date_of_consultation,consulting_users,consulting_content,reply_content', 'consultation_number,farmers_merchants,business_name,contact_number,business_address,date_of_consultation,consulting_users,consulting_content,reply_content', 'consultation_number,farmers_merchants,business_name,contact_number,business_address,date_of_consultation,consulting_users,consulting_content,reply_content', NULL, '0', '{}', '2025-03-31 15:46:36', '2025-03-31 15:46:36');
INSERT INTO `auth` VALUES (194, '消费者', '生产计划', 'production_planning', '生产计划', '/production_planning/table', '', 0, '', '_blank', 0, 0, 0, 0, 'plan_no,schedule_title,planned_date,plan_content,farmers_merchants', 'plan_no,schedule_title,planned_date,plan_content,farmers_merchants', 'plan_no,schedule_title,planned_date,plan_content,farmers_merchants', NULL, '0', '{}', '2025-03-31 15:46:36', '2025-03-31 15:46:36');
INSERT INTO `auth` VALUES (195, '消费者', '生产计划', 'production_planning', '计划详情', '/production_planning/view', '', 0, '', '_blank', 0, 0, 0, 0, 'plan_no,schedule_title,planned_date,plan_content,farmers_merchants', 'plan_no,schedule_title,planned_date,plan_content,farmers_merchants', 'plan_no,schedule_title,planned_date,plan_content,farmers_merchants', NULL, '0', '{}', '2025-03-31 15:46:36', '2025-03-31 15:46:36');
INSERT INTO `auth` VALUES (196, '消费者', '经验分享', 'experience_sharing', '经验分享', '/experience_sharing/table', '', 0, '', '_blank', 0, 0, 0, 0, 'title,share_type,experience_content', 'title,share_type,experience_content', 'title,share_type,experience_content', NULL, '0', '{}', '2025-03-31 15:46:36', '2025-03-31 15:46:36');
INSERT INTO `auth` VALUES (197, '消费者', '经验分享', 'experience_sharing', '分享详情', '/experience_sharing/view', '', 0, '', '_blank', 0, 0, 0, 0, 'title,share_type,experience_content', 'title,share_type,experience_content', 'title,share_type,experience_content', NULL, '0', '{}', '2025-03-31 15:46:36', '2025-03-31 15:46:36');
INSERT INTO `auth` VALUES (198, '消费者', '分享类型', 'share_type', '分享类型', '/share_type/table', '', 0, '', '_blank', 0, 0, 0, 0, 'share_type', 'share_type', 'share_type', NULL, '0', '{}', '2025-03-31 15:46:36', '2025-03-31 15:46:36');
INSERT INTO `auth` VALUES (199, '消费者', '分享类型', 'share_type', '类型详情', '/share_type/view', '', 0, '', '_blank', 0, 0, 0, 0, 'share_type', 'share_type', 'share_type', NULL, '0', '{}', '2025-03-31 15:46:36', '2025-03-31 15:46:36');
INSERT INTO `auth` VALUES (200, '消费者', '我的收藏', 'collect', '我的收藏', '/collect/list', '', 0, '', '_blank', 1, 1, 1, 1, '', '', '', NULL, '0', '{}', '2025-03-31 15:46:36', '2025-03-31 15:46:36');
INSERT INTO `auth` VALUES (201, '消费者', '订单', 'order', '订单列表', '/order/table', '', 0, '', '_blank', 0, 0, 0, 0, '', '', '', NULL, '0', '{\"figure\":false,\"print\":false,\"export_db\":false}', '2025-03-31 15:46:36', '2025-03-31 15:46:36');
INSERT INTO `auth` VALUES (202, '消费者', '订单', 'order', '订单详情', '/order/view', '', 0, '', '_blank', 0, 0, 0, 0, '', '', '', NULL, '0', '{\"print\":false}', '2025-03-31 15:46:36', '2025-03-31 15:46:36');
INSERT INTO `auth` VALUES (203, '消费者', '订单', 'order', '我的订单', '/order/list', '', 0, '', '_blank', 1, 1, 1, 1, '', '', '', NULL, '0', '{}', '2025-03-31 15:46:36', '2025-03-31 15:46:36');
INSERT INTO `auth` VALUES (204, '消费者', '订单', 'order', '订单详情', '/order/details', '', 0, '', '_blank', 1, 1, 1, 1, '', '', '', NULL, '0', '{\"can_comment\":true,\"can_score\":true,\"can_show_comment\":true,\"can_show_score\":true}', '2025-03-31 15:46:36', '2025-03-31 15:46:36');
INSERT INTO `auth` VALUES (205, '消费者', '商品', 'goods', '商品列表', '/goods/table', '', 0, '', '_blank', 0, 0, 0, 0, '', '', '', NULL, '0', '{\"seller\":false,\"print\":false,\"export_db\":false,\"import_db\":false}', '2025-03-31 15:46:36', '2025-03-31 15:46:36');
INSERT INTO `auth` VALUES (206, '消费者', '商品', 'goods', '商品详情', '/goods/view', '', 0, '', '_blank', 0, 0, 0, 0, '', '', '', NULL, '0', '{\"print\":false}', '2025-03-31 15:46:36', '2025-03-31 15:46:36');
INSERT INTO `auth` VALUES (207, '消费者', '商品', 'goods', '商品列表', '/goods/list', '', 0, '', '_blank', 1, 1, 1, 1, '', '', '', NULL, '0', '{}', '2025-03-31 15:46:36', '2025-03-31 15:46:36');
INSERT INTO `auth` VALUES (208, '消费者', '商品', 'goods', '商品详情', '/goods/details', '', 0, '', '_blank', 1, 1, 1, 1, '', '', '', NULL, '0', '{\"can_comment\":true,\"can_score\":true,\"can_show_comment\":true,\"can_show_score\":true}', '2025-03-31 15:46:36', '2025-03-31 15:46:36');
INSERT INTO `auth` VALUES (209, '消费者', '收货地址', 'address', '收货地址', '/address/list', '', 0, '', '_blank', 1, 1, 1, 1, '', '', '', NULL, '0', '{}', '2025-03-31 15:46:36', '2025-03-31 15:46:36');
INSERT INTO `auth` VALUES (210, '消费者', '收货地址', 'address', '地址详情', '/address/details', '', 0, '', '_blank', 1, 1, 1, 1, '', '', '', NULL, '0', '{}', '2025-03-31 15:46:36', '2025-03-31 15:46:36');
INSERT INTO `auth` VALUES (211, '消费者', '配送', 'logistics_delivery', '订单配送', '/logistics_delivery/table', '', 0, '', '_blank', 0, 1, 0, 1, '', '', '', NULL, '0', '{\"sign_for\":true}', '2025-03-31 15:46:36', '2025-03-31 15:46:36');
INSERT INTO `auth` VALUES (212, '消费者', '配送', 'logistics_delivery', '订单配送', '/logistics_delivery/view', '', 0, '', '_blank', 0, 1, 0, 1, '', '', '', NULL, '0', '{}', '2025-03-31 15:46:36', '2025-03-31 15:46:36');
INSERT INTO `auth` VALUES (213, '消费者', '评论', 'comment', '评论列表', '/comment/table', '', 0, '', '_blank', 0, 1, 0, 1, '', '', '', NULL, '0', '{}', '2025-03-31 15:46:36', '2025-03-31 15:46:36');
INSERT INTO `auth` VALUES (214, '消费者', '评论', 'comment', '评论详情', '/comment/view', '', 0, '', '_blank', 0, 1, 0, 1, '', '', '', NULL, '0', '{}', '2025-03-31 15:46:36', '2025-03-31 15:46:36');
INSERT INTO `auth` VALUES (215, '消费者', '评论', 'comment', '我的评论', '/comment/list', '', 0, '', '_blank', 1, 1, 1, 1, '', '', '', NULL, '0', '{}', '2025-03-31 15:46:36', '2025-03-31 15:46:36');
INSERT INTO `auth` VALUES (216, '消费者', '评论', 'comment', '评论详情', '/comment/details', '', 0, '', '_blank', 1, 1, 1, 1, '', '', '', NULL, '0', '{}', '2025-03-31 15:46:36', '2025-03-31 15:46:36');
INSERT INTO `auth` VALUES (217, '消费者', '交流论坛', 'forum', '交流论坛', '/forum/table', '', 0, '', '_blank', 0, 1, 0, 1, '', '', '', NULL, '0', '{\"print\":false,\"export_db\":false,\"import_db\":false}', '2025-03-31 15:46:36', '2025-03-31 15:46:36');
INSERT INTO `auth` VALUES (218, '消费者', '交流论坛', 'forum', '论坛详情', '/forum/view', '', 0, '', '_blank', 0, 1, 0, 1, '', '', '', NULL, '0', '{\"print\":false}', '2025-03-31 15:46:36', '2025-03-31 15:46:36');
INSERT INTO `auth` VALUES (219, '消费者', '交流论坛', 'forum', '交流论坛', '/forum/list', '', 0, '', '_blank', 1, 1, 1, 1, '', '', '', NULL, '0', '{}', '2025-03-31 15:46:36', '2025-03-31 15:46:36');
INSERT INTO `auth` VALUES (220, '消费者', '交流论坛', 'forum', '论坛详情', '/forum/details', '', 0, '', '_blank', 1, 1, 1, 1, '', '', '', NULL, '0', '{\"can_comment\":true,\"can_show_comment\":true}', '2025-03-31 15:46:36', '2025-03-31 15:46:36');
INSERT INTO `auth` VALUES (221, '消费者', '论坛分类', 'forum_type', '论坛分类', '/forum_type/table', '', 0, '', '_blank', 0, 0, 0, 0, '', '', '', NULL, '0', '{}', '2025-03-31 15:46:36', '2025-03-31 15:46:36');
INSERT INTO `auth` VALUES (222, '消费者', '论坛分类', 'forum_type', '分类详情', '/forum_type/view', '', 0, '', '_blank', 0, 0, 0, 0, '', '', '', NULL, '0', '{}', '2025-03-31 15:46:36', '2025-03-31 15:46:36');
INSERT INTO `auth` VALUES (223, '消费者', '农业知识', 'article', '农业知识', '/article/table', '', 0, '', '_blank', 0, 0, 0, 0, '', '', '', NULL, '0', '{\"print\":false,\"export_db\":false,\"import_db\":false}', '2025-03-31 15:46:36', '2025-03-31 15:46:36');
INSERT INTO `auth` VALUES (224, '消费者', '农业知识', 'article', '知识详情', '/article/view', '', 0, '', '_blank', 0, 0, 0, 0, '', '', '', NULL, '0', '{\"print\":false}', '2025-03-31 15:46:36', '2025-03-31 15:46:36');
INSERT INTO `auth` VALUES (225, '消费者', '农业知识', 'article', '农业知识', '/article/list', '', 0, '', '_blank', 1, 1, 1, 1, '', '', '', NULL, '0', '{}', '2025-03-31 15:46:36', '2025-03-31 15:46:36');
INSERT INTO `auth` VALUES (226, '消费者', '农业知识', 'article', '知识详情', '/article/details', '', 0, '', '_blank', 1, 1, 1, 1, '', '', '', NULL, '0', '{\"can_comment\":true,\"can_show_comment\":true}', '2025-03-31 15:46:36', '2025-03-31 15:46:36');
INSERT INTO `auth` VALUES (227, '消费者', '知识分类', 'article_type', '知识分类', '/article_type/table', '', 0, '', '_blank', 0, 0, 0, 0, '', '', '', NULL, '0', '{}', '2025-03-31 15:46:36', '2025-03-31 15:46:36');
INSERT INTO `auth` VALUES (228, '消费者', '知识分类', 'article_type', '分类详情', '/article_type/view', '', 0, '', '_blank', 0, 0, 0, 0, '', '', '', NULL, '0', '{}', '2025-03-31 15:46:36', '2025-03-31 15:46:36');
INSERT INTO `auth` VALUES (229, '消费者', '留言投诉', 'message', '留言投诉', '/message/table', '', 0, '', '_blank', 0, 1, 0, 1, '', '', '', NULL, '0', '{}', '2025-03-31 15:46:36', '2025-03-31 15:46:36');
INSERT INTO `auth` VALUES (230, '消费者', '留言投诉', 'message', '投诉详情', '/message/view', '', 0, '', '_blank', 0, 1, 0, 1, '', '', '', NULL, '0', '{}', '2025-03-31 15:46:36', '2025-03-31 15:46:36');
INSERT INTO `auth` VALUES (231, '消费者', '留言投诉', 'message', '留言投诉', '/message/list', '', 0, '', '_blank', 1, 1, 1, 1, '', '', '', NULL, '0', '{}', '2025-03-31 15:46:36', '2025-03-31 15:46:36');
INSERT INTO `auth` VALUES (232, '消费者', '留言投诉', 'message', '提交留言', '/message/edit', '', 0, '', '_blank', 1, 1, 1, 1, '', '', '', NULL, '0', '{}', '2025-03-31 15:46:36', '2025-03-31 15:46:36');

-- ----------------------------
-- Table structure for cart
-- ----------------------------
DROP TABLE IF EXISTS `cart`;
CREATE TABLE `cart`  (
  `cart_id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '购物车ID',
  `title` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '标题',
  `img` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '0' COMMENT '图片',
  `user_id` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '用户ID',
  `create_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间',
  `state` int(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '状态：使用中，已失效',
  `price` double(8, 2) NOT NULL DEFAULT 0.00 COMMENT '单价',
  `price_ago` double(8, 2) NOT NULL DEFAULT 0.00 COMMENT '原价',
  `price_count` double(10, 2) NOT NULL DEFAULT 0.00 COMMENT '总价',
  `num` int(8) UNSIGNED NOT NULL DEFAULT 1 COMMENT '数量',
  `goods_id` mediumint(8) UNSIGNED NOT NULL COMMENT '商品id',
  `type` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '未分类' COMMENT '商品分类',
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '描述',
  PRIMARY KEY (`cart_id`) USING BTREE,
  INDEX `goods_id`(`goods_id`) USING BTREE,
  CONSTRAINT `cart_ibfk_1` FOREIGN KEY (`goods_id`) REFERENCES `goods` (`goods_id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '购物车' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of cart
-- ----------------------------
INSERT INTO `cart` VALUES (1, '鲜海润 - 精选新鲜猪前腿肉', '/api/upload/ea3926085a790570-1917441911.jpg', 11, '2025-04-28 11:56:12', '2025-04-28 11:56:12', 0, 22.00, 25.00, 22.00, 1, 2, '生鲜', '肉质紧实，肥瘦适中，炖煮香浓，绞馅鲜美');
INSERT INTO `cart` VALUES (2, '鲜海润 - 雪花五花肉片 (肥瘦相间 烧烤火锅优选)', '/api/upload/1051269_20170126122010684070_0-2610040877.jpg', 11, '2025-04-28 11:56:18', '2025-04-28 11:56:18', 0, 35.00, 38.00, 35.00, 1, 1, '生鲜', '精选五花肉，肥瘦黄金比例，口感香嫩，烤涮皆宜');
INSERT INTO `cart` VALUES (3, '桃源仙谷 - 正宗阳山爆汁水蜜桃 (一级大果)', '/api/upload/304a434d476d77557061-2762687778.jpg', 11, '2025-04-28 11:56:22', '2025-04-28 11:56:22', 0, 118.00, 138.00, 118.00, 1, 5, '果蔬', '来自水蜜桃之乡阳山的甜蜜问候，皮薄肉厚，一口爆汁，甜过初恋！');
INSERT INTO `cart` VALUES (4, '果然金穗 - 生态甜糯玉米', '/api/upload/b94e-kcpxnww0586161-394684502.jpg', 11, '2025-04-28 11:56:25', '2025-04-28 11:56:25', 0, 25.00, 28.00, 25.00, 1, 3, '果蔬', '源自广西田阳生态农场，自然农法种植，鲜嫩软糯与清甜多汁的完美结合！');

-- ----------------------------
-- Table structure for code_token
-- ----------------------------
DROP TABLE IF EXISTS `code_token`;
CREATE TABLE `code_token`  (
  `code_token_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '验证码ID',
  `token` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci DEFAULT NULL COMMENT '令牌',
  `code` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci DEFAULT NULL COMMENT '验证码',
  `expire_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '失效时间',
  `create_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间',
  PRIMARY KEY (`code_token_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '验证码' ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for collect
-- ----------------------------
DROP TABLE IF EXISTS `collect`;
CREATE TABLE `collect`  (
  `collect_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '收藏ID',
  `user_id` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '收藏人ID',
  `source_table` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '来源表',
  `source_field` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '来源字段',
  `source_id` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '来源ID',
  `title` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '标题',
  `img` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '封面',
  `create_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间',
  PRIMARY KEY (`collect_id`) USING BTREE,
  INDEX `user_id`(`user_id`) USING BTREE,
  CONSTRAINT `collect_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '收藏' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of collect
-- ----------------------------
INSERT INTO `collect` VALUES (1, 11, 'forum', 'forum_id', 6, '猪前腿肉不只炖和炒！试试这个【香草蒜蓉烤猪肉配时蔬】', '', '2025-04-24 16:47:15', '2025-04-24 16:47:15');
INSERT INTO `collect` VALUES (2, 13, 'forum', 'forum_id', 8, '听说今年特色农产品要火？大家有没有内部消息啊！', '', '2025-05-07 17:10:28', '2025-05-07 17:10:28');

-- ----------------------------
-- Table structure for comment
-- ----------------------------
DROP TABLE IF EXISTS `comment`;
CREATE TABLE `comment`  (
  `comment_id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '评论ID',
  `user_id` int(11) UNSIGNED NOT NULL DEFAULT 0 COMMENT '评论人ID',
  `reply_to_id` int(11) UNSIGNED NOT NULL DEFAULT 0 COMMENT '回复评论ID',
  `content` longtext CHARACTER SET utf8 COLLATE utf8_general_ci COMMENT '内容',
  `nickname` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '昵称',
  `avatar` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '头像地址',
  `create_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间',
  `source_table` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '来源表',
  `source_field` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '来源字段',
  `source_id` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '来源ID',
  PRIMARY KEY (`comment_id`) USING BTREE,
  INDEX `user_id`(`user_id`) USING BTREE,
  CONSTRAINT `comment_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '评论' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of comment
-- ----------------------------
INSERT INTO `comment` VALUES (1, 15, 0, '针对酒店等企业级客户的批量采购，贵公司是否有相应的批发价格体系或阶梯报价？能否提供一份详细的报价单？', '雪松温泉度假酒店', '/api/upload/15876942720821lrorx-1836901316.jpg', '2025-04-24 16:40:45', '2025-04-24 16:40:45', 'origin_display', 'origin_display_id', 2);
INSERT INTO `comment` VALUES (2, 15, 0, '东西很好，孩子很爱吃', '雪松温泉度假酒店', '/api/upload/15876942720821lrorx-1836901316.jpg', '2025-05-04 17:39:15', '2025-05-04 17:39:15', 'goods', 'goods_id', 2);

-- ----------------------------
-- Table structure for consultation_reply
-- ----------------------------
DROP TABLE IF EXISTS `consultation_reply`;
CREATE TABLE `consultation_reply`  (
  `consultation_reply_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '咨询回复ID',
  `consultation_number` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '咨询编号',
  `farmers_merchants` int(11) DEFAULT 0 COMMENT '农户商家',
  `business_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '商家名称',
  `contact_number` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '联系号码',
  `business_address` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '商家地址',
  `date_of_consultation` date DEFAULT NULL COMMENT '咨询日期',
  `consulting_users` int(11) DEFAULT 0 COMMENT '咨询用户',
  `consulting_content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci COMMENT '咨询内容',
  `reply_content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci COMMENT '回复内容',
  `create_time` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间',
  `source_table` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '来源表',
  `source_id` int(10) DEFAULT 0 COMMENT '来源ID',
  `source_user_id` int(10) DEFAULT 0 COMMENT '来源用户',
  PRIMARY KEY (`consultation_reply_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '咨询回复' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of consultation_reply
-- ----------------------------
INSERT INTO `consultation_reply` VALUES (1, '2025-04-24 08:40:03', 19, '丰果季农业科技有限公司', '15863123456', '山东省烟台市蓬莱区南山镇阳光路88号', '2025-04-24', 15, '我们酒店对水果的规格（大小、单果重量）和外观有一定要求，请问贵公司是否有不同等级的果品划分？能否提供详细的规格说明？', '好的，这是一封针对酒店客户关于水果规格和等级询问的回复草稿。您可以根据实际情况进行修改和调整。\n\n尊敬的[酒店名称]采购负责人：\n\n您好！\n\n非常感谢您对我们公司果品的关注及垂询。我们非常理解贵酒店作为高端服务场所，对所采购果品的规格（大小、单果重量）、外观品相及整体品质有着严格的要求。\n\n是的，我们公司为了满足不同客户的需求并确保产品质量的稳定性，对所有销售的果品都建立了详细的分级标准和品控体系。我们的果品根据品质、规格（如尺寸范围、单果重量区间）、外观（如色泽、是否有瑕疵）、成熟度等多个维度进行划分，以确保不同等级的产品能对应相应的质量标准。\n\n针对您的需求，我们确实有涵盖您所提及的各项指标的详细规格说明文档。这份文档详细列出了不同水果品种、不同等级的具体要求，包括：\n\n品种名称\n果品等级划分 (例如：特级、一级、二级等，或按尺寸/重量区分的代号)\n详细规格描述：\n单果平均/最小/最大重量范围\n果实直径/长度范围\n外观标准（如色泽均匀度、表面光滑度、是否有病虫害、机械伤等）\n成熟度要求\n可接受的瑕疵率等\n我们可以立即将这份详细的果品规格说明书发送给您，供您参考和评估。请告知您希望通过何种方式接收（例如：电子邮件）。\n\n此外，如果您在查阅规格后有任何疑问，或者希望进一步了解不同等级果品的具体表现，我们非常乐意安排一次线上或线下的沟通，或提供相关等级的样品供贵酒店进行品鉴。\n\n我们期待有机会与贵酒店建立合作关系，为您提供高品质、符合您严格标准的果品。\n\n再次感谢您的垂询。期待您的回复！', '2025-05-07 17:00:40', '2025-05-07 17:00:40', 'interactive_consultation', 14, 19);

-- ----------------------------
-- Table structure for consumer
-- ----------------------------
DROP TABLE IF EXISTS `consumer`;
CREATE TABLE `consumer`  (
  `consumer_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '消费者ID',
  `user_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '用户姓名',
  `mobile_phone_number` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '手机号码',
  `examine_state` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '已通过' COMMENT '审核状态',
  `user_id` int(11) NOT NULL DEFAULT 0 COMMENT '用户ID',
  `create_time` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间',
  PRIMARY KEY (`consumer_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 10 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '消费者' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of consumer
-- ----------------------------
INSERT INTO `consumer` VALUES (5, '菜篮子达人', '17344445555', '已通过', 11, '2025-04-22 19:09:41', '2025-04-22 19:09:41');
INSERT INTO `consumer` VALUES (6, '果蔬控_520', '13733334444', '已通过', 12, '2025-04-22 19:10:20', '2025-04-22 19:10:20');
INSERT INTO `consumer` VALUES (7, '绿通配送中心', '13788887777', '已通过', 13, '2025-04-22 19:11:03', '2025-04-22 19:11:03');
INSERT INTO `consumer` VALUES (8, '田园联运', '18899994444', '已通过', 14, '2025-04-22 19:12:05', '2025-04-22 19:12:05');
INSERT INTO `consumer` VALUES (9, '雪松温泉度假酒店', '13733335555', '已通过', 15, '2025-04-22 19:13:02', '2025-04-22 19:13:02');

-- ----------------------------
-- Table structure for coupon
-- ----------------------------
DROP TABLE IF EXISTS `coupon`;
CREATE TABLE `coupon`  (
  `coupon_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '优惠券ID',
  `coupon_user_id` int(11) DEFAULT NULL COMMENT '优惠券用户ID',
  `coupon_user_auth` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '优惠券用户',
  `coupon_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '优惠券名称',
  `coupon_price` int(11) DEFAULT NULL COMMENT '优惠券价格',
  `coupon_price1` int(11) DEFAULT NULL COMMENT '优惠券券后价格',
  `coupon_time` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '优惠券时间',
  `coupon_type` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '优惠券类型',
  `create_time` timestamp(0) DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp(0) DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间',
  PRIMARY KEY (`coupon_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '优惠券' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of coupon
-- ----------------------------
INSERT INTO `coupon` VALUES (1, 16, '农户商家', ' 鲜肉尝鲜满50减5元券', 50, 5, '2025-04-24 00:00:00,2025-07-10 00:00:00', '满减', '2025-04-24 16:13:00', '2025-04-24 16:13:00');

-- ----------------------------
-- Table structure for coupon_user
-- ----------------------------
DROP TABLE IF EXISTS `coupon_user`;
CREATE TABLE `coupon_user`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '用户优惠券ID',
  `user_id` int(11) DEFAULT NULL COMMENT '用户ID',
  `coupon_id` int(11) DEFAULT NULL COMMENT '优惠券ID',
  `is_use` int(11) DEFAULT NULL COMMENT '是否使用',
  `coupon_user_id` int(11) DEFAULT NULL COMMENT '用户优惠券ID',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '用户优惠券' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for experience_sharing
-- ----------------------------
DROP TABLE IF EXISTS `experience_sharing`;
CREATE TABLE `experience_sharing`  (
  `experience_sharing_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '经验分享ID',
  `title` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '标题',
  `share_type` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '分享类型',
  `experience_content` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '经验内容',
  `create_time` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间',
  PRIMARY KEY (`experience_sharing_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 16 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '经验分享' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of experience_sharing
-- ----------------------------
INSERT INTO `experience_sharing` VALUES (14, '从牧场到餐桌：鲜海润鲜肉的安心加工之旅', '生产／加工流程', '<p>各位合作伙伴、尊敬的客户：</p><p>大家好！我们是鲜海润肉业有限公司旗下鲜肉加工厂。能够在这个农产品市场平台分享我们的经验，我们感到非常荣幸。今天，我们想重点向大家介绍一下鲜海润鲜肉的“生产/加工流程”，让大家了解我们如何将优质的肉源转化为您餐桌上的放心美味。</p><p>我们的鲜肉加工流程，是一套严谨、科学、全程可控的体系，旨在最大限度地保证肉品的<strong>新鲜、安全与高品质</strong>。</p><ol><li><strong>源头严选，可追溯的安心：</strong> 一切始于优质的活畜。我们与信誉良好、符合国家标准的养殖基地建立长期合作关系，确保每一批进入工厂的活畜都经过严格的检验检疫，来源可追溯。从养殖到运输，我们都遵循严格的动物福利和卫生标准。</li><li><strong>规范屠宰，人道高效：</strong> 活畜抵达工厂后，将在符合国家标准的现代化屠宰车间进行屠宰。我们采用人道、快速的屠宰方式，最大程度减少动物应激反应，保证肉品品质。屠宰过程严格执行卫生规程，确保环境洁净，避免交叉污染。</li><li><strong>精准排酸，提升口感：</strong> 屠宰后的胴体立即进入冷却排酸环节。在精确控制温度和湿度的环境下，肉品进行充分的排酸，这不仅能有效抑制微生物生长，更能改善肉品的嫩度和风味，让肉质更加鲜美。</li><li><strong>精细分割，按需定制：</strong> 经过排酸的胴体由经验丰富的分割技师进行精细分割。根据市场需求和不同部位的特性，我们将肉品分割成各种规格的部位肉。整个分割过程在低温环境下进行，最大限度地保持肉品的新鲜度。</li><li><strong>严格品控，层层把关：</strong> 在加工的每一个环节，我们都设有严格的品质控制点。从原料验收、车间环境、人员操作到半成品和成品的检验，我们都依据国家标准和企业内控标准进行严格检测，包括微生物、兽药残留等多项指标，确保产品符合甚至超越安全标准。</li><li><strong>锁鲜包装，延长保质：</strong> 分割好的鲜肉会立即采用符合食品安全要求的包装材料进行真空或贴体包装。先进的包装技术能够有效隔绝氧气和外界污染，延长肉品的保质期，同时方便运输和储存。</li><li><strong>冷链运输，全程守护：</strong> 包装好的鲜肉产品立即进入冷库进行预冷，然后通过专业的冷链物流车辆送达各地。我们确保在运输过程中全程保持适宜的低温，确保产品从工厂到客户手中，都能保持最佳的新鲜状态。</li></ol><p>我们深知，每一份鲜肉都承载着消费者对食品安全的信任。鲜海润肉业始终坚持“质量为本，诚信经营”的理念，通过标准化的生产加工流程和持续的技术改进，致力于为广大客户提供安全、健康、高品质的鲜肉产品。</p><p>希望这次分享能让大家对我们的鲜肉加工过程有更深入的了解。欢迎大家通过平台与我们沟通交流，也期待未来能与更多伙伴建立合作，共同将优质农产品送上千家万户的餐桌！</p><p>谢谢大家！</p>', '2025-04-24 16:04:39', '2025-04-24 16:04:39');
INSERT INTO `experience_sharing` VALUES (15, '果然甜生态农业：用心耕耘品牌，让“生态甜”深入人心', '市场营销与品牌建设', '<p>各位同行朋友，平台管理员们：</p><p>大家好！我们是果然甜生态农业有限公司，很高兴能在这个平台与大家交流学习。今天，我想结合我们公司的一些实践，简单分享一下在生态农产品领域进行市场营销与品牌建设方面的心得体会，希望能对大家有所启发。</p><p><strong>一、 立足“生态”根本，讲好品牌故事</strong></p><p>“果然甜”的名字，寄托了我们对产品品质的承诺和消费者的期望。我们深知，做生态农业，<strong>产品的“硬实力”是基础，而“讲故事”的能力则是品牌能否深入人心的关键。</strong></p><ol><li><strong>品质是基石：</strong>&nbsp;我们严格把控从种植/养殖到采收、包装的每一个环节，确保符合生态标准，真正做到“果然甜，果然放心”。这是我们所有营销活动能够获得信任的前提。</li><li><strong>挖掘独特性：</strong>&nbsp;我们会提炼产品的核心优势，比如特定的优良品种、独特的生长环境（土壤、水源）、遵循自然农法的种植方式等。将这些信息通过产品详情页、图片、短视频等形式生动地展示给消费者，让他们了解“为什么我们的产品不一样”。</li><li><strong>传递价值观：</strong>&nbsp;我们不仅仅是卖农产品，更是倡导一种健康、可持续的生活方式。通过品牌故事，传递我们对土地的敬畏、对生态的尊重，与认同这种理念的消费者建立情感连接。</li></ol><p><strong>二、 线上线下结合，多渠道触达消费者</strong></p><p>在营销渠道上，我们坚持线上线下协同发力。</p><ol><li><strong>深耕线上平台：</strong>&nbsp;充分利用农产品市场平台的功能，优化商品信息（标题吸引人、主图清晰美观、详情页内容详实），积极参与平台活动，利用好评价体系积累口碑。同时，我们也运营自己的社交媒体账号（如微信公众号/视频号），发布农场日常、产品知识、食谱分享等内容，与粉丝互动，增强用户粘性。</li><li><strong>拓展线下体验：</strong>&nbsp;对于有条件的同行，可以考虑开展农场参观、采摘体验等活动，让消费者亲身感受生态农业的魅力，建立更强的信任感。我们也会选择性地参与一些优质的农夫市集或展会，直接面对消费者，收集反馈。</li></ol><p><strong>三、 塑造统一形象，强化品牌认知</strong></p><p>品牌建设是一个系统工程，视觉形象和品牌调性的统一非常重要。</p><ol><li><strong>视觉锤炼：</strong>&nbsp;从Logo设计、产品包装到宣传物料，我们都力求体现“生态、自然、甜美、健康”的特点，色彩选择、字体运用都围绕这个核心。</li><li><strong>一致沟通：</strong>&nbsp;无论是客服回复、产品文案还是活动宣传，都保持统一的、友好的、专业的品牌语调。</li></ol><p><strong>四、 持续学习与优化</strong></p><p>市场在变，消费者的需求也在变。我们会密切关注行业动态和消费者反馈，不断调整营销策略。同时，也积极向平台上的优秀同行学习，取长补短。</p><p><strong>总结：</strong></p><p>生态农产品的品牌建设，核心在于**“真实”<strong>和</strong>“用心”**。用过硬的产品品质赢得基础信任，用真诚的故事打动消费者，用持续的互动建立长期关系。这条路需要耐心和坚持，但我们相信，只要方向正确，用心耕耘，就一定能让“果然甜”这样的生态品牌，真正走进消费者的心里。</p><p>以上是我们的一些粗浅经验，希望能与大家共同探讨，一起进步！</p><p>谢谢大家！</p><p>果然甜生态农业有限公司</p>', '2025-04-24 16:16:36', '2025-04-24 16:16:36');

-- ----------------------------
-- Table structure for farmers_merchants
-- ----------------------------
DROP TABLE IF EXISTS `farmers_merchants`;
CREATE TABLE `farmers_merchants`  (
  `farmers_merchants_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '农户商家ID',
  `business_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '商家名称',
  `contact_number` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '联系号码',
  `business_address` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '商家地址',
  `business_license` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '营业执照',
  `certification_application` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '认证申请',
  `examine_state` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '未审核' COMMENT '审核状态',
  `user_id` int(11) NOT NULL DEFAULT 0 COMMENT '用户ID',
  `create_time` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间',
  PRIMARY KEY (`farmers_merchants_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 10 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '农户商家' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of farmers_merchants
-- ----------------------------
INSERT INTO `farmers_merchants` VALUES (6, '鲜海润肉业有限公司', '17617661755', '广东省珠海市金湾区红旗镇工业大道18号', '/api/upload/135115ecc2904d31ae4bb581424bbe9e_th-2869793494.jpg', '/api/upload/1557992133129504-4137740402.jpg', '已通过', 16, '2025-04-22 19:15:25', '2025-04-22 19:16:29');
INSERT INTO `farmers_merchants` VALUES (7, '海珍鲜坊食品有限公司', '15200223456', '山东省烟台市莱山区海港工业园5号', '/api/upload/135115ecc2904d31ae4bb581424bbe9e_th-2869793494.jpg', '/api/upload/1557992133129504-4137740402.jpg', '已通过', 17, '2025-04-22 19:19:16', '2025-04-22 19:19:32');
INSERT INTO `farmers_merchants` VALUES (8, '果然甜生态农业有限公司', '13811112222', '广西百色市田阳县生态果园产业园12号', '/api/upload/135115ecc2904d31ae4bb581424bbe9e_th-2869793494.jpg', '/api/upload/135115ecc2904d31ae4bb581424bbe9e_th-2869793494.jpg', '已通过', 18, '2025-04-22 19:21:17', '2025-04-22 19:22:17');
INSERT INTO `farmers_merchants` VALUES (9, '丰果季农业科技有限公司', '15700001111', '河北邯郸市涉县现代农业科技产业园区22号', '/api/upload/135115ecc2904d31ae4bb581424bbe9e_th-2869793494.jpg', '/api/upload/1557992133129504-4137740402.jpg', '已通过', 19, '2025-04-22 19:22:13', '2025-04-22 19:22:15');

-- ----------------------------
-- Table structure for forum
-- ----------------------------
DROP TABLE IF EXISTS `forum`;
CREATE TABLE `forum`  (
  `forum_id` mediumint(8) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '论坛ID',
  `display` smallint(5) UNSIGNED NOT NULL DEFAULT 100 COMMENT '排序',
  `user_id` mediumint(8) UNSIGNED NOT NULL DEFAULT 0 COMMENT '用户ID',
  `nickname` varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT '' COMMENT '昵称',
  `praise_len` int(10) DEFAULT 0 COMMENT '点赞数',
  `hits` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '访问数',
  `title` varchar(125) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '标题',
  `keywords` varchar(125) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '关键词',
  `description` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '描述',
  `url` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '来源地址',
  `tag` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '标签',
  `img` text CHARACTER SET utf8 COLLATE utf8_general_ci COMMENT '封面图',
  `content` longtext CHARACTER SET utf8 COLLATE utf8_general_ci COMMENT '正文',
  `create_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间',
  `avatar` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '发帖人头像',
  `type` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '0' COMMENT '论坛分类',
  `istop` int(10) NOT NULL DEFAULT 0 COMMENT '是否置顶',
  PRIMARY KEY (`forum_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '论坛' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of forum
-- ----------------------------
INSERT INTO `forum` VALUES (6, 0, 11, '菜篮子达人', 1, 502, '猪前腿肉不只炖和炒！试试这个【香草蒜蓉烤猪肉配时蔬】', NULL, '', NULL, '#猪前腿肉 #创意菜谱 #烤箱菜 #家常菜 #一锅出 #周末料理 #香草风味', '', '大家好，我是你们的老朋友“菜篮子达人”！\n前几天在平台买了 [鲜海润肉业有限公司] 的新鲜猪前腿肉，肉质看着真不错！除了咱们常做的红烧、炖汤或者绞肉馅，今天我尝试了个新做法——用烤箱来料理它，搭配上时令蔬菜，做了一道【香草蒜蓉烤猪肉配时蔬】', '2025-04-24 16:46:46', '2025-05-08 22:37:51', NULL, '农产品创意菜谱', 0);
INSERT INTO `forum` VALUES (7, 0, 12, '果蔬控_520', 400, 201, '爆汁水蜜桃', NULL, '', NULL, '水果', '', '这个阳山水蜜桃好吃到爆\n强烈推荐', '2025-05-04 17:24:25', '2025-05-07 17:09:16', NULL, '采摘打卡分享', 0);
INSERT INTO `forum` VALUES (8, 0, 13, '绿通配送中心', 1, 3, '听说今年特色农产品要火？大家有没有内部消息啊！', NULL, '', NULL, '', '', '大家好啊！我们是绿通配送中心，平时接触农产品比较多。\n\n最近在圈子里老听到一些风声，感觉今年的农业趋势有点不一样。特别多朋友在讨论“特色农产品”是不是要迎来爆发期了？\n\n就是那些平时市场上不那么多见，但有地方特色或者特定卖点（比如富硒、有机、特定品种）的农产品。', '2025-05-07 17:10:14', '2025-05-08 22:37:54', NULL, '农业趣事八卦', 0);

-- ----------------------------
-- Table structure for forum_type
-- ----------------------------
DROP TABLE IF EXISTS `forum_type`;
CREATE TABLE `forum_type`  (
  `type_id` smallint(5) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '分类ID',
  `name` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '分类名称',
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '描述',
  `url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '外链地址',
  `father_id` smallint(5) UNSIGNED NOT NULL DEFAULT 0 COMMENT '上级分类ID',
  `icon` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '分类图标',
  `create_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间',
  PRIMARY KEY (`type_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '论坛分类' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of forum_type
-- ----------------------------
INSERT INTO `forum_type` VALUES (4, '农产品创意菜谱', '', '', 0, '', '2025-04-24 16:00:32', '2025-04-24 16:00:32');
INSERT INTO `forum_type` VALUES (5, '采摘打卡分享', '', '', 0, '', '2025-04-24 16:00:41', '2025-04-24 16:00:41');
INSERT INTO `forum_type` VALUES (6, '农业趣事八卦', '', '', 0, '', '2025-04-24 16:00:58', '2025-04-24 16:00:58');

-- ----------------------------
-- Table structure for goods
-- ----------------------------
DROP TABLE IF EXISTS `goods`;
CREATE TABLE `goods`  (
  `goods_id` mediumint(8) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '产品ID',
  `title` varchar(125) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '标题',
  `img` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci COMMENT '封面图：用于显示于产品列表页',
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '描述',
  `price_ago` double(8, 2) UNSIGNED NOT NULL DEFAULT 0.00 COMMENT '原价',
  `price` double(8, 2) UNSIGNED NOT NULL DEFAULT 0.00 COMMENT '卖价',
  `sales` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '销量',
  `inventory` int(11) UNSIGNED NOT NULL DEFAULT 0 COMMENT '商品库存',
  `type` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '商品分类',
  `hits` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '点击量',
  `content` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci COMMENT '正文',
  `img_1` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci COMMENT '主图1',
  `img_2` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci COMMENT '主图2',
  `img_3` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci COMMENT '主图3',
  `img_4` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci COMMENT '主图4',
  `img_5` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci COMMENT '主图5',
  `create_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间',
  `customize_field` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci COMMENT '自定义字段',
  `source_table` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '来源表',
  `source_field` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '来源字段',
  `source_id` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '来源ID',
  `user_id` int(11) UNSIGNED DEFAULT 0 COMMENT '添加人',
  PRIMARY KEY (`goods_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '商品信息' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of goods
-- ----------------------------
INSERT INTO `goods` VALUES (1, '鲜海润 - 雪花五花肉片 (肥瘦相间 烧烤火锅优选)', '/api/upload/1051269_20170126122010684070_0-2610040877.jpg', '精选五花肉，肥瘦黄金比例，口感香嫩，烤涮皆宜', 38.00, 35.00, 0, 650, '生鲜', 5, '<p><strong>【烧烤火锅灵魂伴侣 - 鲜海润雪花五花肉片】</strong></p><p>鲜海润肉业为您呈献精心挑选、切割的雪花五花肉片。我们选用猪腹部精华部位，肥瘦层次分明，呈现诱人的“雪花”纹理。</p><p><strong>【产品亮点】</strong></p><ul><li><strong>黄金肥瘦比：</strong>&nbsp;肥肉甘香，瘦肉鲜嫩，完美结合带来丰富口感。</li><li><strong>均匀切片：</strong>&nbsp;标准厚度约3mm，无论烧烤还是涮烫，都能快速熟透，保持最佳口感。</li><li><strong>鲜嫩多汁：</strong>&nbsp;脂肪在加热后滋润瘦肉，入口香浓不柴，汁水丰盈。</li><li><strong>锁鲜包装：</strong>&nbsp;采用先进的气调包装技术，最大程度保持肉质的新鲜度和色泽。</li></ul><p><strong>【适用场景】</strong></p><ul><li><strong>韩式/日式烧烤：</strong>&nbsp;烤后滋滋作响，香气扑鼻。</li><li><strong>各式火锅：</strong>&nbsp;轻涮几秒即可捞出，鲜嫩爽滑。</li><li><strong>家常小炒：</strong>&nbsp;如蒜苔炒肉、回锅肉等，增添风味。</li></ul><p>鲜海润承诺，为您提供安全、高品质的鲜肉产品。这款雪花五花肉片是家庭聚餐、朋友聚会的理想选择，让美味时刻更加精彩！</p>', '/api/upload/25556641_131901495085_2-904342886.jpg', '/api/upload/1051269_20170126122010684070_0-2610040877.jpg', '/api/upload/25556641_131901495085_2-904342886.jpg', '/api/upload/1051269_20170126122010684070_0-2610040877.jpg', '/api/upload/25556641_131901495085_2-904342886.jpg', '2025-04-24 16:09:48', '2025-05-04 17:38:56', '[{\"field_name\":\"产品规格\",\"field_value\":\"元/500g\"},{\"field_name\":\"农户商家\",\"field_value\":16,\"type\":\"uid\"},{\"field_name\":\"商家名称\",\"field_value\":\"鲜海润肉业有限公司\"},{\"field_name\":\"联系号码\",\"field_value\":\"17617661755\"},{\"field_name\":\"商家地址\",\"field_value\":\"广东省珠海市金湾区红旗镇工业大道18号\"}]', 'agricultural_products', 'agricultural_products_id', 1, 16);
INSERT INTO `goods` VALUES (2, '鲜海润 - 精选新鲜猪前腿肉', '/api/upload/ea3926085a790570-1917441911.jpg', '肉质紧实，肥瘦适中，炖煮香浓，绞馅鲜美', 25.00, 22.00, 0, 800, '生鲜', 4, '<p><strong>鲜海润品质保证，源自自家鲜肉加工厂！</strong></p><p>我们为您带来新鲜宰杀的优质猪前腿肉。这部分肉活动量大，因此肉质紧实，略带筋络，肥瘦比例恰到好处。</p><p><strong>【产品特点】</strong></p><ul><li><strong>新鲜直供：</strong>&nbsp;每日凌晨宰杀处理，冷链配送，确保新鲜。</li><li><strong>肉质优良：</strong>&nbsp;口感丰富有嚼劲，炖煮后汤汁浓郁，肉香四溢。</li><li><strong>用途广泛：</strong>&nbsp;非常适合长时间炖煮（如红烧肉、卤肉）、煲汤，也是制作饺子、包子、肉丸等馅料的绝佳选择。</li><li><strong>安全卫生：</strong>&nbsp;严格执行检疫标准，真空包装有效隔绝污染，锁住营养和风味。</li></ul><p><strong>【烹饪建议】</strong></p><ul><li>红烧、慢炖：充分释放肉质香味。</li><li>绞碎制馅：制作饺子、包子、肉饼等。</li><li>切块煲汤：搭配蔬菜或药材，营养丰富。</li></ul><p>选择鲜海润，就是选择新鲜、安全、美味！即刻下单，为您的餐桌增添一份安心好滋味！</p>', '/api/upload/ea3926085a790570-1917441911.jpg', '/api/upload/41a32c8b04759f73-3374360799.jpg', '/api/upload/41a32c8b04759f73-3374360799.jpg', '/api/upload/ea3926085a790570-1917441911.jpg', '/api/upload/41a32c8b04759f73-3374360799.jpg', '2025-04-24 16:11:36', '2025-05-04 17:39:00', '[{\"field_name\":\"产品规格\",\"field_value\":\"约500g/份，真空锁鲜包装\"},{\"field_name\":\"农户商家\",\"field_value\":16,\"type\":\"uid\"},{\"field_name\":\"商家名称\",\"field_value\":\"鲜海润肉业有限公司\"},{\"field_name\":\"联系号码\",\"field_value\":\"17617661755\"},{\"field_name\":\"商家地址\",\"field_value\":\"广东省珠海市金湾区红旗镇工业大道18号\"}]', 'agricultural_products', 'agricultural_products_id', 2, 16);
INSERT INTO `goods` VALUES (3, '果然金穗 - 生态甜糯玉米', '/api/upload/b94e-kcpxnww0586161-394684502.jpg', '源自广西田阳生态农场，自然农法种植，鲜嫩软糯与清甜多汁的完美结合！', 28.00, 25.00, 0, 1000, '果蔬', 4, '<p><strong>【来自果然金穗农场的甜蜜馈赠 - 生态种植甜糯玉米】</strong></p><p>大家好！我们是“果然甜生态农业”，非常自豪地为您带来产自我们广西百色市田阳县“果然金穗农场”的当季新鲜甜糯玉米！</p><p><strong>【生态种植，自然之味】</strong></p><p>在果然金穗农场，我们坚持生态种植理念：</p><ul><li><strong>尊重土地：</strong>&nbsp;使用有机肥改良土壤，不使用化学除草剂，让土地保持活力。</li><li><strong>自然生长：</strong>&nbsp;遵循玉米自然生长周期，不催熟，享受充足的阳光和雨露。</li><li><strong>物理防治：</strong>&nbsp;采用物理和生物方法防治虫害，最大程度减少人为干预，确保玉米的天然纯粹。</li></ul><p><strong>【产品特点】</strong></p><ul><li><strong>品种优选：</strong>&nbsp;精心挑选甜糯玉米品种，兼具水果玉米的清甜多汁和糯玉米的软糯口感。</li><li><strong>口感上乘：</strong>&nbsp;颗粒饱满，皮薄无渣，入口软糯香甜，回味无穷。无论是蒸、煮、烤，还是煲汤，都风味绝佳。</li><li><strong>新鲜采摘：</strong>&nbsp;坚持“从田间到餐桌”的新鲜承诺，订单后新鲜采摘，带着能锁住水分和新鲜度的苞叶为您发出。</li></ul><p><strong>【食用建议】</strong></p><ul><li><strong>原味蒸煮：</strong>&nbsp;清水煮或蒸15-20分钟，最能品尝到玉米本身的香甜软糯。</li><li><strong>烧烤风味：</strong>&nbsp;刷上酱料进行烧烤，外焦里糯，别有风味。</li><li><strong>营养煲汤：</strong>&nbsp;与排骨、胡萝卜等一同煲汤，汤汁鲜甜，营养丰富。</li></ul><p>选择果然甜，就是选择一份来自大自然的安心与美味。现在下单，让这份来自果然金穗农场的甜蜜滋味，丰富您的健康餐桌！</p><p><strong>温馨提示：</strong>&nbsp;生鲜产品，请收到后尽快食用或冷藏保存（建议3-5天内食用完毕以保最佳风味）。</p>', '/api/upload/34599220_203844395105_2-2969986085.jpg', '/api/upload/b94e-kcpxnww0586161-394684502.jpg', '/api/upload/34599220_203844395105_2-2969986085.jpg', '/api/upload/b94e-kcpxnww0586161-394684502.jpg', '/api/upload/34599220_203844395105_2-2969986085.jpg', '2025-04-24 16:19:55', '2025-05-04 17:32:26', '[{\"field_name\":\"产品规格\",\"field_value\":\"约2.5公斤/份 (约5-7穗，根据单穗大小调整)，带苞叶发货\"},{\"field_name\":\"农户商家\",\"field_value\":18,\"type\":\"uid\"},{\"field_name\":\"商家名称\",\"field_value\":\"果然甜生态农业有限公司\"},{\"field_name\":\"联系号码\",\"field_value\":\"13811112222\"},{\"field_name\":\"商家地址\",\"field_value\":\"广西百色市田阳县生态果园产业园12号\"}]', 'agricultural_products', 'agricultural_products_id', 3, 18);
INSERT INTO `goods` VALUES (4, '海珍鲜坊 - 渤海湾深海鲜活鲍鱼 ', '/api/upload/01xytqlxclkdtcxsjo5fsf3433-1870885558.jpg', '源自海珍深海养殖场，渤海湾优质海域馈赠，每日鲜捞，急速锁鲜直达餐桌！', 198.00, 178.00, 0, 300, '海鲜', 2, '<p><strong>【源自渤海湾的深海珍品——海珍鲜坊·鲜活鲍鱼】</strong></p><p>尊敬的顾客，您好！海珍鲜坊食品有限公司，依托自有**【海珍·深海养殖场】**，为您呈献来自渤海湾核心优质海域的顶级鲜活鲍鱼！</p><p><strong>【得天独厚的生长环境】</strong></p><ul><li><strong>渤海湾优质海域：</strong>&nbsp;水质纯净，营养丰富，盐度适中，是鲍鱼等高端海产得天独厚的生长天堂。</li><li><strong>深海网箱养殖：</strong>&nbsp;远离近岸污染，采用海上深水网箱，模拟鲍鱼自然生长环境，让鲍鱼活动空间更大，肉质更紧实、更鲜美。</li></ul><p><strong>【从大海到餐桌，锁住极致新鲜】</strong></p><p>我们深知“鲜”是海产的灵魂，因此我们郑重承诺：</p><ul><li><strong>每日鲜捞：</strong>&nbsp;专业团队每日根据订单捕捞，确保您收到的每一只鲍鱼都充满活力。</li><li><strong>急速锁鲜：</strong>&nbsp;捕捞上岸后，鲍鱼立即进入岸基急速降温仓库处理，快速降低鲍鱼新陈代谢，最大限度锁住鲜活与营养。</li><li><strong>当日发货：</strong>&nbsp;采用专业鲜活水产包装（泡沫箱+冰袋+氧气袋），与顺丰冷链等优质物流合作，实现当日发货，次日/隔日即达（视距离而定），鲜活到家！</li></ul><p><strong>【品质上乘，口感绝佳】</strong></p><ul><li><strong>个大肉厚：</strong>&nbsp;精选4-6头/斤的优质规格，鲍鱼肉柱肥厚饱满。</li><li><strong>Q弹鲜甜：</strong>&nbsp;口感紧实Q弹，味道鲜美甘甜，无腥味，是海味中的上品。</li><li><strong>营养丰富：</strong>&nbsp;富含蛋白质、多种维生素和微量元素，是滋补佳品。</li></ul><p><strong>【推荐食法】</strong></p><p>清蒸、蒜蓉粉丝蒸、捞饭、煲汤、刺身（需确保绝对新鲜且处理得当）等，简单的烹饪最能体现其原汁原味的鲜美。</p><p>选择海珍鲜坊，就是选择一份来自深海的纯净、新鲜与尊贵。立即下单，让这份渤海湾的馈赠，为您的餐桌增添一道亮丽的风景线！</p><p><strong>【温馨提示】</strong>&nbsp;收到鲜活鲍鱼后，请尽快处理或置于冰箱冷藏（0-4℃），并尽快食用，以保证最佳口感和品质。如需暂养，请用海水或配置接近海水盐度的盐水，并打氧。</p>', '/api/upload/TB2S9w3aH9YBuNjy0FgXXcxcXXa_!!33656204-3533739786.jpg', '/api/upload/TB2S9w3aH9YBuNjy0FgXXcxcXXa_!!33656204-3533739786.jpg', '/api/upload/01xytqlxclkdtcxsjo5fsf3433-1870885558.jpg', '/api/upload/01xytqlxclkdtcxsjo5fsf3433-1870885558.jpg', '/api/upload/TB2S9w3aH9YBuNjy0FgXXcxcXXa_!!33656204-3533739786.jpg', '2025-04-24 16:24:33', '2025-05-07 17:09:41', '[{\"field_name\":\"产品规格\",\"field_value\":\" 约500g/份 (约4-6只，单只约80-125g)，鲜活带壳\"},{\"field_name\":\"农户商家\",\"field_value\":17,\"type\":\"uid\"},{\"field_name\":\"商家名称\",\"field_value\":\"海珍鲜坊食品有限公司\"},{\"field_name\":\"联系号码\",\"field_value\":\"15200223456\"},{\"field_name\":\"商家地址\",\"field_value\":\"山东省烟台市莱山区海港工业园5号\"}]', 'agricultural_products', 'agricultural_products_id', 4, 17);
INSERT INTO `goods` VALUES (5, '桃源仙谷 - 正宗阳山爆汁水蜜桃 (一级大果)', '/api/upload/304a434d476d77557061-2762687778.jpg', '来自水蜜桃之乡阳山的甜蜜问候，皮薄肉厚，一口爆汁，甜过初恋！', 138.00, 118.00, 0, 999, '果蔬', 4, '<p><strong>【夏日限定的甜蜜暴击——桃源仙谷·阳山水蜜桃】</strong></p><p>您是否在期待那一口，能让整个夏天都变得温柔起来的滋味？</p><p>来自正宗水蜜桃核心产区——<strong>江苏无锡阳山</strong>的【桃源仙谷】水蜜桃，带着太湖的温润和江南的灵秀，如约而至！</p><p><strong>【得天独厚的自然恩赐】</strong></p><p>阳山，亿万年前的古火山，留下了独特的火山灰土壤，富含多种微量元素，滋养出与众不同的水蜜桃风味。这里气候温和，雨水充沛，光照适宜，是水蜜桃生长的理想天堂。</p><p><strong>【我们用心，只为您口中的那份甜】</strong></p><ul><li><strong>精心培育：</strong>&nbsp;坚持绿色种植理念，施用农家肥和有机肥，物理方法防治虫害，让每一颗桃子都自然成熟，健康安全。</li><li><strong>人工精选：</strong>&nbsp;只挑选达到一级大果标准、成熟度恰到好处（约8-9分熟，兼顾口感与运输）、外观粉嫩、绒毛均匀的“甜心宝贝”。</li><li><strong>成熟采摘：</strong>&nbsp;绝不提前采摘催熟，只在桃子风味和甜度达到巅峰时，由经验丰富的果农手工采摘。</li></ul><p><strong>【无法抗拒的味蕾诱惑】</strong></p><ul><li><strong>外观：</strong>&nbsp;粉里透红，绒毛细腻，像少女娇羞的脸庞。</li><li><strong>香气：</strong>&nbsp;凑近一闻，浓郁的桃香扑鼻而来，清新自然。</li><li><strong>口感：</strong>&nbsp;轻轻撕开薄如蝉翼的外皮，饱满的汁水几乎要溢出！果肉细腻软糯，<strong>入口即化</strong>，几乎无渣。</li><li><strong>味道：</strong>&nbsp;甜度高而不腻，恰到好处的微酸更添风味层次，满口都是清甜的桃汁和软嫩的果肉，幸福感爆棚！</li></ul><p><strong>【新鲜直达，锁住枝头风味】</strong></p><ul><li><strong>专业包装：</strong>&nbsp;每颗桃子都套上柔软的保护网套，稳固放入带有缓冲隔断的特制礼盒中，最大程度减少运输磕碰。</li><li><strong>快速物流：</strong>&nbsp;采摘后尽快发出，与顺丰/京东等优质快递合作，将枝头的新鲜尽快送到您手中。</li></ul><p>无论是犒劳自己，还是与家人分享，或是作为一份充满心意的夏日礼物，【桃源仙谷】阳山水蜜桃都是绝佳的选择！</p><p><strong>【温馨提示】</strong></p><p>水蜜桃娇嫩，请收到后立即开箱检查。常温放置1-2天可追熟，口感更佳。若想延长保存期，可用保鲜袋包裹后放入冰箱冷藏（非冷冻），并尽快食用。食用前请轻轻清洗。</p><p>现在就下单，开启您的甜蜜一夏吧！</p>', '/api/upload/GDZ4MWd2-SEO-內圖-8-1765660813.jpg', '/api/upload/304a434d476d77557061-2762687778.jpg', '/api/upload/GDZ4MWd2-SEO-內圖-8-1765660813.jpg', '/api/upload/304a434d476d77557061-2762687778.jpg', '/api/upload/GDZ4MWd2-SEO-內圖-8-1765660813.jpg', '2025-04-24 16:28:05', '2025-05-04 17:32:23', '[{\"field_name\":\"产品规格\",\"field_value\":\"一级大果，单果重约250-300g (约7-9个/箱)，净重约4.5-5斤，礼盒装\"},{\"field_name\":\"农户商家\",\"field_value\":19,\"type\":\"uid\"},{\"field_name\":\"商家名称\",\"field_value\":\"丰果季农业科技有限公司\"},{\"field_name\":\"联系号码\",\"field_value\":\"15700001111\"},{\"field_name\":\"商家地址\",\"field_value\":\"河北邯郸市涉县现代农业科技产业园区22号\"}]', 'agricultural_products', 'agricultural_products_id', 5, 19);

-- ----------------------------
-- Table structure for goods_type
-- ----------------------------
DROP TABLE IF EXISTS `goods_type`;
CREATE TABLE `goods_type`  (
  `type_id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '商品分类ID',
  `father_id` smallint(5) UNSIGNED NOT NULL DEFAULT 0 COMMENT '上级分类ID',
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '商品名称',
  `desc` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '描述',
  `icon` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '图标',
  `source_table` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '来源表',
  `source_field` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '来源字段',
  `create_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间',
  PRIMARY KEY (`type_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '商品类型' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of goods_type
-- ----------------------------
INSERT INTO `goods_type` VALUES (1, 0, '生鲜', '', '', NULL, NULL, '2025-03-31 18:21:49', '2025-04-05 11:21:52');
INSERT INTO `goods_type` VALUES (2, 0, '果蔬', '', '', NULL, NULL, '2025-03-31 18:21:49', '2025-04-05 11:21:56');
INSERT INTO `goods_type` VALUES (3, 0, '海鲜', '', '', NULL, NULL, '2025-03-31 18:21:49', '2025-04-05 11:22:01');

-- ----------------------------
-- Table structure for hits
-- ----------------------------
DROP TABLE IF EXISTS `hits`;
CREATE TABLE `hits`  (
  `hits_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '点赞ID',
  `user_id` int(11) UNSIGNED NOT NULL DEFAULT 0 COMMENT '点赞人',
  `create_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间',
  `source_table` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '来源表',
  `source_field` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '来源字段',
  `source_id` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '来源ID',
  PRIMARY KEY (`hits_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 31 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '用户点击' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of hits
-- ----------------------------
INSERT INTO `hits` VALUES (1, 8, '2025-04-03 17:05:32', '2025-04-03 17:05:32', 'origin_display', 'origin_display_id', 5);
INSERT INTO `hits` VALUES (2, 8, '2025-04-03 17:05:36', '2025-04-03 17:05:36', 'origin_display', 'origin_display_id', 5);
INSERT INTO `hits` VALUES (3, 8, '2025-04-03 18:06:25', '2025-04-03 18:06:25', 'origin_display', 'origin_display_id', 2);
INSERT INTO `hits` VALUES (4, 8, '2025-04-03 18:06:29', '2025-04-03 18:06:29', 'origin_display', 'origin_display_id', 13);
INSERT INTO `hits` VALUES (5, 8, '2025-04-03 18:06:33', '2025-04-03 18:06:33', 'origin_display', 'origin_display_id', 13);
INSERT INTO `hits` VALUES (6, 8, '2025-04-04 23:27:09', '2025-04-04 23:27:09', 'origin_display', 'origin_display_id', 1);
INSERT INTO `hits` VALUES (7, 8, '2025-04-04 23:27:25', '2025-04-04 23:27:25', 'origin_display', 'origin_display_id', 1);
INSERT INTO `hits` VALUES (8, 8, '2025-04-04 23:27:28', '2025-04-04 23:27:28', 'origin_display', 'origin_display_id', 3);
INSERT INTO `hits` VALUES (9, 8, '2025-04-05 11:30:58', '2025-04-05 11:30:58', 'origin_display', 'origin_display_id', 13);
INSERT INTO `hits` VALUES (10, 8, '2025-04-05 11:31:05', '2025-04-05 11:31:05', 'origin_display', 'origin_display_id', 1);
INSERT INTO `hits` VALUES (11, 8, '2025-04-05 11:44:35', '2025-04-05 11:44:35', 'origin_display', 'origin_display_id', 1);
INSERT INTO `hits` VALUES (12, 8, '2025-04-05 11:45:20', '2025-04-05 11:45:20', 'origin_display', 'origin_display_id', 1);
INSERT INTO `hits` VALUES (13, 8, '2025-04-05 11:45:44', '2025-04-05 11:45:44', 'origin_display', 'origin_display_id', 1);
INSERT INTO `hits` VALUES (14, 8, '2025-04-05 12:15:18', '2025-04-05 12:15:18', 'origin_display', 'origin_display_id', 13);
INSERT INTO `hits` VALUES (15, 8, '2025-04-05 12:15:33', '2025-04-05 12:15:33', 'origin_display', 'origin_display_id', 13);
INSERT INTO `hits` VALUES (16, 8, '2025-04-05 12:15:40', '2025-04-05 12:15:40', 'origin_display', 'origin_display_id', 13);
INSERT INTO `hits` VALUES (17, 8, '2025-04-05 12:16:34', '2025-04-05 12:16:34', 'origin_display', 'origin_display_id', 13);
INSERT INTO `hits` VALUES (18, 8, '2025-04-05 14:21:19', '2025-04-05 14:21:19', 'origin_display', 'origin_display_id', 13);
INSERT INTO `hits` VALUES (19, 8, '2025-04-05 15:46:22', '2025-04-05 15:46:22', 'origin_display', 'origin_display_id', 13);
INSERT INTO `hits` VALUES (20, 8, '2025-04-05 15:46:35', '2025-04-05 15:46:35', 'origin_display', 'origin_display_id', 13);
INSERT INTO `hits` VALUES (21, 8, '2025-04-05 15:47:37', '2025-04-05 15:47:37', 'origin_display', 'origin_display_id', 1);
INSERT INTO `hits` VALUES (22, 15, '2025-04-24 16:39:09', '2025-04-24 16:39:09', 'origin_display', 'origin_display_id', 4);
INSERT INTO `hits` VALUES (23, 15, '2025-04-24 16:39:57', '2025-04-24 16:39:57', 'origin_display', 'origin_display_id', 4);
INSERT INTO `hits` VALUES (24, 15, '2025-04-24 16:40:01', '2025-04-24 16:40:01', 'origin_display', 'origin_display_id', 2);
INSERT INTO `hits` VALUES (25, 15, '2025-04-24 16:40:26', '2025-04-24 16:40:26', 'origin_display', 'origin_display_id', 2);
INSERT INTO `hits` VALUES (26, 15, '2025-04-24 16:40:40', '2025-04-24 16:40:40', 'origin_display', 'origin_display_id', 2);
INSERT INTO `hits` VALUES (27, 15, '2025-04-24 16:40:46', '2025-04-24 16:40:46', 'origin_display', 'origin_display_id', 2);
INSERT INTO `hits` VALUES (28, 15, '2025-05-04 17:38:16', '2025-05-04 17:38:16', 'origin_display', 'origin_display_id', 2);
INSERT INTO `hits` VALUES (29, 15, '2025-05-04 17:38:46', '2025-05-04 17:38:46', 'origin_display', 'origin_display_id', 1);
INSERT INTO `hits` VALUES (30, 12, '2025-05-08 22:38:45', '2025-05-08 22:38:45', 'origin_display', 'origin_display_id', 4);

-- ----------------------------
-- Table structure for interactive_consultation
-- ----------------------------
DROP TABLE IF EXISTS `interactive_consultation`;
CREATE TABLE `interactive_consultation`  (
  `interactive_consultation_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '互动咨询ID',
  `consultation_number` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '咨询编号',
  `farmers_merchants` int(11) DEFAULT 0 COMMENT '农户商家',
  `business_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '商家名称',
  `contact_number` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '联系号码',
  `business_address` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '商家地址',
  `date_of_consultation` date DEFAULT NULL COMMENT '咨询日期',
  `consulting_users` int(11) DEFAULT 0 COMMENT '咨询用户',
  `consulting_content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci COMMENT '咨询内容',
  `consultation_reply_limit_times` int(8) NOT NULL DEFAULT 1 COMMENT '回复限制次数',
  `create_time` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间',
  `source_table` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '来源表',
  `source_id` int(10) DEFAULT 0 COMMENT '来源ID',
  `source_user_id` int(10) DEFAULT 0 COMMENT '来源用户',
  PRIMARY KEY (`interactive_consultation_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 15 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '互动咨询' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of interactive_consultation
-- ----------------------------
INSERT INTO `interactive_consultation` VALUES (14, '2025-04-24 08:40:03', 19, '丰果季农业科技有限公司', '15863123456', '山东省烟台市蓬莱区南山镇阳光路88号', '2025-04-24', 15, '我们酒店对水果的规格（大小、单果重量）和外观有一定要求，请问贵公司是否有不同等级的果品划分？能否提供详细的规格说明？', 1, '2025-04-24 16:40:25', '2025-04-24 16:40:25', NULL, 0, 0);

-- ----------------------------
-- Table structure for logistics_delivery
-- ----------------------------
DROP TABLE IF EXISTS `logistics_delivery`;
CREATE TABLE `logistics_delivery`  (
  `logistics_delivery_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '物流配送ID',
  `order_number` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '订单号',
  `product_name` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '商品名称',
  `purchase_quantity` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '购买数量',
  `total_transaction_amount` double(10, 2) DEFAULT 0.00 COMMENT '交易总额',
  `the_date_of_issuance` date DEFAULT NULL COMMENT '发货日期',
  `delivery_number` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '配送订单',
  `ordinary_users` int(11) DEFAULT 0 COMMENT '普通用户',
  `shipping_address` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '收货地址',
  `delivery_status` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '配送状态',
  `signing_status` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '签收状态',
  `recommend` int(11) NOT NULL DEFAULT 0 COMMENT '智能推荐',
  `contact_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '联系人名字',
  `merchant_id` int(11) DEFAULT NULL COMMENT '商家id',
  `create_time` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间',
  PRIMARY KEY (`logistics_delivery_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '物流配送' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of logistics_delivery
-- ----------------------------
INSERT INTO `logistics_delivery` VALUES (1, '1745484109130473887', '鲜海润 - 雪花五花肉片 (肥瘦相间 烧烤火锅优选)', '1', 35.00, '2025-04-24', 'dh2yqla8xuo00000', 11, '广东省 深圳市 南山区 科技园 XX小区 3栋 10A', '已完成', '已签收', 0, '王女士', 16, '2025-04-24 16:43:04', '2025-04-24 16:44:03');
INSERT INTO `logistics_delivery` VALUES (2, '1745484121368829083', '桃源仙谷 - 正宗阳山爆汁水蜜桃 (一级大果)', '1', 118.00, '2025-05-07', 't9agpo2izls00000', 11, '广东省 深圳市 南山区 科技园 XX小区 3栋 10A', '待取货', '待签收', 0, '王女士', 19, '2025-05-07 17:03:23', '2025-05-07 17:03:23');

-- ----------------------------
-- Table structure for message
-- ----------------------------
DROP TABLE IF EXISTS `message`;
CREATE TABLE `message`  (
  `message_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '留言板ID',
  `user_id` int(11) UNSIGNED NOT NULL DEFAULT 0 COMMENT '用户ID',
  `title` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '标题',
  `content` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '内容',
  `nickname` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '昵称',
  `avatar` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '头像',
  `email` varchar(125) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '留言者邮箱',
  `phone` varchar(11) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '留言者手机号码',
  `create_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间',
  `reply` longtext CHARACTER SET utf8 COLLATE utf8_general_ci COMMENT '回复',
  `reply_state` tinyint(2) DEFAULT 0 COMMENT '回复状态',
  PRIMARY KEY (`message_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '留言板' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of message
-- ----------------------------
INSERT INTO `message` VALUES (3, 15, '平台使用体验反馈', '管理员您好！用了平台一段时间，感觉界面很清晰，找东西也比较方便，特别是可以直接看到商家信息和联系方式，感觉很靠谱。比之前用过的一些平台好多了。希望平台能一直保持下去，多引进一些优质的农产品商家！', '雪松温泉度假酒店', '/api/upload/15876942720821lrorx-1836901316.jpg', NULL, NULL, '2025-04-24 16:39:01', '2025-05-07 17:22:30', '<p>感谢支持</p>', 1);

-- ----------------------------
-- Table structure for order
-- ----------------------------
DROP TABLE IF EXISTS `order`;
CREATE TABLE `order`  (
  `order_id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '订单ID',
  `order_number` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '订单号',
  `goods_id` mediumint(8) UNSIGNED NOT NULL COMMENT '商品ID',
  `title` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '商品标题',
  `img` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '商品图片',
  `price` double(10, 2) UNSIGNED NOT NULL DEFAULT 0.00 COMMENT '价格',
  `price_ago` double(10, 2) UNSIGNED NOT NULL DEFAULT 0.00 COMMENT '原价',
  `num` int(8) NOT NULL DEFAULT 1 COMMENT '数量',
  `price_count` double(8, 2) UNSIGNED NOT NULL DEFAULT 0.00 COMMENT '总价',
  `norms` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '规格',
  `type` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '未分类' COMMENT '商品分类',
  `contact_name` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '联系人姓名',
  `contact_email` varchar(125) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '联系人邮箱',
  `contact_phone` varchar(11) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '联系人手机',
  `contact_address` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '收件地址',
  `postal_code` varchar(9) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '邮政编码',
  `user_id` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '买家ID',
  `merchant_id` mediumint(8) UNSIGNED NOT NULL DEFAULT 0 COMMENT '商家ID',
  `create_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间',
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '描述',
  `state` varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '待付款' COMMENT '订单状态：待付款，待发货，待签收，已签收，待退款，已退款，已拒绝，已完成',
  `remark` text CHARACTER SET utf8 COLLATE utf8_general_ci COMMENT '订单备注',
  `delivery_state` varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT '未配送' COMMENT '发货状态：未配送，已配送',
  `vip_discount` double(10, 2) DEFAULT 0.00 COMMENT '折扣',
  PRIMARY KEY (`order_id`) USING BTREE,
  INDEX `goods_id`(`goods_id`) USING BTREE,
  CONSTRAINT `order_ibfk_1` FOREIGN KEY (`goods_id`) REFERENCES `goods` (`goods_id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '订单' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of order
-- ----------------------------
INSERT INTO `order` VALUES (1, '1745483794421831819', 2, '鲜海润 - 精选新鲜猪前腿肉', '/api/upload/ea3926085a790570-1917441911.jpg', 22.00, 25.00, 30, 660.00, NULL, '生鲜', '采购部 陈主管', NULL, '13733335555', '河北省 承德市 围场满族蒙古族自治县 御道口风景区 雪松温泉度假酒店 后勤收货处', NULL, 15, 16, '2025-04-24 16:36:34', '2025-04-24 16:36:40', '肉质紧实，肥瘦适中，炖煮香浓，绞馅鲜美', '已付款', NULL, '未配送', 0.00);
INSERT INTO `order` VALUES (2, '1745483833471706564', 5, '桃源仙谷 - 正宗阳山爆汁水蜜桃 (一级大果)', '/api/upload/304a434d476d77557061-2762687778.jpg', 118.00, 138.00, 19, 2242.00, NULL, '果蔬', '采购部 陈主管', NULL, '13733335555', '河北省 承德市 围场满族蒙古族自治县 御道口风景区 雪松温泉度假酒店 后勤收货处', NULL, 15, 19, '2025-04-24 16:37:13', '2025-04-24 16:37:13', '来自水蜜桃之乡阳山的甜蜜问候，皮薄肉厚，一口爆汁，甜过初恋！', '待付款', NULL, '未配送', 0.00);
INSERT INTO `order` VALUES (3, '1745484109130473887', 1, '鲜海润 - 雪花五花肉片 (肥瘦相间 烧烤火锅优选)', '/api/upload/1051269_20170126122010684070_0-2610040877.jpg', 35.00, 38.00, 1, 35.00, NULL, '生鲜', '王女士', NULL, '17344445555', '广东省 深圳市 南山区 科技园 XX小区 3栋 10A', NULL, 11, 16, '2025-04-24 16:41:49', '2025-04-24 16:43:04', '精选五花肉，肥瘦黄金比例，口感香嫩，烤涮皆宜', '已付款', NULL, '已配送', 0.00);
INSERT INTO `order` VALUES (4, '1745484121368829083', 5, '桃源仙谷 - 正宗阳山爆汁水蜜桃 (一级大果)', '/api/upload/304a434d476d77557061-2762687778.jpg', 118.00, 138.00, 1, 118.00, NULL, '果蔬', '王女士', NULL, '17344445555', '广东省 深圳市 南山区 科技园 XX小区 3栋 10A', NULL, 11, 19, '2025-04-24 16:42:01', '2025-05-07 17:03:23', '来自水蜜桃之乡阳山的甜蜜问候，皮薄肉厚，一口爆汁，甜过初恋！', '已付款', NULL, '已配送', 0.00);

-- ----------------------------
-- Table structure for origin_display
-- ----------------------------
DROP TABLE IF EXISTS `origin_display`;
CREATE TABLE `origin_display`  (
  `origin_display_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '产地展示ID',
  `name_of_place_of_origin` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '产地名称',
  `cover_chart` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '封面图',
  `place_of_origin_address` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '产地地址',
  `type_of_place_of_origin` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '产地类型',
  `scale_of_origin` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '产地规模',
  `introduction_of_origin` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci COMMENT '产地介绍',
  `farmers_merchants` int(11) DEFAULT 0 COMMENT '农户商家',
  `business_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '商家名称',
  `contact_number` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '联系号码',
  `business_address` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '商家地址',
  `hits` int(11) NOT NULL DEFAULT 0 COMMENT '点击数',
  `collect_len` int(11) NOT NULL DEFAULT 0 COMMENT '收藏数',
  `comment_len` int(11) NOT NULL DEFAULT 0 COMMENT '评论数',
  `recommend` int(11) NOT NULL DEFAULT 0 COMMENT '智能推荐',
  `interactive_consultation_limit_times` int(8) NOT NULL DEFAULT 0 COMMENT '咨询限制次数',
  `create_time` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间',
  PRIMARY KEY (`origin_display_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '产地展示' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of origin_display
-- ----------------------------
INSERT INTO `origin_display` VALUES (1, '果然金穗农场', '/api/upload/0478.jpg_wh1200-186187249.jpg', '河北省邢台市隆尧县西南张村', '农作物种植基地', '玉米 200 亩 小麦 150 亩', '果然·金穗农场位于华北平原核心产区，土壤肥沃、光照充足、降水适中。全程实行绿色无公害种植，配备精准施肥与滴灌系统，确保玉米颗粒饱满、麦穗金黄。农场通过了绿色食品 AA 级认证，产品直供大型商超与电商平台。', 18, '果然甜生态', '18328479988', '河北省邢台市隆尧县西南张村', 551, 70, 20, 70, 0, '2025-04-24 15:47:40', '2025-05-04 17:38:46');
INSERT INTO `origin_display` VALUES (2, '丰果阳光果园', '/api/upload/17133406coue-3002020318.jpeg', '山东省烟台市蓬莱区南山镇阳光路88号', '果园基地', '120 亩', '丰果·阳光果园坐落于蓬莱半岛靠海位置，日照充足、昼夜温差大，专注高端苹果和樱桃种植，拥有现代化智能温室大棚和自动化灌溉系统，全年提供果园直采服务。 ', 19, '丰果季农业科技有限公司', '15863123456', '山东省烟台市蓬莱区南山镇阳光路88号', 401, 50, 30, 80, 0, '2025-04-24 15:49:59', '2025-05-04 17:38:37');
INSERT INTO `origin_display` VALUES (3, '海珍浅海养殖场', '/api/upload/IMG0021976cb7605135009127-2392024460.jpg', ' 辽宁省大连市庄河市董家口渔港', '海滨生态养殖基地', '300 吨年养殖量', '海珍·深海养殖场依托渤海湾优质海域，主打鲍鱼、海参、扇贝等高端海产，所有产品均采用海上网箱深海养殖，捕捞后立即进入岸基急速降温仓库，确保“每日鲜捞、当日发货”。  ', 17, '海珍鲜坊食品有限公司  ', '13678901122', ' 辽宁省大连市庄河市董家口渔港', 28, 0, 20, 20, 0, '2025-04-24 15:51:19', '2025-05-04 17:38:31');
INSERT INTO `origin_display` VALUES (4, '鲜海屠宰加工车间	', '/api/upload/00004-1740026293.jpg', '吉林省长春市九台区乌拉街道鲜海工业园A区', '综合型鲜肉与水产加工基地', '日处理能力：800 头生猪 年加工量：25,000 吨', '鲜海·屠宰加工车间严格按照 GMP+ 和 HACCP 标准设计，拥有全封闭负压屠宰区、紫外线消毒通道和 ISO 9001 质量管理体系认证。车间配备自动分割线和高效冷链保鲜库，确保从屠宰到包装不超 4 小时，肉品从源头到餐桌全程可追溯。', 16, '鲜海润肉业有限公司', '15043216677', '吉林省长春市九台区乌拉街道鲜海工业园A区', 98, 0, 10, 99, 0, '2025-04-24 15:53:11', '2025-05-08 22:38:45');

-- ----------------------------
-- Table structure for praise
-- ----------------------------
DROP TABLE IF EXISTS `praise`;
CREATE TABLE `praise`  (
  `praise_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '点赞ID',
  `user_id` int(11) UNSIGNED NOT NULL DEFAULT 0 COMMENT '点赞人',
  `create_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间',
  `source_table` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '来源表',
  `source_field` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '来源字段',
  `source_id` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '来源ID',
  `status` tinyint(1) NOT NULL DEFAULT 1 COMMENT '点赞状态:1为点赞，0已取消',
  PRIMARY KEY (`praise_id`) USING BTREE,
  INDEX `user_id`(`user_id`) USING BTREE,
  CONSTRAINT `praise_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '点赞' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of praise
-- ----------------------------
INSERT INTO `praise` VALUES (1, 11, '2025-04-24 16:47:15', '2025-04-24 16:47:15', 'forum', 'forum_id', 6, 1);
INSERT INTO `praise` VALUES (2, 13, '2025-05-07 17:10:29', '2025-05-07 17:10:29', 'forum', 'forum_id', 8, 1);

-- ----------------------------
-- Table structure for production_planning
-- ----------------------------
DROP TABLE IF EXISTS `production_planning`;
CREATE TABLE `production_planning`  (
  `production_planning_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '生产计划ID',
  `plan_no` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '计划编号',
  `schedule_title` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '计划标题',
  `planned_date` date DEFAULT NULL COMMENT '计划日期',
  `plan_content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci COMMENT '计划内容',
  `farmers_merchants` int(11) DEFAULT 0 COMMENT '农户商家',
  `create_time` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间',
  PRIMARY KEY (`production_planning_id`) USING BTREE,
  UNIQUE INDEX `plan_no`(`plan_no`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 15 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '生产计划' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of production_planning
-- ----------------------------
INSERT INTO `production_planning` VALUES (13, 'SHR-20250424-001', '2025年4月–屠宰加工及冷链配送计划', '2025-04-24', '1. 原料猪到厂：每日接收优质草饲生猪800头，统一集中入栏检疫；\n2. 屠宰加工：利用全自动分割线日处理800头，分割出五花肉、里脊、肩胛肉等主要部位；\n3. 品质检验：每批次抽检10%，检测微生物及重金属残留；\n4. 冷链包装：标准化真空包装并转入4℃冷藏库，24小时内对接“闪送”“专线”直发；\n5. 出库配送：全天分3班次出库，覆盖东北区域200+家连锁超市与餐饮客户。', 16, '2025-04-24 16:02:42', '2025-04-24 16:02:42');
INSERT INTO `production_planning` VALUES (14, 'SL20240508-B03', '有机水果推广销售计划', '2025-05-08', '针对新上市的有机苹果和橙子，计划开展为期一个月的线上促销活动，配合线下社区推广，提升品牌知名度和销量。目标销售额达到5万元。', 19, '2025-05-07 17:02:10', '2025-05-07 17:02:10');

-- ----------------------------
-- Table structure for share_type
-- ----------------------------
DROP TABLE IF EXISTS `share_type`;
CREATE TABLE `share_type`  (
  `share_type_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '分享类型ID',
  `share_type` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '分享类型',
  `create_time` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间',
  PRIMARY KEY (`share_type_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 16 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '分享类型' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of share_type
-- ----------------------------
INSERT INTO `share_type` VALUES (13, '种植／养殖技术', '2025-04-24 15:54:57', '2025-04-24 15:54:57');
INSERT INTO `share_type` VALUES (14, '生产／加工流程', '2025-04-24 15:55:02', '2025-04-24 15:55:02');
INSERT INTO `share_type` VALUES (15, '市场营销与品牌建设', '2025-04-24 15:55:11', '2025-04-24 15:55:11');

-- ----------------------------
-- Table structure for slides
-- ----------------------------
DROP TABLE IF EXISTS `slides`;
CREATE TABLE `slides`  (
  `slides_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '轮播图ID',
  `title` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '标题',
  `content` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '内容',
  `url` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '链接',
  `img` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '轮播图',
  `hits` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '点击量',
  `create_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间',
  PRIMARY KEY (`slides_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '轮播图' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of slides
-- ----------------------------
INSERT INTO `slides` VALUES (1, '轮播图1', '内容1', '/article/details?article=2', '/api/upload/1810476149940158464.jpg', 64, '2025-03-31 15:46:36', '2025-04-24 15:56:09');
INSERT INTO `slides` VALUES (2, '轮播图2', '内容2', '/article/details?article=2', '/api/upload/1810486207352668160.jpg', 954, '2025-03-31 15:46:36', '2025-03-31 15:46:36');
INSERT INTO `slides` VALUES (3, '轮播图3', '内容3', '/article/details?article=3', '/api/upload/1810476214528245760.jpg', 399, '2025-03-31 15:46:36', '2025-03-31 15:46:36');

-- ----------------------------
-- Table structure for type_of_place_of_origin
-- ----------------------------
DROP TABLE IF EXISTS `type_of_place_of_origin`;
CREATE TABLE `type_of_place_of_origin`  (
  `type_of_place_of_origin_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '产地类型ID',
  `type_of_place_of_origin` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '产地类型',
  `create_time` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间',
  PRIMARY KEY (`type_of_place_of_origin_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 17 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '产地类型' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of type_of_place_of_origin
-- ----------------------------
INSERT INTO `type_of_place_of_origin` VALUES (13, '海滨生态养殖基地', '2025-04-22 19:27:48', '2025-04-22 19:27:48');
INSERT INTO `type_of_place_of_origin` VALUES (14, '综合型鲜肉与水产加工基地', '2025-04-22 19:29:20', '2025-04-22 19:29:20');
INSERT INTO `type_of_place_of_origin` VALUES (15, '果园基地', '2025-04-24 15:44:07', '2025-04-24 15:44:07');
INSERT INTO `type_of_place_of_origin` VALUES (16, '农作物种植基地', '2025-04-24 15:46:06', '2025-04-24 15:46:06');

-- ----------------------------
-- Table structure for upload
-- ----------------------------
DROP TABLE IF EXISTS `upload`;
CREATE TABLE `upload`  (
  `upload_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '上传ID',
  `name` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '文件名',
  `path` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '访问路径',
  `file` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '文件路径',
  `display` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '显示顺序',
  `father_id` int(11) DEFAULT 0 COMMENT '父级ID',
  `dir` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '文件夹',
  `type` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '文件类型',
  PRIMARY KEY (`upload_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '文件上传' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of upload
-- ----------------------------
INSERT INTO `upload` VALUES (1, 'movie.mp4', '/upload/movie.mp4', '', NULL, 0, NULL, 'video');

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`  (
  `user_id` int(8) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '用户ID',
  `state` smallint(1) UNSIGNED NOT NULL DEFAULT 1 COMMENT '账户状态：(1可用|2异常|3已冻结|4已注销)',
  `user_group` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '所在用户组',
  `login_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '上次登录时间',
  `phone` varchar(11) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '手机号码',
  `phone_state` smallint(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '手机认证：(0未认证|1审核中|2已认证)',
  `username` varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '用户名',
  `nickname` varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT '' COMMENT '昵称',
  `password` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '密码',
  `email` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT '' COMMENT '邮箱',
  `email_state` smallint(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '邮箱认证：(0未认证|1审核中|2已认证)',
  `avatar` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '头像地址',
  `open_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '针对获取用户信息字段',
  `create_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`user_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 20 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '用户账户' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES (1, 1, '管理员', '2025-05-09 16:06:43', NULL, 0, 'admin', 'admin', 'asd123', '', 0, '/api/upload/animal_chara_lion_king.png', NULL, '2025-03-31 17:35:13');
INSERT INTO `user` VALUES (11, 1, '消费者', '2025-04-22 19:09:41', NULL, 0, 'xiaofeizhe1', '菜篮子达人', 'asd123', '17344445555@qq.com', 0, '/api/upload/v2-3f0ae5572e6c977ed9b81ba55b8e283a_r-4246262479.jpg', NULL, '2025-04-22 19:09:41');
INSERT INTO `user` VALUES (12, 1, '消费者', '2025-04-22 19:10:20', NULL, 0, 'xiaofeizhe2', '果蔬控_520', 'asd123', 'xiaofeizhe2@qq.com', 0, '/api/upload/20220920122759_b8893-2072812204.jpg', NULL, '2025-04-22 19:10:20');
INSERT INTO `user` VALUES (13, 1, '消费者', '2025-04-22 19:11:03', NULL, 0, 'xiaofeizhe3', '绿通配送中心', 'asd123', '13788887777@qq.com', 0, '/api/upload/afc410a0b10907f69e3e33abfa9efeff-768x576-2346422950.jpg', NULL, '2025-04-22 19:11:03');
INSERT INTO `user` VALUES (14, 1, '消费者', '2025-04-22 19:12:05', NULL, 0, 'xiaofeizhe4', '田园联运', 'asd123', '122999@qq.com', 0, '/api/upload/201912131576221246055_278-2935430851.jpg', NULL, '2025-04-22 19:12:05');
INSERT INTO `user` VALUES (15, 1, '消费者', '2025-04-22 19:13:02', NULL, 0, 'xiaofeizhe5', '雪松温泉度假酒店', 'asd123', '9998888@qq.com', 0, '/api/upload/15876942720821lrorx-1836901316.jpg', NULL, '2025-04-22 19:13:02');
INSERT INTO `user` VALUES (16, 1, '农户商家', '2025-04-22 19:15:25', NULL, 0, 'shangjia1', '鲜海润肉业有限公司', 'asd123', '21321321@qq.com', 0, '/api/upload/049e-a804f66e7a454e9e4abfdecf7ba80108-2100041306.jpg', NULL, '2025-04-22 19:15:25');
INSERT INTO `user` VALUES (17, 1, '农户商家', '2025-04-22 19:19:16', NULL, 0, 'shangjia2', '海珍鲜坊食品有限公司', 'asd123', 'info@hzxfsp.com', 0, '/api/upload/Img455507537-1783873838.jpg', NULL, '2025-04-22 19:19:16');
INSERT INTO `user` VALUES (18, 1, '农户商家', '2025-04-22 19:21:17', NULL, 0, 'shanghu3', '果然甜生态农业有限公司', 'asd123', 'contact@grtny.com', 0, '/api/upload/049e-a804f66e7a454e9e4abfdecf7ba80108-2100041306.jpg', NULL, '2025-04-22 19:21:17');
INSERT INTO `user` VALUES (19, 1, '农户商家', '2025-04-22 19:22:13', NULL, 0, 'shanghu4', '丰果季农业科技有限公司', 'asd123', 'contact@fgjny.com', 0, '/api/upload/7712-01882531bfb8767c5c8b842bf44a1079-944880058.jpg', NULL, '2025-04-22 19:22:13');

-- ----------------------------
-- Table structure for user_group
-- ----------------------------
DROP TABLE IF EXISTS `user_group`;
CREATE TABLE `user_group`  (
  `group_id` mediumint(8) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '用户组ID',
  `display` smallint(4) UNSIGNED NOT NULL DEFAULT 100 COMMENT '显示顺序',
  `name` varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '名称',
  `description` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '描述',
  `source_table` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '来源表',
  `source_field` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '来源字段',
  `source_id` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '来源ID',
  `register` smallint(1) UNSIGNED DEFAULT 0 COMMENT '注册位置',
  `create_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间',
  PRIMARY KEY (`group_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '用户组' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user_group
-- ----------------------------
INSERT INTO `user_group` VALUES (1, 100, '管理员', NULL, '', '', 0, 0, '2025-03-31 15:46:36', '2025-03-31 15:46:36');
INSERT INTO `user_group` VALUES (2, 100, '游客', NULL, '', '', 0, 0, '2025-03-31 15:46:36', '2025-03-31 15:46:36');
INSERT INTO `user_group` VALUES (3, 100, '农户商家', NULL, 'farmers_merchants', 'farmers_merchants_id', 0, 1, '2025-03-31 15:46:36', '2025-03-31 15:46:36');
INSERT INTO `user_group` VALUES (4, 100, '消费者', NULL, 'consumer', 'consumer_id', 0, 3, '2025-03-31 15:46:36', '2025-03-31 15:46:36');

SET FOREIGN_KEY_CHECKS = 1;
