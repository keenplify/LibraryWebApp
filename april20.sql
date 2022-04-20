-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               10.6.7-MariaDB - mariadb.org binary distribution
-- Server OS:                    Win64
-- HeidiSQL Version:             11.3.0.6295
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Dumping database structure for library_db
CREATE DATABASE IF NOT EXISTS `library_db` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `library_db`;

-- Dumping structure for table library_db.books_tbl
CREATE TABLE IF NOT EXISTS `books_tbl` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `created_by` bigint(20) NOT NULL DEFAULT 0,
  `title` varchar(50) NOT NULL,
  `publisher` varchar(255) NOT NULL DEFAULT '0',
  `author` varchar(255) NOT NULL,
  `stock` int(11) NOT NULL,
  `cover_image_location` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `Book_Created_By_FK` (`created_by`),
  CONSTRAINT `Book_Created_By_FK` FOREIGN KEY (`created_by`) REFERENCES `users_tbl` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

-- Dumping data for table library_db.books_tbl: ~1 rows (approximately)
/*!40000 ALTER TABLE `books_tbl` DISABLE KEYS */;
INSERT INTO `books_tbl` (`id`, `created_by`, `title`, `publisher`, `author`, `stock`, `cover_image_location`) VALUES
	(2, 1, 'Genki 1', 'Eri Banno, Yoko Ikeda, Yukata Ohno', 'Eri Banno, Yoko Ikeda, Yukata Ohno', 9, '/public/genki1.jpg');
/*!40000 ALTER TABLE `books_tbl` ENABLE KEYS */;

-- Dumping structure for table library_db.penalties_tbl
CREATE TABLE IF NOT EXISTS `penalties_tbl` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `created_by` bigint(20) DEFAULT NULL,
  `description` varchar(50) NOT NULL,
  `punished_id` bigint(20) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `Penalty_Created_By_FK` (`created_by`),
  KEY `Penalty_Punished_FK` (`punished_id`),
  CONSTRAINT `Penalty_Created_By_FK` FOREIGN KEY (`created_by`) REFERENCES `users_tbl` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `Penalty_Punished_FK` FOREIGN KEY (`punished_id`) REFERENCES `users_tbl` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table library_db.penalties_tbl: ~0 rows (approximately)
/*!40000 ALTER TABLE `penalties_tbl` DISABLE KEYS */;
/*!40000 ALTER TABLE `penalties_tbl` ENABLE KEYS */;

-- Dumping structure for table library_db.transactions_tbl
CREATE TABLE IF NOT EXISTS `transactions_tbl` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `created_by` bigint(20) NOT NULL,
  `date_borrowed` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `state` enum('RETURNED','BORROWED') NOT NULL DEFAULT 'BORROWED',
  `book_id` bigint(20) NOT NULL,
  `date_of_return` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`),
  KEY `Book_FK` (`book_id`),
  KEY `Transaction_Created_By_FK` (`created_by`),
  CONSTRAINT `Book_FK` FOREIGN KEY (`book_id`) REFERENCES `books_tbl` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `Transaction_Created_By_FK` FOREIGN KEY (`created_by`) REFERENCES `users_tbl` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

-- Dumping data for table library_db.transactions_tbl: ~0 rows (approximately)
/*!40000 ALTER TABLE `transactions_tbl` DISABLE KEYS */;
/*!40000 ALTER TABLE `transactions_tbl` ENABLE KEYS */;

-- Dumping structure for table library_db.users_tbl
CREATE TABLE IF NOT EXISTS `users_tbl` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `first_name` varchar(50) NOT NULL,
  `last_name` varchar(50) NOT NULL,
  `birthday` date NOT NULL,
  `email` varchar(50) NOT NULL,
  `type` enum('ADMIN','USER') NOT NULL DEFAULT 'USER',
  `gender` enum('MALE','FEMALE') NOT NULL,
  `section` varchar(50) DEFAULT NULL,
  `address` varchar(255) NOT NULL,
  `phone_number` varchar(50) NOT NULL,
  `guardian_phone_number` varchar(50) DEFAULT NULL,
  `school_id_image_location` varchar(255) DEFAULT NULL,
  `password` varchar(72) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

-- Dumping data for table library_db.users_tbl: ~3 rows (approximately)
/*!40000 ALTER TABLE `users_tbl` DISABLE KEYS */;
INSERT INTO `users_tbl` (`id`, `first_name`, `last_name`, `birthday`, `email`, `type`, `gender`, `section`, `address`, `phone_number`, `guardian_phone_number`, `school_id_image_location`, `password`) VALUES
	(1, 'Admin', 'User', '2002-02-02', 'keenplify@gmail.com', 'ADMIN', 'MALE', 'SBIT-2F', '107-1195, Roppongi Izumigadentawa, Tokyo, Japan', '81723722129', '09062281049', NULL, '$2y$10$6MlGi/Vi1cLeHhHB/Ea5geNECev72.R4XCCmgwe5vCN6mq7H/NU7C'),
	(2, 'Test', 'User', '2022-04-19', 'testuser@site.com', 'USER', 'MALE', 'SBIT-2F', '458-1047, Daimon Imizu-shi, Toyama, Japan', '81812844848', '81823680896', NULL, '$2y$10$htVLtc/mV5JEmK2XK9l6de1xK53M5lsEaUR8MiHdITYK0Hfwu.Vk2'),
	(4, 'John', 'Smith', '2001-01-01', 'johnsmith@site.com', 'USER', 'FEMALE', 'SBIT-2Z', '12q312', '4432432', '4432432', '/public/aaa.png', '$2a$10$RPquUEeImHli.TkwVtFrjusDJSqdvbadhXWym2mP8Q70cE4O0bwBq');
/*!40000 ALTER TABLE `users_tbl` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
