/*
Navicat MySQL Data Transfer

Source Server         : 券商qa
Source Server Version : 50722
Source Host           : 192.168.168.125:3306
Source Database       : cloud_broker_market

Target Server Type    : MYSQL
Target Server Version : 50722
File Encoding         : 65001

Date: 2018-07-18 10:48:09
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for admin_role
-- ----------------------------
DROP TABLE IF EXISTS `admin_role`;
CREATE TABLE `admin_role` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增主键id',
  `admin_id` int(11) unsigned NOT NULL COMMENT '用户id',
  `role_id` int(11) unsigned NOT NULL COMMENT '角色id',
  `create_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `idx_admin_id` (`admin_id`)
) ENGINE=InnoDB AUTO_INCREMENT=93 DEFAULT CHARSET=utf8mb4 COMMENT='管理用户角色关联表';

-- ----------------------------
-- Records of admin_role
-- ----------------------------
INSERT INTO `admin_role` VALUES ('1', '1', '1', '2018-04-18 11:03:33', '2018-07-18 10:32:40');

-- ----------------------------
-- Table structure for administrators
-- ----------------------------
DROP TABLE IF EXISTS `administrators`;
CREATE TABLE `administrators` (
  `admin_id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `op_name` char(32) NOT NULL COMMENT '姓名',
  `mobile` char(11) NOT NULL COMMENT '手机',
  `login_password` char(125) NOT NULL DEFAULT '' COMMENT '登陆密码',
  `locked` enum('LOCK','UNLOCK') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'UNLOCK' COMMENT '锁定状态，0-锁定，1-未锁定',
  `role` char(32) NOT NULL COMMENT '角色',
  `create_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `createip` char(15) DEFAULT '0.0.0.0' COMMENT '创建ip',
  `update_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `updateip` char(15) DEFAULT '0.0.0.0' COMMENT '更新ip',
  `create_admin_id` int(11) DEFAULT NULL COMMENT '创建此管理员的管理员id',
  PRIMARY KEY (`admin_id`),
  UNIQUE KEY `idx_mobile` (`mobile`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COMMENT='管理员用户表';

-- ----------------------------
-- Records of administrators
-- ----------------------------
INSERT INTO `administrators` VALUES ('1', '超级管理员', '18514763176', 'AE20IWHBdK6G7S2Q3PY/bXdw+50QVviIoN/6OD/DoIfHvRoZkRPuYIv1WUmXau87jAiepBR2MKEZTJxiNfjzy80=', 'UNLOCK', 'ADMIN', '2018-03-01 10:50:41', '0.0.0.0', '2018-03-01 10:50:41', '0.0.0.0', '1');

-- ----------------------------
-- Table structure for channel_coin_address_withdraw
-- ----------------------------
DROP TABLE IF EXISTS `channel_coin_address_withdraw`;
CREATE TABLE `channel_coin_address_withdraw` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `uid` int(11) NOT NULL COMMENT '用户ID',
  `asset_code` varchar(40) NOT NULL COMMENT '资产类型',
  `name` varchar(200) DEFAULT NULL COMMENT '备注名称',
  `auth_status` enum('UNAUTH','AUTHED') NOT NULL COMMENT '地址认证状态：未认证,已\n\n认证',
  `coin_address` varchar(70) NOT NULL COMMENT '外部地址',
  `create_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `create_ip` char(15) DEFAULT '0.0.0.0' COMMENT '创建ip',
  `inner_address` enum('YES','NO') DEFAULT 'NO' COMMENT '是否内部地址',
  `del_flag` enum('TRUE','FALSE') DEFAULT 'FALSE' COMMENT 'TRUE：已删除, ''FALSE''：未删除',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uid` (`uid`,`asset_code`,`coin_address`),
  KEY `idx_uid_asset_code_del_flag` (`uid`,`asset_code`,`del_flag`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='提现：用户对应的数字资产地址表';

-- ----------------------------
-- Records of channel_coin_address_withdraw
-- ----------------------------

-- ----------------------------
-- Table structure for config_asset
-- ----------------------------
DROP TABLE IF EXISTS `config_asset`;
CREATE TABLE `config_asset` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `asset_code` varchar(40) NOT NULL COMMENT '资产代码',
  `currency_type` enum('COIN','CASH') NOT NULL COMMENT '资产种类',
  `status` enum('INIT','LISTED','DELISTED') NOT NULL COMMENT '处理状态：INIT初始，LISTED上市，DELISTED退市',
  `name` varchar(64) NOT NULL COMMENT '资产名称',
  `supply_amount` decimal(35,20) unsigned NOT NULL COMMENT '当前的供应量',
  `total_amount` decimal(35,20) unsigned NOT NULL COMMENT '总的供应量',
  `min_precision` int(11) NOT NULL COMMENT '最小精度',
  `description` varchar(256) NOT NULL COMMENT '描述',
  `web_url` varchar(256) NOT NULL COMMENT '官方url',
  `create_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_asset_code` (`asset_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='资产基本信息表';

-- ----------------------------
-- Records of config_asset
-- ----------------------------

-- ----------------------------
-- Table structure for config_asset_profile
-- ----------------------------
DROP TABLE IF EXISTS `config_asset_profile`;
CREATE TABLE `config_asset_profile` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `asset_code` varchar(40) NOT NULL COMMENT '资产代码',
  `profile_key` varchar(64) NOT NULL COMMENT '配置关键字',
  `profile_value` varchar(10240) NOT NULL COMMENT '配置数值',
  `create_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `update_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_asset_code_profile_key` (`asset_code`,`profile_key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='资产配置参数:url,消息队列';

-- ----------------------------
-- Records of config_asset_profile
-- ----------------------------

-- ----------------------------
-- Table structure for config_email
-- ----------------------------
DROP TABLE IF EXISTS `config_email`;
CREATE TABLE `config_email` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `mail_username` varchar(45) NOT NULL COMMENT '邮箱登陆用户名',
  `mail_password` varchar(45) NOT NULL COMMENT '邮箱登陆密码',
  `mail_host` varchar(64) NOT NULL,
  `mail_subject` varchar(64) NOT NULL,
  `send_count` int(11) NOT NULL,
  `status` enum('LISTED','DELISTED') NOT NULL COMMENT '状态',
  `create_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `username_UNIQUE` (`mail_username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='给用户发送邮件的邮箱配置表';

-- ----------------------------
-- Records of config_email
-- ----------------------------

-- ----------------------------
-- Table structure for config_symbol
-- ----------------------------
DROP TABLE IF EXISTS `config_symbol`;
CREATE TABLE `config_symbol` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `symbol` varchar(32) NOT NULL COMMENT '交易对',
  `trade_asset` varchar(40) NOT NULL DEFAULT '' COMMENT '交易币种',
  `price_asset` varchar(40) NOT NULL DEFAULT '' COMMENT '计价币种',
  `status` enum('INIT','LISTED','DELISTED') NOT NULL COMMENT '处理状态：INIT初始，LISTED上市，DELISTED退市',
  `title` varchar(64) NOT NULL COMMENT '交易对标题',
  `name` varchar(64) NOT NULL COMMENT '交易对名称',
  `description` varchar(256) DEFAULT NULL COMMENT '描述',
  `min_precision1` int(11) NOT NULL COMMENT '资产1的最小精度',
  `min_precision2` int(11) NOT NULL COMMENT '资产2的最小精度',
  `min_amount1` decimal(35,20) unsigned NOT NULL COMMENT '资产1的最小数量',
  `min_amount2` decimal(35,20) unsigned NOT NULL COMMENT '资产2的最小数量',
  `max_amount1` decimal(35,20) unsigned NOT NULL COMMENT '资产1的最大数量',
  `max_amount2` decimal(35,20) unsigned NOT NULL COMMENT '资产2的最大数量',
  `create_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_symbol` (`symbol`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='交易对';

-- ----------------------------
-- Records of config_symbol
-- ----------------------------

-- ----------------------------
-- Table structure for config_symbol_profile
-- ----------------------------
DROP TABLE IF EXISTS `config_symbol_profile`;
CREATE TABLE `config_symbol_profile` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `symbol` varchar(32) NOT NULL COMMENT '交易对',
  `profile_key` varchar(64) NOT NULL COMMENT '配置关键字',
  `profile_value` varchar(10240) NOT NULL COMMENT '配置数值',
  `create_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `update_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_symbol_profile_key_profile_index` (`symbol`,`profile_key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='交易对配置参数:url,消息队列';

-- ----------------------------
-- Records of config_symbol_profile
-- ----------------------------

-- ----------------------------
-- Table structure for email_log
-- ----------------------------
DROP TABLE IF EXISTS `email_log`;
CREATE TABLE `email_log` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `msg_id` varchar(32) NOT NULL COMMENT '短信id',
  `service_code` enum('MARKET','NOTICE','REPORT_DAILY','VERIFY_CODE') DEFAULT NULL,
  `service_provider` varchar(32) NOT NULL COMMENT '邮件服务提供商',
  `sys_code` enum('GP_MARKET','QUICKDAX','GP_BAO') DEFAULT NULL,
  `email` char(128) NOT NULL COMMENT '邮箱地址',
  `msg_content` text,
  `create_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='邮件发送日志';

-- ----------------------------
-- Records of email_log
-- ----------------------------

-- ----------------------------
-- Table structure for manager_google_code_config
-- ----------------------------
DROP TABLE IF EXISTS `manager_google_code_config`;
CREATE TABLE `manager_google_code_config` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `admin_id` int(11) NOT NULL COMMENT '管理员id',
  `secret_code` varchar(32) NOT NULL COMMENT '谷歌秘钥',
  `del_flag` enum('TRUE','FALSE') NOT NULL COMMENT '删除标识',
  `create_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `idx_admin_id` (`admin_id`),
  KEY `idx_del_flag` (`del_flag`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='管理员谷歌验证码配置表';

-- ----------------------------
-- Records of manager_google_code_config
-- ----------------------------

-- ----------------------------
-- Table structure for manager_oper_log
-- ----------------------------
DROP TABLE IF EXISTS `manager_oper_log`;
CREATE TABLE `manager_oper_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `admin_id` int(11) NOT NULL COMMENT '管理员id',
  `ip_address` varchar(32) NOT NULL COMMENT 'ip地址',
  `ip_country` varchar(45) NOT NULL COMMENT 'ip国家所在地',
  `ip_city` varchar(45) NOT NULL COMMENT 'ip城市所在地',
  `oper_type` varchar(32) NOT NULL COMMENT '类型',
  `remark` varchar(45) DEFAULT '' COMMENT '其他备注',
  `create_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `idx_admin_id` (`admin_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='管理员操作日志表';

-- ----------------------------
-- Records of manager_oper_log
-- ----------------------------

-- ----------------------------
-- Table structure for manager_password_oper_record
-- ----------------------------
DROP TABLE IF EXISTS `manager_password_oper_record`;
CREATE TABLE `manager_password_oper_record` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `admin_id` int(11) NOT NULL COMMENT '管理员ID',
  `modify_flag` enum('TRUE','FALSE') NOT NULL COMMENT '是否修改密码',
  `create_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `admin_id_UNIQUE` (`admin_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='管理员密码操作记录表';

-- ----------------------------
-- Records of manager_password_oper_record
-- ----------------------------

-- ----------------------------
-- Table structure for menu
-- ----------------------------
DROP TABLE IF EXISTS `menu`;
CREATE TABLE `menu` (
  `menu_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增主键id',
  `menu_name` varchar(64) NOT NULL COMMENT '菜单名称',
  `menu_module` varchar(45) NOT NULL COMMENT '菜单module名',
  `parent_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '父级菜单',
  `level` int(11) unsigned NOT NULL COMMENT '级别',
  `uri` varchar(60) DEFAULT '' COMMENT '接口uri',
  `show` varchar(10) NOT NULL COMMENT '是否显示',
  `i18n` varchar(50) DEFAULT '' COMMENT '多语言',
  PRIMARY KEY (`menu_id`),
  KEY `level_Index` (`level`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=103333331 DEFAULT CHARSET=utf8mb4 COMMENT='菜单表';

-- ----------------------------
-- Records of menu
-- ----------------------------
INSERT INTO `menu` VALUES ('100', '系统权限', 'system', '0', '0', '', 'true', 'common.system');
INSERT INTO `menu` VALUES ('101', '用户管理', 'adminUser', '100', '1', '', 'true', 'common.userManagement');
INSERT INTO `menu` VALUES ('102', '添加用户', 'adminAdd', '100', '1', '', 'true', 'common.addNewUser');
INSERT INTO `menu` VALUES ('103', '登录详情', 'adminLoginLog', '100', '1', '', 'false', '');
INSERT INTO `menu` VALUES ('104', '角色管理', 'roleList', '100', '1', '', 'true', 'common.todo7');
INSERT INTO `menu` VALUES ('105', '添加角色', 'roleAdd', '100', '1', '', 'true', 'common.todo8');
INSERT INTO `menu` VALUES ('106', '人员查看', 'rolePeople', '100', '1', '', 'false', '');
INSERT INTO `menu` VALUES ('107', '权限管理', 'rolePerm', '100', '1', '', 'false', '');
INSERT INTO `menu` VALUES ('200', '控制面板', 'controlPan', '0', '0', '', 'true', 'common.controlPanel');
INSERT INTO `menu` VALUES ('201', '密码管理', 'setPwd', '200', '1', '', 'true', 'common.passwordManagement');
INSERT INTO `menu` VALUES ('202', '谷歌验证', 'google', '200', '1', '', 'true', 'common.googleVerfication');
INSERT INTO `menu` VALUES ('203', '登录信息', 'loginInfo', '200', '1', '', 'true', 'common.todo6');
INSERT INTO `menu` VALUES ('300', '用户管理', 'commonusers', '0', '0', '', 'true', 'common.userManagement');
INSERT INTO `menu` VALUES ('301', '用户信息', 'commonUserInfo', '300', '1', '', 'true', 'common.userInformation');
INSERT INTO `menu` VALUES ('302', '用户详情', 'commonDetail', '300', '1', '', 'false', '');
INSERT INTO `menu` VALUES ('303', 'kyc审核', 'commonUserKyc', '300', '1', '', 'true', 'common.kycApproval');
INSERT INTO `menu` VALUES ('400', '资产管理', 'asset', '0', '0', '', 'true', 'common.assetManagement');
INSERT INTO `menu` VALUES ('401', '充值记录', 'assetDeposit', '400', '1', '', 'true', 'common.depositRecords');
INSERT INTO `menu` VALUES ('402', '提现记录', 'assetWithdraw', '400', '1', '', 'true', 'common.withdrawalRecords');
INSERT INTO `menu` VALUES ('403', '提现审核', 'assetCheck', '400', '1', '', 'true', 'common.withdrawalVerification');
INSERT INTO `menu` VALUES ('1700', '交易管理', 'trade', '0', '0', '', 'true', 'common.todo1');
INSERT INTO `menu` VALUES ('1701', '交易记录', 'tradeRecord', '1700', '1', '', 'true', 'finance.trade');
INSERT INTO `menu` VALUES ('1800', '网站维护', 'setting', '0', '0', '', 'true', 'common.websiteMaintenance');
INSERT INTO `menu` VALUES ('1801', '币种列表', 'coinConfig', '1800', '1', '', 'true', 'settingCoinconfig.coinList');
INSERT INTO `menu` VALUES ('1802', '增加新币', 'addCoin', '1800', '1', '', 'true', 'settingCoinadd.addNewCoin');
INSERT INTO `menu` VALUES ('1803', '交易配置', 'symbolConfig', '1800', '1', '', 'true', 'settingSymbolconfig.tradingConfiguration');
INSERT INTO `menu` VALUES ('1804', '增加交易', 'addSymbol', '1800', '1', '', 'true', 'settingSymboladd.addTradingPair');
INSERT INTO `menu` VALUES ('1805', '免手续费白名单', 'whiteList', '1800', '1', '', 'true', 'settingSymbolwhitelist.noCommisionFee');
INSERT INTO `menu` VALUES ('1900', '结算管理', 'settlement', '0', '0', '', 'true', 'settlement.name');
INSERT INTO `menu` VALUES ('1901', '结算信息管理', 'settlementConfig', '1900', '1', '', 'true', 'settlement.settlementConfig');
INSERT INTO `menu` VALUES ('1902', '结算记录查询', 'settlementRecord', '1900', '1', '', 'true', 'settlement.settlementRecord');
INSERT INTO `menu` VALUES ('1903', '转出记录查询', 'settlementOutRecord', '1900', '1', '', 'true', 'settlement.settlementOutRecord');
INSERT INTO `menu` VALUES ('1904', '申请转出', 'applyWithdraw', '1900', '1', '', 'true', 'settlement.settlementWithdrawApply');

-- ----------------------------
-- Table structure for menu_interface
-- ----------------------------
DROP TABLE IF EXISTS `menu_interface`;
CREATE TABLE `menu_interface` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增主键id',
  `menu_id` int(11) NOT NULL COMMENT '菜单id',
  `interface_name` varchar(32) NOT NULL COMMENT '接口名',
  `uri` varchar(128) DEFAULT '' COMMENT '接口uri',
  PRIMARY KEY (`id`),
  KEY `menu_Index` (`menu_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=58 DEFAULT CHARSET=utf8mb4 COMMENT='菜单接口对应表';

-- ----------------------------
-- Records of menu_interface
-- ----------------------------
INSERT INTO `menu_interface` VALUES ('1', '101', '查询管理员列表', '/exchange_manager/admin/list');
INSERT INTO `menu_interface` VALUES ('2', '101', '重置密码', '/exchange_manager/admin/reset-login-password');
INSERT INTO `menu_interface` VALUES ('3', '101', '重置谷歌验证器', '/exchange_manager/manager/googlecode-reset');
INSERT INTO `menu_interface` VALUES ('4', '101', '锁定管理员', '/exchange_manager/admin/lock');
INSERT INTO `menu_interface` VALUES ('5', '101', '解锁管理员', '/exchange_manager/admin/unlock');
INSERT INTO `menu_interface` VALUES ('6', '103', '查询登录信息', '/exchange_manager/admin/loginlog-info');
INSERT INTO `menu_interface` VALUES ('7', '102', '创建管理员用户', '/exchange_manager/admin/new');
INSERT INTO `menu_interface` VALUES ('8', '104', '角色列表', '/exchange_manager/roleManager/role-list');
INSERT INTO `menu_interface` VALUES ('9', '104', '删除角色', '/exchange_manager/roleManager/delete_role');
INSERT INTO `menu_interface` VALUES ('10', '106', '人员角色列表', '/exchange_manager/roleManager/admin-role-list');
INSERT INTO `menu_interface` VALUES ('11', '107', '人员菜单列表', '/exchange_manager/roleManager/menu-role-list');
INSERT INTO `menu_interface` VALUES ('12', '107', '更新人员菜单列表', '/exchange_manager/roleManager/update-role-menu');
INSERT INTO `menu_interface` VALUES ('13', '105', '添加角色', '/exchange_manager/roleManager/add-role');
INSERT INTO `menu_interface` VALUES ('14', '201', '修改用户登录密码', '/exchange_manager/admin/login-password');
INSERT INTO `menu_interface` VALUES ('15', '202', '管理员开启谷歌验证码并保存信息', '/exchange_manager/manager/googlecode-firstcheck');
INSERT INTO `menu_interface` VALUES ('16', '202', '获取谷歌验证二维码及相关信息', '/exchange_manager/manager/googlecode-get');
INSERT INTO `menu_interface` VALUES ('17', '203', '登录信息', '/exchange_manager/admin/loginlog-info');
INSERT INTO `menu_interface` VALUES ('18', '301', '获取用户信息列表', '/exchange_manager/security/overseas/user-list');
INSERT INTO `menu_interface` VALUES ('19', '302', '获取用户详情', '/exchange_manager/security/overseas/user-detail');
INSERT INTO `menu_interface` VALUES ('20', '302', '查询用户资产列表', '/exchange_manager/asset/getUserAccounts');
INSERT INTO `menu_interface` VALUES ('21', '302', '重置谷歌验证器', '/exchange_manager/user/user_googlecode-reset');
INSERT INTO `menu_interface` VALUES ('22', '303', '获取身份认证信息列表', '/exchange_manager/security/overseas/identities');
INSERT INTO `menu_interface` VALUES ('23', '303', '获取居住认证信息列表', '/exchange_manager/security/overseas/residences');
INSERT INTO `menu_interface` VALUES ('24', '303', '身份审核验证', '/exchange_manager/security/overseas/identity-audit');
INSERT INTO `menu_interface` VALUES ('25', '303', '高级身份审核验证', '/exchange_manager/security/overseas/residence-audit');
INSERT INTO `menu_interface` VALUES ('26', '401', '充值记录查询', '/exchange_manager/deposit/coin/transfer');
INSERT INTO `menu_interface` VALUES ('27', '402', '提现记录查询', '/exchange_manager/withdraw/coin/processed-query');
INSERT INTO `menu_interface` VALUES ('28', '403', '提现未处理记录查询', '/exchange_manager/withdraw/coin/untreated');
INSERT INTO `menu_interface` VALUES ('29', '403', '后台管理员待审信息统计提醒', '/exchange_manager/user/unverified');
INSERT INTO `menu_interface` VALUES ('30', '403', '提现审核', '/exchange_manager/withdraw/coin/confirm');
INSERT INTO `menu_interface` VALUES ('31', '1701', '交易结果查询', '/exchange_manager/match/orders-query');
INSERT INTO `menu_interface` VALUES ('32', '1801', '已有币种列表查询', '/exchange_manager/managerAssetAndSymbol/configasset-list');
INSERT INTO `menu_interface` VALUES ('33', '1801', '查询资产配置参数列表', '/exchange_manager/managerAssetAndSymbol/configassetprofile-list');
INSERT INTO `menu_interface` VALUES ('34', '1801', '转账配置查询', '/exchange_manager/withdraw-config/config-list');
INSERT INTO `menu_interface` VALUES ('35', '1801', '更改已有币种配置', '/exchange_manager/managerAssetAndSymbol/configassetprofile-edit');
INSERT INTO `menu_interface` VALUES ('36', '1801', '添加新币种或更新币种状态', '/exchange_manager/managerAssetAndSymbol/configasset-edit');
INSERT INTO `menu_interface` VALUES ('37', '1802', '添加新币种或更新币种状态', '/exchange_manager/managerAssetAndSymbol/configasset-edit');
INSERT INTO `menu_interface` VALUES ('38', '1802', '查询云端已配置币种', '/exchange_manager/managerAssetAndSymbol/assets');
INSERT INTO `menu_interface` VALUES ('39', '1803', '已有交易对列表查询', '/exchange_manager/managerAssetAndSymbol/configsymbol-list');
INSERT INTO `menu_interface` VALUES ('40', '1803', '已有交易对配置查询', '/exchange_manager/managerAssetAndSymbol/configsymbolprofile-list');
INSERT INTO `menu_interface` VALUES ('41', '1803', '更改交易对配置', '/exchange_manager/managerAssetAndSymbol/configsymbolprofile-edit');
INSERT INTO `menu_interface` VALUES ('42', '1803', '添加新交易对或更新交易对状态', '/exchange_manager/managerAssetAndSymbol/configsymbol-update');
INSERT INTO `menu_interface` VALUES ('43', '1803', '更新交易对收费', '/exchange_manager/transaction-config/config-update');
INSERT INTO `menu_interface` VALUES ('44', '1803', '查询交易对费率列表', '/exchange_manager/transaction-config/config-list');
INSERT INTO `menu_interface` VALUES ('45', '1804', '添加新交易对或更新交易对状态', '/exchange_manager/managerAssetAndSymbol/configsymbol-create');
INSERT INTO `menu_interface` VALUES ('46', '1805', '查询白名单用户', '/exchange_manager/whiteListconfig/query');
INSERT INTO `menu_interface` VALUES ('47', '1805', '新增白名单用户', '/exchange_manager/whiteListconfig/add');
INSERT INTO `menu_interface` VALUES ('48', '1805', '删除白名单用户', '/exchange_manager/whiteListconfig/delete');
INSERT INTO `menu_interface` VALUES ('49', '1901', '查询结算信息', '/exchange_manager/settle/info-list');
INSERT INTO `menu_interface` VALUES ('50', '1902', '查询结算记录', '/exchange_manager/settle/record-list');
INSERT INTO `menu_interface` VALUES ('51', '1903', '查询结算记录', '/exchange_manager/settle/withdraw-record-list');
INSERT INTO `menu_interface` VALUES ('52', '1904', '查询提现限制', '/exchange_manager/settle/withdraw-limit');
INSERT INTO `menu_interface` VALUES ('53', '1904', '查询提现地址', '/exchange_manager/settle/withdraw-address');
INSERT INTO `menu_interface` VALUES ('54', '1904', '添加结算地址', '/exchange_manager/settle/withdraw-address/add');
INSERT INTO `menu_interface` VALUES ('55', '1904', '修改结算地址', '/exchange_manager/settle/withdraw-address/update');
INSERT INTO `menu_interface` VALUES ('56', '1904', '申请转出', '/exchange_manager/settle/withdraw-broker');
INSERT INTO `menu_interface` VALUES ('57', '101', '查询管理员登录信息', '/exchange_manager/admin/operlog-query');

-- ----------------------------
-- Table structure for menu_role
-- ----------------------------
DROP TABLE IF EXISTS `menu_role`;
CREATE TABLE `menu_role` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `menu_id` int(11) NOT NULL COMMENT '关联menu表id',
  `role_id` int(11) NOT NULL COMMENT '关联role表id',
  `status` tinyint(2) NOT NULL COMMENT '0 不可用 1 可用',
  `create_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `menu_id_Index` (`menu_id`) USING BTREE,
  KEY `role_id_Index` (`role_id`) USING BTREE,
  KEY `status_Index` (`status`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COMMENT='菜单_角色表';

-- ----------------------------
-- Records of menu_role
-- ----------------------------
INSERT INTO `menu_role` VALUES ('1', '100', '1', '1', '2018-07-05 21:19:54', '2018-07-18 10:44:43');
INSERT INTO `menu_role` VALUES ('2', '101', '1', '1', '2018-07-05 21:19:54', '2018-07-18 10:44:44');
INSERT INTO `menu_role` VALUES ('3', '102', '1', '1', '2018-07-05 21:19:55', '2018-07-18 10:44:45');
INSERT INTO `menu_role` VALUES ('4', '103', '1', '1', '2018-07-05 21:19:55', '2018-07-18 10:44:46');
INSERT INTO `menu_role` VALUES ('5', '104', '1', '1', '2018-07-05 21:19:55', '2018-07-18 10:44:48');
INSERT INTO `menu_role` VALUES ('6', '105', '1', '1', '2018-07-05 21:19:55', '2018-07-18 10:44:49');
INSERT INTO `menu_role` VALUES ('7', '106', '1', '1', '2018-07-05 21:19:55', '2018-07-18 10:44:50');
INSERT INTO `menu_role` VALUES ('8', '107', '1', '1', '2018-07-05 21:19:56', '2018-07-18 10:44:53');
INSERT INTO `menu_role` VALUES ('9', '200', '1', '1', '2018-07-05 21:19:56', '2018-07-18 10:44:54');
INSERT INTO `menu_role` VALUES ('10', '201', '1', '1', '2018-07-05 21:19:56', '2018-07-18 10:44:58');
INSERT INTO `menu_role` VALUES ('11', '202', '1', '1', '2018-07-05 21:19:56', '2018-07-18 10:45:00');
INSERT INTO `menu_role` VALUES ('12', '203', '1', '1', '2018-07-05 21:19:56', '2018-07-18 10:45:02');

-- ----------------------------
-- Table structure for public_notice
-- ----------------------------
DROP TABLE IF EXISTS `public_notice`;
CREATE TABLE `public_notice` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `uid` int(11) unsigned NOT NULL COMMENT '发布者id',
  `nickname` varchar(128) DEFAULT NULL COMMENT '发布者名称',
  `top_status` enum('YES','NO') DEFAULT 'NO' COMMENT '是否置顶',
  `top_time` time(6) NOT NULL DEFAULT '00:00:00.000000' COMMENT '最后置顶时间，每次置顶操作更新这个时间',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `title` varchar(128) DEFAULT NULL COMMENT '公告标题',
  `content` varchar(10240) DEFAULT NULL COMMENT '公告内容',
  `status` enum('VALID','INVALID') DEFAULT 'VALID',
  PRIMARY KEY (`id`),
  KEY `idx_create_time` (`create_time`,`status`,`top_status`,`top_time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='test';

-- ----------------------------
-- Records of public_notice
-- ----------------------------

-- ----------------------------
-- Table structure for role
-- ----------------------------
DROP TABLE IF EXISTS `role`;
CREATE TABLE `role` (
  `role_id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增主键id',
  `role_name` varchar(32) NOT NULL COMMENT '角色名称',
  `instruction` varchar(64) DEFAULT NULL COMMENT '描述',
  `role_status` tinyint(4) NOT NULL DEFAULT '1' COMMENT '角色状态, 1启用, 0禁用',
  `create_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`role_id`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4 COMMENT='管理员用户角色';

-- ----------------------------
-- Records of role
-- ----------------------------
INSERT INTO `role` VALUES ('1', '超级管理员', '超管', '1', '2018-04-16 11:30:06', '2018-04-16 11:30:11');

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `uid` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `invite_uid` int(11) unsigned DEFAULT '0' COMMENT '邀请人',
  `broker_id` int(11) unsigned NOT NULL COMMENT '用户所属券商id',
  `nickname` varchar(64) DEFAULT NULL COMMENT '昵称',
  `mobile` varchar(16) DEFAULT NULL COMMENT '手机',
  `email` varchar(64) DEFAULT NULL COMMENT '邮箱',
  `login_salt` varchar(100) NOT NULL COMMENT '登录盐码',
  `login_password` varchar(200) NOT NULL COMMENT '密码',
  `pay_salt` varchar(100) NOT NULL DEFAULT '' COMMENT '支付盐码',
  `pay_password` varchar(200) NOT NULL DEFAULT '' COMMENT '交易密码',
  `lock_num` tinyint(4) NOT NULL DEFAULT '0' COMMENT '锁定次数',
  `role` enum('user','admin','admin_read') DEFAULT 'user' COMMENT '角色',
  `fullname` varchar(128) NOT NULL DEFAULT '' COMMENT '姓名',
  `create_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `createip` char(15) DEFAULT '0.0.0.0' COMMENT '创建ip',
  `update_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `updateip` char(15) DEFAULT '0.0.0.0' COMMENT '更新ip',
  `auth_level` varchar(16) NOT NULL DEFAULT 'LEVEL0' COMMENT '实名认证级别：LEVEL0没有认证，LEVEL1基础认证',
  PRIMARY KEY (`uid`),
  UNIQUE KEY `idx_email` (`email`),
  UNIQUE KEY `idx_mobile` (`mobile`),
  KEY `idx_invite_uid` (`invite_uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='用户';

-- ----------------------------
-- Records of user
-- ----------------------------

-- ----------------------------
-- Table structure for user_api_key
-- ----------------------------
DROP TABLE IF EXISTS `user_api_key`;
CREATE TABLE `user_api_key` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `uid` int(11) unsigned NOT NULL COMMENT '用户id',
  `broker_id` int(11) unsigned DEFAULT NULL COMMENT '用户所属券商id',
  `user_no` varchar(32) NOT NULL DEFAULT '0' COMMENT '券商编号',
  `name` char(60) NOT NULL COMMENT '名称',
  `auth_type` enum('PASSPHRASE','ACCESS_KEY') DEFAULT NULL COMMENT '认证方式',
  `passphrase` varchar(256) DEFAULT NULL COMMENT '口令',
  `access_key` varchar(32) DEFAULT NULL COMMENT '访问密匙',
  `secret_key` varchar(32) DEFAULT NULL COMMENT '私钥',
  `level` enum('limited','readonly','full') NOT NULL DEFAULT 'full' COMMENT '级别',
  `ip_allow` char(255) NOT NULL DEFAULT '' COMMENT '允许的ip地址：支持ip段等方式',
  `del_flag` enum('TRUE','FALSE') DEFAULT 'FALSE' COMMENT 'TRUE：已删除, ''FALSE''：未删除',
  `create_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_access_key` (`access_key`),
  UNIQUE KEY `idx_secret_key` (`secret_key`),
  UNIQUE KEY `idx_passphrase` (`passphrase`(64)),
  KEY `idx_broker_id` (`broker_id`),
  KEY `idx_uid` (`uid`),
  KEY `idx_user_no` (`user_no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='券商访问key：API访问秘钥，给商户分配key';

-- ----------------------------
-- Records of user_api_key
-- ----------------------------

-- ----------------------------
-- Table structure for user_basic_info
-- ----------------------------
DROP TABLE IF EXISTS `user_basic_info`;
CREATE TABLE `user_basic_info` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `first_name` varchar(128) NOT NULL DEFAULT '',
  `middle_name` varchar(128) NOT NULL DEFAULT '',
  `last_name` varchar(128) NOT NULL DEFAULT '',
  `gender` enum('MALE','FEMALE') NOT NULL DEFAULT 'MALE',
  `birthday` varchar(30) NOT NULL DEFAULT '',
  `country_id` varchar(11) NOT NULL DEFAULT '',
  `country` varchar(128) NOT NULL DEFAULT '',
  `uid` int(11) NOT NULL,
  `create_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `update_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uid_key` (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of user_basic_info
-- ----------------------------

-- ----------------------------
-- Table structure for user_google_code_config
-- ----------------------------
DROP TABLE IF EXISTS `user_google_code_config`;
CREATE TABLE `user_google_code_config` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `uid` int(11) unsigned NOT NULL,
  `flag` varchar(32) NOT NULL,
  `secret_code` varchar(32) NOT NULL,
  `create_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `update_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `reset_date` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uid` (`uid`),
  KEY `idx_uid` (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of user_google_code_config
-- ----------------------------

-- ----------------------------
-- Table structure for user_identification
-- ----------------------------
DROP TABLE IF EXISTS `user_identification`;
CREATE TABLE `user_identification` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `uid` int(11) unsigned NOT NULL COMMENT '用户id',
  `country_id` varchar(32) NOT NULL COMMENT '证件国家编号',
  `country` varchar(128) NOT NULL COMMENT '证件国家',
  `card_type` varchar(32) NOT NULL COMMENT '证件类型',
  `card_no` varchar(32) NOT NULL COMMENT '证件编号',
  `expired_date` datetime NOT NULL COMMENT '有效期至',
  `card_photo` varchar(512) NOT NULL COMMENT '证件照片，照片的md5，从mongodb中获取，用json数组支持多张照片？',
  `card_handhold` varchar(512) NOT NULL COMMENT '手持证件照，照片的md5，从mongodb中获取，用json数组支持多张照片？',
  `card_translate` varchar(512) NOT NULL COMMENT '证件翻译照片，照片的md5，从mongodb中获取，用json数组支持多张照片？',
  `status` enum('INIT','FINISH') NOT NULL COMMENT '处理状态：INIT初始，FINISH完成',
  `audit_uid` int(11) NOT NULL DEFAULT '0' COMMENT '审核人员',
  `audit_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '审核时间',
  `audit_status` enum('INIT','OK','FAIL') NOT NULL COMMENT '审核状态：INIT初始, OK通过，FAIL没有通过',
  `audit_first` enum('YES','NO') NOT NULL COMMENT '是否首次认证',
  `audit_message_id` varchar(32) NOT NULL DEFAULT '' COMMENT '消息id',
  `audit_message` varchar(256) NOT NULL DEFAULT '' COMMENT '审核消息',
  `create_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `card_back` varchar(512) DEFAULT '',
  `full_name` varchar(128) NOT NULL COMMENT '用户全名',
  PRIMARY KEY (`id`),
  KEY `idx_uid` (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='用户身份认证';

-- ----------------------------
-- Records of user_identification
-- ----------------------------

-- ----------------------------
-- Table structure for user_info
-- ----------------------------
DROP TABLE IF EXISTS `user_info`;
CREATE TABLE `user_info` (
  `uid` int(11) unsigned NOT NULL COMMENT '用户id',
  `user_no` varchar(32) DEFAULT NULL COMMENT '用户编号',
  `name` char(32) NOT NULL DEFAULT '' COMMENT '姓名',
  `id_number` char(30) NOT NULL DEFAULT '' COMMENT '证件号码',
  `id_type` tinyint(1) unsigned DEFAULT '0' COMMENT '证件类型',
  `id_auth_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '认证时间',
  `id_authip` char(15) DEFAULT '0.0.0.0' COMMENT '认证ip',
  `mobile_bind_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '手机绑定时间',
  PRIMARY KEY (`uid`),
  UNIQUE KEY `idx_user_no` (`user_no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='用户基本信息';

-- ----------------------------
-- Records of user_info
-- ----------------------------

-- ----------------------------
-- Table structure for user_info_profile
-- ----------------------------
DROP TABLE IF EXISTS `user_info_profile`;
CREATE TABLE `user_info_profile` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `uid` int(11) unsigned NOT NULL COMMENT '用户id',
  `profile_group` varchar(32) NOT NULL COMMENT '配置组',
  `profile_key` varchar(64) NOT NULL COMMENT '配置关键字',
  `profile_index` varchar(32) NOT NULL COMMENT '配置序号',
  `data_type` varchar(32) NOT NULL COMMENT '数据类型',
  `profile_value` varchar(10240) NOT NULL COMMENT '配置数值',
  `create_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `update_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_uid_profile_key_profile_index` (`uid`,`profile_key`,`profile_index`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='用户配置信息表';

-- ----------------------------
-- Records of user_info_profile
-- ----------------------------

-- ----------------------------
-- Table structure for user_login_log
-- ----------------------------
DROP TABLE IF EXISTS `user_login_log`;
CREATE TABLE `user_login_log` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `uid` int(11) unsigned NOT NULL COMMENT '用户id',
  `ip_address` varchar(32) NOT NULL COMMENT '用户登录ip地址',
  `create_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  `ip_country` varchar(45) NOT NULL DEFAULT '',
  `ip_city` varchar(45) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `idx_create_date` (`create_date`) USING BTREE,
  KEY `idx_ip_address` (`ip_address`),
  KEY `idx_uid_create` (`uid`,`create_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of user_login_log
-- ----------------------------

-- ----------------------------
-- Table structure for user_message
-- ----------------------------
DROP TABLE IF EXISTS `user_message`;
CREATE TABLE `user_message` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `uid` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '用户id',
  `category` enum('SECURITY','ASSETS','SYSTEM','C2C') DEFAULT NULL COMMENT 'SECURITY:安全信息，ASSETS:资产信息，SYSTEM：系统消息',
  `content` text COMMENT '消息内容',
  `create_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `status` enum('UNREAD','READ') DEFAULT NULL COMMENT 'UNREAD:未读，READ:已读',
  PRIMARY KEY (`id`),
  KEY `category` (`category`),
  KEY `status` (`status`),
  KEY `uid` (`uid`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='站内信：给用户推送的各种消息';

-- ----------------------------
-- Records of user_message
-- ----------------------------

-- ----------------------------
-- Table structure for user_pay_password
-- ----------------------------
DROP TABLE IF EXISTS `user_pay_password`;
CREATE TABLE `user_pay_password` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增id',
  `uid` int(11) NOT NULL COMMENT '用户id',
  `lock_num` int(11) NOT NULL COMMENT '锁定次数',
  `create_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_uid` (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='支付密码上锁表：支付密码上锁表（支付密码错误次数记录，以及限制）';

-- ----------------------------
-- Records of user_pay_password
-- ----------------------------

-- ----------------------------
-- Table structure for user_pre_registration_pool
-- ----------------------------
DROP TABLE IF EXISTS `user_pre_registration_pool`;
CREATE TABLE `user_pre_registration_pool` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `invite_uid` int(11) unsigned DEFAULT '0' COMMENT '邀请人',
  `broker_id` int(11) unsigned NOT NULL COMMENT '用户所属券商id',
  `nickname` varchar(64) DEFAULT NULL COMMENT '昵称',
  `mobile` varchar(16) DEFAULT NULL COMMENT '手机',
  `email` varchar(64) DEFAULT NULL COMMENT '邮箱',
  `login_salt` varchar(100) NOT NULL COMMENT '登录盐码',
  `login_password` varchar(200) NOT NULL COMMENT '密码',
  `pay_salt` varchar(100) NOT NULL DEFAULT '' COMMENT '支付盐码',
  `pay_password` varchar(200) NOT NULL DEFAULT '' COMMENT '交易密码',
  `lock_num` tinyint(4) NOT NULL DEFAULT '0' COMMENT '锁定次数',
  `role` enum('user','admin','admin_read') DEFAULT 'user' COMMENT '角色',
  `fullname` varchar(128) NOT NULL DEFAULT '' COMMENT '姓名',
  `create_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='用户';

-- ----------------------------
-- Records of user_pre_registration_pool
-- ----------------------------

-- ----------------------------
-- Table structure for user_residence
-- ----------------------------
DROP TABLE IF EXISTS `user_residence`;
CREATE TABLE `user_residence` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `uid` int(11) unsigned NOT NULL COMMENT '用户id',
  `country_id` varchar(32) NOT NULL COMMENT '证件国家编号',
  `country` varchar(128) NOT NULL COMMENT '证件国家',
  `city` varchar(128) NOT NULL COMMENT '居住城市',
  `address` varchar(256) NOT NULL COMMENT '居住详细地址',
  `postcode` varchar(32) NOT NULL COMMENT '邮编',
  `residence_photo` varchar(512) NOT NULL COMMENT '居住证明照片，照片的md5，从mongodb中获取，用json数组支持多张照片？',
  `residence_translate` varchar(512) NOT NULL COMMENT '居住证明翻译照片，照片的md5，从mongodb中获取，用json数组支持多张照片？',
  `status` enum('INIT','FINISH') NOT NULL COMMENT '处理状态：INIT初始，FINISH完成',
  `audit_uid` int(11) NOT NULL DEFAULT '0' COMMENT '审核人员',
  `audit_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '审核时间',
  `audit_status` enum('INIT','OK','FAIL') NOT NULL COMMENT '审核状态：INIT初始, OK通过，FAIL没有通过',
  `audit_first` enum('YES','NO') NOT NULL COMMENT '是否首次认证',
  `audit_message_id` varchar(32) NOT NULL DEFAULT '' COMMENT '消息id',
  `audit_message` varchar(256) NOT NULL DEFAULT '' COMMENT '审核消息',
  `create_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `full_name` varchar(128) NOT NULL COMMENT '用户全称',
  `paper_type` tinyint(4) unsigned zerofill NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_uid` (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='用户居住认证';

-- ----------------------------
-- Records of user_residence
-- ----------------------------

-- ----------------------------
-- Table structure for user_transaction_fee_white_list
-- ----------------------------
DROP TABLE IF EXISTS `user_transaction_fee_white_list`;
CREATE TABLE `user_transaction_fee_white_list` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `uid` int(11) NOT NULL,
  `create_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `update_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `admin_id` int(11) DEFAULT NULL,
  `flag` enum('VALID','INVALID') DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uid` (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of user_transaction_fee_white_list
-- ----------------------------

-- ----------------------------
-- Table structure for user_upload_resource_log
-- ----------------------------
DROP TABLE IF EXISTS `user_upload_resource_log`;
CREATE TABLE `user_upload_resource_log` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `uid` int(11) unsigned NOT NULL COMMENT '用户id',
  `tag` varchar(40) NOT NULL COMMENT '图片hashcode',
  `dataType` varchar(64) NOT NULL COMMENT 'tag类型',
  `soucre` varchar(64) DEFAULT NULL COMMENT '下载来源',
  `storeType` varchar(64) DEFAULT NULL COMMENT '存储类型',
  `createTime` datetime(6) DEFAULT NULL COMMENT '创建时间',
  `updateTime` datetime(6) DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `tag` (`tag`,`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='用户配置信息表';

-- ----------------------------
-- Records of user_upload_resource_log
-- ----------------------------

-- ----------------------------
-- Table structure for withdraw_address
-- ----------------------------
DROP TABLE IF EXISTS `withdraw_address`;
CREATE TABLE `withdraw_address` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `asset_code` varchar(40) NOT NULL DEFAULT '' COMMENT '币种',
  `coin_address` varchar(70) NOT NULL DEFAULT '' COMMENT '券商提现地址',
  `create_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of withdraw_address
-- ----------------------------
/*
Navicat MySQL Data Transfer

Source Server         : 券商qa
Source Server Version : 50722
Source Host           : 192.168.168.125:3306
Source Database       : cloud_broker_market

Target Server Type    : MYSQL
Target Server Version : 50722
File Encoding         : 65001

Date: 2018-07-18 10:48:09
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for admin_role
-- ----------------------------
DROP TABLE IF EXISTS `admin_role`;
CREATE TABLE `admin_role` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增主键id',
  `admin_id` int(11) unsigned NOT NULL COMMENT '用户id',
  `role_id` int(11) unsigned NOT NULL COMMENT '角色id',
  `create_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `idx_admin_id` (`admin_id`)
) ENGINE=InnoDB AUTO_INCREMENT=93 DEFAULT CHARSET=utf8mb4 COMMENT='管理用户角色关联表';

-- ----------------------------
-- Records of admin_role
-- ----------------------------
INSERT INTO `admin_role` VALUES ('1', '1', '1', '2018-04-18 11:03:33', '2018-07-18 10:32:40');

-- ----------------------------
-- Table structure for administrators
-- ----------------------------
DROP TABLE IF EXISTS `administrators`;
CREATE TABLE `administrators` (
  `admin_id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `op_name` char(32) NOT NULL COMMENT '姓名',
  `mobile` char(11) NOT NULL COMMENT '手机',
  `login_password` char(125) NOT NULL DEFAULT '' COMMENT '登陆密码',
  `locked` enum('LOCK','UNLOCK') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'UNLOCK' COMMENT '锁定状态，0-锁定，1-未锁定',
  `role` char(32) NOT NULL COMMENT '角色',
  `create_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `createip` char(15) DEFAULT '0.0.0.0' COMMENT '创建ip',
  `update_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `updateip` char(15) DEFAULT '0.0.0.0' COMMENT '更新ip',
  `create_admin_id` int(11) DEFAULT NULL COMMENT '创建此管理员的管理员id',
  PRIMARY KEY (`admin_id`),
  UNIQUE KEY `idx_mobile` (`mobile`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COMMENT='管理员用户表';

-- ----------------------------
-- Records of administrators
-- ----------------------------
INSERT INTO `administrators` VALUES ('1', '超级管理员', '18514763176', 'AE20IWHBdK6G7S2Q3PY/bXdw+50QVviIoN/6OD/DoIfHvRoZkRPuYIv1WUmXau87jAiepBR2MKEZTJxiNfjzy80=', 'UNLOCK', 'ADMIN', '2018-03-01 10:50:41', '0.0.0.0', '2018-03-01 10:50:41', '0.0.0.0', '1');

-- ----------------------------
-- Table structure for channel_coin_address_withdraw
-- ----------------------------
DROP TABLE IF EXISTS `channel_coin_address_withdraw`;
CREATE TABLE `channel_coin_address_withdraw` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `uid` int(11) NOT NULL COMMENT '用户ID',
  `asset_code` varchar(40) NOT NULL COMMENT '资产类型',
  `name` varchar(200) DEFAULT NULL COMMENT '备注名称',
  `auth_status` enum('UNAUTH','AUTHED') NOT NULL COMMENT '地址认证状态：未认证,已\n\n认证',
  `coin_address` varchar(70) NOT NULL COMMENT '外部地址',
  `create_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `create_ip` char(15) DEFAULT '0.0.0.0' COMMENT '创建ip',
  `inner_address` enum('YES','NO') DEFAULT 'NO' COMMENT '是否内部地址',
  `del_flag` enum('TRUE','FALSE') DEFAULT 'FALSE' COMMENT 'TRUE：已删除, ''FALSE''：未删除',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uid` (`uid`,`asset_code`,`coin_address`),
  KEY `idx_uid_asset_code_del_flag` (`uid`,`asset_code`,`del_flag`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='提现：用户对应的数字资产地址表';

-- ----------------------------
-- Records of channel_coin_address_withdraw
-- ----------------------------

-- ----------------------------
-- Table structure for config_asset
-- ----------------------------
DROP TABLE IF EXISTS `config_asset`;
CREATE TABLE `config_asset` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `asset_code` varchar(40) NOT NULL COMMENT '资产代码',
  `currency_type` enum('COIN','CASH') NOT NULL COMMENT '资产种类',
  `status` enum('INIT','LISTED','DELISTED') NOT NULL COMMENT '处理状态：INIT初始，LISTED上市，DELISTED退市',
  `name` varchar(64) NOT NULL COMMENT '资产名称',
  `supply_amount` decimal(35,20) unsigned NOT NULL COMMENT '当前的供应量',
  `total_amount` decimal(35,20) unsigned NOT NULL COMMENT '总的供应量',
  `min_precision` int(11) NOT NULL COMMENT '最小精度',
  `description` varchar(256) NOT NULL COMMENT '描述',
  `web_url` varchar(256) NOT NULL COMMENT '官方url',
  `create_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_asset_code` (`asset_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='资产基本信息表';

-- ----------------------------
-- Records of config_asset
-- ----------------------------

-- ----------------------------
-- Table structure for config_asset_profile
-- ----------------------------
DROP TABLE IF EXISTS `config_asset_profile`;
CREATE TABLE `config_asset_profile` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `asset_code` varchar(40) NOT NULL COMMENT '资产代码',
  `profile_key` varchar(64) NOT NULL COMMENT '配置关键字',
  `profile_value` varchar(10240) NOT NULL COMMENT '配置数值',
  `create_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `update_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_asset_code_profile_key` (`asset_code`,`profile_key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='资产配置参数:url,消息队列';

-- ----------------------------
-- Records of config_asset_profile
-- ----------------------------

-- ----------------------------
-- Table structure for config_email
-- ----------------------------
DROP TABLE IF EXISTS `config_email`;
CREATE TABLE `config_email` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `mail_username` varchar(45) NOT NULL COMMENT '邮箱登陆用户名',
  `mail_password` varchar(45) NOT NULL COMMENT '邮箱登陆密码',
  `mail_host` varchar(64) NOT NULL,
  `mail_subject` varchar(64) NOT NULL,
  `send_count` int(11) NOT NULL,
  `status` enum('LISTED','DELISTED') NOT NULL COMMENT '状态',
  `create_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `username_UNIQUE` (`mail_username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='给用户发送邮件的邮箱配置表';

-- ----------------------------
-- Records of config_email
-- ----------------------------

-- ----------------------------
-- Table structure for config_symbol
-- ----------------------------
DROP TABLE IF EXISTS `config_symbol`;
CREATE TABLE `config_symbol` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `symbol` varchar(32) NOT NULL COMMENT '交易对',
  `trade_asset` varchar(40) NOT NULL DEFAULT '' COMMENT '交易币种',
  `price_asset` varchar(40) NOT NULL DEFAULT '' COMMENT '计价币种',
  `status` enum('INIT','LISTED','DELISTED') NOT NULL COMMENT '处理状态：INIT初始，LISTED上市，DELISTED退市',
  `title` varchar(64) NOT NULL COMMENT '交易对标题',
  `name` varchar(64) NOT NULL COMMENT '交易对名称',
  `description` varchar(256) DEFAULT NULL COMMENT '描述',
  `min_precision1` int(11) NOT NULL COMMENT '资产1的最小精度',
  `min_precision2` int(11) NOT NULL COMMENT '资产2的最小精度',
  `min_amount1` decimal(35,20) unsigned NOT NULL COMMENT '资产1的最小数量',
  `min_amount2` decimal(35,20) unsigned NOT NULL COMMENT '资产2的最小数量',
  `max_amount1` decimal(35,20) unsigned NOT NULL COMMENT '资产1的最大数量',
  `max_amount2` decimal(35,20) unsigned NOT NULL COMMENT '资产2的最大数量',
  `create_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_symbol` (`symbol`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='交易对';

-- ----------------------------
-- Records of config_symbol
-- ----------------------------

-- ----------------------------
-- Table structure for config_symbol_profile
-- ----------------------------
DROP TABLE IF EXISTS `config_symbol_profile`;
CREATE TABLE `config_symbol_profile` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `symbol` varchar(32) NOT NULL COMMENT '交易对',
  `profile_key` varchar(64) NOT NULL COMMENT '配置关键字',
  `profile_value` varchar(10240) NOT NULL COMMENT '配置数值',
  `create_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `update_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_symbol_profile_key_profile_index` (`symbol`,`profile_key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='交易对配置参数:url,消息队列';

-- ----------------------------
-- Records of config_symbol_profile
-- ----------------------------

-- ----------------------------
-- Table structure for email_log
-- ----------------------------
DROP TABLE IF EXISTS `email_log`;
CREATE TABLE `email_log` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `msg_id` varchar(32) NOT NULL COMMENT '短信id',
  `service_code` enum('MARKET','NOTICE','REPORT_DAILY','VERIFY_CODE') DEFAULT NULL,
  `service_provider` varchar(32) NOT NULL COMMENT '邮件服务提供商',
  `sys_code` enum('GP_MARKET','QUICKDAX','GP_BAO') DEFAULT NULL,
  `email` char(128) NOT NULL COMMENT '邮箱地址',
  `msg_content` text,
  `create_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='邮件发送日志';

-- ----------------------------
-- Records of email_log
-- ----------------------------

-- ----------------------------
-- Table structure for manager_google_code_config
-- ----------------------------
DROP TABLE IF EXISTS `manager_google_code_config`;
CREATE TABLE `manager_google_code_config` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `admin_id` int(11) NOT NULL COMMENT '管理员id',
  `secret_code` varchar(32) NOT NULL COMMENT '谷歌秘钥',
  `del_flag` enum('TRUE','FALSE') NOT NULL COMMENT '删除标识',
  `create_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `idx_admin_id` (`admin_id`),
  KEY `idx_del_flag` (`del_flag`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='管理员谷歌验证码配置表';

-- ----------------------------
-- Records of manager_google_code_config
-- ----------------------------

-- ----------------------------
-- Table structure for manager_oper_log
-- ----------------------------
DROP TABLE IF EXISTS `manager_oper_log`;
CREATE TABLE `manager_oper_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `admin_id` int(11) NOT NULL COMMENT '管理员id',
  `ip_address` varchar(32) NOT NULL COMMENT 'ip地址',
  `ip_country` varchar(45) NOT NULL COMMENT 'ip国家所在地',
  `ip_city` varchar(45) NOT NULL COMMENT 'ip城市所在地',
  `oper_type` varchar(32) NOT NULL COMMENT '类型',
  `remark` varchar(45) DEFAULT '' COMMENT '其他备注',
  `create_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `idx_admin_id` (`admin_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='管理员操作日志表';

-- ----------------------------
-- Records of manager_oper_log
-- ----------------------------

-- ----------------------------
-- Table structure for manager_password_oper_record
-- ----------------------------
DROP TABLE IF EXISTS `manager_password_oper_record`;
CREATE TABLE `manager_password_oper_record` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `admin_id` int(11) NOT NULL COMMENT '管理员ID',
  `modify_flag` enum('TRUE','FALSE') NOT NULL COMMENT '是否修改密码',
  `create_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `admin_id_UNIQUE` (`admin_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='管理员密码操作记录表';

-- ----------------------------
-- Records of manager_password_oper_record
-- ----------------------------

-- ----------------------------
-- Table structure for menu
-- ----------------------------
DROP TABLE IF EXISTS `menu`;
CREATE TABLE `menu` (
  `menu_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增主键id',
  `menu_name` varchar(64) NOT NULL COMMENT '菜单名称',
  `menu_module` varchar(45) NOT NULL COMMENT '菜单module名',
  `parent_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '父级菜单',
  `level` int(11) unsigned NOT NULL COMMENT '级别',
  `uri` varchar(60) DEFAULT '' COMMENT '接口uri',
  `show` varchar(10) NOT NULL COMMENT '是否显示',
  `i18n` varchar(50) DEFAULT '' COMMENT '多语言',
  PRIMARY KEY (`menu_id`),
  KEY `level_Index` (`level`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=103333331 DEFAULT CHARSET=utf8mb4 COMMENT='菜单表';

-- ----------------------------
-- Records of menu
-- ----------------------------
INSERT INTO `menu` VALUES ('100', '系统权限', 'system', '0', '0', '', 'true', 'common.system');
INSERT INTO `menu` VALUES ('101', '用户管理', 'adminUser', '100', '1', '', 'true', 'common.userManagement');
INSERT INTO `menu` VALUES ('102', '添加用户', 'adminAdd', '100', '1', '', 'true', 'common.addNewUser');
INSERT INTO `menu` VALUES ('103', '登录详情', 'adminLoginLog', '100', '1', '', 'false', '');
INSERT INTO `menu` VALUES ('104', '角色管理', 'roleList', '100', '1', '', 'true', 'common.todo7');
INSERT INTO `menu` VALUES ('105', '添加角色', 'roleAdd', '100', '1', '', 'true', 'common.todo8');
INSERT INTO `menu` VALUES ('106', '人员查看', 'rolePeople', '100', '1', '', 'false', '');
INSERT INTO `menu` VALUES ('107', '权限管理', 'rolePerm', '100', '1', '', 'false', '');
INSERT INTO `menu` VALUES ('200', '控制面板', 'controlPan', '0', '0', '', 'true', 'common.controlPanel');
INSERT INTO `menu` VALUES ('201', '密码管理', 'setPwd', '200', '1', '', 'true', 'common.passwordManagement');
INSERT INTO `menu` VALUES ('202', '谷歌验证', 'google', '200', '1', '', 'true', 'common.googleVerfication');
INSERT INTO `menu` VALUES ('203', '登录信息', 'loginInfo', '200', '1', '', 'true', 'common.todo6');
INSERT INTO `menu` VALUES ('300', '用户管理', 'commonusers', '0', '0', '', 'true', 'common.userManagement');
INSERT INTO `menu` VALUES ('301', '用户信息', 'commonUserInfo', '300', '1', '', 'true', 'common.userInformation');
INSERT INTO `menu` VALUES ('302', '用户详情', 'commonDetail', '300', '1', '', 'false', '');
INSERT INTO `menu` VALUES ('303', 'kyc审核', 'commonUserKyc', '300', '1', '', 'true', 'common.kycApproval');
INSERT INTO `menu` VALUES ('400', '资产管理', 'asset', '0', '0', '', 'true', 'common.assetManagement');
INSERT INTO `menu` VALUES ('401', '充值记录', 'assetDeposit', '400', '1', '', 'true', 'common.depositRecords');
INSERT INTO `menu` VALUES ('402', '提现记录', 'assetWithdraw', '400', '1', '', 'true', 'common.withdrawalRecords');
INSERT INTO `menu` VALUES ('403', '提现审核', 'assetCheck', '400', '1', '', 'true', 'common.withdrawalVerification');
INSERT INTO `menu` VALUES ('1700', '交易管理', 'trade', '0', '0', '', 'true', 'common.todo1');
INSERT INTO `menu` VALUES ('1701', '交易记录', 'tradeRecord', '1700', '1', '', 'true', 'finance.trade');
INSERT INTO `menu` VALUES ('1800', '网站维护', 'setting', '0', '0', '', 'true', 'common.websiteMaintenance');
INSERT INTO `menu` VALUES ('1801', '币种列表', 'coinConfig', '1800', '1', '', 'true', 'settingCoinconfig.coinList');
INSERT INTO `menu` VALUES ('1802', '增加新币', 'addCoin', '1800', '1', '', 'true', 'settingCoinadd.addNewCoin');
INSERT INTO `menu` VALUES ('1803', '交易配置', 'symbolConfig', '1800', '1', '', 'true', 'settingSymbolconfig.tradingConfiguration');
INSERT INTO `menu` VALUES ('1804', '增加交易', 'addSymbol', '1800', '1', '', 'true', 'settingSymboladd.addTradingPair');
INSERT INTO `menu` VALUES ('1805', '免手续费白名单', 'whiteList', '1800', '1', '', 'true', 'settingSymbolwhitelist.noCommisionFee');
INSERT INTO `menu` VALUES ('1900', '结算管理', 'settlement', '0', '0', '', 'true', 'settlement.name');
INSERT INTO `menu` VALUES ('1901', '结算信息管理', 'settlementConfig', '1900', '1', '', 'true', 'settlement.settlementConfig');
INSERT INTO `menu` VALUES ('1902', '结算记录查询', 'settlementRecord', '1900', '1', '', 'true', 'settlement.settlementRecord');
INSERT INTO `menu` VALUES ('1903', '转出记录查询', 'settlementOutRecord', '1900', '1', '', 'true', 'settlement.settlementOutRecord');
INSERT INTO `menu` VALUES ('1904', '申请转出', 'applyWithdraw', '1900', '1', '', 'true', 'settlement.settlementWithdrawApply');

-- ----------------------------
-- Table structure for menu_interface
-- ----------------------------
DROP TABLE IF EXISTS `menu_interface`;
CREATE TABLE `menu_interface` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增主键id',
  `menu_id` int(11) NOT NULL COMMENT '菜单id',
  `interface_name` varchar(32) NOT NULL COMMENT '接口名',
  `uri` varchar(128) DEFAULT '' COMMENT '接口uri',
  PRIMARY KEY (`id`),
  KEY `menu_Index` (`menu_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=58 DEFAULT CHARSET=utf8mb4 COMMENT='菜单接口对应表';

-- ----------------------------
-- Records of menu_interface
-- ----------------------------
INSERT INTO `menu_interface` VALUES ('1', '101', '查询管理员列表', '/exchange_manager/admin/list');
INSERT INTO `menu_interface` VALUES ('2', '101', '重置密码', '/exchange_manager/admin/reset-login-password');
INSERT INTO `menu_interface` VALUES ('3', '101', '重置谷歌验证器', '/exchange_manager/manager/googlecode-reset');
INSERT INTO `menu_interface` VALUES ('4', '101', '锁定管理员', '/exchange_manager/admin/lock');
INSERT INTO `menu_interface` VALUES ('5', '101', '解锁管理员', '/exchange_manager/admin/unlock');
INSERT INTO `menu_interface` VALUES ('6', '103', '查询登录信息', '/exchange_manager/admin/loginlog-info');
INSERT INTO `menu_interface` VALUES ('7', '102', '创建管理员用户', '/exchange_manager/admin/new');
INSERT INTO `menu_interface` VALUES ('8', '104', '角色列表', '/exchange_manager/roleManager/role-list');
INSERT INTO `menu_interface` VALUES ('9', '104', '删除角色', '/exchange_manager/roleManager/delete_role');
INSERT INTO `menu_interface` VALUES ('10', '106', '人员角色列表', '/exchange_manager/roleManager/admin-role-list');
INSERT INTO `menu_interface` VALUES ('11', '107', '人员菜单列表', '/exchange_manager/roleManager/menu-role-list');
INSERT INTO `menu_interface` VALUES ('12', '107', '更新人员菜单列表', '/exchange_manager/roleManager/update-role-menu');
INSERT INTO `menu_interface` VALUES ('13', '105', '添加角色', '/exchange_manager/roleManager/add-role');
INSERT INTO `menu_interface` VALUES ('14', '201', '修改用户登录密码', '/exchange_manager/admin/login-password');
INSERT INTO `menu_interface` VALUES ('15', '202', '管理员开启谷歌验证码并保存信息', '/exchange_manager/manager/googlecode-firstcheck');
INSERT INTO `menu_interface` VALUES ('16', '202', '获取谷歌验证二维码及相关信息', '/exchange_manager/manager/googlecode-get');
INSERT INTO `menu_interface` VALUES ('17', '203', '登录信息', '/exchange_manager/admin/loginlog-info');
INSERT INTO `menu_interface` VALUES ('18', '301', '获取用户信息列表', '/exchange_manager/security/overseas/user-list');
INSERT INTO `menu_interface` VALUES ('19', '302', '获取用户详情', '/exchange_manager/security/overseas/user-detail');
INSERT INTO `menu_interface` VALUES ('20', '302', '查询用户资产列表', '/exchange_manager/asset/getUserAccounts');
INSERT INTO `menu_interface` VALUES ('21', '302', '重置谷歌验证器', '/exchange_manager/user/user_googlecode-reset');
INSERT INTO `menu_interface` VALUES ('22', '303', '获取身份认证信息列表', '/exchange_manager/security/overseas/identities');
INSERT INTO `menu_interface` VALUES ('23', '303', '获取居住认证信息列表', '/exchange_manager/security/overseas/residences');
INSERT INTO `menu_interface` VALUES ('24', '303', '身份审核验证', '/exchange_manager/security/overseas/identity-audit');
INSERT INTO `menu_interface` VALUES ('25', '303', '高级身份审核验证', '/exchange_manager/security/overseas/residence-audit');
INSERT INTO `menu_interface` VALUES ('26', '401', '充值记录查询', '/exchange_manager/deposit/coin/transfer');
INSERT INTO `menu_interface` VALUES ('27', '402', '提现记录查询', '/exchange_manager/withdraw/coin/processed-query');
INSERT INTO `menu_interface` VALUES ('28', '403', '提现未处理记录查询', '/exchange_manager/withdraw/coin/untreated');
INSERT INTO `menu_interface` VALUES ('29', '403', '后台管理员待审信息统计提醒', '/exchange_manager/user/unverified');
INSERT INTO `menu_interface` VALUES ('30', '403', '提现审核', '/exchange_manager/withdraw/coin/confirm');
INSERT INTO `menu_interface` VALUES ('31', '1701', '交易结果查询', '/exchange_manager/match/orders-query');
INSERT INTO `menu_interface` VALUES ('32', '1801', '已有币种列表查询', '/exchange_manager/managerAssetAndSymbol/configasset-list');
INSERT INTO `menu_interface` VALUES ('33', '1801', '查询资产配置参数列表', '/exchange_manager/managerAssetAndSymbol/configassetprofile-list');
INSERT INTO `menu_interface` VALUES ('34', '1801', '转账配置查询', '/exchange_manager/withdraw-config/config-list');
INSERT INTO `menu_interface` VALUES ('35', '1801', '更改已有币种配置', '/exchange_manager/managerAssetAndSymbol/configassetprofile-edit');
INSERT INTO `menu_interface` VALUES ('36', '1801', '添加新币种或更新币种状态', '/exchange_manager/managerAssetAndSymbol/configasset-edit');
INSERT INTO `menu_interface` VALUES ('37', '1802', '添加新币种或更新币种状态', '/exchange_manager/managerAssetAndSymbol/configasset-edit');
INSERT INTO `menu_interface` VALUES ('38', '1802', '查询云端已配置币种', '/exchange_manager/managerAssetAndSymbol/assets');
INSERT INTO `menu_interface` VALUES ('39', '1803', '已有交易对列表查询', '/exchange_manager/managerAssetAndSymbol/configsymbol-list');
INSERT INTO `menu_interface` VALUES ('40', '1803', '已有交易对配置查询', '/exchange_manager/managerAssetAndSymbol/configsymbolprofile-list');
INSERT INTO `menu_interface` VALUES ('41', '1803', '更改交易对配置', '/exchange_manager/managerAssetAndSymbol/configsymbolprofile-edit');
INSERT INTO `menu_interface` VALUES ('42', '1803', '添加新交易对或更新交易对状态', '/exchange_manager/managerAssetAndSymbol/configsymbol-update');
INSERT INTO `menu_interface` VALUES ('43', '1803', '更新交易对收费', '/exchange_manager/transaction-config/config-update');
INSERT INTO `menu_interface` VALUES ('44', '1803', '查询交易对费率列表', '/exchange_manager/transaction-config/config-list');
INSERT INTO `menu_interface` VALUES ('45', '1804', '添加新交易对或更新交易对状态', '/exchange_manager/managerAssetAndSymbol/configsymbol-create');
INSERT INTO `menu_interface` VALUES ('46', '1805', '查询白名单用户', '/exchange_manager/whiteListconfig/query');
INSERT INTO `menu_interface` VALUES ('47', '1805', '新增白名单用户', '/exchange_manager/whiteListconfig/add');
INSERT INTO `menu_interface` VALUES ('48', '1805', '删除白名单用户', '/exchange_manager/whiteListconfig/delete');
INSERT INTO `menu_interface` VALUES ('49', '1901', '查询结算信息', '/exchange_manager/settle/info-list');
INSERT INTO `menu_interface` VALUES ('50', '1902', '查询结算记录', '/exchange_manager/settle/record-list');
INSERT INTO `menu_interface` VALUES ('51', '1903', '查询结算记录', '/exchange_manager/settle/withdraw-record-list');
INSERT INTO `menu_interface` VALUES ('52', '1904', '查询提现限制', '/exchange_manager/settle/withdraw-limit');
INSERT INTO `menu_interface` VALUES ('53', '1904', '查询提现地址', '/exchange_manager/settle/withdraw-address');
INSERT INTO `menu_interface` VALUES ('54', '1904', '添加结算地址', '/exchange_manager/settle/withdraw-address/add');
INSERT INTO `menu_interface` VALUES ('55', '1904', '修改结算地址', '/exchange_manager/settle/withdraw-address/update');
INSERT INTO `menu_interface` VALUES ('56', '1904', '申请转出', '/exchange_manager/settle/withdraw-broker');
INSERT INTO `menu_interface` VALUES ('57', '101', '查询管理员登录信息', '/exchange_manager/admin/operlog-query');

-- ----------------------------
-- Table structure for menu_role
-- ----------------------------
DROP TABLE IF EXISTS `menu_role`;
CREATE TABLE `menu_role` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `menu_id` int(11) NOT NULL COMMENT '关联menu表id',
  `role_id` int(11) NOT NULL COMMENT '关联role表id',
  `status` tinyint(2) NOT NULL COMMENT '0 不可用 1 可用',
  `create_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `menu_id_Index` (`menu_id`) USING BTREE,
  KEY `role_id_Index` (`role_id`) USING BTREE,
  KEY `status_Index` (`status`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COMMENT='菜单_角色表';

-- ----------------------------
-- Records of menu_role
-- ----------------------------
INSERT INTO `menu_role` VALUES ('1', '100', '1', '1', '2018-07-05 21:19:54', '2018-07-18 10:44:43');
INSERT INTO `menu_role` VALUES ('2', '101', '1', '1', '2018-07-05 21:19:54', '2018-07-18 10:44:44');
INSERT INTO `menu_role` VALUES ('3', '102', '1', '1', '2018-07-05 21:19:55', '2018-07-18 10:44:45');
INSERT INTO `menu_role` VALUES ('4', '103', '1', '1', '2018-07-05 21:19:55', '2018-07-18 10:44:46');
INSERT INTO `menu_role` VALUES ('5', '104', '1', '1', '2018-07-05 21:19:55', '2018-07-18 10:44:48');
INSERT INTO `menu_role` VALUES ('6', '105', '1', '1', '2018-07-05 21:19:55', '2018-07-18 10:44:49');
INSERT INTO `menu_role` VALUES ('7', '106', '1', '1', '2018-07-05 21:19:55', '2018-07-18 10:44:50');
INSERT INTO `menu_role` VALUES ('8', '107', '1', '1', '2018-07-05 21:19:56', '2018-07-18 10:44:53');
INSERT INTO `menu_role` VALUES ('9', '200', '1', '1', '2018-07-05 21:19:56', '2018-07-18 10:44:54');
INSERT INTO `menu_role` VALUES ('10', '201', '1', '1', '2018-07-05 21:19:56', '2018-07-18 10:44:58');
INSERT INTO `menu_role` VALUES ('11', '202', '1', '1', '2018-07-05 21:19:56', '2018-07-18 10:45:00');
INSERT INTO `menu_role` VALUES ('12', '203', '1', '1', '2018-07-05 21:19:56', '2018-07-18 10:45:02');

-- ----------------------------
-- Table structure for public_notice
-- ----------------------------
DROP TABLE IF EXISTS `public_notice`;
CREATE TABLE `public_notice` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `uid` int(11) unsigned NOT NULL COMMENT '发布者id',
  `nickname` varchar(128) DEFAULT NULL COMMENT '发布者名称',
  `top_status` enum('YES','NO') DEFAULT 'NO' COMMENT '是否置顶',
  `top_time` time(6) NOT NULL DEFAULT '00:00:00.000000' COMMENT '最后置顶时间，每次置顶操作更新这个时间',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `title` varchar(128) DEFAULT NULL COMMENT '公告标题',
  `content` varchar(10240) DEFAULT NULL COMMENT '公告内容',
  `status` enum('VALID','INVALID') DEFAULT 'VALID',
  PRIMARY KEY (`id`),
  KEY `idx_create_time` (`create_time`,`status`,`top_status`,`top_time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='test';

-- ----------------------------
-- Records of public_notice
-- ----------------------------

-- ----------------------------
-- Table structure for role
-- ----------------------------
DROP TABLE IF EXISTS `role`;
CREATE TABLE `role` (
  `role_id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增主键id',
  `role_name` varchar(32) NOT NULL COMMENT '角色名称',
  `instruction` varchar(64) DEFAULT NULL COMMENT '描述',
  `role_status` tinyint(4) NOT NULL DEFAULT '1' COMMENT '角色状态, 1启用, 0禁用',
  `create_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`role_id`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4 COMMENT='管理员用户角色';

-- ----------------------------
-- Records of role
-- ----------------------------
INSERT INTO `role` VALUES ('1', '超级管理员', '超管', '1', '2018-04-16 11:30:06', '2018-04-16 11:30:11');

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `uid` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `invite_uid` int(11) unsigned DEFAULT '0' COMMENT '邀请人',
  `broker_id` int(11) unsigned NOT NULL COMMENT '用户所属券商id',
  `nickname` varchar(64) DEFAULT NULL COMMENT '昵称',
  `mobile` varchar(16) DEFAULT NULL COMMENT '手机',
  `email` varchar(64) DEFAULT NULL COMMENT '邮箱',
  `login_salt` varchar(100) NOT NULL COMMENT '登录盐码',
  `login_password` varchar(200) NOT NULL COMMENT '密码',
  `pay_salt` varchar(100) NOT NULL DEFAULT '' COMMENT '支付盐码',
  `pay_password` varchar(200) NOT NULL DEFAULT '' COMMENT '交易密码',
  `lock_num` tinyint(4) NOT NULL DEFAULT '0' COMMENT '锁定次数',
  `role` enum('user','admin','admin_read') DEFAULT 'user' COMMENT '角色',
  `fullname` varchar(128) NOT NULL DEFAULT '' COMMENT '姓名',
  `create_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `createip` char(15) DEFAULT '0.0.0.0' COMMENT '创建ip',
  `update_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `updateip` char(15) DEFAULT '0.0.0.0' COMMENT '更新ip',
  `auth_level` varchar(16) NOT NULL DEFAULT 'LEVEL0' COMMENT '实名认证级别：LEVEL0没有认证，LEVEL1基础认证',
  PRIMARY KEY (`uid`),
  UNIQUE KEY `idx_email` (`email`),
  UNIQUE KEY `idx_mobile` (`mobile`),
  KEY `idx_invite_uid` (`invite_uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='用户';

-- ----------------------------
-- Records of user
-- ----------------------------

-- ----------------------------
-- Table structure for user_api_key
-- ----------------------------
DROP TABLE IF EXISTS `user_api_key`;
CREATE TABLE `user_api_key` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `uid` int(11) unsigned NOT NULL COMMENT '用户id',
  `broker_id` int(11) unsigned DEFAULT NULL COMMENT '用户所属券商id',
  `user_no` varchar(32) NOT NULL DEFAULT '0' COMMENT '券商编号',
  `name` char(60) NOT NULL COMMENT '名称',
  `auth_type` enum('PASSPHRASE','ACCESS_KEY') DEFAULT NULL COMMENT '认证方式',
  `passphrase` varchar(256) DEFAULT NULL COMMENT '口令',
  `access_key` varchar(32) DEFAULT NULL COMMENT '访问密匙',
  `secret_key` varchar(32) DEFAULT NULL COMMENT '私钥',
  `level` enum('limited','readonly','full') NOT NULL DEFAULT 'full' COMMENT '级别',
  `ip_allow` char(255) NOT NULL DEFAULT '' COMMENT '允许的ip地址：支持ip段等方式',
  `del_flag` enum('TRUE','FALSE') DEFAULT 'FALSE' COMMENT 'TRUE：已删除, ''FALSE''：未删除',
  `create_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_access_key` (`access_key`),
  UNIQUE KEY `idx_secret_key` (`secret_key`),
  UNIQUE KEY `idx_passphrase` (`passphrase`(64)),
  KEY `idx_broker_id` (`broker_id`),
  KEY `idx_uid` (`uid`),
  KEY `idx_user_no` (`user_no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='券商访问key：API访问秘钥，给商户分配key';

-- ----------------------------
-- Records of user_api_key
-- ----------------------------

-- ----------------------------
-- Table structure for user_basic_info
-- ----------------------------
DROP TABLE IF EXISTS `user_basic_info`;
CREATE TABLE `user_basic_info` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `first_name` varchar(128) NOT NULL DEFAULT '',
  `middle_name` varchar(128) NOT NULL DEFAULT '',
  `last_name` varchar(128) NOT NULL DEFAULT '',
  `gender` enum('MALE','FEMALE') NOT NULL DEFAULT 'MALE',
  `birthday` varchar(30) NOT NULL DEFAULT '',
  `country_id` varchar(11) NOT NULL DEFAULT '',
  `country` varchar(128) NOT NULL DEFAULT '',
  `uid` int(11) NOT NULL,
  `create_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `update_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uid_key` (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of user_basic_info
-- ----------------------------

-- ----------------------------
-- Table structure for user_google_code_config
-- ----------------------------
DROP TABLE IF EXISTS `user_google_code_config`;
CREATE TABLE `user_google_code_config` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `uid` int(11) unsigned NOT NULL,
  `flag` varchar(32) NOT NULL,
  `secret_code` varchar(32) NOT NULL,
  `create_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `update_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `reset_date` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uid` (`uid`),
  KEY `idx_uid` (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of user_google_code_config
-- ----------------------------

-- ----------------------------
-- Table structure for user_identification
-- ----------------------------
DROP TABLE IF EXISTS `user_identification`;
CREATE TABLE `user_identification` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `uid` int(11) unsigned NOT NULL COMMENT '用户id',
  `country_id` varchar(32) NOT NULL COMMENT '证件国家编号',
  `country` varchar(128) NOT NULL COMMENT '证件国家',
  `card_type` varchar(32) NOT NULL COMMENT '证件类型',
  `card_no` varchar(32) NOT NULL COMMENT '证件编号',
  `expired_date` datetime NOT NULL COMMENT '有效期至',
  `card_photo` varchar(512) NOT NULL COMMENT '证件照片，照片的md5，从mongodb中获取，用json数组支持多张照片？',
  `card_handhold` varchar(512) NOT NULL COMMENT '手持证件照，照片的md5，从mongodb中获取，用json数组支持多张照片？',
  `card_translate` varchar(512) NOT NULL COMMENT '证件翻译照片，照片的md5，从mongodb中获取，用json数组支持多张照片？',
  `status` enum('INIT','FINISH') NOT NULL COMMENT '处理状态：INIT初始，FINISH完成',
  `audit_uid` int(11) NOT NULL DEFAULT '0' COMMENT '审核人员',
  `audit_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '审核时间',
  `audit_status` enum('INIT','OK','FAIL') NOT NULL COMMENT '审核状态：INIT初始, OK通过，FAIL没有通过',
  `audit_first` enum('YES','NO') NOT NULL COMMENT '是否首次认证',
  `audit_message_id` varchar(32) NOT NULL DEFAULT '' COMMENT '消息id',
  `audit_message` varchar(256) NOT NULL DEFAULT '' COMMENT '审核消息',
  `create_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `card_back` varchar(512) DEFAULT '',
  `full_name` varchar(128) NOT NULL COMMENT '用户全名',
  PRIMARY KEY (`id`),
  KEY `idx_uid` (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='用户身份认证';

-- ----------------------------
-- Records of user_identification
-- ----------------------------

-- ----------------------------
-- Table structure for user_info
-- ----------------------------
DROP TABLE IF EXISTS `user_info`;
CREATE TABLE `user_info` (
  `uid` int(11) unsigned NOT NULL COMMENT '用户id',
  `user_no` varchar(32) DEFAULT NULL COMMENT '用户编号',
  `name` char(32) NOT NULL DEFAULT '' COMMENT '姓名',
  `id_number` char(30) NOT NULL DEFAULT '' COMMENT '证件号码',
  `id_type` tinyint(1) unsigned DEFAULT '0' COMMENT '证件类型',
  `id_auth_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '认证时间',
  `id_authip` char(15) DEFAULT '0.0.0.0' COMMENT '认证ip',
  `mobile_bind_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '手机绑定时间',
  PRIMARY KEY (`uid`),
  UNIQUE KEY `idx_user_no` (`user_no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='用户基本信息';

-- ----------------------------
-- Records of user_info
-- ----------------------------

-- ----------------------------
-- Table structure for user_info_profile
-- ----------------------------
DROP TABLE IF EXISTS `user_info_profile`;
CREATE TABLE `user_info_profile` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `uid` int(11) unsigned NOT NULL COMMENT '用户id',
  `profile_group` varchar(32) NOT NULL COMMENT '配置组',
  `profile_key` varchar(64) NOT NULL COMMENT '配置关键字',
  `profile_index` varchar(32) NOT NULL COMMENT '配置序号',
  `data_type` varchar(32) NOT NULL COMMENT '数据类型',
  `profile_value` varchar(10240) NOT NULL COMMENT '配置数值',
  `create_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `update_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_uid_profile_key_profile_index` (`uid`,`profile_key`,`profile_index`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='用户配置信息表';

-- ----------------------------
-- Records of user_info_profile
-- ----------------------------

-- ----------------------------
-- Table structure for user_login_log
-- ----------------------------
DROP TABLE IF EXISTS `user_login_log`;
CREATE TABLE `user_login_log` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `uid` int(11) unsigned NOT NULL COMMENT '用户id',
  `ip_address` varchar(32) NOT NULL COMMENT '用户登录ip地址',
  `create_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  `ip_country` varchar(45) NOT NULL DEFAULT '',
  `ip_city` varchar(45) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `idx_create_date` (`create_date`) USING BTREE,
  KEY `idx_ip_address` (`ip_address`),
  KEY `idx_uid_create` (`uid`,`create_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of user_login_log
-- ----------------------------

-- ----------------------------
-- Table structure for user_message
-- ----------------------------
DROP TABLE IF EXISTS `user_message`;
CREATE TABLE `user_message` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `uid` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '用户id',
  `category` enum('SECURITY','ASSETS','SYSTEM','C2C') DEFAULT NULL COMMENT 'SECURITY:安全信息，ASSETS:资产信息，SYSTEM：系统消息',
  `content` text COMMENT '消息内容',
  `create_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `status` enum('UNREAD','READ') DEFAULT NULL COMMENT 'UNREAD:未读，READ:已读',
  PRIMARY KEY (`id`),
  KEY `category` (`category`),
  KEY `status` (`status`),
  KEY `uid` (`uid`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='站内信：给用户推送的各种消息';

-- ----------------------------
-- Records of user_message
-- ----------------------------

-- ----------------------------
-- Table structure for user_pay_password
-- ----------------------------
DROP TABLE IF EXISTS `user_pay_password`;
CREATE TABLE `user_pay_password` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增id',
  `uid` int(11) NOT NULL COMMENT '用户id',
  `lock_num` int(11) NOT NULL COMMENT '锁定次数',
  `create_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_uid` (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='支付密码上锁表：支付密码上锁表（支付密码错误次数记录，以及限制）';

-- ----------------------------
-- Records of user_pay_password
-- ----------------------------

-- ----------------------------
-- Table structure for user_pre_registration_pool
-- ----------------------------
DROP TABLE IF EXISTS `user_pre_registration_pool`;
CREATE TABLE `user_pre_registration_pool` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `invite_uid` int(11) unsigned DEFAULT '0' COMMENT '邀请人',
  `broker_id` int(11) unsigned NOT NULL COMMENT '用户所属券商id',
  `nickname` varchar(64) DEFAULT NULL COMMENT '昵称',
  `mobile` varchar(16) DEFAULT NULL COMMENT '手机',
  `email` varchar(64) DEFAULT NULL COMMENT '邮箱',
  `login_salt` varchar(100) NOT NULL COMMENT '登录盐码',
  `login_password` varchar(200) NOT NULL COMMENT '密码',
  `pay_salt` varchar(100) NOT NULL DEFAULT '' COMMENT '支付盐码',
  `pay_password` varchar(200) NOT NULL DEFAULT '' COMMENT '交易密码',
  `lock_num` tinyint(4) NOT NULL DEFAULT '0' COMMENT '锁定次数',
  `role` enum('user','admin','admin_read') DEFAULT 'user' COMMENT '角色',
  `fullname` varchar(128) NOT NULL DEFAULT '' COMMENT '姓名',
  `create_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='用户';

-- ----------------------------
-- Records of user_pre_registration_pool
-- ----------------------------

-- ----------------------------
-- Table structure for user_residence
-- ----------------------------
DROP TABLE IF EXISTS `user_residence`;
CREATE TABLE `user_residence` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `uid` int(11) unsigned NOT NULL COMMENT '用户id',
  `country_id` varchar(32) NOT NULL COMMENT '证件国家编号',
  `country` varchar(128) NOT NULL COMMENT '证件国家',
  `city` varchar(128) NOT NULL COMMENT '居住城市',
  `address` varchar(256) NOT NULL COMMENT '居住详细地址',
  `postcode` varchar(32) NOT NULL COMMENT '邮编',
  `residence_photo` varchar(512) NOT NULL COMMENT '居住证明照片，照片的md5，从mongodb中获取，用json数组支持多张照片？',
  `residence_translate` varchar(512) NOT NULL COMMENT '居住证明翻译照片，照片的md5，从mongodb中获取，用json数组支持多张照片？',
  `status` enum('INIT','FINISH') NOT NULL COMMENT '处理状态：INIT初始，FINISH完成',
  `audit_uid` int(11) NOT NULL DEFAULT '0' COMMENT '审核人员',
  `audit_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '审核时间',
  `audit_status` enum('INIT','OK','FAIL') NOT NULL COMMENT '审核状态：INIT初始, OK通过，FAIL没有通过',
  `audit_first` enum('YES','NO') NOT NULL COMMENT '是否首次认证',
  `audit_message_id` varchar(32) NOT NULL DEFAULT '' COMMENT '消息id',
  `audit_message` varchar(256) NOT NULL DEFAULT '' COMMENT '审核消息',
  `create_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `full_name` varchar(128) NOT NULL COMMENT '用户全称',
  `paper_type` tinyint(4) unsigned zerofill NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_uid` (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='用户居住认证';

-- ----------------------------
-- Records of user_residence
-- ----------------------------

-- ----------------------------
-- Table structure for user_transaction_fee_white_list
-- ----------------------------
DROP TABLE IF EXISTS `user_transaction_fee_white_list`;
CREATE TABLE `user_transaction_fee_white_list` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `uid` int(11) NOT NULL,
  `create_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `update_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `admin_id` int(11) DEFAULT NULL,
  `flag` enum('VALID','INVALID') DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uid` (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of user_transaction_fee_white_list
-- ----------------------------

-- ----------------------------
-- Table structure for user_upload_resource_log
-- ----------------------------
DROP TABLE IF EXISTS `user_upload_resource_log`;
CREATE TABLE `user_upload_resource_log` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `uid` int(11) unsigned NOT NULL COMMENT '用户id',
  `tag` varchar(40) NOT NULL COMMENT '图片hashcode',
  `dataType` varchar(64) NOT NULL COMMENT 'tag类型',
  `soucre` varchar(64) DEFAULT NULL COMMENT '下载来源',
  `storeType` varchar(64) DEFAULT NULL COMMENT '存储类型',
  `createTime` datetime(6) DEFAULT NULL COMMENT '创建时间',
  `updateTime` datetime(6) DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `tag` (`tag`,`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='用户配置信息表';

-- ----------------------------
-- Records of user_upload_resource_log
-- ----------------------------

-- ----------------------------
-- Table structure for withdraw_address
-- ----------------------------
DROP TABLE IF EXISTS `withdraw_address`;
CREATE TABLE `withdraw_address` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `asset_code` varchar(40) NOT NULL DEFAULT '' COMMENT '币种',
  `coin_address` varchar(70) NOT NULL DEFAULT '' COMMENT '券商提现地址',
  `create_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of withdraw_address
-- ----------------------------
/*
Navicat MySQL Data Transfer

Source Server         : 券商qa
Source Server Version : 50722
Source Host           : 192.168.168.125:3306
Source Database       : cloud_broker_market

Target Server Type    : MYSQL
Target Server Version : 50722
File Encoding         : 65001

Date: 2018-07-18 10:48:09
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for admin_role
-- ----------------------------
DROP TABLE IF EXISTS `admin_role`;
CREATE TABLE `admin_role` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增主键id',
  `admin_id` int(11) unsigned NOT NULL COMMENT '用户id',
  `role_id` int(11) unsigned NOT NULL COMMENT '角色id',
  `create_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `idx_admin_id` (`admin_id`)
) ENGINE=InnoDB AUTO_INCREMENT=93 DEFAULT CHARSET=utf8mb4 COMMENT='管理用户角色关联表';

-- ----------------------------
-- Records of admin_role
-- ----------------------------
INSERT INTO `admin_role` VALUES ('1', '1', '1', '2018-04-18 11:03:33', '2018-07-18 10:32:40');

-- ----------------------------
-- Table structure for administrators
-- ----------------------------
DROP TABLE IF EXISTS `administrators`;
CREATE TABLE `administrators` (
  `admin_id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `op_name` char(32) NOT NULL COMMENT '姓名',
  `mobile` char(11) NOT NULL COMMENT '手机',
  `login_password` char(125) NOT NULL DEFAULT '' COMMENT '登陆密码',
  `locked` enum('LOCK','UNLOCK') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'UNLOCK' COMMENT '锁定状态，0-锁定，1-未锁定',
  `role` char(32) NOT NULL COMMENT '角色',
  `create_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `createip` char(15) DEFAULT '0.0.0.0' COMMENT '创建ip',
  `update_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `updateip` char(15) DEFAULT '0.0.0.0' COMMENT '更新ip',
  `create_admin_id` int(11) DEFAULT NULL COMMENT '创建此管理员的管理员id',
  PRIMARY KEY (`admin_id`),
  UNIQUE KEY `idx_mobile` (`mobile`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COMMENT='管理员用户表';

-- ----------------------------
-- Records of administrators
-- ----------------------------
INSERT INTO `administrators` VALUES ('1', '超级管理员', '18514763176', 'AE20IWHBdK6G7S2Q3PY/bXdw+50QVviIoN/6OD/DoIfHvRoZkRPuYIv1WUmXau87jAiepBR2MKEZTJxiNfjzy80=', 'UNLOCK', 'ADMIN', '2018-03-01 10:50:41', '0.0.0.0', '2018-03-01 10:50:41', '0.0.0.0', '1');

-- ----------------------------
-- Table structure for channel_coin_address_withdraw
-- ----------------------------
DROP TABLE IF EXISTS `channel_coin_address_withdraw`;
CREATE TABLE `channel_coin_address_withdraw` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `uid` int(11) NOT NULL COMMENT '用户ID',
  `asset_code` varchar(40) NOT NULL COMMENT '资产类型',
  `name` varchar(200) DEFAULT NULL COMMENT '备注名称',
  `auth_status` enum('UNAUTH','AUTHED') NOT NULL COMMENT '地址认证状态：未认证,已\n\n认证',
  `coin_address` varchar(70) NOT NULL COMMENT '外部地址',
  `create_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `create_ip` char(15) DEFAULT '0.0.0.0' COMMENT '创建ip',
  `inner_address` enum('YES','NO') DEFAULT 'NO' COMMENT '是否内部地址',
  `del_flag` enum('TRUE','FALSE') DEFAULT 'FALSE' COMMENT 'TRUE：已删除, ''FALSE''：未删除',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uid` (`uid`,`asset_code`,`coin_address`),
  KEY `idx_uid_asset_code_del_flag` (`uid`,`asset_code`,`del_flag`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='提现：用户对应的数字资产地址表';

-- ----------------------------
-- Records of channel_coin_address_withdraw
-- ----------------------------

-- ----------------------------
-- Table structure for config_asset
-- ----------------------------
DROP TABLE IF EXISTS `config_asset`;
CREATE TABLE `config_asset` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `asset_code` varchar(40) NOT NULL COMMENT '资产代码',
  `currency_type` enum('COIN','CASH') NOT NULL COMMENT '资产种类',
  `status` enum('INIT','LISTED','DELISTED') NOT NULL COMMENT '处理状态：INIT初始，LISTED上市，DELISTED退市',
  `name` varchar(64) NOT NULL COMMENT '资产名称',
  `supply_amount` decimal(35,20) unsigned NOT NULL COMMENT '当前的供应量',
  `total_amount` decimal(35,20) unsigned NOT NULL COMMENT '总的供应量',
  `min_precision` int(11) NOT NULL COMMENT '最小精度',
  `description` varchar(256) NOT NULL COMMENT '描述',
  `web_url` varchar(256) NOT NULL COMMENT '官方url',
  `create_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_asset_code` (`asset_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='资产基本信息表';

-- ----------------------------
-- Records of config_asset
-- ----------------------------

-- ----------------------------
-- Table structure for config_asset_profile
-- ----------------------------
DROP TABLE IF EXISTS `config_asset_profile`;
CREATE TABLE `config_asset_profile` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `asset_code` varchar(40) NOT NULL COMMENT '资产代码',
  `profile_key` varchar(64) NOT NULL COMMENT '配置关键字',
  `profile_value` varchar(10240) NOT NULL COMMENT '配置数值',
  `create_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `update_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_asset_code_profile_key` (`asset_code`,`profile_key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='资产配置参数:url,消息队列';

-- ----------------------------
-- Records of config_asset_profile
-- ----------------------------

-- ----------------------------
-- Table structure for config_email
-- ----------------------------
DROP TABLE IF EXISTS `config_email`;
CREATE TABLE `config_email` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `mail_username` varchar(45) NOT NULL COMMENT '邮箱登陆用户名',
  `mail_password` varchar(45) NOT NULL COMMENT '邮箱登陆密码',
  `mail_host` varchar(64) NOT NULL,
  `mail_subject` varchar(64) NOT NULL,
  `send_count` int(11) NOT NULL,
  `status` enum('LISTED','DELISTED') NOT NULL COMMENT '状态',
  `create_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `username_UNIQUE` (`mail_username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='给用户发送邮件的邮箱配置表';

-- ----------------------------
-- Records of config_email
-- ----------------------------

-- ----------------------------
-- Table structure for config_symbol
-- ----------------------------
DROP TABLE IF EXISTS `config_symbol`;
CREATE TABLE `config_symbol` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `symbol` varchar(32) NOT NULL COMMENT '交易对',
  `trade_asset` varchar(40) NOT NULL DEFAULT '' COMMENT '交易币种',
  `price_asset` varchar(40) NOT NULL DEFAULT '' COMMENT '计价币种',
  `status` enum('INIT','LISTED','DELISTED') NOT NULL COMMENT '处理状态：INIT初始，LISTED上市，DELISTED退市',
  `title` varchar(64) NOT NULL COMMENT '交易对标题',
  `name` varchar(64) NOT NULL COMMENT '交易对名称',
  `description` varchar(256) DEFAULT NULL COMMENT '描述',
  `min_precision1` int(11) NOT NULL COMMENT '资产1的最小精度',
  `min_precision2` int(11) NOT NULL COMMENT '资产2的最小精度',
  `min_amount1` decimal(35,20) unsigned NOT NULL COMMENT '资产1的最小数量',
  `min_amount2` decimal(35,20) unsigned NOT NULL COMMENT '资产2的最小数量',
  `max_amount1` decimal(35,20) unsigned NOT NULL COMMENT '资产1的最大数量',
  `max_amount2` decimal(35,20) unsigned NOT NULL COMMENT '资产2的最大数量',
  `create_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_symbol` (`symbol`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='交易对';

-- ----------------------------
-- Records of config_symbol
-- ----------------------------

-- ----------------------------
-- Table structure for config_symbol_profile
-- ----------------------------
DROP TABLE IF EXISTS `config_symbol_profile`;
CREATE TABLE `config_symbol_profile` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `symbol` varchar(32) NOT NULL COMMENT '交易对',
  `profile_key` varchar(64) NOT NULL COMMENT '配置关键字',
  `profile_value` varchar(10240) NOT NULL COMMENT '配置数值',
  `create_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `update_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_symbol_profile_key_profile_index` (`symbol`,`profile_key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='交易对配置参数:url,消息队列';

-- ----------------------------
-- Records of config_symbol_profile
-- ----------------------------

-- ----------------------------
-- Table structure for email_log
-- ----------------------------
DROP TABLE IF EXISTS `email_log`;
CREATE TABLE `email_log` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `msg_id` varchar(32) NOT NULL COMMENT '短信id',
  `service_code` enum('MARKET','NOTICE','REPORT_DAILY','VERIFY_CODE') DEFAULT NULL,
  `service_provider` varchar(32) NOT NULL COMMENT '邮件服务提供商',
  `sys_code` enum('GP_MARKET','QUICKDAX','GP_BAO') DEFAULT NULL,
  `email` char(128) NOT NULL COMMENT '邮箱地址',
  `msg_content` text,
  `create_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='邮件发送日志';

-- ----------------------------
-- Records of email_log
-- ----------------------------

-- ----------------------------
-- Table structure for manager_google_code_config
-- ----------------------------
DROP TABLE IF EXISTS `manager_google_code_config`;
CREATE TABLE `manager_google_code_config` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `admin_id` int(11) NOT NULL COMMENT '管理员id',
  `secret_code` varchar(32) NOT NULL COMMENT '谷歌秘钥',
  `del_flag` enum('TRUE','FALSE') NOT NULL COMMENT '删除标识',
  `create_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `idx_admin_id` (`admin_id`),
  KEY `idx_del_flag` (`del_flag`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='管理员谷歌验证码配置表';

-- ----------------------------
-- Records of manager_google_code_config
-- ----------------------------

-- ----------------------------
-- Table structure for manager_oper_log
-- ----------------------------
DROP TABLE IF EXISTS `manager_oper_log`;
CREATE TABLE `manager_oper_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `admin_id` int(11) NOT NULL COMMENT '管理员id',
  `ip_address` varchar(32) NOT NULL COMMENT 'ip地址',
  `ip_country` varchar(45) NOT NULL COMMENT 'ip国家所在地',
  `ip_city` varchar(45) NOT NULL COMMENT 'ip城市所在地',
  `oper_type` varchar(32) NOT NULL COMMENT '类型',
  `remark` varchar(45) DEFAULT '' COMMENT '其他备注',
  `create_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `idx_admin_id` (`admin_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='管理员操作日志表';

-- ----------------------------
-- Records of manager_oper_log
-- ----------------------------

-- ----------------------------
-- Table structure for manager_password_oper_record
-- ----------------------------
DROP TABLE IF EXISTS `manager_password_oper_record`;
CREATE TABLE `manager_password_oper_record` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `admin_id` int(11) NOT NULL COMMENT '管理员ID',
  `modify_flag` enum('TRUE','FALSE') NOT NULL COMMENT '是否修改密码',
  `create_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `admin_id_UNIQUE` (`admin_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='管理员密码操作记录表';

-- ----------------------------
-- Records of manager_password_oper_record
-- ----------------------------

-- ----------------------------
-- Table structure for menu
-- ----------------------------
DROP TABLE IF EXISTS `menu`;
CREATE TABLE `menu` (
  `menu_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增主键id',
  `menu_name` varchar(64) NOT NULL COMMENT '菜单名称',
  `menu_module` varchar(45) NOT NULL COMMENT '菜单module名',
  `parent_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '父级菜单',
  `level` int(11) unsigned NOT NULL COMMENT '级别',
  `uri` varchar(60) DEFAULT '' COMMENT '接口uri',
  `show` varchar(10) NOT NULL COMMENT '是否显示',
  `i18n` varchar(50) DEFAULT '' COMMENT '多语言',
  PRIMARY KEY (`menu_id`),
  KEY `level_Index` (`level`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=103333331 DEFAULT CHARSET=utf8mb4 COMMENT='菜单表';

-- ----------------------------
-- Records of menu
-- ----------------------------
INSERT INTO `menu` VALUES ('100', '系统权限', 'system', '0', '0', '', 'true', 'common.system');
INSERT INTO `menu` VALUES ('101', '用户管理', 'adminUser', '100', '1', '', 'true', 'common.userManagement');
INSERT INTO `menu` VALUES ('102', '添加用户', 'adminAdd', '100', '1', '', 'true', 'common.addNewUser');
INSERT INTO `menu` VALUES ('103', '登录详情', 'adminLoginLog', '100', '1', '', 'false', '');
INSERT INTO `menu` VALUES ('104', '角色管理', 'roleList', '100', '1', '', 'true', 'common.todo7');
INSERT INTO `menu` VALUES ('105', '添加角色', 'roleAdd', '100', '1', '', 'true', 'common.todo8');
INSERT INTO `menu` VALUES ('106', '人员查看', 'rolePeople', '100', '1', '', 'false', '');
INSERT INTO `menu` VALUES ('107', '权限管理', 'rolePerm', '100', '1', '', 'false', '');
INSERT INTO `menu` VALUES ('200', '控制面板', 'controlPan', '0', '0', '', 'true', 'common.controlPanel');
INSERT INTO `menu` VALUES ('201', '密码管理', 'setPwd', '200', '1', '', 'true', 'common.passwordManagement');
INSERT INTO `menu` VALUES ('202', '谷歌验证', 'google', '200', '1', '', 'true', 'common.googleVerfication');
INSERT INTO `menu` VALUES ('203', '登录信息', 'loginInfo', '200', '1', '', 'true', 'common.todo6');
INSERT INTO `menu` VALUES ('300', '用户管理', 'commonusers', '0', '0', '', 'true', 'common.userManagement');
INSERT INTO `menu` VALUES ('301', '用户信息', 'commonUserInfo', '300', '1', '', 'true', 'common.userInformation');
INSERT INTO `menu` VALUES ('302', '用户详情', 'commonDetail', '300', '1', '', 'false', '');
INSERT INTO `menu` VALUES ('303', 'kyc审核', 'commonUserKyc', '300', '1', '', 'true', 'common.kycApproval');
INSERT INTO `menu` VALUES ('400', '资产管理', 'asset', '0', '0', '', 'true', 'common.assetManagement');
INSERT INTO `menu` VALUES ('401', '充值记录', 'assetDeposit', '400', '1', '', 'true', 'common.depositRecords');
INSERT INTO `menu` VALUES ('402', '提现记录', 'assetWithdraw', '400', '1', '', 'true', 'common.withdrawalRecords');
INSERT INTO `menu` VALUES ('403', '提现审核', 'assetCheck', '400', '1', '', 'true', 'common.withdrawalVerification');
INSERT INTO `menu` VALUES ('1700', '交易管理', 'trade', '0', '0', '', 'true', 'common.todo1');
INSERT INTO `menu` VALUES ('1701', '交易记录', 'tradeRecord', '1700', '1', '', 'true', 'finance.trade');
INSERT INTO `menu` VALUES ('1800', '网站维护', 'setting', '0', '0', '', 'true', 'common.websiteMaintenance');
INSERT INTO `menu` VALUES ('1801', '币种列表', 'coinConfig', '1800', '1', '', 'true', 'settingCoinconfig.coinList');
INSERT INTO `menu` VALUES ('1802', '增加新币', 'addCoin', '1800', '1', '', 'true', 'settingCoinadd.addNewCoin');
INSERT INTO `menu` VALUES ('1803', '交易配置', 'symbolConfig', '1800', '1', '', 'true', 'settingSymbolconfig.tradingConfiguration');
INSERT INTO `menu` VALUES ('1804', '增加交易', 'addSymbol', '1800', '1', '', 'true', 'settingSymboladd.addTradingPair');
INSERT INTO `menu` VALUES ('1805', '免手续费白名单', 'whiteList', '1800', '1', '', 'true', 'settingSymbolwhitelist.noCommisionFee');
INSERT INTO `menu` VALUES ('1900', '结算管理', 'settlement', '0', '0', '', 'true', 'settlement.name');
INSERT INTO `menu` VALUES ('1901', '结算信息管理', 'settlementConfig', '1900', '1', '', 'true', 'settlement.settlementConfig');
INSERT INTO `menu` VALUES ('1902', '结算记录查询', 'settlementRecord', '1900', '1', '', 'true', 'settlement.settlementRecord');
INSERT INTO `menu` VALUES ('1903', '转出记录查询', 'settlementOutRecord', '1900', '1', '', 'true', 'settlement.settlementOutRecord');
INSERT INTO `menu` VALUES ('1904', '申请转出', 'applyWithdraw', '1900', '1', '', 'true', 'settlement.settlementWithdrawApply');

-- ----------------------------
-- Table structure for menu_interface
-- ----------------------------
DROP TABLE IF EXISTS `menu_interface`;
CREATE TABLE `menu_interface` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增主键id',
  `menu_id` int(11) NOT NULL COMMENT '菜单id',
  `interface_name` varchar(32) NOT NULL COMMENT '接口名',
  `uri` varchar(128) DEFAULT '' COMMENT '接口uri',
  PRIMARY KEY (`id`),
  KEY `menu_Index` (`menu_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=58 DEFAULT CHARSET=utf8mb4 COMMENT='菜单接口对应表';

-- ----------------------------
-- Records of menu_interface
-- ----------------------------
INSERT INTO `menu_interface` VALUES ('1', '101', '查询管理员列表', '/exchange_manager/admin/list');
INSERT INTO `menu_interface` VALUES ('2', '101', '重置密码', '/exchange_manager/admin/reset-login-password');
INSERT INTO `menu_interface` VALUES ('3', '101', '重置谷歌验证器', '/exchange_manager/manager/googlecode-reset');
INSERT INTO `menu_interface` VALUES ('4', '101', '锁定管理员', '/exchange_manager/admin/lock');
INSERT INTO `menu_interface` VALUES ('5', '101', '解锁管理员', '/exchange_manager/admin/unlock');
INSERT INTO `menu_interface` VALUES ('6', '103', '查询登录信息', '/exchange_manager/admin/loginlog-info');
INSERT INTO `menu_interface` VALUES ('7', '102', '创建管理员用户', '/exchange_manager/admin/new');
INSERT INTO `menu_interface` VALUES ('8', '104', '角色列表', '/exchange_manager/roleManager/role-list');
INSERT INTO `menu_interface` VALUES ('9', '104', '删除角色', '/exchange_manager/roleManager/delete_role');
INSERT INTO `menu_interface` VALUES ('10', '106', '人员角色列表', '/exchange_manager/roleManager/admin-role-list');
INSERT INTO `menu_interface` VALUES ('11', '107', '人员菜单列表', '/exchange_manager/roleManager/menu-role-list');
INSERT INTO `menu_interface` VALUES ('12', '107', '更新人员菜单列表', '/exchange_manager/roleManager/update-role-menu');
INSERT INTO `menu_interface` VALUES ('13', '105', '添加角色', '/exchange_manager/roleManager/add-role');
INSERT INTO `menu_interface` VALUES ('14', '201', '修改用户登录密码', '/exchange_manager/admin/login-password');
INSERT INTO `menu_interface` VALUES ('15', '202', '管理员开启谷歌验证码并保存信息', '/exchange_manager/manager/googlecode-firstcheck');
INSERT INTO `menu_interface` VALUES ('16', '202', '获取谷歌验证二维码及相关信息', '/exchange_manager/manager/googlecode-get');
INSERT INTO `menu_interface` VALUES ('17', '203', '登录信息', '/exchange_manager/admin/loginlog-info');
INSERT INTO `menu_interface` VALUES ('18', '301', '获取用户信息列表', '/exchange_manager/security/overseas/user-list');
INSERT INTO `menu_interface` VALUES ('19', '302', '获取用户详情', '/exchange_manager/security/overseas/user-detail');
INSERT INTO `menu_interface` VALUES ('20', '302', '查询用户资产列表', '/exchange_manager/asset/getUserAccounts');
INSERT INTO `menu_interface` VALUES ('21', '302', '重置谷歌验证器', '/exchange_manager/user/user_googlecode-reset');
INSERT INTO `menu_interface` VALUES ('22', '303', '获取身份认证信息列表', '/exchange_manager/security/overseas/identities');
INSERT INTO `menu_interface` VALUES ('23', '303', '获取居住认证信息列表', '/exchange_manager/security/overseas/residences');
INSERT INTO `menu_interface` VALUES ('24', '303', '身份审核验证', '/exchange_manager/security/overseas/identity-audit');
INSERT INTO `menu_interface` VALUES ('25', '303', '高级身份审核验证', '/exchange_manager/security/overseas/residence-audit');
INSERT INTO `menu_interface` VALUES ('26', '401', '充值记录查询', '/exchange_manager/deposit/coin/transfer');
INSERT INTO `menu_interface` VALUES ('27', '402', '提现记录查询', '/exchange_manager/withdraw/coin/processed-query');
INSERT INTO `menu_interface` VALUES ('28', '403', '提现未处理记录查询', '/exchange_manager/withdraw/coin/untreated');
INSERT INTO `menu_interface` VALUES ('29', '403', '后台管理员待审信息统计提醒', '/exchange_manager/user/unverified');
INSERT INTO `menu_interface` VALUES ('30', '403', '提现审核', '/exchange_manager/withdraw/coin/confirm');
INSERT INTO `menu_interface` VALUES ('31', '1701', '交易结果查询', '/exchange_manager/match/orders-query');
INSERT INTO `menu_interface` VALUES ('32', '1801', '已有币种列表查询', '/exchange_manager/managerAssetAndSymbol/configasset-list');
INSERT INTO `menu_interface` VALUES ('33', '1801', '查询资产配置参数列表', '/exchange_manager/managerAssetAndSymbol/configassetprofile-list');
INSERT INTO `menu_interface` VALUES ('34', '1801', '转账配置查询', '/exchange_manager/withdraw-config/config-list');
INSERT INTO `menu_interface` VALUES ('35', '1801', '更改已有币种配置', '/exchange_manager/managerAssetAndSymbol/configassetprofile-edit');
INSERT INTO `menu_interface` VALUES ('36', '1801', '添加新币种或更新币种状态', '/exchange_manager/managerAssetAndSymbol/configasset-edit');
INSERT INTO `menu_interface` VALUES ('37', '1802', '添加新币种或更新币种状态', '/exchange_manager/managerAssetAndSymbol/configasset-edit');
INSERT INTO `menu_interface` VALUES ('38', '1802', '查询云端已配置币种', '/exchange_manager/managerAssetAndSymbol/assets');
INSERT INTO `menu_interface` VALUES ('39', '1803', '已有交易对列表查询', '/exchange_manager/managerAssetAndSymbol/configsymbol-list');
INSERT INTO `menu_interface` VALUES ('40', '1803', '已有交易对配置查询', '/exchange_manager/managerAssetAndSymbol/configsymbolprofile-list');
INSERT INTO `menu_interface` VALUES ('41', '1803', '更改交易对配置', '/exchange_manager/managerAssetAndSymbol/configsymbolprofile-edit');
INSERT INTO `menu_interface` VALUES ('42', '1803', '添加新交易对或更新交易对状态', '/exchange_manager/managerAssetAndSymbol/configsymbol-update');
INSERT INTO `menu_interface` VALUES ('43', '1803', '更新交易对收费', '/exchange_manager/transaction-config/config-update');
INSERT INTO `menu_interface` VALUES ('44', '1803', '查询交易对费率列表', '/exchange_manager/transaction-config/config-list');
INSERT INTO `menu_interface` VALUES ('45', '1804', '添加新交易对或更新交易对状态', '/exchange_manager/managerAssetAndSymbol/configsymbol-create');
INSERT INTO `menu_interface` VALUES ('46', '1805', '查询白名单用户', '/exchange_manager/whiteListconfig/query');
INSERT INTO `menu_interface` VALUES ('47', '1805', '新增白名单用户', '/exchange_manager/whiteListconfig/add');
INSERT INTO `menu_interface` VALUES ('48', '1805', '删除白名单用户', '/exchange_manager/whiteListconfig/delete');
INSERT INTO `menu_interface` VALUES ('49', '1901', '查询结算信息', '/exchange_manager/settle/info-list');
INSERT INTO `menu_interface` VALUES ('50', '1902', '查询结算记录', '/exchange_manager/settle/record-list');
INSERT INTO `menu_interface` VALUES ('51', '1903', '查询结算记录', '/exchange_manager/settle/withdraw-record-list');
INSERT INTO `menu_interface` VALUES ('52', '1904', '查询提现限制', '/exchange_manager/settle/withdraw-limit');
INSERT INTO `menu_interface` VALUES ('53', '1904', '查询提现地址', '/exchange_manager/settle/withdraw-address');
INSERT INTO `menu_interface` VALUES ('54', '1904', '添加结算地址', '/exchange_manager/settle/withdraw-address/add');
INSERT INTO `menu_interface` VALUES ('55', '1904', '修改结算地址', '/exchange_manager/settle/withdraw-address/update');
INSERT INTO `menu_interface` VALUES ('56', '1904', '申请转出', '/exchange_manager/settle/withdraw-broker');
INSERT INTO `menu_interface` VALUES ('57', '101', '查询管理员登录信息', '/exchange_manager/admin/operlog-query');

-- ----------------------------
-- Table structure for menu_role
-- ----------------------------
DROP TABLE IF EXISTS `menu_role`;
CREATE TABLE `menu_role` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `menu_id` int(11) NOT NULL COMMENT '关联menu表id',
  `role_id` int(11) NOT NULL COMMENT '关联role表id',
  `status` tinyint(2) NOT NULL COMMENT '0 不可用 1 可用',
  `create_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `menu_id_Index` (`menu_id`) USING BTREE,
  KEY `role_id_Index` (`role_id`) USING BTREE,
  KEY `status_Index` (`status`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COMMENT='菜单_角色表';

-- ----------------------------
-- Records of menu_role
-- ----------------------------
INSERT INTO `menu_role` VALUES ('1', '100', '1', '1', '2018-07-05 21:19:54', '2018-07-18 10:44:43');
INSERT INTO `menu_role` VALUES ('2', '101', '1', '1', '2018-07-05 21:19:54', '2018-07-18 10:44:44');
INSERT INTO `menu_role` VALUES ('3', '102', '1', '1', '2018-07-05 21:19:55', '2018-07-18 10:44:45');
INSERT INTO `menu_role` VALUES ('4', '103', '1', '1', '2018-07-05 21:19:55', '2018-07-18 10:44:46');
INSERT INTO `menu_role` VALUES ('5', '104', '1', '1', '2018-07-05 21:19:55', '2018-07-18 10:44:48');
INSERT INTO `menu_role` VALUES ('6', '105', '1', '1', '2018-07-05 21:19:55', '2018-07-18 10:44:49');
INSERT INTO `menu_role` VALUES ('7', '106', '1', '1', '2018-07-05 21:19:55', '2018-07-18 10:44:50');
INSERT INTO `menu_role` VALUES ('8', '107', '1', '1', '2018-07-05 21:19:56', '2018-07-18 10:44:53');
INSERT INTO `menu_role` VALUES ('9', '200', '1', '1', '2018-07-05 21:19:56', '2018-07-18 10:44:54');
INSERT INTO `menu_role` VALUES ('10', '201', '1', '1', '2018-07-05 21:19:56', '2018-07-18 10:44:58');
INSERT INTO `menu_role` VALUES ('11', '202', '1', '1', '2018-07-05 21:19:56', '2018-07-18 10:45:00');
INSERT INTO `menu_role` VALUES ('12', '203', '1', '1', '2018-07-05 21:19:56', '2018-07-18 10:45:02');

-- ----------------------------
-- Table structure for public_notice
-- ----------------------------
DROP TABLE IF EXISTS `public_notice`;
CREATE TABLE `public_notice` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `uid` int(11) unsigned NOT NULL COMMENT '发布者id',
  `nickname` varchar(128) DEFAULT NULL COMMENT '发布者名称',
  `top_status` enum('YES','NO') DEFAULT 'NO' COMMENT '是否置顶',
  `top_time` time(6) NOT NULL DEFAULT '00:00:00.000000' COMMENT '最后置顶时间，每次置顶操作更新这个时间',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `title` varchar(128) DEFAULT NULL COMMENT '公告标题',
  `content` varchar(10240) DEFAULT NULL COMMENT '公告内容',
  `status` enum('VALID','INVALID') DEFAULT 'VALID',
  PRIMARY KEY (`id`),
  KEY `idx_create_time` (`create_time`,`status`,`top_status`,`top_time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='test';

-- ----------------------------
-- Records of public_notice
-- ----------------------------

-- ----------------------------
-- Table structure for role
-- ----------------------------
DROP TABLE IF EXISTS `role`;
CREATE TABLE `role` (
  `role_id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增主键id',
  `role_name` varchar(32) NOT NULL COMMENT '角色名称',
  `instruction` varchar(64) DEFAULT NULL COMMENT '描述',
  `role_status` tinyint(4) NOT NULL DEFAULT '1' COMMENT '角色状态, 1启用, 0禁用',
  `create_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`role_id`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4 COMMENT='管理员用户角色';

-- ----------------------------
-- Records of role
-- ----------------------------
INSERT INTO `role` VALUES ('1', '超级管理员', '超管', '1', '2018-04-16 11:30:06', '2018-04-16 11:30:11');

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `uid` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `invite_uid` int(11) unsigned DEFAULT '0' COMMENT '邀请人',
  `broker_id` int(11) unsigned NOT NULL COMMENT '用户所属券商id',
  `nickname` varchar(64) DEFAULT NULL COMMENT '昵称',
  `mobile` varchar(16) DEFAULT NULL COMMENT '手机',
  `email` varchar(64) DEFAULT NULL COMMENT '邮箱',
  `login_salt` varchar(100) NOT NULL COMMENT '登录盐码',
  `login_password` varchar(200) NOT NULL COMMENT '密码',
  `pay_salt` varchar(100) NOT NULL DEFAULT '' COMMENT '支付盐码',
  `pay_password` varchar(200) NOT NULL DEFAULT '' COMMENT '交易密码',
  `lock_num` tinyint(4) NOT NULL DEFAULT '0' COMMENT '锁定次数',
  `role` enum('user','admin','admin_read') DEFAULT 'user' COMMENT '角色',
  `fullname` varchar(128) NOT NULL DEFAULT '' COMMENT '姓名',
  `create_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `createip` char(15) DEFAULT '0.0.0.0' COMMENT '创建ip',
  `update_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `updateip` char(15) DEFAULT '0.0.0.0' COMMENT '更新ip',
  `auth_level` varchar(16) NOT NULL DEFAULT 'LEVEL0' COMMENT '实名认证级别：LEVEL0没有认证，LEVEL1基础认证',
  PRIMARY KEY (`uid`),
  UNIQUE KEY `idx_email` (`email`),
  UNIQUE KEY `idx_mobile` (`mobile`),
  KEY `idx_invite_uid` (`invite_uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='用户';

-- ----------------------------
-- Records of user
-- ----------------------------

-- ----------------------------
-- Table structure for user_api_key
-- ----------------------------
DROP TABLE IF EXISTS `user_api_key`;
CREATE TABLE `user_api_key` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `uid` int(11) unsigned NOT NULL COMMENT '用户id',
  `broker_id` int(11) unsigned DEFAULT NULL COMMENT '用户所属券商id',
  `user_no` varchar(32) NOT NULL DEFAULT '0' COMMENT '券商编号',
  `name` char(60) NOT NULL COMMENT '名称',
  `auth_type` enum('PASSPHRASE','ACCESS_KEY') DEFAULT NULL COMMENT '认证方式',
  `passphrase` varchar(256) DEFAULT NULL COMMENT '口令',
  `access_key` varchar(32) DEFAULT NULL COMMENT '访问密匙',
  `secret_key` varchar(32) DEFAULT NULL COMMENT '私钥',
  `level` enum('limited','readonly','full') NOT NULL DEFAULT 'full' COMMENT '级别',
  `ip_allow` char(255) NOT NULL DEFAULT '' COMMENT '允许的ip地址：支持ip段等方式',
  `del_flag` enum('TRUE','FALSE') DEFAULT 'FALSE' COMMENT 'TRUE：已删除, ''FALSE''：未删除',
  `create_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_access_key` (`access_key`),
  UNIQUE KEY `idx_secret_key` (`secret_key`),
  UNIQUE KEY `idx_passphrase` (`passphrase`(64)),
  KEY `idx_broker_id` (`broker_id`),
  KEY `idx_uid` (`uid`),
  KEY `idx_user_no` (`user_no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='券商访问key：API访问秘钥，给商户分配key';

-- ----------------------------
-- Records of user_api_key
-- ----------------------------

-- ----------------------------
-- Table structure for user_basic_info
-- ----------------------------
DROP TABLE IF EXISTS `user_basic_info`;
CREATE TABLE `user_basic_info` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `first_name` varchar(128) NOT NULL DEFAULT '',
  `middle_name` varchar(128) NOT NULL DEFAULT '',
  `last_name` varchar(128) NOT NULL DEFAULT '',
  `gender` enum('MALE','FEMALE') NOT NULL DEFAULT 'MALE',
  `birthday` varchar(30) NOT NULL DEFAULT '',
  `country_id` varchar(11) NOT NULL DEFAULT '',
  `country` varchar(128) NOT NULL DEFAULT '',
  `uid` int(11) NOT NULL,
  `create_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `update_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uid_key` (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of user_basic_info
-- ----------------------------

-- ----------------------------
-- Table structure for user_google_code_config
-- ----------------------------
DROP TABLE IF EXISTS `user_google_code_config`;
CREATE TABLE `user_google_code_config` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `uid` int(11) unsigned NOT NULL,
  `flag` varchar(32) NOT NULL,
  `secret_code` varchar(32) NOT NULL,
  `create_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `update_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `reset_date` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uid` (`uid`),
  KEY `idx_uid` (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of user_google_code_config
-- ----------------------------

-- ----------------------------
-- Table structure for user_identification
-- ----------------------------
DROP TABLE IF EXISTS `user_identification`;
CREATE TABLE `user_identification` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `uid` int(11) unsigned NOT NULL COMMENT '用户id',
  `country_id` varchar(32) NOT NULL COMMENT '证件国家编号',
  `country` varchar(128) NOT NULL COMMENT '证件国家',
  `card_type` varchar(32) NOT NULL COMMENT '证件类型',
  `card_no` varchar(32) NOT NULL COMMENT '证件编号',
  `expired_date` datetime NOT NULL COMMENT '有效期至',
  `card_photo` varchar(512) NOT NULL COMMENT '证件照片，照片的md5，从mongodb中获取，用json数组支持多张照片？',
  `card_handhold` varchar(512) NOT NULL COMMENT '手持证件照，照片的md5，从mongodb中获取，用json数组支持多张照片？',
  `card_translate` varchar(512) NOT NULL COMMENT '证件翻译照片，照片的md5，从mongodb中获取，用json数组支持多张照片？',
  `status` enum('INIT','FINISH') NOT NULL COMMENT '处理状态：INIT初始，FINISH完成',
  `audit_uid` int(11) NOT NULL DEFAULT '0' COMMENT '审核人员',
  `audit_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '审核时间',
  `audit_status` enum('INIT','OK','FAIL') NOT NULL COMMENT '审核状态：INIT初始, OK通过，FAIL没有通过',
  `audit_first` enum('YES','NO') NOT NULL COMMENT '是否首次认证',
  `audit_message_id` varchar(32) NOT NULL DEFAULT '' COMMENT '消息id',
  `audit_message` varchar(256) NOT NULL DEFAULT '' COMMENT '审核消息',
  `create_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `card_back` varchar(512) DEFAULT '',
  `full_name` varchar(128) NOT NULL COMMENT '用户全名',
  PRIMARY KEY (`id`),
  KEY `idx_uid` (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='用户身份认证';

-- ----------------------------
-- Records of user_identification
-- ----------------------------

-- ----------------------------
-- Table structure for user_info
-- ----------------------------
DROP TABLE IF EXISTS `user_info`;
CREATE TABLE `user_info` (
  `uid` int(11) unsigned NOT NULL COMMENT '用户id',
  `user_no` varchar(32) DEFAULT NULL COMMENT '用户编号',
  `name` char(32) NOT NULL DEFAULT '' COMMENT '姓名',
  `id_number` char(30) NOT NULL DEFAULT '' COMMENT '证件号码',
  `id_type` tinyint(1) unsigned DEFAULT '0' COMMENT '证件类型',
  `id_auth_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '认证时间',
  `id_authip` char(15) DEFAULT '0.0.0.0' COMMENT '认证ip',
  `mobile_bind_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '手机绑定时间',
  PRIMARY KEY (`uid`),
  UNIQUE KEY `idx_user_no` (`user_no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='用户基本信息';

-- ----------------------------
-- Records of user_info
-- ----------------------------

-- ----------------------------
-- Table structure for user_info_profile
-- ----------------------------
DROP TABLE IF EXISTS `user_info_profile`;
CREATE TABLE `user_info_profile` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `uid` int(11) unsigned NOT NULL COMMENT '用户id',
  `profile_group` varchar(32) NOT NULL COMMENT '配置组',
  `profile_key` varchar(64) NOT NULL COMMENT '配置关键字',
  `profile_index` varchar(32) NOT NULL COMMENT '配置序号',
  `data_type` varchar(32) NOT NULL COMMENT '数据类型',
  `profile_value` varchar(10240) NOT NULL COMMENT '配置数值',
  `create_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `update_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_uid_profile_key_profile_index` (`uid`,`profile_key`,`profile_index`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='用户配置信息表';

-- ----------------------------
-- Records of user_info_profile
-- ----------------------------

-- ----------------------------
-- Table structure for user_login_log
-- ----------------------------
DROP TABLE IF EXISTS `user_login_log`;
CREATE TABLE `user_login_log` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `uid` int(11) unsigned NOT NULL COMMENT '用户id',
  `ip_address` varchar(32) NOT NULL COMMENT '用户登录ip地址',
  `create_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  `ip_country` varchar(45) NOT NULL DEFAULT '',
  `ip_city` varchar(45) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `idx_create_date` (`create_date`) USING BTREE,
  KEY `idx_ip_address` (`ip_address`),
  KEY `idx_uid_create` (`uid`,`create_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of user_login_log
-- ----------------------------

-- ----------------------------
-- Table structure for user_message
-- ----------------------------
DROP TABLE IF EXISTS `user_message`;
CREATE TABLE `user_message` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `uid` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '用户id',
  `category` enum('SECURITY','ASSETS','SYSTEM','C2C') DEFAULT NULL COMMENT 'SECURITY:安全信息，ASSETS:资产信息，SYSTEM：系统消息',
  `content` text COMMENT '消息内容',
  `create_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `status` enum('UNREAD','READ') DEFAULT NULL COMMENT 'UNREAD:未读，READ:已读',
  PRIMARY KEY (`id`),
  KEY `category` (`category`),
  KEY `status` (`status`),
  KEY `uid` (`uid`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='站内信：给用户推送的各种消息';

-- ----------------------------
-- Records of user_message
-- ----------------------------

-- ----------------------------
-- Table structure for user_pay_password
-- ----------------------------
DROP TABLE IF EXISTS `user_pay_password`;
CREATE TABLE `user_pay_password` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增id',
  `uid` int(11) NOT NULL COMMENT '用户id',
  `lock_num` int(11) NOT NULL COMMENT '锁定次数',
  `create_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_uid` (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='支付密码上锁表：支付密码上锁表（支付密码错误次数记录，以及限制）';

-- ----------------------------
-- Records of user_pay_password
-- ----------------------------

-- ----------------------------
-- Table structure for user_pre_registration_pool
-- ----------------------------
DROP TABLE IF EXISTS `user_pre_registration_pool`;
CREATE TABLE `user_pre_registration_pool` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `invite_uid` int(11) unsigned DEFAULT '0' COMMENT '邀请人',
  `broker_id` int(11) unsigned NOT NULL COMMENT '用户所属券商id',
  `nickname` varchar(64) DEFAULT NULL COMMENT '昵称',
  `mobile` varchar(16) DEFAULT NULL COMMENT '手机',
  `email` varchar(64) DEFAULT NULL COMMENT '邮箱',
  `login_salt` varchar(100) NOT NULL COMMENT '登录盐码',
  `login_password` varchar(200) NOT NULL COMMENT '密码',
  `pay_salt` varchar(100) NOT NULL DEFAULT '' COMMENT '支付盐码',
  `pay_password` varchar(200) NOT NULL DEFAULT '' COMMENT '交易密码',
  `lock_num` tinyint(4) NOT NULL DEFAULT '0' COMMENT '锁定次数',
  `role` enum('user','admin','admin_read') DEFAULT 'user' COMMENT '角色',
  `fullname` varchar(128) NOT NULL DEFAULT '' COMMENT '姓名',
  `create_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='用户';

-- ----------------------------
-- Records of user_pre_registration_pool
-- ----------------------------

-- ----------------------------
-- Table structure for user_residence
-- ----------------------------
DROP TABLE IF EXISTS `user_residence`;
CREATE TABLE `user_residence` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `uid` int(11) unsigned NOT NULL COMMENT '用户id',
  `country_id` varchar(32) NOT NULL COMMENT '证件国家编号',
  `country` varchar(128) NOT NULL COMMENT '证件国家',
  `city` varchar(128) NOT NULL COMMENT '居住城市',
  `address` varchar(256) NOT NULL COMMENT '居住详细地址',
  `postcode` varchar(32) NOT NULL COMMENT '邮编',
  `residence_photo` varchar(512) NOT NULL COMMENT '居住证明照片，照片的md5，从mongodb中获取，用json数组支持多张照片？',
  `residence_translate` varchar(512) NOT NULL COMMENT '居住证明翻译照片，照片的md5，从mongodb中获取，用json数组支持多张照片？',
  `status` enum('INIT','FINISH') NOT NULL COMMENT '处理状态：INIT初始，FINISH完成',
  `audit_uid` int(11) NOT NULL DEFAULT '0' COMMENT '审核人员',
  `audit_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '审核时间',
  `audit_status` enum('INIT','OK','FAIL') NOT NULL COMMENT '审核状态：INIT初始, OK通过，FAIL没有通过',
  `audit_first` enum('YES','NO') NOT NULL COMMENT '是否首次认证',
  `audit_message_id` varchar(32) NOT NULL DEFAULT '' COMMENT '消息id',
  `audit_message` varchar(256) NOT NULL DEFAULT '' COMMENT '审核消息',
  `create_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `full_name` varchar(128) NOT NULL COMMENT '用户全称',
  `paper_type` tinyint(4) unsigned zerofill NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_uid` (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='用户居住认证';

-- ----------------------------
-- Records of user_residence
-- ----------------------------

-- ----------------------------
-- Table structure for user_transaction_fee_white_list
-- ----------------------------
DROP TABLE IF EXISTS `user_transaction_fee_white_list`;
CREATE TABLE `user_transaction_fee_white_list` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `uid` int(11) NOT NULL,
  `create_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `update_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `admin_id` int(11) DEFAULT NULL,
  `flag` enum('VALID','INVALID') DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uid` (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of user_transaction_fee_white_list
-- ----------------------------

-- ----------------------------
-- Table structure for user_upload_resource_log
-- ----------------------------
DROP TABLE IF EXISTS `user_upload_resource_log`;
CREATE TABLE `user_upload_resource_log` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `uid` int(11) unsigned NOT NULL COMMENT '用户id',
  `tag` varchar(40) NOT NULL COMMENT '图片hashcode',
  `dataType` varchar(64) NOT NULL COMMENT 'tag类型',
  `soucre` varchar(64) DEFAULT NULL COMMENT '下载来源',
  `storeType` varchar(64) DEFAULT NULL COMMENT '存储类型',
  `createTime` datetime(6) DEFAULT NULL COMMENT '创建时间',
  `updateTime` datetime(6) DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `tag` (`tag`,`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='用户配置信息表';

-- ----------------------------
-- Records of user_upload_resource_log
-- ----------------------------

-- ----------------------------
-- Table structure for withdraw_address
-- ----------------------------
DROP TABLE IF EXISTS `withdraw_address`;
CREATE TABLE `withdraw_address` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `asset_code` varchar(40) NOT NULL DEFAULT '' COMMENT '币种',
  `coin_address` varchar(70) NOT NULL DEFAULT '' COMMENT '券商提现地址',
  `create_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of withdraw_address
-- ----------------------------
