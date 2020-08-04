-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- 主机： 172.17.0.2:3306
-- 生成日期： 2020-08-04 13:57:33
-- 服务器版本： 5.7.31
-- PHP 版本： 7.4.6

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- 数据库： `rbac`
--

-- --------------------------------------------------------

--
-- 表的结构 `app_permission`
--

CREATE TABLE `app_permission` (
  `permission_id` int(11) NOT NULL,
  `pid` bigint(20) NOT NULL,
  `permission_name` varchar(64) NOT NULL,
  `permission_dec` varchar(200) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `app_permission`
--

INSERT INTO `app_permission` (`permission_id`, `pid`, `permission_name`, `permission_dec`) VALUES
(1, 0, '系统管理', NULL),
(2, 1, '用户管理', NULL),
(3, 2, '查看用户', NULL),
(4, 2, '删除用户', NULL),
(5, 2, '编辑用户', NULL),
(6, 2, '新增用户', NULL);

-- --------------------------------------------------------

--
-- 表的结构 `app_role`
--

CREATE TABLE `app_role` (
  `role_id` int(11) NOT NULL,
  `pid` bigint(20) NOT NULL,
  `role_name` varchar(64) NOT NULL,
  `create_time` date NOT NULL,
  `role_dec` varchar(200) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `app_role`
--

INSERT INTO `app_role` (`role_id`, `pid`, `role_name`, `create_time`, `role_dec`) VALUES
(1, 0, '管理员', '2020-08-04', NULL),
(2, 1, '用户', '2020-08-04', NULL),
(3, 2, '访客', '2020-08-04', NULL);

-- --------------------------------------------------------

--
-- 表的结构 `app_role_permission`
--

CREATE TABLE `app_role_permission` (
  `id` int(11) NOT NULL,
  `permission_type` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- 表的结构 `app_role_permission_permission_id`
--

CREATE TABLE `app_role_permission_permission_id` (
  `id` int(11) NOT NULL,
  `role_permission_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- 表的结构 `app_role_permission_role_id`
--

CREATE TABLE `app_role_permission_role_id` (
  `id` int(11) NOT NULL,
  `role_permission_id` int(11) NOT NULL,
  `role_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- 表的结构 `app_user`
--

CREATE TABLE `app_user` (
  `user_id` int(11) NOT NULL,
  `account` varchar(64) NOT NULL,
  `password` varchar(64) NOT NULL,
  `user_name` varchar(64) NOT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `email` varchar(64) DEFAULT NULL,
  `create_time` date NOT NULL,
  `login_time` date DEFAULT NULL,
  `last_login_time` date DEFAULT NULL,
  `login_count` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `app_user`
--

INSERT INTO `app_user` (`user_id`, `account`, `password`, `user_name`, `phone`, `email`, `create_time`, `login_time`, `last_login_time`, `login_count`) VALUES
(1, 'zhangjing', '123456', 'test', NULL, NULL, '2020-08-04', NULL, NULL, 0);

-- --------------------------------------------------------

--
-- 表的结构 `app_user_permission`
--

CREATE TABLE `app_user_permission` (
  `id` int(11) NOT NULL,
  `permission_type` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- 表的结构 `app_user_permission_permission_id`
--

CREATE TABLE `app_user_permission_permission_id` (
  `id` int(11) NOT NULL,
  `user_permission_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- 表的结构 `app_user_permission_user_id`
--

CREATE TABLE `app_user_permission_user_id` (
  `id` int(11) NOT NULL,
  `user_permission_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- 表的结构 `app_user_role`
--

CREATE TABLE `app_user_role` (
  `id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- 表的结构 `app_user_role_role_id`
--

CREATE TABLE `app_user_role_role_id` (
  `id` int(11) NOT NULL,
  `user_role_id` int(11) NOT NULL,
  `role_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- 表的结构 `app_user_role_user_id`
--

CREATE TABLE `app_user_role_user_id` (
  `id` int(11) NOT NULL,
  `user_role_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- 表的结构 `auth_group`
--

CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL,
  `name` varchar(150) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- 表的结构 `auth_group_permissions`
--

CREATE TABLE `auth_group_permissions` (
  `id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- 表的结构 `auth_permission`
--

CREATE TABLE `auth_permission` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `auth_permission`
--

INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
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

-- --------------------------------------------------------

--
-- 表的结构 `auth_user`
--

CREATE TABLE `auth_user` (
  `id` int(11) NOT NULL,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(30) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- 表的结构 `auth_user_groups`
--

CREATE TABLE `auth_user_groups` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- 表的结构 `auth_user_user_permissions`
--

CREATE TABLE `auth_user_user_permissions` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- 表的结构 `django_admin_log`
--

CREATE TABLE `django_admin_log` (
  `id` int(11) NOT NULL,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint(5) UNSIGNED NOT NULL,
  `change_message` longtext NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `user_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- 表的结构 `django_content_type`
--

CREATE TABLE `django_content_type` (
  `id` int(11) NOT NULL,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `django_content_type`
--

INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES
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

-- --------------------------------------------------------

--
-- 表的结构 `django_migrations`
--

CREATE TABLE `django_migrations` (
  `id` int(11) NOT NULL,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `django_migrations`
--

INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES
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

-- --------------------------------------------------------

--
-- 表的结构 `django_session`
--

CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- 转储表的索引
--

--
-- 表的索引 `app_permission`
--
ALTER TABLE `app_permission`
  ADD PRIMARY KEY (`permission_id`);

--
-- 表的索引 `app_role`
--
ALTER TABLE `app_role`
  ADD PRIMARY KEY (`role_id`);

--
-- 表的索引 `app_role_permission`
--
ALTER TABLE `app_role_permission`
  ADD PRIMARY KEY (`id`);

--
-- 表的索引 `app_role_permission_permission_id`
--
ALTER TABLE `app_role_permission_permission_id`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `app_role_permission_perm_role_permission_id_permi_a5e0b1fe_uniq` (`role_permission_id`,`permission_id`),
  ADD KEY `app_role_permission__permission_id_4c12a7f5_fk_app_permi` (`permission_id`);

--
-- 表的索引 `app_role_permission_role_id`
--
ALTER TABLE `app_role_permission_role_id`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `app_role_permission_role_role_permission_id_role__48b22b69_uniq` (`role_permission_id`,`role_id`),
  ADD KEY `app_role_permission_role_id_role_id_96d82e2a_fk_app_role_role_id` (`role_id`);

--
-- 表的索引 `app_user`
--
ALTER TABLE `app_user`
  ADD PRIMARY KEY (`user_id`);

--
-- 表的索引 `app_user_permission`
--
ALTER TABLE `app_user_permission`
  ADD PRIMARY KEY (`id`);

--
-- 表的索引 `app_user_permission_permission_id`
--
ALTER TABLE `app_user_permission_permission_id`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `app_user_permission_perm_user_permission_id_permi_ee1e65a8_uniq` (`user_permission_id`,`permission_id`),
  ADD KEY `app_user_permission__permission_id_2a70efce_fk_app_permi` (`permission_id`);

--
-- 表的索引 `app_user_permission_user_id`
--
ALTER TABLE `app_user_permission_user_id`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `app_user_permission_user_user_permission_id_user__80f9e8a8_uniq` (`user_permission_id`,`user_id`),
  ADD KEY `app_user_permission_user_id_user_id_a96b6f11_fk_app_user_user_id` (`user_id`);

--
-- 表的索引 `app_user_role`
--
ALTER TABLE `app_user_role`
  ADD PRIMARY KEY (`id`);

--
-- 表的索引 `app_user_role_role_id`
--
ALTER TABLE `app_user_role_role_id`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `app_user_role_role_id_user_role_id_role_id_894e8a58_uniq` (`user_role_id`,`role_id`),
  ADD KEY `app_user_role_role_id_role_id_9aab69ea_fk_app_role_role_id` (`role_id`);

--
-- 表的索引 `app_user_role_user_id`
--
ALTER TABLE `app_user_role_user_id`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `app_user_role_user_id_user_role_id_user_id_5d4277ad_uniq` (`user_role_id`,`user_id`),
  ADD KEY `app_user_role_user_id_user_id_2c584059_fk_app_user_user_id` (`user_id`);

--
-- 表的索引 `auth_group`
--
ALTER TABLE `auth_group`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- 表的索引 `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  ADD KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`);

--
-- 表的索引 `auth_permission`
--
ALTER TABLE `auth_permission`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`);

--
-- 表的索引 `auth_user`
--
ALTER TABLE `auth_user`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`);

--
-- 表的索引 `auth_user_groups`
--
ALTER TABLE `auth_user_groups`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_user_groups_user_id_group_id_94350c0c_uniq` (`user_id`,`group_id`),
  ADD KEY `auth_user_groups_group_id_97559544_fk_auth_group_id` (`group_id`);

--
-- 表的索引 `auth_user_user_permissions`
--
ALTER TABLE `auth_user_user_permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq` (`user_id`,`permission_id`),
  ADD KEY `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` (`permission_id`);

--
-- 表的索引 `django_admin_log`
--
ALTER TABLE `django_admin_log`
  ADD PRIMARY KEY (`id`),
  ADD KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  ADD KEY `django_admin_log_user_id_c564eba6_fk_auth_user_id` (`user_id`);

--
-- 表的索引 `django_content_type`
--
ALTER TABLE `django_content_type`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`);

--
-- 表的索引 `django_migrations`
--
ALTER TABLE `django_migrations`
  ADD PRIMARY KEY (`id`);

--
-- 表的索引 `django_session`
--
ALTER TABLE `django_session`
  ADD PRIMARY KEY (`session_key`),
  ADD KEY `django_session_expire_date_a5c62663` (`expire_date`);

--
-- 在导出的表使用AUTO_INCREMENT
--

--
-- 使用表AUTO_INCREMENT `app_permission`
--
ALTER TABLE `app_permission`
  MODIFY `permission_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- 使用表AUTO_INCREMENT `app_role`
--
ALTER TABLE `app_role`
  MODIFY `role_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- 使用表AUTO_INCREMENT `app_role_permission`
--
ALTER TABLE `app_role_permission`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- 使用表AUTO_INCREMENT `app_role_permission_permission_id`
--
ALTER TABLE `app_role_permission_permission_id`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- 使用表AUTO_INCREMENT `app_role_permission_role_id`
--
ALTER TABLE `app_role_permission_role_id`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- 使用表AUTO_INCREMENT `app_user`
--
ALTER TABLE `app_user`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- 使用表AUTO_INCREMENT `app_user_permission`
--
ALTER TABLE `app_user_permission`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- 使用表AUTO_INCREMENT `app_user_permission_permission_id`
--
ALTER TABLE `app_user_permission_permission_id`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- 使用表AUTO_INCREMENT `app_user_permission_user_id`
--
ALTER TABLE `app_user_permission_user_id`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- 使用表AUTO_INCREMENT `app_user_role`
--
ALTER TABLE `app_user_role`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- 使用表AUTO_INCREMENT `app_user_role_role_id`
--
ALTER TABLE `app_user_role_role_id`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- 使用表AUTO_INCREMENT `app_user_role_user_id`
--
ALTER TABLE `app_user_role_user_id`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- 使用表AUTO_INCREMENT `auth_group`
--
ALTER TABLE `auth_group`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- 使用表AUTO_INCREMENT `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- 使用表AUTO_INCREMENT `auth_permission`
--
ALTER TABLE `auth_permission`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=53;

--
-- 使用表AUTO_INCREMENT `auth_user`
--
ALTER TABLE `auth_user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- 使用表AUTO_INCREMENT `auth_user_groups`
--
ALTER TABLE `auth_user_groups`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- 使用表AUTO_INCREMENT `auth_user_user_permissions`
--
ALTER TABLE `auth_user_user_permissions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- 使用表AUTO_INCREMENT `django_admin_log`
--
ALTER TABLE `django_admin_log`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- 使用表AUTO_INCREMENT `django_content_type`
--
ALTER TABLE `django_content_type`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- 使用表AUTO_INCREMENT `django_migrations`
--
ALTER TABLE `django_migrations`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- 限制导出的表
--

--
-- 限制表 `app_role_permission_permission_id`
--
ALTER TABLE `app_role_permission_permission_id`
  ADD CONSTRAINT `app_role_permission__permission_id_4c12a7f5_fk_app_permi` FOREIGN KEY (`permission_id`) REFERENCES `app_permission` (`permission_id`),
  ADD CONSTRAINT `app_role_permission__role_permission_id_b7295feb_fk_app_role_` FOREIGN KEY (`role_permission_id`) REFERENCES `app_role_permission` (`id`);

--
-- 限制表 `app_role_permission_role_id`
--
ALTER TABLE `app_role_permission_role_id`
  ADD CONSTRAINT `app_role_permission__role_permission_id_b2f7fca8_fk_app_role_` FOREIGN KEY (`role_permission_id`) REFERENCES `app_role_permission` (`id`),
  ADD CONSTRAINT `app_role_permission_role_id_role_id_96d82e2a_fk_app_role_role_id` FOREIGN KEY (`role_id`) REFERENCES `app_role` (`role_id`);

--
-- 限制表 `app_user_permission_permission_id`
--
ALTER TABLE `app_user_permission_permission_id`
  ADD CONSTRAINT `app_user_permission__permission_id_2a70efce_fk_app_permi` FOREIGN KEY (`permission_id`) REFERENCES `app_permission` (`permission_id`),
  ADD CONSTRAINT `app_user_permission__user_permission_id_b0e47037_fk_app_user_` FOREIGN KEY (`user_permission_id`) REFERENCES `app_user_permission` (`id`);

--
-- 限制表 `app_user_permission_user_id`
--
ALTER TABLE `app_user_permission_user_id`
  ADD CONSTRAINT `app_user_permission__user_permission_id_4c349eb7_fk_app_user_` FOREIGN KEY (`user_permission_id`) REFERENCES `app_user_permission` (`id`),
  ADD CONSTRAINT `app_user_permission_user_id_user_id_a96b6f11_fk_app_user_user_id` FOREIGN KEY (`user_id`) REFERENCES `app_user` (`user_id`);

--
-- 限制表 `app_user_role_role_id`
--
ALTER TABLE `app_user_role_role_id`
  ADD CONSTRAINT `app_user_role_role_id_role_id_9aab69ea_fk_app_role_role_id` FOREIGN KEY (`role_id`) REFERENCES `app_role` (`role_id`),
  ADD CONSTRAINT `app_user_role_role_id_user_role_id_18d69f1a_fk_app_user_role_id` FOREIGN KEY (`user_role_id`) REFERENCES `app_user_role` (`id`);

--
-- 限制表 `app_user_role_user_id`
--
ALTER TABLE `app_user_role_user_id`
  ADD CONSTRAINT `app_user_role_user_id_user_id_2c584059_fk_app_user_user_id` FOREIGN KEY (`user_id`) REFERENCES `app_user` (`user_id`),
  ADD CONSTRAINT `app_user_role_user_id_user_role_id_37d65e49_fk_app_user_role_id` FOREIGN KEY (`user_role_id`) REFERENCES `app_user_role` (`id`);

--
-- 限制表 `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  ADD CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  ADD CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`);

--
-- 限制表 `auth_permission`
--
ALTER TABLE `auth_permission`
  ADD CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`);

--
-- 限制表 `auth_user_groups`
--
ALTER TABLE `auth_user_groups`
  ADD CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  ADD CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- 限制表 `auth_user_user_permissions`
--
ALTER TABLE `auth_user_user_permissions`
  ADD CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  ADD CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- 限制表 `django_admin_log`
--
ALTER TABLE `django_admin_log`
  ADD CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  ADD CONSTRAINT `django_admin_log_user_id_c564eba6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
