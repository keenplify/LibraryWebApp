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
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=latin1;

-- Dumping data for table library_db.books_tbl: ~4 rows (approximately)
/*!40000 ALTER TABLE `books_tbl` DISABLE KEYS */;
INSERT INTO `books_tbl` (`id`, `created_by`, `title`, `publisher`, `author`, `stock`, `cover_image_location`) VALUES
	(2, 1, 'Genki 1', 'Eri Banno, Yoko Ikeda, Yukata Ohno', 'Eri Banno, Yoko Ikeda, Yukata Ohno', 5, '/public/book-cover-37852-2022-04-21 10_04_58-Window.png'),
	(6, 1, 'Sunday Service', 'Choir', 'West', 5, '/public/book-cover-87914-2022-04-20 23_39_32-Window.png'),
	(7, 1, 'Wagahai wa Neko de Aru', 'Tuttle Publishing', 'Natsume Souseki', 5, '/public/book-cover-80498-o0898128014681528787.jpg'),
	(8, 1, 'The Enchiridion', 'THE LIBERAL ARTS PRESS New York', 'Epictitus', 3, '/public/book-cover-66291-9781647985905.jpg'),
	(9, 1, 'Genki 2', 'Eri Banno', 'Eri Banno', 5, '/public/book-cover-39251-2022-04-20 16_54_43-Window.png'),
	(10, 1, 'The Republic', 'Simon & Schuster', 'Plato', 8, '/public/book-cover-82037-the-republic-64.jpg');
/*!40000 ALTER TABLE `books_tbl` ENABLE KEYS */;

-- Dumping structure for table library_db.penalties_tbl
CREATE TABLE IF NOT EXISTS `penalties_tbl` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `created_by` bigint(20) DEFAULT NULL,
  `description` varchar(50) NOT NULL,
  `punished_id` bigint(20) NOT NULL DEFAULT 0,
  `punisher_id` bigint(20) NOT NULL,
  `is_resolved` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `Penalty_Created_By_FK` (`created_by`),
  KEY `Penalty_Punished_FK` (`punished_id`),
  KEY `Penalty_Punisher_FK` (`punisher_id`),
  CONSTRAINT `Penalty_Created_By_FK` FOREIGN KEY (`created_by`) REFERENCES `users_tbl` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `Penalty_Punished_FK` FOREIGN KEY (`punished_id`) REFERENCES `users_tbl` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `Penalty_Punisher_FK` FOREIGN KEY (`punisher_id`) REFERENCES `users_tbl` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

-- Dumping data for table library_db.penalties_tbl: ~2 rows (approximately)
/*!40000 ALTER TABLE `penalties_tbl` DISABLE KEYS */;
INSERT INTO `penalties_tbl` (`id`, `created_by`, `description`, `punished_id`, `punisher_id`, `is_resolved`) VALUES
	(1, 1, 'hehe', 2, 1, 0),
	(2, 1, 'dsadsa', 2, 1, 1);
/*!40000 ALTER TABLE `penalties_tbl` ENABLE KEYS */;

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
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=latin1;

-- Dumping data for table library_db.transactions_tbl: ~4 rows (approximately)
/*!40000 ALTER TABLE `transactions_tbl` DISABLE KEYS */;
INSERT INTO `transactions_tbl` (`id`, `created_by`, `date_borrowed`, `state`, `book_id`, `date_of_return`, `return_code`) VALUES
	(5, 2, '2022-04-21 20:40:50', 'RETURNED', 2, '2022-04-22 00:00:00', '123456'),
	(6, 2, '2022-04-22 08:59:17', 'BORROWED', 6, '2022-04-20 00:00:00', '623211'),
	(7, 2, '2022-04-21 20:40:28', 'BORROWED', 2, '2022-04-28 00:00:00', '757992'),
	(8, 2, '2022-04-22 00:07:43', 'RETURNED', 7, '2022-04-25 00:00:00', '815940'),
	(9, 2, '2022-04-22 09:49:24', 'BORROWED', 8, '2022-04-29 00:00:00', '274151');
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
	(1, 'Admin', 'User', '2002-02-02', 'keenplify@gmail.com', 'ADMIN', 'MALE', 'SBIT-2F', '107-1195, Roppongi Izumigadentawa, Tokyo, Japan', '81723722129', '09062281049', '/public/aaa.png', '$2y$10$6MlGi/Vi1cLeHhHB/Ea5geNECev72.R4XCCmgwe5vCN6mq7H/NU7C'),
	(2, 'Test', 'User', '2022-04-19', 'testuser@site.com', 'USER', 'FEMALE', 'SBIT-2F', '458-1047, Daimon Imizu-shi, Toyama, Japan', '81812844848', '12345678901', '/public/aaa.png', '$2a$10$3h37kicHxm5XZy962ivNQeKbkYJjBz4cPlxueGf9e6ZbL0TEGYeMu'),
	(4, 'John', 'Smith', '2001-01-01', 'johnsmith@site.com', 'USER', 'FEMALE', 'SBIT-2Z', '12q312', '4432432', '4432432', '/public/aaa.png', '$2a$10$RPquUEeImHli.TkwVtFrjusDJSqdvbadhXWym2mP8Q70cE4O0bwBq');
/*!40000 ALTER TABLE `users_tbl` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
