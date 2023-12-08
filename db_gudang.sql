-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Dec 06, 2023 at 04:19 PM
-- Server version: 10.4.27-MariaDB
-- PHP Version: 7.4.33

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `db_gudang`
--

-- --------------------------------------------------------

--
-- Table structure for table `customers`
--

CREATE TABLE `customers` (
  `id` int(11) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `phone` varchar(255) DEFAULT NULL,
  `departemen` text DEFAULT NULL,
  `status` smallint(4) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `customers`
--

INSERT INTO `customers` (`id`, `name`, `phone`, `departemen`, `status`, `created_at`, `updated_at`) VALUES
(4, 'Kowiyul Iman', '083844437978', 'IT', NULL, '2023-11-11 05:27:30', '2023-11-11 05:27:30'),
(5, 'Tegar', '083844437978', 'produksi', NULL, '2023-11-15 15:54:27', '2023-11-15 15:54:27'),
(6, 'Yogi Andi Wibowo', '12412', 'FAC', NULL, '2023-11-28 16:18:34', '2023-11-28 16:18:34');

-- --------------------------------------------------------

--
-- Table structure for table `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `uuid` varchar(255) NOT NULL,
  `connection` text NOT NULL,
  `queue` text NOT NULL,
  `payload` longtext NOT NULL,
  `exception` longtext NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `items`
--

CREATE TABLE `items` (
  `id` int(11) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `minimum_stock` int(11) NOT NULL,
  `sell_price` decimal(10,2) DEFAULT NULL,
  `purchase_price` decimal(10,2) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `satuan` varchar(11) DEFAULT NULL,
  `item_type_id` int(11) DEFAULT NULL,
  `status` smallint(4) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `items`
--

INSERT INTO `items` (`id`, `name`, `minimum_stock`, `sell_price`, `purchase_price`, `description`, `satuan`, `item_type_id`, `status`, `created_at`, `updated_at`) VALUES
(7, 'Kertas A4 Paper One 75 Gram green', 10, '12000.00', '10000.00', '-', 'RIM', 1, 0, '2023-11-15 15:01:18', '2023-11-28 16:13:17'),
(8, 'Kertas A3 Paper One 75 Gram', 10, '12000.00', '10000.00', '-', 'RIM', 1, 1, '2023-11-15 15:40:00', '2023-11-15 15:40:00'),
(10, 'Ballpoint Standard AE-7 Hitam', 100, '1000.00', '500.00', '-', 'PCS', 2, 1, '2023-11-17 06:31:22', '2023-11-17 06:31:22'),
(11, 'Spidol snowman', 10, NULL, NULL, '-', 'PCS', 2, 1, '2023-11-28 16:16:04', '2023-11-28 16:16:04');

-- --------------------------------------------------------

--
-- Table structure for table `item_stocks`
--

CREATE TABLE `item_stocks` (
  `id` int(11) NOT NULL,
  `item_id` int(11) DEFAULT NULL,
  `supplier_id` int(11) DEFAULT NULL,
  `stock` bigint(20) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `item_stocks`
--

INSERT INTO `item_stocks` (`id`, `item_id`, `supplier_id`, `stock`, `created_at`, `updated_at`) VALUES
(2, 1, 1, 0, '2020-11-11 05:28:49', '2020-11-11 14:49:32'),
(3, 2, 1, 97, '2020-11-11 05:28:49', '2020-11-11 05:32:44'),
(4, 1, 1, 8, '2020-11-11 05:28:49', '2020-11-11 14:49:32'),
(5, 1, 2, 80, '2020-11-11 15:45:11', '2020-11-11 15:45:11'),
(6, 4, 1, 4, '2023-11-11 05:32:26', '2023-11-11 05:35:21'),
(7, 6, 1, 15, '2023-11-11 05:32:26', '2023-11-15 15:02:36'),
(8, 7, 1, 0, '2023-11-15 15:02:36', '2023-11-16 16:05:06'),
(9, 8, 1, 2, '2023-11-15 16:03:02', '2023-11-16 16:13:30'),
(10, 9, 1, 9, '2023-11-15 16:03:02', '2023-11-15 17:22:11'),
(11, 7, 4, 9, '2023-11-16 16:19:52', '2023-11-17 06:21:10'),
(12, 10, 4, 0, '2023-11-17 06:32:10', '2023-11-22 14:52:54'),
(13, 11, 4, 20, '2023-11-30 06:53:54', '2023-11-30 06:53:54');

-- --------------------------------------------------------

--
-- Table structure for table `item_types`
--

CREATE TABLE `item_types` (
  `id` int(11) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `item_types`
--

INSERT INTO `item_types` (`id`, `name`, `created_at`, `updated_at`) VALUES
(1, 'Buku', NULL, '2023-11-11 05:28:03'),
(2, 'Alat Tulis', NULL, '2023-11-11 05:28:14'),
(3, 'Peralatan umum', NULL, '2023-11-16 16:14:49');

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '2014_10_12_000000_create_users_table', 1),
(2, '2014_10_12_100000_create_password_resets_table', 1),
(3, '2019_08_19_000000_create_failed_jobs_table', 1);

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `id` int(11) NOT NULL,
  `order_number` varchar(255) DEFAULT NULL,
  `order_date` datetime DEFAULT NULL,
  `supplier_id` int(11) DEFAULT NULL,
  `grand_total` decimal(14,0) DEFAULT NULL,
  `note` text DEFAULT NULL,
  `status` smallint(4) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `orders`
--

INSERT INTO `orders` (`id`, `order_number`, `order_date`, `supplier_id`, `grand_total`, `note`, `status`, `created_at`, `updated_at`, `user_id`) VALUES
(5, 'INV-2020-11-11-0003', '2020-11-03 00:00:00', 1, '4200000', 'asd', 1, '2020-11-11 05:32:44', '2020-11-11 05:32:44', NULL),
(6, 'INV-2020-11-11-0004', '2020-11-11 00:00:00', 2, '6400000', 'ok', 1, '2020-11-11 15:45:11', '2020-11-11 15:45:11', NULL),
(8, 'INV-2023-11-15-0001', '2023-11-14 00:00:00', 1, '145000', '-', 1, '2023-11-15 15:02:36', '2023-11-15 15:02:36', NULL),
(10, 'INV-2023-11-16-0001', '2023-11-16 00:00:00', 4, '120000', '-', 1, '2023-11-16 16:19:52', '2023-11-16 16:19:52', NULL),
(11, 'INV-2023-11-17-0001', '2023-11-17 00:00:00', 4, '10000', '-', 1, '2023-11-17 06:32:10', '2023-11-17 06:32:10', NULL),
(12, 'INV-2023-11-30-0001', '2023-11-30 00:00:00', 4, '200000', NULL, 1, '2023-11-30 06:53:54', '2023-11-30 06:53:54', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `order_details`
--

CREATE TABLE `order_details` (
  `id` int(11) NOT NULL,
  `order_id` int(11) DEFAULT NULL,
  `item_id` int(11) DEFAULT NULL,
  `qty` int(11) DEFAULT NULL,
  `price` decimal(14,2) DEFAULT NULL,
  `purchase_total` decimal(14,2) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `order_details`
--

INSERT INTO `order_details` (`id`, `order_id`, `item_id`, `qty`, `price`, `purchase_total`, `created_at`, `updated_at`) VALUES
(4, 3, 1, 60, '600000.00', '36000000.00', '2020-11-11 05:28:49', '2020-11-11 05:28:49'),
(5, 3, 2, 90, '700000.00', '63000000.00', '2020-11-11 05:28:49', '2020-11-11 05:28:49'),
(6, 4, 1, 40, '700000.00', '28000000.00', '2020-11-11 05:29:19', '2020-11-11 05:29:19'),
(7, 5, 2, 7, '600000.00', '4200000.00', '2020-11-11 05:32:44', '2020-11-11 05:32:44'),
(8, 6, 1, 80, '80000.00', '6400000.00', '2020-11-11 15:45:11', '2020-11-11 15:45:11'),
(9, 7, 4, 10, '10000.00', '100000.00', '2023-11-11 05:32:26', '2023-11-11 05:32:26'),
(10, 7, 6, 10, '15000.00', '150000.00', '2023-11-11 05:32:26', '2023-11-11 05:32:26'),
(11, 7, 4, 10, '15000.00', '150000.00', '2023-11-11 05:32:26', '2023-11-11 05:32:26'),
(12, 7, 4, 10, '15000.00', '150000.00', '2023-11-11 05:32:26', '2023-11-11 05:32:26'),
(13, 8, 7, 10, '12000.00', '120000.00', '2023-11-15 15:02:36', '2023-11-15 15:02:36'),
(14, 8, 6, 5, '5000.00', '25000.00', '2023-11-15 15:02:36', '2023-11-15 15:02:36'),
(15, 9, 8, 5, '15000.00', '75000.00', '2023-11-15 16:03:02', '2023-11-15 16:03:02'),
(16, 9, 9, 10, '5000.00', '50000.00', '2023-11-15 16:03:02', '2023-11-15 16:03:02'),
(17, 10, 7, 10, '12000.00', '120000.00', '2023-11-16 16:19:52', '2023-11-16 16:19:52'),
(18, 11, 10, 10, '1000.00', '10000.00', '2023-11-17 06:32:10', '2023-11-17 06:32:10'),
(19, 12, 11, 20, '10000.00', '200000.00', '2023-11-30 06:53:54', '2023-11-30 06:53:54');

-- --------------------------------------------------------

--
-- Table structure for table `password_resets`
--

CREATE TABLE `password_resets` (
  `email` varchar(255) NOT NULL,
  `token` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `suppliers`
--

CREATE TABLE `suppliers` (
  `id` int(11) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `phone` varchar(255) DEFAULT NULL,
  `address` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `suppliers`
--

INSERT INTO `suppliers` (`id`, `name`, `phone`, `address`, `created_at`, `updated_at`) VALUES
(2, 'Kimia', '08561471500', 'Jl Batu Ceper No 2Y', '2020-11-11 15:44:38', '2020-11-11 15:44:38'),
(4, 'Toko Maju Makmur', '083844437978', 'Jakarta', '2023-11-16 15:41:35', '2023-11-16 15:41:35');

-- --------------------------------------------------------

--
-- Table structure for table `transactions`
--

CREATE TABLE `transactions` (
  `id` int(11) NOT NULL,
  `trx_number` varchar(255) DEFAULT NULL,
  `customer_id` int(11) DEFAULT NULL,
  `grand_total` decimal(14,0) DEFAULT NULL,
  `status` smallint(4) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `transactions`
--

INSERT INTO `transactions` (`id`, `trx_number`, `customer_id`, `grand_total`, `status`, `created_at`, `updated_at`, `user_id`) VALUES
(11, 'TRX-2023-11-16-0002', 5, '12000', 1, '2023-11-16 16:13:30', '2023-11-16 16:13:30', 4),
(12, 'TRX-2023-11-17-0001', 4, '12000', 0, '2023-11-17 06:21:10', '2023-11-17 06:21:10', 4),
(13, 'TRX-2023-11-22-0001', 4, '10000', 0, '2023-11-22 14:52:54', '2023-11-22 14:52:54', 4);

-- --------------------------------------------------------

--
-- Table structure for table `transaction_details`
--

CREATE TABLE `transaction_details` (
  `id` int(11) NOT NULL,
  `transaction_id` int(11) DEFAULT NULL,
  `item_id` int(11) DEFAULT NULL,
  `qty` int(11) DEFAULT NULL,
  `price` decimal(14,2) DEFAULT NULL,
  `total_price` decimal(14,2) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `transaction_details`
--

INSERT INTO `transaction_details` (`id`, `transaction_id`, `item_id`, `qty`, `price`, `total_price`, `created_at`, `updated_at`) VALUES
(15, 11, 8, 1, '12000.00', '12000.00', '2023-11-16 16:13:30', '2023-11-16 16:13:30'),
(16, 12, 7, 1, '12000.00', '12000.00', '2023-11-17 06:21:10', '2023-11-17 06:21:10'),
(17, 13, 10, 10, '1000.00', '10000.00', '2023-11-22 14:52:54', '2023-11-22 14:52:54');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `role` smallint(4) DEFAULT NULL,
  `email` varchar(255) NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `remember_token` varchar(100) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `role`, `email`, `email_verified_at`, `password`, `remember_token`, `created_at`, `updated_at`) VALUES
(1, 'Kowiyul Iman', 1, 'hendri.gnw@gmail.com', NULL, '$2y$10$87hhSEYbVq82Ur6om4X5BOclGTNiqMw1Sd.s2KaA3mrSGdCFDqG.C', NULL, '2020-11-09 21:30:08', '2020-11-09 21:30:08'),
(2, 'Hendri Karyawan', 2, 'hendri.karyawan@gmail.com', NULL, '$2y$10$NfB6qvA.ko3eFKUHj4fS9e0tGpjCFDrW43dsyKAbEFZa1ptoLyLhO', NULL, '2020-11-09 22:03:37', '2020-11-09 22:03:37'),
(4, 'Kowi', 1, 'admin@admin.com', NULL, '$2y$10$a75rA5LGuh1mqVUpkE59SeuYDqZ.ng4cYN3nbL95zskcwMuDA4NsK', '85TL4QguCaqdveIqMGGgqyKu7iJm5YLguRaUgDHTgUvtKtEUKQyAvagK4LMC', '2023-11-16 13:40:13', '2023-11-16 13:40:13');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `customers`
--
ALTER TABLE `customers`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`);

--
-- Indexes for table `items`
--
ALTER TABLE `items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `item_item_type_id_foreign` (`item_type_id`);

--
-- Indexes for table `item_stocks`
--
ALTER TABLE `item_stocks`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `item_types`
--
ALTER TABLE `item_types`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `order_details`
--
ALTER TABLE `order_details`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `password_resets`
--
ALTER TABLE `password_resets`
  ADD KEY `password_resets_email_index` (`email`);

--
-- Indexes for table `suppliers`
--
ALTER TABLE `suppliers`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `transactions`
--
ALTER TABLE `transactions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `trx_customer_id_foreign` (`customer_id`);

--
-- Indexes for table `transaction_details`
--
ALTER TABLE `transaction_details`
  ADD PRIMARY KEY (`id`),
  ADD KEY `trx_detail_transaction_id_foreign` (`transaction_id`),
  ADD KEY `trx_detail_item_id_foreign` (`item_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `customers`
--
ALTER TABLE `customers`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `items`
--
ALTER TABLE `items`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `item_stocks`
--
ALTER TABLE `item_stocks`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `item_types`
--
ALTER TABLE `item_types`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `order_details`
--
ALTER TABLE `order_details`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT for table `suppliers`
--
ALTER TABLE `suppliers`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `transactions`
--
ALTER TABLE `transactions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `transaction_details`
--
ALTER TABLE `transaction_details`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `items`
--
ALTER TABLE `items`
  ADD CONSTRAINT `item_item_type_id_foreign` FOREIGN KEY (`item_type_id`) REFERENCES `item_types` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `transactions`
--
ALTER TABLE `transactions`
  ADD CONSTRAINT `trx_customer_id_foreign` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `transaction_details`
--
ALTER TABLE `transaction_details`
  ADD CONSTRAINT `trx_detail_item_id_foreign` FOREIGN KEY (`item_id`) REFERENCES `items` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
