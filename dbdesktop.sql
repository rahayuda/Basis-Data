-- CREATE DATABASE
CREATE DATABASE IF NOT EXISTS `dbdesktop`;
USE `dbdesktop`;

-- CREATE TABLE productdesktop
CREATE TABLE `productdesktop` (
  `DesktopID` int(11) NOT NULL AUTO_INCREMENT,
  `ProductID` int(11) NOT NULL,
  PRIMARY KEY (`DesktopID`),
  KEY `ProductID` (`ProductID`),
  CONSTRAINT `productdesktop_ibfk_1` FOREIGN KEY (`ProductID`) REFERENCES `dbmanagement`.`product` (`ProductID`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- CREATE VIEW desktopfullview
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `desktopfullview` AS 
SELECT 
  `p`.`ProductID` AS `ProductID`, 
  `p`.`Product` AS `Product`, 
  `p`.`Brand` AS `Brand`, 
  `p`.`Model` AS `Model`, 
  `pb`.`DesktopID` AS `DesktopID`
FROM 
  `dbmanagement`.`product` `p`
  JOIN `productdesktop` `pb` ON (`p`.`ProductID` = `pb`.`ProductID`);
