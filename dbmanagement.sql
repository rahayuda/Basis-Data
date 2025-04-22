-- =============================================
-- DATABASE INITIALIZATION
-- =============================================

CREATE DATABASE IF NOT EXISTS dbmanagement;
USE dbmanagement;

-- =============================================
-- TABLE DEFINITIONS
-- =============================================

-- Table: customer
CREATE TABLE `customer` (
  `CustomerID` INT AUTO_INCREMENT PRIMARY KEY,
  `CustomerName` VARCHAR(100) NOT NULL,
  `Saldo` DECIMAL(10,2) NOT NULL CHECK (`Saldo` > 500),
  `Email` VARCHAR(100),
  `Alamat` TEXT,
  KEY `idx_customer_saldo` (`CustomerName`),
  KEY `idx_customer_email` (`Email`) USING HASH,
  FULLTEXT KEY `idx_fulltext_alamat` (`Alamat`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Table: customerpartition
CREATE TABLE `customerpartition` (
  `CustomerID` INT NOT NULL,
  `CustomerName` VARCHAR(255),
  `Saldo` DECIMAL(10,2) NOT NULL,
  `Email` VARCHAR(255),
  `Alamat` VARCHAR(255),
  PRIMARY KEY (`CustomerID`, `Saldo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci
PARTITION BY RANGE (`Saldo`) (
  PARTITION p0 VALUES LESS THAN (750),
  PARTITION p1 VALUES LESS THAN (1000),
  PARTITION p2 VALUES LESS THAN (1250),
  PARTITION p3 VALUES LESS THAN MAXVALUE
);

-- Table: product
CREATE TABLE `product` (
  `ProductID` INT AUTO_INCREMENT PRIMARY KEY,
  `Product` VARCHAR(50) NOT NULL,
  `Brand` VARCHAR(50) NOT NULL,
  `Model` VARCHAR(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Table: orderrequest
CREATE TABLE `orderrequest` (
  `OrderRequestID` INT AUTO_INCREMENT PRIMARY KEY,
  `CustomerID` INT NOT NULL,
  `ProductID` INT NOT NULL,
  `Quantity` INT NOT NULL,
  `OrderDate` DATE NOT NULL,
  KEY `CustomerID` (`CustomerID`),
  KEY `ProductID` (`ProductID`),
  CONSTRAINT `orderrequest_ibfk_1` FOREIGN KEY (`CustomerID`) REFERENCES `customer` (`CustomerID`),
  CONSTRAINT `orderrequest_ibfk_2` FOREIGN KEY (`ProductID`) REFERENCES `product` (`ProductID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- =============================================
-- TRIGGERS & EVENTS
-- =============================================

DELIMITER $$

-- Trigger: Replication
CREATE TRIGGER `Replication` AFTER INSERT ON `product` FOR EACH ROW 
BEGIN
  INSERT INTO DBBackup.ProductBackup (ProductID) VALUES (NEW.ProductID);
END$$

-- Trigger: Sharding
CREATE TRIGGER `sharding` AFTER INSERT ON `product` FOR EACH ROW 
BEGIN
  IF NEW.Product IN ('Laptop', 'Computer') THEN
    INSERT INTO dbdesktop.ProductDesktop (ProductID) VALUES (NEW.ProductID);
  END IF;
  IF NEW.Product IN ('Phone', 'Tablet', 'Smart Watch', 'Smart Band', 'Smart Ring') THEN
    INSERT INTO dbmobile.ProductMobile (ProductID) VALUES (NEW.ProductID);
  END IF;
END$$

-- Event: SyncCustomer
CREATE DEFINER=`root`@`localhost` EVENT `SyncCustomer` 
ON SCHEDULE EVERY 1 DAY 
STARTS CURRENT_TIMESTAMP 
DO
BEGIN
  INSERT INTO dbbackup.customer_backup SELECT * FROM customer;
END$$

DELIMITER ;
