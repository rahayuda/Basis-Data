-- CREATE DATABASE
CREATE DATABASE IF NOT EXISTS `dbfulfillment`;
USE `dbfulfillment`;

-- CREATE TABLE payment
CREATE TABLE `payment` (
  `PaymentID` int(11) NOT NULL AUTO_INCREMENT,
  `OrderRequestID` int(11) NOT NULL,
  `PaymentDate` date NOT NULL,
  `Amount` decimal(10,2) NOT NULL,
  `Method` varchar(50) NOT NULL,
  PRIMARY KEY (`PaymentID`),
  KEY `OrderRequestID` (`OrderRequestID`),
  CONSTRAINT `payment_ibfk_1` FOREIGN KEY (`OrderRequestID`) REFERENCES `dbmanagement`.`orderrequest` (`OrderRequestID`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- CREATE TABLE shipment
CREATE TABLE `shipment` (
  `ShipmentID` int(11) NOT NULL AUTO_INCREMENT,
  `PaymentID` int(11) NOT NULL,
  `ShipmentDate` date NOT NULL,
  `Status` varchar(50) NOT NULL,
  PRIMARY KEY (`ShipmentID`),
  KEY `PaymentID` (`PaymentID`),
  CONSTRAINT `shipment_ibfk_1` FOREIGN KEY (`PaymentID`) REFERENCES `payment` (`PaymentID`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
