-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jul 21, 2025 at 06:01 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `basc-portal_db`
--

-- --------------------------------------------------------

--
-- Table structure for table `1roles`
--

CREATE TABLE `1roles` (
  `role_id` tinyint(3) UNSIGNED NOT NULL,
  `role_name` varchar(30) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `1users`
--

CREATE TABLE `1users` (
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `employee_id` varchar(20) NOT NULL,
  `first_name` varchar(50) NOT NULL,
  `last_name` varchar(50) NOT NULL,
  `email` varchar(160) DEFAULT NULL,
  `email_verified_at` datetime DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `password_hash` varchar(255) NOT NULL,
  `status_id` tinyint(3) UNSIGNED NOT NULL DEFAULT 1,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `1user_roles`
--

CREATE TABLE `1user_roles` (
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `role_id` tinyint(3) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `1user_statuses`
--

CREATE TABLE `1user_statuses` (
  `status_id` tinyint(3) UNSIGNED NOT NULL,
  `status_name` varchar(30) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `1user_statuses`
--

INSERT INTO `1user_statuses` (`status_id`, `status_name`) VALUES
(1, 'active'),
(2, 'inactive'),
(4, 'pending'),
(3, 'suspended');

-- --------------------------------------------------------

--
-- Table structure for table `2user_activities`
--

CREATE TABLE `2user_activities` (
  `activity_id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `module` varchar(50) NOT NULL,
  `action` varchar(50) NOT NULL,
  `description` text DEFAULT NULL,
  `related_id` bigint(20) UNSIGNED DEFAULT NULL,
  `ip` varchar(45) DEFAULT NULL,
  `user_agent` varchar(255) DEFAULT NULL,
  `performed_at` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `2user_logins`
--

CREATE TABLE `2user_logins` (
  `login_id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `ip` varchar(45) DEFAULT NULL,
  `user_agent` varchar(255) DEFAULT NULL,
  `logged_in_at` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `2user_presence`
--

CREATE TABLE `2user_presence` (
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `is_online` tinyint(1) DEFAULT 0,
  `last_seen` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `3inventory_movements`
--

CREATE TABLE `3inventory_movements` (
  `movement_id` bigint(20) UNSIGNED NOT NULL,
  `product_id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `movement_type` enum('in','out','adjust') NOT NULL,
  `quantity` int(11) NOT NULL,
  `remarks` text DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `3locations`
--

CREATE TABLE `3locations` (
  `location_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(100) NOT NULL,
  `address` text DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `3products`
--

CREATE TABLE `3products` (
  `product_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(100) NOT NULL,
  `description` text DEFAULT NULL,
  `category` varchar(50) DEFAULT NULL,
  `unit_price` decimal(10,2) NOT NULL,
  `reorder_level` int(10) UNSIGNED DEFAULT 10,
  `status` enum('active','archived') DEFAULT 'active',
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `3product_history`
--

CREATE TABLE `3product_history` (
  `history_id` bigint(20) UNSIGNED NOT NULL,
  `product_id` bigint(20) UNSIGNED NOT NULL,
  `changed_by` bigint(20) UNSIGNED NOT NULL,
  `field_changed` varchar(50) DEFAULT NULL,
  `old_value` text DEFAULT NULL,
  `new_value` text DEFAULT NULL,
  `changed_at` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `3product_stock_by_location`
--

CREATE TABLE `3product_stock_by_location` (
  `product_id` bigint(20) UNSIGNED NOT NULL,
  `location_id` bigint(20) UNSIGNED NOT NULL,
  `quantity` int(10) UNSIGNED NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `3reorder_requests`
--

CREATE TABLE `3reorder_requests` (
  `request_id` bigint(20) UNSIGNED NOT NULL,
  `product_id` bigint(20) UNSIGNED NOT NULL,
  `requested_by` bigint(20) UNSIGNED NOT NULL,
  `quantity` int(10) UNSIGNED NOT NULL,
  `status` enum('pending','approved','rejected','fulfilled') DEFAULT 'pending',
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `4sales_daily_summary`
--

CREATE TABLE `4sales_daily_summary` (
  `summary_id` bigint(20) UNSIGNED NOT NULL,
  `product_id` bigint(20) UNSIGNED NOT NULL,
  `sales_date` date NOT NULL,
  `total_quantity` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `total_sales` decimal(12,2) NOT NULL DEFAULT 0.00
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `4sales_orders`
--

CREATE TABLE `4sales_orders` (
  `order_id` bigint(20) UNSIGNED NOT NULL,
  `ordered_by` bigint(20) UNSIGNED NOT NULL,
  `customer_name` varchar(100) NOT NULL,
  `customer_contact` varchar(50) DEFAULT NULL,
  `total_amount` decimal(10,2) NOT NULL,
  `discount_amount` decimal(10,2) DEFAULT 0.00,
  `payment_type` enum('cash','gcash','bank_transfer','credit') DEFAULT 'cash',
  `status` enum('pending','processing','completed','cancelled') DEFAULT 'pending',
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `4sales_order_items`
--

CREATE TABLE `4sales_order_items` (
  `item_id` bigint(20) UNSIGNED NOT NULL,
  `order_id` bigint(20) UNSIGNED NOT NULL,
  `product_id` bigint(20) UNSIGNED NOT NULL,
  `quantity` int(10) UNSIGNED NOT NULL,
  `unit_price` decimal(10,2) NOT NULL,
  `subtotal` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `4sales_returns`
--

CREATE TABLE `4sales_returns` (
  `return_id` bigint(20) UNSIGNED NOT NULL,
  `order_id` bigint(20) UNSIGNED NOT NULL,
  `product_id` bigint(20) UNSIGNED NOT NULL,
  `quantity` int(10) UNSIGNED NOT NULL,
  `reason` text DEFAULT NULL,
  `returned_by` bigint(20) UNSIGNED NOT NULL,
  `returned_at` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `5product_suppliers`
--

CREATE TABLE `5product_suppliers` (
  `product_id` bigint(20) UNSIGNED NOT NULL,
  `supplier_id` bigint(20) UNSIGNED NOT NULL,
  `preferred` tinyint(1) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `5suppliers`
--

CREATE TABLE `5suppliers` (
  `supplier_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(100) NOT NULL,
  `contact_person` varchar(100) DEFAULT NULL,
  `phone` varchar(50) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `address` text DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `6deliveries`
--

CREATE TABLE `6deliveries` (
  `delivery_id` bigint(20) UNSIGNED NOT NULL,
  `order_id` bigint(20) UNSIGNED NOT NULL,
  `delivered_by` bigint(20) UNSIGNED NOT NULL,
  `delivery_date` date NOT NULL,
  `status` enum('pending','in_transit','delivered','failed') DEFAULT 'pending',
  `remarks` text DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `6delivery_items`
--

CREATE TABLE `6delivery_items` (
  `delivery_item_id` bigint(20) UNSIGNED NOT NULL,
  `delivery_id` bigint(20) UNSIGNED NOT NULL,
  `product_id` bigint(20) UNSIGNED NOT NULL,
  `quantity_delivered` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `6delivery_logs`
--

CREATE TABLE `6delivery_logs` (
  `log_id` bigint(20) UNSIGNED NOT NULL,
  `delivery_id` bigint(20) UNSIGNED NOT NULL,
  `status` enum('in_transit','delivered','failed') NOT NULL,
  `location` varchar(255) DEFAULT NULL,
  `updated_by` bigint(20) UNSIGNED NOT NULL,
  `logged_at` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `7supplier_deliveries`
--

CREATE TABLE `7supplier_deliveries` (
  `supplier_delivery_id` bigint(20) UNSIGNED NOT NULL,
  `supplier_id` bigint(20) UNSIGNED NOT NULL,
  `product_id` bigint(20) UNSIGNED NOT NULL,
  `quantity` int(10) UNSIGNED NOT NULL,
  `delivery_date` date NOT NULL,
  `status` enum('pending','shipped','received','cancelled') DEFAULT 'pending',
  `remarks` text DEFAULT NULL,
  `received_by` bigint(20) UNSIGNED DEFAULT NULL,
  `received_at` datetime DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `8purchase_orders`
--

CREATE TABLE `8purchase_orders` (
  `po_id` bigint(20) UNSIGNED NOT NULL,
  `supplier_id` bigint(20) UNSIGNED NOT NULL,
  `ordered_by` bigint(20) UNSIGNED NOT NULL,
  `po_number` varchar(50) NOT NULL,
  `total_amount` decimal(12,2) NOT NULL,
  `status` enum('draft','sent','approved','received','cancelled') DEFAULT 'draft',
  `remarks` text DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `8purchase_order_items`
--

CREATE TABLE `8purchase_order_items` (
  `po_item_id` bigint(20) UNSIGNED NOT NULL,
  `po_id` bigint(20) UNSIGNED NOT NULL,
  `product_id` bigint(20) UNSIGNED NOT NULL,
  `quantity` int(10) UNSIGNED NOT NULL,
  `unit_cost` decimal(10,2) NOT NULL,
  `subtotal` decimal(12,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `9notifications`
--

CREATE TABLE `9notifications` (
  `notification_id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `role_id` tinyint(3) UNSIGNED DEFAULT NULL,
  `module` varchar(50) DEFAULT NULL,
  `message` text NOT NULL,
  `is_read` tinyint(1) DEFAULT 0,
  `created_at` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `1roles`
--
ALTER TABLE `1roles`
  ADD PRIMARY KEY (`role_id`),
  ADD UNIQUE KEY `role_name` (`role_name`);

--
-- Indexes for table `1users`
--
ALTER TABLE `1users`
  ADD PRIMARY KEY (`user_id`),
  ADD UNIQUE KEY `employee_id` (`employee_id`),
  ADD KEY `status_id` (`status_id`);

--
-- Indexes for table `1user_roles`
--
ALTER TABLE `1user_roles`
  ADD PRIMARY KEY (`user_id`,`role_id`),
  ADD KEY `role_id` (`role_id`);

--
-- Indexes for table `1user_statuses`
--
ALTER TABLE `1user_statuses`
  ADD PRIMARY KEY (`status_id`),
  ADD UNIQUE KEY `status_name` (`status_name`);

--
-- Indexes for table `2user_activities`
--
ALTER TABLE `2user_activities`
  ADD PRIMARY KEY (`activity_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `2user_logins`
--
ALTER TABLE `2user_logins`
  ADD PRIMARY KEY (`login_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `2user_presence`
--
ALTER TABLE `2user_presence`
  ADD PRIMARY KEY (`user_id`);

--
-- Indexes for table `3inventory_movements`
--
ALTER TABLE `3inventory_movements`
  ADD PRIMARY KEY (`movement_id`),
  ADD KEY `product_id` (`product_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `3locations`
--
ALTER TABLE `3locations`
  ADD PRIMARY KEY (`location_id`);

--
-- Indexes for table `3products`
--
ALTER TABLE `3products`
  ADD PRIMARY KEY (`product_id`);

--
-- Indexes for table `3product_history`
--
ALTER TABLE `3product_history`
  ADD PRIMARY KEY (`history_id`),
  ADD KEY `product_id` (`product_id`),
  ADD KEY `changed_by` (`changed_by`);

--
-- Indexes for table `3product_stock_by_location`
--
ALTER TABLE `3product_stock_by_location`
  ADD PRIMARY KEY (`product_id`,`location_id`),
  ADD KEY `location_id` (`location_id`);

--
-- Indexes for table `3reorder_requests`
--
ALTER TABLE `3reorder_requests`
  ADD PRIMARY KEY (`request_id`),
  ADD KEY `product_id` (`product_id`),
  ADD KEY `requested_by` (`requested_by`);

--
-- Indexes for table `4sales_daily_summary`
--
ALTER TABLE `4sales_daily_summary`
  ADD PRIMARY KEY (`summary_id`),
  ADD UNIQUE KEY `product_id` (`product_id`,`sales_date`);

--
-- Indexes for table `4sales_orders`
--
ALTER TABLE `4sales_orders`
  ADD PRIMARY KEY (`order_id`),
  ADD KEY `ordered_by` (`ordered_by`);

--
-- Indexes for table `4sales_order_items`
--
ALTER TABLE `4sales_order_items`
  ADD PRIMARY KEY (`item_id`),
  ADD KEY `order_id` (`order_id`),
  ADD KEY `product_id` (`product_id`);

--
-- Indexes for table `4sales_returns`
--
ALTER TABLE `4sales_returns`
  ADD PRIMARY KEY (`return_id`),
  ADD KEY `order_id` (`order_id`),
  ADD KEY `product_id` (`product_id`),
  ADD KEY `returned_by` (`returned_by`);

--
-- Indexes for table `5product_suppliers`
--
ALTER TABLE `5product_suppliers`
  ADD PRIMARY KEY (`product_id`,`supplier_id`),
  ADD KEY `supplier_id` (`supplier_id`);

--
-- Indexes for table `5suppliers`
--
ALTER TABLE `5suppliers`
  ADD PRIMARY KEY (`supplier_id`);

--
-- Indexes for table `6deliveries`
--
ALTER TABLE `6deliveries`
  ADD PRIMARY KEY (`delivery_id`),
  ADD KEY `order_id` (`order_id`),
  ADD KEY `delivered_by` (`delivered_by`);

--
-- Indexes for table `6delivery_items`
--
ALTER TABLE `6delivery_items`
  ADD PRIMARY KEY (`delivery_item_id`),
  ADD KEY `delivery_id` (`delivery_id`),
  ADD KEY `product_id` (`product_id`);

--
-- Indexes for table `6delivery_logs`
--
ALTER TABLE `6delivery_logs`
  ADD PRIMARY KEY (`log_id`),
  ADD KEY `delivery_id` (`delivery_id`),
  ADD KEY `updated_by` (`updated_by`);

--
-- Indexes for table `7supplier_deliveries`
--
ALTER TABLE `7supplier_deliveries`
  ADD PRIMARY KEY (`supplier_delivery_id`),
  ADD KEY `supplier_id` (`supplier_id`),
  ADD KEY `product_id` (`product_id`),
  ADD KEY `received_by` (`received_by`);

--
-- Indexes for table `8purchase_orders`
--
ALTER TABLE `8purchase_orders`
  ADD PRIMARY KEY (`po_id`),
  ADD UNIQUE KEY `po_number` (`po_number`),
  ADD KEY `supplier_id` (`supplier_id`),
  ADD KEY `ordered_by` (`ordered_by`);

--
-- Indexes for table `8purchase_order_items`
--
ALTER TABLE `8purchase_order_items`
  ADD PRIMARY KEY (`po_item_id`),
  ADD KEY `po_id` (`po_id`),
  ADD KEY `product_id` (`product_id`);

--
-- Indexes for table `9notifications`
--
ALTER TABLE `9notifications`
  ADD PRIMARY KEY (`notification_id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `role_id` (`role_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `1roles`
--
ALTER TABLE `1roles`
  MODIFY `role_id` tinyint(3) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `1users`
--
ALTER TABLE `1users`
  MODIFY `user_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `2user_activities`
--
ALTER TABLE `2user_activities`
  MODIFY `activity_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `2user_logins`
--
ALTER TABLE `2user_logins`
  MODIFY `login_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `3inventory_movements`
--
ALTER TABLE `3inventory_movements`
  MODIFY `movement_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `3locations`
--
ALTER TABLE `3locations`
  MODIFY `location_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `3products`
--
ALTER TABLE `3products`
  MODIFY `product_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `3product_history`
--
ALTER TABLE `3product_history`
  MODIFY `history_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `3reorder_requests`
--
ALTER TABLE `3reorder_requests`
  MODIFY `request_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `4sales_daily_summary`
--
ALTER TABLE `4sales_daily_summary`
  MODIFY `summary_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `4sales_orders`
--
ALTER TABLE `4sales_orders`
  MODIFY `order_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `4sales_order_items`
--
ALTER TABLE `4sales_order_items`
  MODIFY `item_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `4sales_returns`
--
ALTER TABLE `4sales_returns`
  MODIFY `return_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `5suppliers`
--
ALTER TABLE `5suppliers`
  MODIFY `supplier_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `6deliveries`
--
ALTER TABLE `6deliveries`
  MODIFY `delivery_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `6delivery_items`
--
ALTER TABLE `6delivery_items`
  MODIFY `delivery_item_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `6delivery_logs`
--
ALTER TABLE `6delivery_logs`
  MODIFY `log_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `7supplier_deliveries`
--
ALTER TABLE `7supplier_deliveries`
  MODIFY `supplier_delivery_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `8purchase_orders`
--
ALTER TABLE `8purchase_orders`
  MODIFY `po_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `8purchase_order_items`
--
ALTER TABLE `8purchase_order_items`
  MODIFY `po_item_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `9notifications`
--
ALTER TABLE `9notifications`
  MODIFY `notification_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `1users`
--
ALTER TABLE `1users`
  ADD CONSTRAINT `1users_ibfk_1` FOREIGN KEY (`status_id`) REFERENCES `1user_statuses` (`status_id`);

--
-- Constraints for table `1user_roles`
--
ALTER TABLE `1user_roles`
  ADD CONSTRAINT `1user_roles_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `1users` (`user_id`),
  ADD CONSTRAINT `1user_roles_ibfk_2` FOREIGN KEY (`role_id`) REFERENCES `1roles` (`role_id`);

--
-- Constraints for table `2user_activities`
--
ALTER TABLE `2user_activities`
  ADD CONSTRAINT `2user_activities_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `1users` (`user_id`);

--
-- Constraints for table `2user_logins`
--
ALTER TABLE `2user_logins`
  ADD CONSTRAINT `2user_logins_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `1users` (`user_id`);

--
-- Constraints for table `2user_presence`
--
ALTER TABLE `2user_presence`
  ADD CONSTRAINT `2user_presence_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `1users` (`user_id`);

--
-- Constraints for table `3inventory_movements`
--
ALTER TABLE `3inventory_movements`
  ADD CONSTRAINT `3inventory_movements_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `3products` (`product_id`),
  ADD CONSTRAINT `3inventory_movements_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `1users` (`user_id`);

--
-- Constraints for table `3product_history`
--
ALTER TABLE `3product_history`
  ADD CONSTRAINT `3product_history_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `3products` (`product_id`),
  ADD CONSTRAINT `3product_history_ibfk_2` FOREIGN KEY (`changed_by`) REFERENCES `1users` (`user_id`);

--
-- Constraints for table `3product_stock_by_location`
--
ALTER TABLE `3product_stock_by_location`
  ADD CONSTRAINT `3product_stock_by_location_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `3products` (`product_id`),
  ADD CONSTRAINT `3product_stock_by_location_ibfk_2` FOREIGN KEY (`location_id`) REFERENCES `3locations` (`location_id`);

--
-- Constraints for table `3reorder_requests`
--
ALTER TABLE `3reorder_requests`
  ADD CONSTRAINT `3reorder_requests_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `3products` (`product_id`),
  ADD CONSTRAINT `3reorder_requests_ibfk_2` FOREIGN KEY (`requested_by`) REFERENCES `1users` (`user_id`);

--
-- Constraints for table `4sales_daily_summary`
--
ALTER TABLE `4sales_daily_summary`
  ADD CONSTRAINT `4sales_daily_summary_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `3products` (`product_id`);

--
-- Constraints for table `4sales_orders`
--
ALTER TABLE `4sales_orders`
  ADD CONSTRAINT `4sales_orders_ibfk_1` FOREIGN KEY (`ordered_by`) REFERENCES `1users` (`user_id`);

--
-- Constraints for table `4sales_order_items`
--
ALTER TABLE `4sales_order_items`
  ADD CONSTRAINT `4sales_order_items_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `4sales_orders` (`order_id`),
  ADD CONSTRAINT `4sales_order_items_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `3products` (`product_id`);

--
-- Constraints for table `4sales_returns`
--
ALTER TABLE `4sales_returns`
  ADD CONSTRAINT `4sales_returns_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `4sales_orders` (`order_id`),
  ADD CONSTRAINT `4sales_returns_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `3products` (`product_id`),
  ADD CONSTRAINT `4sales_returns_ibfk_3` FOREIGN KEY (`returned_by`) REFERENCES `1users` (`user_id`);

--
-- Constraints for table `5product_suppliers`
--
ALTER TABLE `5product_suppliers`
  ADD CONSTRAINT `5product_suppliers_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `3products` (`product_id`),
  ADD CONSTRAINT `5product_suppliers_ibfk_2` FOREIGN KEY (`supplier_id`) REFERENCES `5suppliers` (`supplier_id`);

--
-- Constraints for table `6deliveries`
--
ALTER TABLE `6deliveries`
  ADD CONSTRAINT `6deliveries_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `4sales_orders` (`order_id`),
  ADD CONSTRAINT `6deliveries_ibfk_2` FOREIGN KEY (`delivered_by`) REFERENCES `1users` (`user_id`);

--
-- Constraints for table `6delivery_items`
--
ALTER TABLE `6delivery_items`
  ADD CONSTRAINT `6delivery_items_ibfk_1` FOREIGN KEY (`delivery_id`) REFERENCES `6deliveries` (`delivery_id`),
  ADD CONSTRAINT `6delivery_items_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `3products` (`product_id`);

--
-- Constraints for table `6delivery_logs`
--
ALTER TABLE `6delivery_logs`
  ADD CONSTRAINT `6delivery_logs_ibfk_1` FOREIGN KEY (`delivery_id`) REFERENCES `6deliveries` (`delivery_id`),
  ADD CONSTRAINT `6delivery_logs_ibfk_2` FOREIGN KEY (`updated_by`) REFERENCES `1users` (`user_id`);

--
-- Constraints for table `7supplier_deliveries`
--
ALTER TABLE `7supplier_deliveries`
  ADD CONSTRAINT `7supplier_deliveries_ibfk_1` FOREIGN KEY (`supplier_id`) REFERENCES `5suppliers` (`supplier_id`),
  ADD CONSTRAINT `7supplier_deliveries_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `3products` (`product_id`),
  ADD CONSTRAINT `7supplier_deliveries_ibfk_3` FOREIGN KEY (`received_by`) REFERENCES `1users` (`user_id`);

--
-- Constraints for table `8purchase_orders`
--
ALTER TABLE `8purchase_orders`
  ADD CONSTRAINT `8purchase_orders_ibfk_1` FOREIGN KEY (`supplier_id`) REFERENCES `5suppliers` (`supplier_id`),
  ADD CONSTRAINT `8purchase_orders_ibfk_2` FOREIGN KEY (`ordered_by`) REFERENCES `1users` (`user_id`);

--
-- Constraints for table `8purchase_order_items`
--
ALTER TABLE `8purchase_order_items`
  ADD CONSTRAINT `8purchase_order_items_ibfk_1` FOREIGN KEY (`po_id`) REFERENCES `8purchase_orders` (`po_id`),
  ADD CONSTRAINT `8purchase_order_items_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `3products` (`product_id`);

--
-- Constraints for table `9notifications`
--
ALTER TABLE `9notifications`
  ADD CONSTRAINT `9notifications_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `1users` (`user_id`),
  ADD CONSTRAINT `9notifications_ibfk_2` FOREIGN KEY (`role_id`) REFERENCES `1roles` (`role_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
