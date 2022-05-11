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
  `isbn` varchar(64) DEFAULT '',
  `publisher_id` varchar(64) DEFAULT '',
  `pages` int(11) DEFAULT 0,
  `book_type` varchar(50) DEFAULT '',
  `publishing_date` varchar(50) DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `Book_Created_By_FK` (`created_by`),
  CONSTRAINT `Book_Created_By_FK` FOREIGN KEY (`created_by`) REFERENCES `users_tbl` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table library_db.penalties_tbl
CREATE TABLE IF NOT EXISTS `penalties_tbl` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `created_by` bigint(20) DEFAULT NULL,
  `description` varchar(128) NOT NULL,
  `punished_id` bigint(20) NOT NULL DEFAULT 0,
  `punisher_id` bigint(20) NOT NULL,
  `is_resolved` tinyint(1) NOT NULL DEFAULT 0,
  `remarks` varchar(128) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `Penalty_Created_By_FK` (`created_by`),
  KEY `Penalty_Punished_FK` (`punished_id`),
  KEY `Penalty_Punisher_FK` (`punisher_id`),
  CONSTRAINT `Penalty_Created_By_FK` FOREIGN KEY (`created_by`) REFERENCES `users_tbl` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `Penalty_Punished_FK` FOREIGN KEY (`punished_id`) REFERENCES `users_tbl` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `Penalty_Punisher_FK` FOREIGN KEY (`punisher_id`) REFERENCES `users_tbl` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table library_db.transactions_tbl
CREATE TABLE IF NOT EXISTS `transactions_tbl` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `created_by` bigint(20) NOT NULL,
  `date_borrowed` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `state` enum('RETURNED','BORROWED') NOT NULL DEFAULT 'BORROWED',
  `book_id` bigint(20) NOT NULL,
  `date_of_return` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `return_code` varchar(6) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `Book_FK` (`book_id`),
  KEY `Transaction_Created_By_FK` (`created_by`),
  CONSTRAINT `Book_FK` FOREIGN KEY (`book_id`) REFERENCES `books_tbl` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `Transaction_Created_By_FK` FOREIGN KEY (`created_by`) REFERENCES `users_tbl` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table library_db.users_tbl
CREATE TABLE IF NOT EXISTS `users_tbl` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `first_name` varchar(50) NOT NULL,
  `last_name` varchar(50) NOT NULL,
  `birthday` date NOT NULL,
  `email` varchar(50) NOT NULL,
  `type` enum('ADMIN','USER') NOT NULL DEFAULT 'USER',
  `gender` enum('MALE','FEMALE') NOT NULL,
  `strand` varchar(50) DEFAULT NULL,
  `address` varchar(255) NOT NULL,
  `phone_number` varchar(50) NOT NULL,
  `guardian_phone_number` varchar(50) DEFAULT NULL,
  `school_id_image_location` varchar(255) DEFAULT NULL,
  `password` varchar(72) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
