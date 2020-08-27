-- --------------------------------------------------------
-- 主机:                           127.0.0.1
-- 服务器版本:                        10.3.7-MariaDB - mariadb.org binary distribution
-- 服务器操作系统:                      Win64
-- HeidiSQL 版本:                  9.4.0.5125
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;


-- 导出 rbac 的数据库结构
CREATE DATABASE IF NOT EXISTS `rbac` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `rbac`;

-- 导出  表 rbac.app_permission 结构
DROP TABLE IF EXISTS `app_permission`;
CREATE TABLE IF NOT EXISTS `app_permission` (
  `permission_id` int(11) NOT NULL AUTO_INCREMENT,
  `pid` bigint(20) NOT NULL,
  `permission_name` varchar(64) NOT NULL,
  `permission_dec` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`permission_id`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8;

-- 正在导出表  rbac.app_permission 的数据：~15 rows (大约)
/*!40000 ALTER TABLE `app_permission` DISABLE KEYS */;
REPLACE INTO `app_permission` (`permission_id`, `pid`, `permission_name`, `permission_dec`) VALUES
	(1, 0, '系统管理', NULL),
	(2, 1, '用户管理', NULL),
	(3, 2, '查看用户', NULL),
	(4, 2, '删除用户', NULL),
	(5, 2, '编辑用户', NULL),
	(6, 2, '新增用户', NULL),
	(8, 1, '角色管理', 'undefined'),
	(14, 8, '查看角色', '查看角色'),
	(15, 8, '编辑角色', '编辑角色'),
	(16, 8, '新增角色', '新增角色'),
	(17, 8, '删除角色', '删除角色'),
	(18, 1, '权限管理', '权限管理'),
	(19, 18, '添加权限', '添加权限'),
	(20, 18, '查看权限', '查看权限'),
	(22, 18, '删除权限', '删除权限');
/*!40000 ALTER TABLE `app_permission` ENABLE KEYS */;

-- 导出  表 rbac.app_role 结构
DROP TABLE IF EXISTS `app_role`;
CREATE TABLE IF NOT EXISTS `app_role` (
  `role_id` int(11) NOT NULL AUTO_INCREMENT,
  `pid` bigint(20) NOT NULL,
  `role_name` varchar(64) NOT NULL,
  `create_time` timestamp NOT NULL DEFAULT current_timestamp(),
  `role_dec` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`role_id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8;

-- 正在导出表  rbac.app_role 的数据：~3 rows (大约)
/*!40000 ALTER TABLE `app_role` DISABLE KEYS */;
REPLACE INTO `app_role` (`role_id`, `pid`, `role_name`, `create_time`, `role_dec`) VALUES
	(1, 0, '管理员', '2020-08-04 00:00:00', '管理员'),
	(2, 1, '普通用户', '2020-08-04 00:00:00', '普通用户'),
	(3, 2, '访客', '2020-08-04 00:00:00', '访客');
/*!40000 ALTER TABLE `app_role` ENABLE KEYS */;

-- 导出  表 rbac.app_role_permission 结构
DROP TABLE IF EXISTS `app_role_permission`;
CREATE TABLE IF NOT EXISTS `app_role_permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `permission_type` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=83 DEFAULT CHARSET=utf8;

-- 正在导出表  rbac.app_role_permission 的数据：~36 rows (大约)
/*!40000 ALTER TABLE `app_role_permission` DISABLE KEYS */;
REPLACE INTO `app_role_permission` (`id`, `permission_type`) VALUES
	(12, 0),
	(13, 0),
	(14, 0),
	(15, 0),
	(16, 0),
	(17, 0),
	(18, 0),
	(19, 0),
	(20, 0),
	(21, 0),
	(22, 0),
	(49, 0),
	(50, 0),
	(51, 0),
	(52, 0),
	(53, 0),
	(54, 0),
	(55, 0),
	(56, 0),
	(57, 0),
	(58, 0),
	(59, 0),
	(60, 0),
	(61, 0),
	(62, 0),
	(63, 0),
	(64, 0),
	(74, 0),
	(75, 0),
	(76, 0),
	(77, 0),
	(78, 0),
	(79, 0),
	(80, 0),
	(81, 0),
	(82, 0);
/*!40000 ALTER TABLE `app_role_permission` ENABLE KEYS */;

-- 导出  表 rbac.app_role_permission_permission_id 结构
DROP TABLE IF EXISTS `app_role_permission_permission_id`;
CREATE TABLE IF NOT EXISTS `app_role_permission_permission_id` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `role_permission_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `app_role_permission_perm_role_permission_id_permi_a5e0b1fe_uniq` (`role_permission_id`,`permission_id`),
  KEY `app_role_permission__permission_id_4c12a7f5_fk_app_permi` (`permission_id`),
  CONSTRAINT `app_role_permission__permission_id_4c12a7f5_fk_app_permi` FOREIGN KEY (`permission_id`) REFERENCES `app_permission` (`permission_id`),
  CONSTRAINT `app_role_permission__role_permission_id_b7295feb_fk_app_role_` FOREIGN KEY (`role_permission_id`) REFERENCES `app_role_permission` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=75 DEFAULT CHARSET=utf8;

-- 正在导出表  rbac.app_role_permission_permission_id 的数据：~35 rows (大约)
/*!40000 ALTER TABLE `app_role_permission_permission_id` DISABLE KEYS */;
REPLACE INTO `app_role_permission_permission_id` (`id`, `role_permission_id`, `permission_id`) VALUES
	(4, 12, 3),
	(5, 13, 4),
	(6, 14, 6),
	(7, 15, 4),
	(8, 16, 4),
	(9, 17, 4),
	(10, 18, 5),
	(11, 19, 5),
	(12, 20, 6),
	(13, 21, 5),
	(14, 22, 6),
	(41, 49, 1),
	(42, 50, 2),
	(43, 51, 3),
	(44, 52, 4),
	(45, 53, 5),
	(46, 54, 6),
	(47, 55, 8),
	(48, 56, 14),
	(49, 57, 15),
	(50, 58, 16),
	(51, 59, 17),
	(52, 60, 18),
	(53, 61, 19),
	(54, 62, 20),
	(56, 64, 22),
	(66, 74, 3),
	(67, 75, 14),
	(68, 76, 2),
	(69, 77, 3),
	(70, 78, 4),
	(71, 79, 5),
	(72, 80, 6),
	(73, 81, 14),
	(74, 82, 20);
/*!40000 ALTER TABLE `app_role_permission_permission_id` ENABLE KEYS */;

-- 导出  表 rbac.app_role_permission_role_id 结构
DROP TABLE IF EXISTS `app_role_permission_role_id`;
CREATE TABLE IF NOT EXISTS `app_role_permission_role_id` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `role_permission_id` int(11) NOT NULL,
  `role_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `app_role_permission_role_role_permission_id_role__48b22b69_uniq` (`role_permission_id`,`role_id`),
  KEY `app_role_permission_role_id_role_id_96d82e2a_fk_app_role_role_id` (`role_id`),
  CONSTRAINT `app_role_permission__role_permission_id_b2f7fca8_fk_app_role_` FOREIGN KEY (`role_permission_id`) REFERENCES `app_role_permission` (`id`),
  CONSTRAINT `app_role_permission_role_id_role_id_96d82e2a_fk_app_role_role_id` FOREIGN KEY (`role_id`) REFERENCES `app_role` (`role_id`)
) ENGINE=InnoDB AUTO_INCREMENT=81 DEFAULT CHARSET=utf8;

-- 正在导出表  rbac.app_role_permission_role_id 的数据：~25 rows (大约)
/*!40000 ALTER TABLE `app_role_permission_role_id` DISABLE KEYS */;
REPLACE INTO `app_role_permission_role_id` (`id`, `role_permission_id`, `role_id`) VALUES
	(47, 49, 1),
	(48, 50, 1),
	(49, 51, 1),
	(50, 52, 1),
	(51, 53, 1),
	(52, 54, 1),
	(53, 55, 1),
	(54, 56, 1),
	(55, 57, 1),
	(56, 58, 1),
	(57, 59, 1),
	(58, 60, 1),
	(59, 61, 1),
	(60, 62, 1),
	(61, 63, 1),
	(62, 64, 1),
	(72, 74, 3),
	(73, 75, 3),
	(74, 76, 2),
	(75, 77, 2),
	(76, 78, 2),
	(77, 79, 2),
	(78, 80, 2),
	(79, 81, 2),
	(80, 82, 2);
/*!40000 ALTER TABLE `app_role_permission_role_id` ENABLE KEYS */;

-- 导出  表 rbac.app_user 结构
DROP TABLE IF EXISTS `app_user`;
CREATE TABLE IF NOT EXISTS `app_user` (
  `user_id` int(11) NOT NULL AUTO_INCREMENT,
  `account` varchar(64) NOT NULL,
  `password` varchar(200) NOT NULL,
  `user_name` varchar(64) NOT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `email` varchar(64) DEFAULT NULL,
  `create_time` timestamp NOT NULL DEFAULT current_timestamp(),
  `login_time` timestamp NULL DEFAULT NULL,
  `last_login_time` timestamp NULL DEFAULT NULL,
  `login_count` bigint(20) DEFAULT 0,
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=39 DEFAULT CHARSET=utf8;

-- 正在导出表  rbac.app_user 的数据：~11 rows (大约)
/*!40000 ALTER TABLE `app_user` DISABLE KEYS */;
REPLACE INTO `app_user` (`user_id`, `account`, `password`, `user_name`, `phone`, `email`, `create_time`, `login_time`, `last_login_time`, `login_count`) VALUES
	(28, 'admin', 'pbkdf2_sha256$180000$RqAXU1jRwybC$vbXhSy7VElVxgPlTeqRgwvJmHfcxJu8v317049LVqew=', '系统管理员', '', '', '2020-08-18 00:00:00', '2020-08-27 00:00:00', NULL, 11),
	(29, 'superadmin', 'pbkdf2_sha256$180000$RqAXU1jRwybC$vbXhSy7VElVxgPlTeqRgwvJmHfcxJu8v317049LVqew=', '超级管理员', '', '', '2020-08-19 16:25:05', NULL, NULL, 0),
	(30, 'visitor', 'pbkdf2_sha256$180000$5eExDyyR17OT$XD4Pq1t3o3nnrjT8YPLuEV5VybTn+HVJoJVtANqwcd4=', '访客', '', '', '2020-08-19 16:32:35', NULL, NULL, 0),
	(31, 'zhangjing', 'pbkdf2_sha256$180000$y02PfLGiPPFm$RSjO78y7qI7HNp8Oxf02Baf1uCzmLDwa/ylmsmyeSlg=', 'zhangjing', '13888888888', 'test@163.com', '2020-08-19 00:00:00', '2020-08-27 00:00:00', NULL, 1),
	(32, 'test1', 'pbkdf2_sha256$180000$LBwxggA1igul$Skh114JpfC7vITIciejFPtjJKaEBrGLrjiyGrV5vepY=', '测试1', '13688888888', 'test@qq.com', '2020-08-19 00:00:00', '2020-08-27 00:00:00', NULL, 3),
	(33, 'test2', 'pbkdf2_sha256$180000$3britnoKc7vo$+oqHsMTCKYgX09bRLPbq0by7dFIwehop7vQ2hTIai/o=', '测试2', '13935555555', 'test@qq.com', '2020-08-19 17:16:24', NULL, NULL, 0),
	(34, 'test3', 'pbkdf2_sha256$180000$MHW19dB5NuAr$5Vq+rXCCwNIZnPHUHoo7x/j7AWBPng/JGYpZ1HGwIwQ=', '测试3', '13642558978', 'test2@qq.com', '2020-08-26 15:33:03', NULL, NULL, 0),
	(35, 'test4', 'pbkdf2_sha256$180000$VAxoXkc1OU58$6dF8j69bQCZTIswH8avRxHTgIfvXcGHIUFrGfnNwLrI=', '测试4', '13789890098', 'test4@qq.com', '2020-08-26 15:33:33', NULL, NULL, 0),
	(36, 'test5', 'pbkdf2_sha256$180000$5lkCNpAKI9CQ$0RplSou++6lRjrJ8AUdsZy6QR7NFFjgLgSiO8L69OlY=', '测试5', '', '', '2020-08-26 15:34:00', NULL, NULL, 0),
	(37, 'test6', 'pbkdf2_sha256$180000$TNdVgSbgJrX7$PIjljTS+L1xxA1+abMDEQys6yblviVrwVZ08x5gd+44=', '测试6', '', '', '2020-08-26 15:34:10', NULL, NULL, 0),
	(38, 'test7', 'pbkdf2_sha256$180000$nNaohLvnYmM9$+3FYSFdBk7sxC/7PakJdDGRVMW1TSIDrwu7Cz/qKXlA=', '测试7', '', '', '2020-08-26 15:34:25', NULL, NULL, 0);
/*!40000 ALTER TABLE `app_user` ENABLE KEYS */;

-- 导出  表 rbac.app_user_permission 结构
DROP TABLE IF EXISTS `app_user_permission`;
CREATE TABLE IF NOT EXISTS `app_user_permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `permission_type` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 正在导出表  rbac.app_user_permission 的数据：~0 rows (大约)
/*!40000 ALTER TABLE `app_user_permission` DISABLE KEYS */;
/*!40000 ALTER TABLE `app_user_permission` ENABLE KEYS */;

-- 导出  表 rbac.app_user_permission_permission_id 结构
DROP TABLE IF EXISTS `app_user_permission_permission_id`;
CREATE TABLE IF NOT EXISTS `app_user_permission_permission_id` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_permission_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `app_user_permission_perm_user_permission_id_permi_ee1e65a8_uniq` (`user_permission_id`,`permission_id`),
  KEY `app_user_permission__permission_id_2a70efce_fk_app_permi` (`permission_id`),
  CONSTRAINT `app_user_permission__permission_id_2a70efce_fk_app_permi` FOREIGN KEY (`permission_id`) REFERENCES `app_permission` (`permission_id`),
  CONSTRAINT `app_user_permission__user_permission_id_b0e47037_fk_app_user_` FOREIGN KEY (`user_permission_id`) REFERENCES `app_user_permission` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 正在导出表  rbac.app_user_permission_permission_id 的数据：~0 rows (大约)
/*!40000 ALTER TABLE `app_user_permission_permission_id` DISABLE KEYS */;
/*!40000 ALTER TABLE `app_user_permission_permission_id` ENABLE KEYS */;

-- 导出  表 rbac.app_user_permission_user_id 结构
DROP TABLE IF EXISTS `app_user_permission_user_id`;
CREATE TABLE IF NOT EXISTS `app_user_permission_user_id` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_permission_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `app_user_permission_user_user_permission_id_user__80f9e8a8_uniq` (`user_permission_id`,`user_id`),
  KEY `app_user_permission_user_id_user_id_a96b6f11_fk_app_user_user_id` (`user_id`),
  CONSTRAINT `app_user_permission__user_permission_id_4c349eb7_fk_app_user_` FOREIGN KEY (`user_permission_id`) REFERENCES `app_user_permission` (`id`),
  CONSTRAINT `app_user_permission_user_id_user_id_a96b6f11_fk_app_user_user_id` FOREIGN KEY (`user_id`) REFERENCES `app_user` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 正在导出表  rbac.app_user_permission_user_id 的数据：~0 rows (大约)
/*!40000 ALTER TABLE `app_user_permission_user_id` DISABLE KEYS */;
/*!40000 ALTER TABLE `app_user_permission_user_id` ENABLE KEYS */;

-- 导出  表 rbac.app_user_role 结构
DROP TABLE IF EXISTS `app_user_role`;
CREATE TABLE IF NOT EXISTS `app_user_role` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=69 DEFAULT CHARSET=utf8;

-- 正在导出表  rbac.app_user_role 的数据：~11 rows (大约)
/*!40000 ALTER TABLE `app_user_role` DISABLE KEYS */;
REPLACE INTO `app_user_role` (`id`) VALUES
	(58),
	(59),
	(60),
	(61),
	(62),
	(63),
	(64),
	(65),
	(66),
	(67),
	(68);
/*!40000 ALTER TABLE `app_user_role` ENABLE KEYS */;

-- 导出  表 rbac.app_user_role_role_id 结构
DROP TABLE IF EXISTS `app_user_role_role_id`;
CREATE TABLE IF NOT EXISTS `app_user_role_role_id` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_role_id` int(11) NOT NULL,
  `role_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `app_user_role_role_id_user_role_id_role_id_894e8a58_uniq` (`user_role_id`,`role_id`),
  KEY `app_user_role_role_id_role_id_9aab69ea_fk_app_role_role_id` (`role_id`),
  CONSTRAINT `app_user_role_role_id_role_id_9aab69ea_fk_app_role_role_id` FOREIGN KEY (`role_id`) REFERENCES `app_role` (`role_id`),
  CONSTRAINT `app_user_role_role_id_user_role_id_18d69f1a_fk_app_user_role_id` FOREIGN KEY (`user_role_id`) REFERENCES `app_user_role` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=64 DEFAULT CHARSET=utf8;

-- 正在导出表  rbac.app_user_role_role_id 的数据：~11 rows (大约)
/*!40000 ALTER TABLE `app_user_role_role_id` DISABLE KEYS */;
REPLACE INTO `app_user_role_role_id` (`id`, `user_role_id`, `role_id`) VALUES
	(53, 58, 1),
	(54, 59, 1),
	(55, 60, 3),
	(56, 61, 2),
	(57, 62, 2),
	(58, 63, 2),
	(59, 64, 2),
	(60, 65, 3),
	(61, 66, 3),
	(62, 67, 3),
	(63, 68, 3);
/*!40000 ALTER TABLE `app_user_role_role_id` ENABLE KEYS */;

-- 导出  表 rbac.app_user_role_user_id 结构
DROP TABLE IF EXISTS `app_user_role_user_id`;
CREATE TABLE IF NOT EXISTS `app_user_role_user_id` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_role_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `app_user_role_user_id_user_role_id_user_id_5d4277ad_uniq` (`user_role_id`,`user_id`),
  KEY `app_user_role_user_id_user_id_2c584059_fk_app_user_user_id` (`user_id`),
  CONSTRAINT `app_user_role_user_id_user_id_2c584059_fk_app_user_user_id` FOREIGN KEY (`user_id`) REFERENCES `app_user` (`user_id`),
  CONSTRAINT `app_user_role_user_id_user_role_id_37d65e49_fk_app_user_role_id` FOREIGN KEY (`user_role_id`) REFERENCES `app_user_role` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=69 DEFAULT CHARSET=utf8;

-- 正在导出表  rbac.app_user_role_user_id 的数据：~11 rows (大约)
/*!40000 ALTER TABLE `app_user_role_user_id` DISABLE KEYS */;
REPLACE INTO `app_user_role_user_id` (`id`, `user_role_id`, `user_id`) VALUES
	(58, 58, 29),
	(59, 59, 28),
	(60, 60, 30),
	(61, 61, 31),
	(62, 62, 32),
	(63, 63, 33),
	(64, 64, 34),
	(65, 65, 35),
	(66, 66, 36),
	(67, 67, 37),
	(68, 68, 38);
/*!40000 ALTER TABLE `app_user_role_user_id` ENABLE KEYS */;

-- 导出  表 rbac.auth_group 结构
DROP TABLE IF EXISTS `auth_group`;
CREATE TABLE IF NOT EXISTS `auth_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(150) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 正在导出表  rbac.auth_group 的数据：~0 rows (大约)
/*!40000 ALTER TABLE `auth_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group` ENABLE KEYS */;

-- 导出  表 rbac.auth_group_permissions 结构
DROP TABLE IF EXISTS `auth_group_permissions`;
CREATE TABLE IF NOT EXISTS `auth_group_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 正在导出表  rbac.auth_group_permissions 的数据：~0 rows (大约)
/*!40000 ALTER TABLE `auth_group_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group_permissions` ENABLE KEYS */;

-- 导出  表 rbac.auth_permission 结构
DROP TABLE IF EXISTS `auth_permission`;
CREATE TABLE IF NOT EXISTS `auth_permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=53 DEFAULT CHARSET=utf8;

-- 正在导出表  rbac.auth_permission 的数据：~52 rows (大约)
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
REPLACE INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
	(1, 'Can add log entry', 1, 'add_logentry'),
	(2, 'Can change log entry', 1, 'change_logentry'),
	(3, 'Can delete log entry', 1, 'delete_logentry'),
	(4, 'Can view log entry', 1, 'view_logentry'),
	(5, 'Can add permission', 2, 'add_permission'),
	(6, 'Can change permission', 2, 'change_permission'),
	(7, 'Can delete permission', 2, 'delete_permission'),
	(8, 'Can view permission', 2, 'view_permission'),
	(9, 'Can add group', 3, 'add_group'),
	(10, 'Can change group', 3, 'change_group'),
	(11, 'Can delete group', 3, 'delete_group'),
	(12, 'Can view group', 3, 'view_group'),
	(13, 'Can add user', 4, 'add_user'),
	(14, 'Can change user', 4, 'change_user'),
	(15, 'Can delete user', 4, 'delete_user'),
	(16, 'Can view user', 4, 'view_user'),
	(17, 'Can add content type', 5, 'add_contenttype'),
	(18, 'Can change content type', 5, 'change_contenttype'),
	(19, 'Can delete content type', 5, 'delete_contenttype'),
	(20, 'Can view content type', 5, 'view_contenttype'),
	(21, 'Can add session', 6, 'add_session'),
	(22, 'Can change session', 6, 'change_session'),
	(23, 'Can delete session', 6, 'delete_session'),
	(24, 'Can view session', 6, 'view_session'),
	(25, 'Can add test', 7, 'add_test'),
	(26, 'Can change test', 7, 'change_test'),
	(27, 'Can delete test', 7, 'delete_test'),
	(28, 'Can view test', 7, 'view_test'),
	(29, 'Can add permission', 8, 'add_permission'),
	(30, 'Can change permission', 8, 'change_permission'),
	(31, 'Can delete permission', 8, 'delete_permission'),
	(32, 'Can view permission', 8, 'view_permission'),
	(33, 'Can add role', 9, 'add_role'),
	(34, 'Can change role', 9, 'change_role'),
	(35, 'Can delete role', 9, 'delete_role'),
	(36, 'Can view role', 9, 'view_role'),
	(37, 'Can add user', 10, 'add_user'),
	(38, 'Can change user', 10, 'change_user'),
	(39, 'Can delete user', 10, 'delete_user'),
	(40, 'Can view user', 10, 'view_user'),
	(41, 'Can add user_role', 11, 'add_user_role'),
	(42, 'Can change user_role', 11, 'change_user_role'),
	(43, 'Can delete user_role', 11, 'delete_user_role'),
	(44, 'Can view user_role', 11, 'view_user_role'),
	(45, 'Can add user_permission', 12, 'add_user_permission'),
	(46, 'Can change user_permission', 12, 'change_user_permission'),
	(47, 'Can delete user_permission', 12, 'delete_user_permission'),
	(48, 'Can view user_permission', 12, 'view_user_permission'),
	(49, 'Can add role_permission', 13, 'add_role_permission'),
	(50, 'Can change role_permission', 13, 'change_role_permission'),
	(51, 'Can delete role_permission', 13, 'delete_role_permission'),
	(52, 'Can view role_permission', 13, 'view_role_permission');
/*!40000 ALTER TABLE `auth_permission` ENABLE KEYS */;

-- 导出  表 rbac.auth_user 结构
DROP TABLE IF EXISTS `auth_user`;
CREATE TABLE IF NOT EXISTS `auth_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(30) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 正在导出表  rbac.auth_user 的数据：~0 rows (大约)
/*!40000 ALTER TABLE `auth_user` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user` ENABLE KEYS */;

-- 导出  表 rbac.auth_user_groups 结构
DROP TABLE IF EXISTS `auth_user_groups`;
CREATE TABLE IF NOT EXISTS `auth_user_groups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_groups_user_id_group_id_94350c0c_uniq` (`user_id`,`group_id`),
  KEY `auth_user_groups_group_id_97559544_fk_auth_group_id` (`group_id`),
  CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 正在导出表  rbac.auth_user_groups 的数据：~0 rows (大约)
/*!40000 ALTER TABLE `auth_user_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_groups` ENABLE KEYS */;

-- 导出  表 rbac.auth_user_user_permissions 结构
DROP TABLE IF EXISTS `auth_user_user_permissions`;
CREATE TABLE IF NOT EXISTS `auth_user_user_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq` (`user_id`,`permission_id`),
  KEY `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 正在导出表  rbac.auth_user_user_permissions 的数据：~0 rows (大约)
/*!40000 ALTER TABLE `auth_user_user_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_user_permissions` ENABLE KEYS */;

-- 导出  表 rbac.django_admin_log 结构
DROP TABLE IF EXISTS `django_admin_log`;
CREATE TABLE IF NOT EXISTS `django_admin_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext DEFAULT NULL,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint(5) unsigned NOT NULL,
  `change_message` longtext NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6_fk_auth_user_id` (`user_id`),
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 正在导出表  rbac.django_admin_log 的数据：~0 rows (大约)
/*!40000 ALTER TABLE `django_admin_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `django_admin_log` ENABLE KEYS */;

-- 导出  表 rbac.django_content_type 结构
DROP TABLE IF EXISTS `django_content_type`;
CREATE TABLE IF NOT EXISTS `django_content_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;

-- 正在导出表  rbac.django_content_type 的数据：~13 rows (大约)
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
REPLACE INTO `django_content_type` (`id`, `app_label`, `model`) VALUES
	(1, 'admin', 'logentry'),
	(8, 'app', 'permission'),
	(9, 'app', 'role'),
	(13, 'app', 'role_permission'),
	(7, 'app', 'test'),
	(10, 'app', 'user'),
	(12, 'app', 'user_permission'),
	(11, 'app', 'user_role'),
	(3, 'auth', 'group'),
	(2, 'auth', 'permission'),
	(4, 'auth', 'user'),
	(5, 'contenttypes', 'contenttype'),
	(6, 'sessions', 'session');
/*!40000 ALTER TABLE `django_content_type` ENABLE KEYS */;

-- 导出  表 rbac.django_migrations 结构
DROP TABLE IF EXISTS `django_migrations`;
CREATE TABLE IF NOT EXISTS `django_migrations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8;

-- 正在导出表  rbac.django_migrations 的数据：~18 rows (大约)
/*!40000 ALTER TABLE `django_migrations` DISABLE KEYS */;
REPLACE INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES
	(1, 'contenttypes', '0001_initial', '2020-07-23 23:51:23.665076'),
	(2, 'auth', '0001_initial', '2020-07-23 23:51:24.283630'),
	(3, 'admin', '0001_initial', '2020-07-23 23:51:24.833053'),
	(4, 'admin', '0002_logentry_remove_auto_add', '2020-07-23 23:51:24.946415'),
	(5, 'admin', '0003_logentry_add_action_flag_choices', '2020-07-23 23:51:24.976611'),
	(7, 'contenttypes', '0002_remove_content_type_name', '2020-07-23 23:51:25.209496'),
	(8, 'auth', '0002_alter_permission_name_max_length', '2020-07-23 23:51:25.296236'),
	(9, 'auth', '0003_alter_user_email_max_length', '2020-07-23 23:51:25.383955'),
	(10, 'auth', '0004_alter_user_username_opts', '2020-07-23 23:51:25.417972'),
	(11, 'auth', '0005_alter_user_last_login_null', '2020-07-23 23:51:25.509145'),
	(12, 'auth', '0006_require_contenttypes_0002', '2020-07-23 23:51:25.537741'),
	(13, 'auth', '0007_alter_validators_add_error_messages', '2020-07-23 23:51:25.570916'),
	(14, 'auth', '0008_alter_user_username_max_length', '2020-07-23 23:51:25.663456'),
	(15, 'auth', '0009_alter_user_last_name_max_length', '2020-07-23 23:51:25.751149'),
	(16, 'auth', '0010_alter_group_name_max_length', '2020-07-23 23:51:25.833678'),
	(17, 'auth', '0011_update_proxy_permissions', '2020-07-23 23:51:25.874094'),
	(18, 'sessions', '0001_initial', '2020-07-23 23:51:25.998170'),
	(19, 'app', '0001_initial', '2020-08-04 06:17:01.564545');
/*!40000 ALTER TABLE `django_migrations` ENABLE KEYS */;

-- 导出  表 rbac.django_session 结构
DROP TABLE IF EXISTS `django_session`;
CREATE TABLE IF NOT EXISTS `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 正在导出表  rbac.django_session 的数据：~16 rows (大约)
/*!40000 ALTER TABLE `django_session` DISABLE KEYS */;
REPLACE INTO `django_session` (`session_key`, `session_data`, `expire_date`) VALUES
	('0r7vzoppmd6u8jgkzt9scs4uylccqst2', 'OGMyMTY1M2QyZDFhMmRmOTM2NjY1ZjQzNTk0ZDE5OGUwNzEzZDAwMDp7ImlzX2xvZ2luIjp0cnVlLCJsb2dpbl91c2VyIjoiemhhbmdqaW5nIn0=', '2020-08-10 08:46:38.108996'),
	('3q8j0hrhe2oneij1n8z3t6kyiij56s41', 'OGMyMTY1M2QyZDFhMmRmOTM2NjY1ZjQzNTk0ZDE5OGUwNzEzZDAwMDp7ImlzX2xvZ2luIjp0cnVlLCJsb2dpbl91c2VyIjoiemhhbmdqaW5nIn0=', '2020-08-10 06:39:01.466996'),
	('65ds1pl27q0aykd7ebe8fhj627kyxhx9', 'OWY5NGVhYjk4MDhhMWZhMTUzNjExMWZmODZmZDcxYTc0MWQ1ZmFkMjp7ImlzX2xvZ2luIjp0cnVlLCJsb2dpbl91c2VyIjoidGVzdDEifQ==', '2020-09-10 09:50:00.297996'),
	('7y235oibk1j75q2bvwxnamy3ea4afe16', 'OGMyMTY1M2QyZDFhMmRmOTM2NjY1ZjQzNTk0ZDE5OGUwNzEzZDAwMDp7ImlzX2xvZ2luIjp0cnVlLCJsb2dpbl91c2VyIjoiemhhbmdqaW5nIn0=', '2020-08-10 09:03:23.055996'),
	('9fr5q064jk4r8r7syp78thhevvsusg8j', 'OGQ4ODgzMzIwMDVhODkzZGU4NzIzNGRiZjJmY2ZhMzZkNmE5OWMwMTp7ImlzX2xvZ2luIjp0cnVlLCJsb2dpbl91c2VyIjoiYWRtaW4ifQ==', '2020-09-01 05:56:53.917996'),
	('bah5eiasnt2koveqc4kfekpxp6njyl35', 'OGMyMTY1M2QyZDFhMmRmOTM2NjY1ZjQzNTk0ZDE5OGUwNzEzZDAwMDp7ImlzX2xvZ2luIjp0cnVlLCJsb2dpbl91c2VyIjoiemhhbmdqaW5nIn0=', '2020-08-10 06:19:43.728996'),
	('e58meeh84f2g1vobhpj3iyk5jeqlmad3', 'OGMyMTY1M2QyZDFhMmRmOTM2NjY1ZjQzNTk0ZDE5OGUwNzEzZDAwMDp7ImlzX2xvZ2luIjp0cnVlLCJsb2dpbl91c2VyIjoiemhhbmdqaW5nIn0=', '2020-09-01 00:42:44.079996'),
	('fxwxyb6ryt0utzch25k7197m0drcnvmt', 'OGMyMTY1M2QyZDFhMmRmOTM2NjY1ZjQzNTk0ZDE5OGUwNzEzZDAwMDp7ImlzX2xvZ2luIjp0cnVlLCJsb2dpbl91c2VyIjoiemhhbmdqaW5nIn0=', '2020-08-10 03:14:39.028996'),
	('j54ertmitu1s1hmd1wu28ohj5uu0xk1o', 'OGMyMTY1M2QyZDFhMmRmOTM2NjY1ZjQzNTk0ZDE5OGUwNzEzZDAwMDp7ImlzX2xvZ2luIjp0cnVlLCJsb2dpbl91c2VyIjoiemhhbmdqaW5nIn0=', '2020-08-10 02:21:34.991996'),
	('m7zeeff6f8ls1pbulu7am8c652e2g1zw', 'OGMyMTY1M2QyZDFhMmRmOTM2NjY1ZjQzNTk0ZDE5OGUwNzEzZDAwMDp7ImlzX2xvZ2luIjp0cnVlLCJsb2dpbl91c2VyIjoiemhhbmdqaW5nIn0=', '2020-08-10 09:00:50.312996'),
	('oyc37ilqm7cyercg6k6m7z3dxttobokg', 'OGMyMTY1M2QyZDFhMmRmOTM2NjY1ZjQzNTk0ZDE5OGUwNzEzZDAwMDp7ImlzX2xvZ2luIjp0cnVlLCJsb2dpbl91c2VyIjoiemhhbmdqaW5nIn0=', '2020-08-24 00:35:47.116996'),
	('psdcqlpz5w8cc9xyo99e6rju7jo021xy', 'OGMyMTY1M2QyZDFhMmRmOTM2NjY1ZjQzNTk0ZDE5OGUwNzEzZDAwMDp7ImlzX2xvZ2luIjp0cnVlLCJsb2dpbl91c2VyIjoiemhhbmdqaW5nIn0=', '2020-08-10 08:51:37.608996'),
	('u23e3rak0bcbzzklywavze49uehh6wwj', 'OGMyMTY1M2QyZDFhMmRmOTM2NjY1ZjQzNTk0ZDE5OGUwNzEzZDAwMDp7ImlzX2xvZ2luIjp0cnVlLCJsb2dpbl91c2VyIjoiemhhbmdqaW5nIn0=', '2020-08-27 03:51:48.461996'),
	('uj0krv9exgw75w3dylf6sj0jiysca1cm', 'OGMyMTY1M2QyZDFhMmRmOTM2NjY1ZjQzNTk0ZDE5OGUwNzEzZDAwMDp7ImlzX2xvZ2luIjp0cnVlLCJsb2dpbl91c2VyIjoiemhhbmdqaW5nIn0=', '2020-08-24 09:03:43.647996'),
	('uv99g66x6kc1df6kdm497n4ty3sfxva1', 'OGMyMTY1M2QyZDFhMmRmOTM2NjY1ZjQzNTk0ZDE5OGUwNzEzZDAwMDp7ImlzX2xvZ2luIjp0cnVlLCJsb2dpbl91c2VyIjoiemhhbmdqaW5nIn0=', '2020-08-10 06:45:30.735996'),
	('yzbh851e6a62z0zcto32dk623wn2xyf4', 'OGMyMTY1M2QyZDFhMmRmOTM2NjY1ZjQzNTk0ZDE5OGUwNzEzZDAwMDp7ImlzX2xvZ2luIjp0cnVlLCJsb2dpbl91c2VyIjoiemhhbmdqaW5nIn0=', '2020-08-10 02:48:30.463996');
/*!40000 ALTER TABLE `django_session` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
