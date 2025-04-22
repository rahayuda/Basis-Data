-- CREATE DATABASE
CREATE DATABASE IF NOT EXISTS `dbbackup`;
USE `dbbackup`;

-- CREATE TABLE customerbackup
CREATE TABLE `customerbackup` (
  `BackupID` int(11) NOT NULL AUTO_INCREMENT,
  `CustomerID` int(11) DEFAULT NULL,
  PRIMARY KEY (`BackupID`),
  KEY `CustomerID` (`CustomerID`),
  CONSTRAINT `customerbackup_ibfk_1` FOREIGN KEY (`CustomerID`) REFERENCES `dbmanagement`.`customer` (`CustomerID`)
) ENGINE=InnoDB AUTO_INCREMENT=5132 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- CREATE TABLE productbackup
CREATE TABLE `productbackup` (
  `BackupID` int(11) NOT NULL AUTO_INCREMENT,
  `ProductID` int(11) NOT NULL,
  PRIMARY KEY (`BackupID`),
  KEY `ProductID` (`ProductID`),
  CONSTRAINT `productbackup_ibfk_1` FOREIGN KEY (`ProductID`) REFERENCES `dbmanagement`.`product` (`ProductID`)
) ENGINE=InnoDB AUTO_INCREMENT=55 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- CREATE VIEW backupfullview
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `backupfullview` AS 
SELECT 
  `p`.`ProductID` AS `ProductID`, 
  `p`.`Product` AS `Product`, 
  `p`.`Brand` AS `Brand`, 
  `p`.`Model` AS `Model`, 
  `pb`.`BackupID` AS `BackupID`
FROM 
  `dbmanagement`.`product` `p`
  JOIN `productbackup` `pb` ON (`p`.`ProductID` = `pb`.`ProductID`);

-- CREATE VIEW customerfullview
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `customerfullview` AS 
SELECT 
  `p`.`CustomerID` AS `CustomerID`, 
  `p`.`CustomerName` AS `CustomerName`, 
  `p`.`Saldo` AS `Saldo`, 
  `p`.`Email` AS `Email`, 
  `pb`.`BackupID` AS `BackupID`
FROM 
  `dbmanagement`.`customer` `p`
  JOIN `customerbackup` `pb` ON (`p`.`CustomerID` = `pb`.`CustomerID`);
