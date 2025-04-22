-- CREATE DATABASE
CREATE DATABASE IF NOT EXISTS `dbmobile`;
USE `dbmobile`;

-- CREATE TABLE with constraints and indexes directly
CREATE TABLE `productmobile` (
  `MobileID` INT(11) NOT NULL AUTO_INCREMENT,
  `ProductID` INT(11) NOT NULL,
  PRIMARY KEY (`MobileID`),
  KEY `ProductID` (`ProductID`),
  CONSTRAINT `productmobile_ibfk_1` 
    FOREIGN KEY (`ProductID`) REFERENCES `dbmanagement`.`product` (`ProductID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- CREATE VIEW (pastikan tabel 'product' di database 'dbmanagement' sudah ada)
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `mobilefullview` AS 
SELECT 
  `p`.`ProductID` AS `ProductID`, 
  `p`.`Product` AS `Product`, 
  `p`.`Brand` AS `Brand`, 
  `p`.`Model` AS `Model`, 
  `pb`.`MobileID` AS `MobileID`
FROM `dbmanagement`.`product` `p`
JOIN `productmobile` `pb` ON `p`.`ProductID` = `pb`.`ProductID`;

