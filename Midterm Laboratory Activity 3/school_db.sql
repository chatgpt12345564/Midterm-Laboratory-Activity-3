-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Feb 27, 2025 at 03:31 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `school_db`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `add_student` (IN `student_name` VARCHAR(100), IN `student_email` VARCHAR(100), IN `teacher` INT)   BEGIN
    INSERT INTO students (name, email, teacher_id) VALUES (student_name, student_email, teacher);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `add_teacher` (IN `teacher_name` VARCHAR(100), IN `teacher_email` VARCHAR(100))   BEGIN
    INSERT INTO teachers (name, email) VALUES (teacher_name, teacher_email);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `delete_student` (IN `student_id` INT)   BEGIN
    DELETE FROM students WHERE id = student_id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `delete_teacher` (IN `teacher_id` INT)   BEGIN
    DELETE FROM teachers WHERE id = teacher_id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `edit_student` (IN `student_id` INT, IN `student_name` VARCHAR(100), IN `student_email` VARCHAR(100), IN `teacher` INT)   BEGIN
    UPDATE students SET name = student_name, email = student_email, teacher_id = teacher WHERE id = student_id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `edit_teacher` (IN `teacher_id` INT, IN `teacher_name` VARCHAR(100), IN `teacher_email` VARCHAR(100))   BEGIN
    UPDATE teachers SET name = teacher_name, email = teacher_email WHERE id = teacher_id;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `students`
--

CREATE TABLE `students` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `teacher_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `students`
--

INSERT INTO `students` (`id`, `name`, `email`, `teacher_id`) VALUES
(2, 'jerald arenque', 'jeraldarenque1@gmail.com', 4),
(3, 'jeraldhaiud', 'jeraldwaudh@gmail.com', 4);

-- --------------------------------------------------------

--
-- Table structure for table `teachers`
--

CREATE TABLE `teachers` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `teachers`
--

INSERT INTO `teachers` (`id`, `name`, `email`) VALUES
(4, 'lord ian pacquao', 'lordian@gmail.com'),
(5, 'adam', 'adam@gmail.com'),
(6, 'adam12', 'adam12@gmail.com');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `students`
--
ALTER TABLE `students`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`),
  ADD KEY `teacher_id` (`teacher_id`);

--
-- Indexes for table `teachers`
--
ALTER TABLE `teachers`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `students`
--
ALTER TABLE `students`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `teachers`
--
ALTER TABLE `teachers`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `students`
--
ALTER TABLE `students`
  ADD CONSTRAINT `students_ibfk_1` FOREIGN KEY (`teacher_id`) REFERENCES `teachers` (`id`) ON DELETE SET NULL;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
