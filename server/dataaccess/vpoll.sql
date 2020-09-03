-- phpMyAdmin SQL Dump
-- version 4.8.3
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Sep 03, 2020 at 04:57 PM
-- Server version: 10.1.35-MariaDB
-- PHP Version: 7.2.9

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `vpoll`
--

DELIMITER $$
--
-- Functions
--
CREATE DEFINER=`root`@`localhost` FUNCTION `get_votes_count` (`_question_id` INT) RETURNS INT(11) BEGIN

DECLARE _count int(3);

select count(*) into _count
from votes 
where question_id = _question_id;

return _count;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `questions`
--

CREATE TABLE `questions` (
  `id` int(11) NOT NULL,
  `text` varchar(500) DEFAULT NULL,
  `date` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `questions`
--

INSERT INTO `questions` (`id`, `text`, `date`) VALUES
(1, 'Is bitcoin worth the time and money that mining requires?', '2020-09-03'),
(2, 'Should chatbots replace humans in customer service jobs?', '2020-01-15'),
(3, 'Will the economics of Shehzhen and Guangzhou overtake Hong?', '2020-01-12'),
(4, 'Will new benefits encourage you to study or work in mainlan?', '2020-01-10'),
(5, 'Should police officer be exempt from criminal liability at work?', '2020-01-09');

-- --------------------------------------------------------

--
-- Table structure for table `votes`
--

CREATE TABLE `votes` (
  `question_id` int(11) NOT NULL,
  `vote_value` tinyint(1) NOT NULL DEFAULT '1' COMMENT '0 mean No, 1 mean Yes',
  `casted_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `votes`
--

INSERT INTO `votes` (`question_id`, `vote_value`, `casted_at`) VALUES
(1, 1, '2020-09-03 13:22:36'),
(1, 1, '2020-09-03 13:22:41'),
(1, 0, '2020-09-03 13:25:13'),
(1, 0, '2020-09-03 13:37:19'),
(1, 1, '2020-09-03 13:39:55'),
(1, 0, '2020-09-03 13:40:07'),
(1, 0, '2020-09-03 13:40:18'),
(1, 0, '2020-09-03 13:44:38'),
(1, 0, '2020-09-03 13:45:12'),
(1, 0, '2020-09-03 13:45:58'),
(1, 0, '2020-09-03 14:26:17'),
(1, 1, '2020-09-03 14:37:36'),
(1, 0, '2020-09-03 14:37:47'),
(1, 1, '2020-09-03 14:39:27'),
(1, 1, '2020-09-03 14:49:36');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `questions`
--
ALTER TABLE `questions`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `questions`
--
ALTER TABLE `questions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
