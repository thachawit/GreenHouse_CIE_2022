-- phpMyAdmin SQL Dump
-- version 5.1.3
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: May 18, 2022 at 06:54 PM
-- Server version: 10.4.21-MariaDB
-- PHP Version: 7.4.29

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `smart_greenhouse`
--

-- --------------------------------------------------------

--
-- Table structure for table `ambient`
--

CREATE TABLE `ambient` (
  `time_stamp` int(11) NOT NULL,
  `humidity_level` int(11) DEFAULT NULL,
  `humidity_unit` varchar(255) DEFAULT NULL,
  `temperature` int(11) DEFAULT NULL,
  `temperature_unit` varchar(255) DEFAULT NULL,
  `light_level` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `ambient`
--

INSERT INTO `ambient` (`time_stamp`, `humidity_level`, `humidity_unit`, `temperature`, `temperature_unit`, `light_level`) VALUES
(1, 50, 'percent', 24, 'celcuis', 1000);

-- --------------------------------------------------------

--
-- Table structure for table `cooling_state`
--

CREATE TABLE `cooling_state` (
  `cooling_status` tinyint(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `cooling_state`
--

INSERT INTO `cooling_state` (`cooling_status`) VALUES
(0);

-- --------------------------------------------------------

--
-- Table structure for table `planttype`
--

CREATE TABLE `planttype` (
  `plant_name` varchar(255) NOT NULL,
  `optimal_phosphorus` int(11) DEFAULT NULL,
  `optimal_nitrogen` int(11) DEFAULT NULL,
  `optimal_potassium` int(11) DEFAULT NULL,
  `optimal_moisture` int(11) DEFAULT NULL,
  `optimal_temp` int(11) DEFAULT NULL,
  `optimal_light_level` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `planttype`
--

INSERT INTO `planttype` (`plant_name`, `optimal_phosphorus`, `optimal_nitrogen`, `optimal_potassium`, `optimal_moisture`, `optimal_temp`, `optimal_light_level`) VALUES
('kaprao', 20, 20, 20, 60, 25, 700);

-- --------------------------------------------------------

--
-- Table structure for table `plant_pot`
--

CREATE TABLE `plant_pot` (
  `pot_id` int(11) NOT NULL,
  `date_plant` datetime DEFAULT NULL,
  `date_harvest` datetime DEFAULT NULL,
  `plant_name` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `plant_pot`
--

INSERT INTO `plant_pot` (`pot_id`, `date_plant`, `date_harvest`, `plant_name`) VALUES
(1, '2022-05-16 18:59:52', '2022-05-20 18:59:52', 'kaprao'),
(2, '2022-05-16 18:59:52', '2022-05-20 18:59:52', 'kaprao');

-- --------------------------------------------------------

--
-- Table structure for table `soil_info`
--

CREATE TABLE `soil_info` (
  `mc_id` int(11) NOT NULL,
  `pot_id` int(11) DEFAULT NULL,
  `moisture_level` int(11) DEFAULT NULL,
  `moisture_unit` varchar(255) DEFAULT NULL,
  `phosphorus_level` int(11) DEFAULT NULL,
  `phosphorus_unit` varchar(255) DEFAULT NULL,
  `nitrogen_level` int(11) DEFAULT NULL,
  `nitrohen_unit` varchar(255) DEFAULT NULL,
  `potassium_level` int(11) DEFAULT NULL,
  `potassium_unit` varchar(255) DEFAULT NULL,
  `measure_time` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `soil_info`
--

INSERT INTO `soil_info` (`mc_id`, `pot_id`, `moisture_level`, `moisture_unit`, `phosphorus_level`, `phosphorus_unit`, `nitrogen_level`, `nitrohen_unit`, `potassium_level`, `potassium_unit`, `measure_time`) VALUES
(1, 1, 50, 'percent', 20, 'percent', 20, 'percent', 20, 'percent', '2022-05-17 19:00:30'),
(2, 2, 100, 'percent', 30, 'percent', 30, 'percent', 30, 'percent', '2022-05-18 19:03:02');

-- --------------------------------------------------------

--
-- Table structure for table `sunshade_state`
--

CREATE TABLE `sunshade_state` (
  `sunshade_status` tinyint(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `sunshade_state`
--

INSERT INTO `sunshade_state` (`sunshade_status`) VALUES
(1);

-- --------------------------------------------------------

--
-- Table structure for table `watering_system`
--

CREATE TABLE `watering_system` (
  `water_level` int(11) DEFAULT NULL,
  `fertilizer_level` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `watering_system`
--

INSERT INTO `watering_system` (`water_level`, `fertilizer_level`) VALUES
(100, 100);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `ambient`
--
ALTER TABLE `ambient`
  ADD PRIMARY KEY (`time_stamp`);

--
-- Indexes for table `planttype`
--
ALTER TABLE `planttype`
  ADD PRIMARY KEY (`plant_name`);

--
-- Indexes for table `plant_pot`
--
ALTER TABLE `plant_pot`
  ADD PRIMARY KEY (`pot_id`),
  ADD KEY `plant_name` (`plant_name`);

--
-- Indexes for table `soil_info`
--
ALTER TABLE `soil_info`
  ADD PRIMARY KEY (`mc_id`),
  ADD KEY `pot_id` (`pot_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `ambient`
--
ALTER TABLE `ambient`
  MODIFY `time_stamp` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `plant_pot`
--
ALTER TABLE `plant_pot`
  MODIFY `pot_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `soil_info`
--
ALTER TABLE `soil_info`
  MODIFY `mc_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `plant_pot`
--
ALTER TABLE `plant_pot`
  ADD CONSTRAINT `plant_pot_ibfk_1` FOREIGN KEY (`plant_name`) REFERENCES `planttype` (`plant_name`);

--
-- Constraints for table `soil_info`
--
ALTER TABLE `soil_info`
  ADD CONSTRAINT `soil_info_ibfk_1` FOREIGN KEY (`pot_id`) REFERENCES `plant_pot` (`pot_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
