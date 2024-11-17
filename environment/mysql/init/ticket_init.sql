CREATE DATABASE IF NOT EXISTS vetautet
       DEFAULT CHARSET = utf8mb4
       COLLATE = utf8mb4_unicode_ci;

-- 1. Ticket table
CREATE TABLE IF NOT EXISTS `vetautet`.`ticket` (
    `id` BIGINT(20) NOT NULL AUTO_INCREMENT COMMENT 'primary key',
    `name` VARCHAR(50) NOT NULL COMMENT 'ticket name',
    `desc` TEXT COMMENT 'ticket description',
    `start_time` DATETIME NOT NULL COMMENT 'ticket sale start time',
    `end_time` DATETIME NOT NULL COMMENT 'ticket sale end time',
    `status` INT(11) NOT NULL DEFAULT 0 COMMENT 'ticket sale activity status, 0: deactivate, 1: activate',
    `updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'last update time',
    `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'creation time',
    PRIMARY KEY (`id`),
    KEY `idx_end_time` (`end_time`),
    KEY `idx_start_time` (`start_time`),
    KEY `idx_status` (`status`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT 'ticket table';

-- 2. Ticket detail (item) table
CREATE TABLE IF NOT EXISTS `vetautet`.`ticket_item` (
    `id` BIGINT(20) NOT NULL AUTO_INCREMENT COMMENT 'primary key',
    `name` VARCHAR(50) NOT NULL COMMENT 'ticket title',
    `description` TEXT COMMENT 'ticket description',
    `stock_initial` INT(11) NOT NULL DEFAULT 0 COMMENT 'initial stock quantity (e.g. 1000 tickets)',
    `stock_available` INT(11) NOT NULL DEFAULT 0 COMMENT 'current available stock (e.g. 900 tickets)',
    `is_stock_prepared` BOOLEAN NOT NULL DEFAULT 0 COMMENT 'indicates if stock is pre-warmed (0/1), warm up cache',
    `price_original` BIGINT(20) NOT NULL COMMENT 'original ticket price (e.g. 100k/ticket)',
    `price_flash` BIGINT(20) NOT NULL COMMENT 'discounted price during flash sale',
    `sale_start_time` DATETIME NOT NULL COMMENT 'flash sale start time',
    `sale_end_time` DATETIME NOT NULL COMMENT 'flash sale end time',
    `status` INT(11) NOT NULL DEFAULT 0 COMMENT 'ticket status (e.g. active/inactive)',
    `activity_id` BIGINT(20) NOT NULL COMMENT 'id of associated activity',
    `updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'last update time',
    `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'creation time',
    PRIMARY KEY (`id`),
    KEY `idx_end_time` (`end_time`),
    KEY `idx_start_time` (`start_time`),
    KEY `idx_status` (`status`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT 'ticket detail table';

-- Insert mock date
-- Insert data into `ticket` table
INSERT INTO `vetautet`.`ticket` (`name`, `desc` ,`start_time`, `end_time`, `status`, `updated_at`, `created_at`)
VALUES
    ('Đợt mở bán vé ngày 12/12', 'Sự kiện mở bán vé đặc biệt cho ngày 12/12', '2024-12-12 00:00:00', '2024-12-13 00:00:00'),
    ('Đợt mở bán vé ngày 01/01', 'Sự kiện mở bán vé cho ngày đầu năm mới 12/12', '2025-01-01 00:00:00');

-- Insert data into `ticket_item` table corresponding to each event in `ticket` table
INSERT INTO `vetautet`.`ticket_item` (`name`, `description`, `stock_initial`, `stock_available`, `is_stock_prepared`)
VALUES
    -- Ticket items for the 12/12 event
    ('Vé sự kiện 12/12 - Hạng phổ thông', 'Vé phổ thông cho ngày 12/12', 1000),
    ('Vé sự kiện 12/12 - Hạng VIP', 'Vé VIP cho ngày 12/12', 500, 500),

    -- Ticket items for the 01/01 event
    ('Vé sự kiện 01/01 - Hạng phổ thông', 'Vé phổ thông cho ngày 01/01', 2000),
    ('Vé sự kiện 01/01 - Hạng VIP', 'Vé VIP cho ngày 01/01', 1000, 1000);
