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

-- Dumping data for table library_db.books_tbl: ~3 rows (approximately)
/*!40000 ALTER TABLE `books_tbl` DISABLE KEYS */;
REPLACE INTO `books_tbl` (`id`, `created_by`, `title`, `publisher`, `author`, `stock`, `cover_image_location`) VALUES
	(2, 1, 'Genki 1', 'Eri Banno, Yoko Ikeda, Yukata Ohno', 'Eri Banno, Yoko Ikeda, Yukata Ohno', 9, '/public/genki1.jpg');
/*!40000 ALTER TABLE `books_tbl` ENABLE KEYS */;

-- Dumping data for table library_db.penalties_tbl: ~0 rows (approximately)
/*!40000 ALTER TABLE `penalties_tbl` DISABLE KEYS */;
/*!40000 ALTER TABLE `penalties_tbl` ENABLE KEYS */;

-- Dumping data for table library_db.transactions_tbl: ~1 rows (approximately)
/*!40000 ALTER TABLE `transactions_tbl` DISABLE KEYS */;
/*!40000 ALTER TABLE `transactions_tbl` ENABLE KEYS */;

-- Dumping data for table library_db.users_tbl: ~3 rows (approximately)
/*!40000 ALTER TABLE `users_tbl` DISABLE KEYS */;
REPLACE INTO `users_tbl` (`id`, `first_name`, `last_name`, `birthday`, `email`, `type`, `gender`, `section`, `address`, `phone_number`, `guardian_phone_number`, `school_id_image_location`, `password`) VALUES
	(1, 'Admin', 'User', '2002-02-02', 'keenplify@gmail.com', 'ADMIN', 'MALE', 'SBIT-2F', '107-1195, Roppongi Izumigadentawa, Tokyo, Japan', '81723722129', '09062281049', NULL, '$2y$10$6MlGi/Vi1cLeHhHB/Ea5geNECev72.R4XCCmgwe5vCN6mq7H/NU7C'),
	(2, 'Test', 'User', '2022-04-19', 'testuser@site.com', 'USER', 'MALE', 'SBIT-2F', '458-1047, Daimon Imizu-shi, Toyama, Japan', '81812844848', '81823680896', NULL, '$2y$10$htVLtc/mV5JEmK2XK9l6de1xK53M5lsEaUR8MiHdITYK0Hfwu.Vk2'),
	(4, 'John', 'Smith', '2001-01-01', 'johnsmith@site.com', 'USER', 'FEMALE', 'SBIT-2Z', '12q312', '4432432', '4432432', '/public/aaa.png', '$2a$10$RPquUEeImHli.TkwVtFrjusDJSqdvbadhXWym2mP8Q70cE4O0bwBq');
/*!40000 ALTER TABLE `users_tbl` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
