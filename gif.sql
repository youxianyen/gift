-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- 主机： localhost
-- 生成日期： 2025-07-19 10:22:35
-- 服务器版本： 5.7.43-log
-- PHP 版本： 8.0.26

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- 数据库： `gif`
--

-- --------------------------------------------------------

--
-- 表的结构 `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `uuid` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `connection` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- 表的结构 `gift`
--

CREATE TABLE `gift` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `group_id` int(11) NOT NULL DEFAULT '0' COMMENT '分组id',
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '名称',
  `resource_id` int(11) NOT NULL DEFAULT '0' COMMENT '静态资源id',
  `coin` decimal(12,2) NOT NULL DEFAULT '0.00' COMMENT '价格',
  `sort` int(11) NOT NULL DEFAULT '0' COMMENT '排序，大数靠前',
  `gift_types` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '礼物类型 hall,week_star,blind_box,lover',
  `week_star_start_at` datetime DEFAULT NULL COMMENT '作为周星礼物开始时间',
  `week_star_end_at` datetime DEFAULT NULL COMMENT '作为周星礼物结束时间',
  `blind_box_coin_min` decimal(12,2) NOT NULL DEFAULT '0.00' COMMENT '盲盒礼物最小价值币数',
  `blind_box_coin_max` decimal(12,2) NOT NULL DEFAULT '0.00' COMMENT '盲盒礼物最大价值币数',
  `play_position` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '播放位置',
  `status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '状态，1封禁0激活'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='礼物列表';

--
-- 转存表中的数据 `gift`
--

INSERT INTO `gift` (`id`, `created_at`, `updated_at`, `group_id`, `name`, `resource_id`, `coin`, `sort`, `gift_types`, `week_star_start_at`, `week_star_end_at`, `blind_box_coin_min`, `blind_box_coin_max`, `play_position`, `status`) VALUES
(1, '2025-07-16 10:58:19', '2025-07-16 10:58:25', 1, '玫瑰', 1001, '10.00', 1, 'hall', '2025-07-01 00:00:00', '2025-07-31 23:59:59', '5.00', '15.00', 'room', 0);

-- --------------------------------------------------------

--
-- 表的结构 `gift_beneficiary`
--

CREATE TABLE `gift_beneficiary` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `room_id` bigint(20) NOT NULL DEFAULT '0' COMMENT '所属房间id',
  `scene` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '刷礼物场景,如房间、小黑屋',
  `scene_id` bigint(20) NOT NULL DEFAULT '0' COMMENT '场景id',
  `bill_id` bigint(20) NOT NULL DEFAULT '0' COMMENT '收益对应账单id',
  `uid` bigint(20) NOT NULL DEFAULT '0' COMMENT '收益人用户id,平台是0',
  `identity` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '用户身份标识',
  `coin` decimal(18,8) NOT NULL DEFAULT '0.00000000' COMMENT '收益币数',
  `money` decimal(18,8) NOT NULL DEFAULT '0.00000000' COMMENT '收益金额'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='全局刷礼物账单受益人记录';

-- --------------------------------------------------------

--
-- 表的结构 `gift_bill`
--

CREATE TABLE `gift_bill` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `room_id` bigint(20) NOT NULL DEFAULT '0' COMMENT '所属房间id',
  `scene` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '刷礼物场景',
  `scene_id` bigint(20) NOT NULL DEFAULT '0' COMMENT '场景id,如房间、小黑屋',
  `uid` bigint(20) NOT NULL DEFAULT '0' COMMENT '刷礼物用户id',
  `to_uid` bigint(20) NOT NULL DEFAULT '0' COMMENT '接收礼物用户id',
  `gift_id` bigint(20) NOT NULL DEFAULT '0' COMMENT '礼物id',
  `gift_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '礼物名称',
  `gift_number` int(11) NOT NULL DEFAULT '0' COMMENT '礼物数量',
  `gift_coin` decimal(12,2) NOT NULL DEFAULT '0.00' COMMENT '价值币数',
  `gift_money` decimal(12,2) NOT NULL DEFAULT '0.00' COMMENT '价值金额',
  `is_permanent` tinyint(4) NOT NULL DEFAULT '0' COMMENT '是否常驻，1是0否',
  `source` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'gift' COMMENT '礼物来源',
  `number_group` int(11) NOT NULL DEFAULT '1' COMMENT '礼物组数'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='全局刷礼物账单记录';

-- --------------------------------------------------------

--
-- 表的结构 `gift_blind_box_probability`
--

CREATE TABLE `gift_blind_box_probability` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `gift_id` int(11) NOT NULL DEFAULT '0' COMMENT '对应礼物id',
  `probability` decimal(8,2) NOT NULL DEFAULT '0.00' COMMENT '概率，万分比',
  `status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '状态，1显示0隐藏'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='盲盒礼物概率';

-- --------------------------------------------------------

--
-- 表的结构 `gift_group`
--

CREATE TABLE `gift_group` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '名称',
  `sort` int(11) NOT NULL DEFAULT '0' COMMENT '排序，大数靠前',
  `is_permanent` tinyint(4) NOT NULL DEFAULT '0' COMMENT '是否常驻，1是0否',
  `status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '状态，1封禁0激活'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='礼物分组';

-- --------------------------------------------------------

--
-- 表的结构 `gift_luck_probability`
--

CREATE TABLE `gift_luck_probability` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `gift_id` int(11) NOT NULL DEFAULT '0' COMMENT '对应幸运礼物id',
  `gift_multiple_id` int(11) NOT NULL DEFAULT '0' COMMENT '对应爆出的倍数id',
  `probability` decimal(8,2) NOT NULL DEFAULT '0.00' COMMENT '概率，万分比',
  `status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '状态，1显示0隐藏'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='幸运礼物倍数概率';

-- --------------------------------------------------------

--
-- 表的结构 `gift_multiple`
--

CREATE TABLE `gift_multiple` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` int(11) NOT NULL DEFAULT '0' COMMENT '倍数',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `resource_id` int(11) NOT NULL DEFAULT '0' COMMENT '静态资源id'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='幸运礼物倍数';

-- --------------------------------------------------------

--
-- 表的结构 `gift_number_group`
--

CREATE TABLE `gift_number_group` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `gift_id` int(11) NOT NULL DEFAULT '0' COMMENT '对应礼物id',
  `num` int(11) NOT NULL DEFAULT '1' COMMENT '礼物组数',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='幸运礼物组数';

-- --------------------------------------------------------

--
-- 表的结构 `gift_resource`
--

CREATE TABLE `gift_resource` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '名称',
  `image` varchar(500) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '缩略图',
  `type` varchar(32) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '文件类型，svga|mp4',
  `file` varchar(500) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '文件地址',
  `permanent_type` varchar(32) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '常驻文件类型，svga|mp4',
  `permanent_file` varchar(500) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '常驻文件地址',
  `sound_file` varchar(500) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '音效文件地址',
  `status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '状态，1封禁0激活'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='礼物样式资源表';

-- --------------------------------------------------------

--
-- 表的结构 `gift_unit_price`
--

CREATE TABLE `gift_unit_price` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `gift_id` int(11) NOT NULL DEFAULT '0' COMMENT '对应礼物id',
  `coin` decimal(18,8) NOT NULL DEFAULT '0.00000000' COMMENT '组礼物单价',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='幸运礼物单价(注意区分组礼物的价格和组礼物的单价)';

--
-- 转存表中的数据 `gift_unit_price`
--

INSERT INTO `gift_unit_price` (`id`, `gift_id`, `coin`, `created_at`, `updated_at`) VALUES
(2, 1, '10.00000000', '2025-07-17 02:57:22', '2025-07-17 02:57:22');

-- --------------------------------------------------------

--
-- 表的结构 `gift_wall`
--

CREATE TABLE `gift_wall` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `uid` bigint(20) NOT NULL DEFAULT '0' COMMENT '用户id',
  `gift_id` bigint(20) NOT NULL DEFAULT '0' COMMENT '礼物id',
  `gift_number` int(11) NOT NULL DEFAULT '0' COMMENT '礼物数量'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='礼物墙';

-- --------------------------------------------------------

--
-- 表的结构 `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- 转存表中的数据 `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '2014_10_12_000000_create_users_table', 1),
(2, '2014_10_12_100000_create_password_resets_table', 1),
(3, '2019_08_19_000000_create_failed_jobs_table', 1),
(4, '2019_12_14_000001_create_personal_access_tokens_table', 1),
(5, '2022_06_20_144146_create_gift_bill_table', 2),
(6, '2022_06_21_101624_create_gift_beneficiary_table', 2),
(7, '2022_06_21_103608_create_gift_table', 2),
(8, '2022_06_21_104149_create_gift_group_table', 2),
(9, '2022_06_21_105422_create_gift_resource_table', 2),
(10, '2022_07_04_110709_create_gift_wall_table', 2),
(11, '2022_11_23_113440_create_gift_blind_box_probability_table', 2),
(12, '2023_02_23_090235_create_gift_luck_probability_table', 2),
(13, '2023_02_23_184112_create_gift_multiple_table', 2),
(14, '2023_02_24_083240_create_gift_number_group_table', 2),
(15, '2023_02_24_092842_create_gift_unit_price_table', 2),
(16, '2023_02_25_150419_add_gift_number_group_to_gift_bill_table', 2),
(17, '2023_03_13_171722_add_resource_id_to_gift_multiple', 2),
(18, '2023_03_15_044949_add_idx_sceneid_scene_ispermanent_giftcoin_createdat_to_gift_bill_table', 2),
(19, '2025_07_18_032812_add_coin_to_users_table', 3);

-- --------------------------------------------------------

--
-- 表的结构 `password_resets`
--

CREATE TABLE `password_resets` (
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- 表的结构 `personal_access_tokens`
--

CREATE TABLE `personal_access_tokens` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `tokenable_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tokenable_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `abilities` text COLLATE utf8mb4_unicode_ci,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- 表的结构 `users`
--

CREATE TABLE `users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `coin` decimal(12,2) NOT NULL DEFAULT '0.00' COMMENT '用户钱包余额'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- 转存表中的数据 `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `email_verified_at`, `password`, `remember_token`, `created_at`, `updated_at`, `coin`) VALUES
(1, 'sender', 'sender@example.com', NULL, '$2y$10$testpassword', NULL, '2025-07-17 02:58:03', '2025-07-17 02:58:03', '20.00'),
(2, 'receiver1', 'receiver1@example.com', NULL, '$2y$10$testpassword', NULL, '2025-07-17 02:58:03', '2025-07-17 02:58:03', '2.00'),
(3, 'receiver2', 'receiver2@example.com', NULL, '$2y$10$testpassword', NULL, '2025-07-17 02:58:03', '2025-07-17 02:58:03', '10.00');

--
-- 转储表的索引
--

--
-- 表的索引 `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`);

--
-- 表的索引 `gift`
--
ALTER TABLE `gift`
  ADD PRIMARY KEY (`id`),
  ADD KEY `gift_group_id_status_index` (`group_id`,`status`);

--
-- 表的索引 `gift_beneficiary`
--
ALTER TABLE `gift_beneficiary`
  ADD PRIMARY KEY (`id`),
  ADD KEY `gift_beneficiary_uid_scene_scene_id_index` (`uid`,`scene`,`scene_id`),
  ADD KEY `gift_beneficiary_bill_id_index` (`bill_id`),
  ADD KEY `gift_beneficiary_room_id_uid_index` (`room_id`,`uid`);

--
-- 表的索引 `gift_bill`
--
ALTER TABLE `gift_bill`
  ADD PRIMARY KEY (`id`),
  ADD KEY `gift_bill_scene_scene_id_index` (`scene`,`scene_id`),
  ADD KEY `gift_bill_room_id_index` (`room_id`),
  ADD KEY `gift_bill_scene_scene_id_is_permanent_gift_coin_created_at_index` (`scene`,`scene_id`,`is_permanent`,`gift_coin`,`created_at`);

--
-- 表的索引 `gift_blind_box_probability`
--
ALTER TABLE `gift_blind_box_probability`
  ADD PRIMARY KEY (`id`);

--
-- 表的索引 `gift_group`
--
ALTER TABLE `gift_group`
  ADD PRIMARY KEY (`id`);

--
-- 表的索引 `gift_luck_probability`
--
ALTER TABLE `gift_luck_probability`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `gift_luck_probability_gift_id_gift_multiple_id_unique` (`gift_id`,`gift_multiple_id`);

--
-- 表的索引 `gift_multiple`
--
ALTER TABLE `gift_multiple`
  ADD PRIMARY KEY (`id`);

--
-- 表的索引 `gift_number_group`
--
ALTER TABLE `gift_number_group`
  ADD PRIMARY KEY (`id`);

--
-- 表的索引 `gift_resource`
--
ALTER TABLE `gift_resource`
  ADD PRIMARY KEY (`id`);

--
-- 表的索引 `gift_unit_price`
--
ALTER TABLE `gift_unit_price`
  ADD PRIMARY KEY (`id`);

--
-- 表的索引 `gift_wall`
--
ALTER TABLE `gift_wall`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `gift_wall_uid_gift_id_unique` (`uid`,`gift_id`);

--
-- 表的索引 `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- 表的索引 `password_resets`
--
ALTER TABLE `password_resets`
  ADD KEY `password_resets_email_index` (`email`);

--
-- 表的索引 `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  ADD KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`);

--
-- 表的索引 `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`);

--
-- 在导出的表使用AUTO_INCREMENT
--

--
-- 使用表AUTO_INCREMENT `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- 使用表AUTO_INCREMENT `gift`
--
ALTER TABLE `gift`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- 使用表AUTO_INCREMENT `gift_beneficiary`
--
ALTER TABLE `gift_beneficiary`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- 使用表AUTO_INCREMENT `gift_bill`
--
ALTER TABLE `gift_bill`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- 使用表AUTO_INCREMENT `gift_blind_box_probability`
--
ALTER TABLE `gift_blind_box_probability`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- 使用表AUTO_INCREMENT `gift_group`
--
ALTER TABLE `gift_group`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- 使用表AUTO_INCREMENT `gift_luck_probability`
--
ALTER TABLE `gift_luck_probability`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- 使用表AUTO_INCREMENT `gift_multiple`
--
ALTER TABLE `gift_multiple`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- 使用表AUTO_INCREMENT `gift_number_group`
--
ALTER TABLE `gift_number_group`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- 使用表AUTO_INCREMENT `gift_resource`
--
ALTER TABLE `gift_resource`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- 使用表AUTO_INCREMENT `gift_unit_price`
--
ALTER TABLE `gift_unit_price`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- 使用表AUTO_INCREMENT `gift_wall`
--
ALTER TABLE `gift_wall`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- 使用表AUTO_INCREMENT `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- 使用表AUTO_INCREMENT `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- 使用表AUTO_INCREMENT `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
