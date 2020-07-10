-- --------------------------------------------------------
-- Värd:                         localhost
-- Serverversion:                10.1.26-MariaDB-0+deb9u1 - Debian 9.1
-- Server-OS:                    debian-linux-gnu
-- HeidiSQL Version:             10.3.0.5771
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;


-- Dumpar databasstruktur för test
DROP DATABASE IF EXISTS `test`;
CREATE DATABASE IF NOT EXISTS `test` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `test`;

-- Dumpar struktur för tabell test.t_acquired_data
DROP TABLE IF EXISTS `t_acquired_data`;
CREATE TABLE IF NOT EXISTS `t_acquired_data` (
  `UNIQUE_INDEX` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `CHANNEL_INDEX` smallint(5) unsigned NOT NULL,
  `ACQUIRED_TIME` int(11) unsigned NOT NULL,
  `STATUS` tinyint(4) DEFAULT NULL,
  `ACQUIRED_VALUE` double DEFAULT NULL,
  `ACQUIRED_MICROSECS` mediumint(8) unsigned DEFAULT NULL,
  `ACQUIRED_SUBSAMPLES` mediumtext CHARACTER SET ascii COLLATE ascii_bin,
  `ACQUIRED_BASE64` mediumblob,
  PRIMARY KEY (`ACQUIRED_TIME`,`CHANNEL_INDEX`),
  KEY `ACQUIRED_TIME_CHANNEL_INDEX_IDX` (`ACQUIRED_TIME`,`CHANNEL_INDEX`),
  KEY `CHANNEL_INDEX_STATUS_IDX` (`CHANNEL_INDEX`,`STATUS`),
  KEY `UNIQUE_INDEX_IDX` (`UNIQUE_INDEX`)
) ENGINE=InnoDB AUTO_INCREMENT=680323495 DEFAULT CHARSET=utf8
/*!50100 PARTITION BY RANGE (ACQUIRED_TIME)
(PARTITION acquired_time_20200423 VALUES LESS THAN (1587686400) ENGINE = InnoDB,
 PARTITION acquired_time_20200424 VALUES LESS THAN (1587772800) ENGINE = InnoDB,
 PARTITION acquired_time_20200425 VALUES LESS THAN (1587859200) ENGINE = InnoDB,
 PARTITION acquired_time_20200426 VALUES LESS THAN (1587945600) ENGINE = InnoDB,
 PARTITION acquired_time_20200427 VALUES LESS THAN (1588032000) ENGINE = InnoDB,
 PARTITION acquired_time_20200428 VALUES LESS THAN (1588118400) ENGINE = InnoDB,
 PARTITION acquired_time_20200429 VALUES LESS THAN (1588204800) ENGINE = InnoDB,
 PARTITION acquired_time_20200430 VALUES LESS THAN (1588291200) ENGINE = InnoDB,
 PARTITION acquired_time_20200501 VALUES LESS THAN (1588377600) ENGINE = InnoDB,
 PARTITION acquired_time_20200502 VALUES LESS THAN (1588464000) ENGINE = InnoDB,
 PARTITION acquired_time_20200503 VALUES LESS THAN (1588550400) ENGINE = InnoDB,
 PARTITION acquired_time_max VALUES LESS THAN MAXVALUE ENGINE = InnoDB) */;

-- Dumpar struktur för tabell test.t_accumulated_data
DROP TABLE IF EXISTS `t_accumulated_data`;
CREATE TABLE IF NOT EXISTS `t_accumulated_data` (
  `CHANNEL_INDEX` smallint(5) unsigned DEFAULT NULL,
  `ACCUMULATED_BIN_END_TIME` int(11) unsigned DEFAULT NULL,
  `ACCUMULATED_BIN_SIZE` mediumint(8) unsigned DEFAULT NULL,
  `ACCUMULATED_NO_OF_SAMPLES` mediumint(8) unsigned DEFAULT NULL,
  `ACCUMULATED_VALUE` double DEFAULT NULL,
  `ACCUMULATED_TEXT` mediumtext,
  `ACCUMULATED_BINARY` mediumblob,
  UNIQUE KEY `T_DOWNSAMPLED_DATA_IDX` (`CHANNEL_INDEX`,`ACCUMULATED_BIN_END_TIME`,`ACCUMULATED_BIN_SIZE`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumpar struktur för tabell test.t_channel
DROP TABLE IF EXISTS `t_channel`;
CREATE TABLE IF NOT EXISTS `t_channel` (
  `CHANNEL_UNIQUE_INDEX` smallint(5) unsigned NOT NULL,
  `CHANNEL_SAMPLE_RATE` float unsigned DEFAULT NULL,
  `CHANNEL_MIN_VALUE` float DEFAULT NULL,
  `CHANNEL_MAX_VALUE` float DEFAULT NULL,
  `CHANNEL_FACTOR` float DEFAULT NULL,
  `CHANNEL_UNIT` varchar(50) DEFAULT NULL,
  `CHANNEL_TEXT_ID` varchar(50) DEFAULT NULL,
  `CHANNEL_DESCRIPTION` varchar(1000) DEFAULT NULL,
  `CHANNEL_FUNCTION` varchar(200) DEFAULT NULL,
  `CHANNEL_LOOKUP` varchar(2000) DEFAULT NULL,
  `OFFSET` smallint(5) unsigned DEFAULT NULL,
  `MODULE_INDEX` smallint(5) unsigned DEFAULT NULL,
  `DEVICE_INDEX` smallint(5) unsigned DEFAULT NULL,
  `HOST_INDEX` smallint(5) unsigned DEFAULT NULL,
  PRIMARY KEY (`CHANNEL_UNIQUE_INDEX`),
  KEY `t_channels_t_modules_FK` (`MODULE_INDEX`),
  KEY `t_channels_t_hosts_FK` (`HOST_INDEX`),
  KEY `t_channels_t_devices_FK` (`DEVICE_INDEX`),
  CONSTRAINT `t_channels_t_devices_FK` FOREIGN KEY (`DEVICE_INDEX`) REFERENCES `t_device` (`DEVICE_UNIQUE_INDEX`),
  CONSTRAINT `t_channels_t_hosts_FK` FOREIGN KEY (`HOST_INDEX`) REFERENCES `t_host` (`HOST_UNIQUE_INDEX`),
  CONSTRAINT `t_channels_t_modules_FK` FOREIGN KEY (`MODULE_INDEX`) REFERENCES `t_module` (`MODULE_UNIQUE_INDEX`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumpar data för tabell test.t_channel: ~29 rows (ungefär)
/*!40000 ALTER TABLE `t_channel` DISABLE KEYS */;
INSERT INTO `t_channel` (`CHANNEL_UNIQUE_INDEX`, `CHANNEL_SAMPLE_RATE`, `CHANNEL_MIN_VALUE`, `CHANNEL_MAX_VALUE`, `CHANNEL_FACTOR`, `CHANNEL_UNIT`, `CHANNEL_TEXT_ID`, `CHANNEL_DESCRIPTION`, `CHANNEL_FUNCTION`, `CHANNEL_LOOKUP`, `OFFSET`, `MODULE_INDEX`, `DEVICE_INDEX`, `HOST_INDEX`) VALUES
	(20, NULL, NULL, NULL, NULL, 'u00B0C', NULL, 'Cooling water temperature', NULL, NULL, 20, 5, 0, 0),
	(22, NULL, NULL, NULL, NULL, NULL, NULL, 'Weather station excitatio', NULL, NULL, 22, 1, 0, 0),
	(23, NULL, NULL, NULL, NULL, NULL, NULL, 'Weather station temperature sensor voltage', NULL, NULL, 23, 1, 0, 0),
	(97, NULL, NULL, NULL, NULL, NULL, NULL, 'Makeup water conductivity', NULL, NULL, 1, 6, 0, 0),
	(140, NULL, NULL, NULL, NULL, NULL, NULL, 'RPi HETA 01 Raspicam', NULL, NULL, 0, 0, 3, 0),
	(160, NULL, NULL, NULL, NULL, NULL, NULL, 'RPi HETA 02 USB camera', NULL, NULL, 0, 0, 7, 0),
	(161, NULL, NULL, NULL, NULL, NULL, NULL, 'RPi HETA 02 USB camera', NULL, NULL, 0, 0, 8, 0),
	(162, NULL, NULL, NULL, NULL, NULL, NULL, 'Arduino AI0', NULL, NULL, 0, 0, 6, 0),
	(163, NULL, NULL, NULL, NULL, NULL, NULL, 'Arduino AI1', NULL, NULL, 0, 0, 6, 0),
	(164, NULL, NULL, NULL, NULL, NULL, NULL, 'Arduino AI2', NULL, NULL, 0, 0, 6, 0),
	(165, NULL, NULL, NULL, NULL, NULL, NULL, 'Arduino AI3', NULL, NULL, 0, 0, 6, 0),
	(166, NULL, NULL, NULL, NULL, NULL, NULL, 'Arduino AI4', NULL, NULL, 0, 0, 6, 0),
	(167, NULL, NULL, NULL, NULL, NULL, NULL, 'Arduino AI5', NULL, NULL, 0, 0, 6, 0),
	(168, NULL, NULL, NULL, NULL, NULL, NULL, 'Arduino DI2', NULL, NULL, 0, 0, 6, 0),
	(169, NULL, NULL, NULL, NULL, NULL, NULL, 'Arduino DI4', NULL, NULL, 0, 0, 6, 0),
	(170, NULL, NULL, NULL, NULL, NULL, NULL, 'Arduino DI7', NULL, NULL, 0, 0, 6, 0),
	(171, NULL, NULL, NULL, NULL, NULL, NULL, 'Arduino DI8', NULL, NULL, 0, 0, 6, 0),
	(172, NULL, NULL, NULL, NULL, NULL, NULL, 'Arduino DI12', NULL, NULL, 0, 0, 6, 0),
	(173, NULL, NULL, NULL, NULL, NULL, NULL, 'Arduino DI13', NULL, NULL, 0, 0, 6, 0),
	(174, NULL, NULL, NULL, NULL, NULL, NULL, 'Arduino ADO3', NULL, NULL, 0, 0, 6, 0),
	(175, NULL, NULL, NULL, NULL, NULL, NULL, 'Arduino ADO5', NULL, NULL, 0, 0, 6, 0),
	(176, NULL, NULL, NULL, NULL, NULL, NULL, 'Arduino ADO6', NULL, NULL, 0, 0, 6, 0),
	(177, NULL, NULL, NULL, NULL, NULL, NULL, 'Arduino ADO9', NULL, NULL, 0, 0, 6, 0),
	(178, NULL, NULL, NULL, NULL, NULL, NULL, 'Arduino ADO10', NULL, NULL, 0, 0, 6, 0),
	(179, NULL, NULL, NULL, NULL, NULL, NULL, 'Arduino ADO11', NULL, NULL, 0, 0, 6, 0),
	(180, NULL, NULL, NULL, NULL, NULL, NULL, 'Purethermal USB thermal camera', NULL, NULL, 0, 0, 9, 0),
	(600, NULL, NULL, NULL, NULL, NULL, NULL, 'LAN gateway host screenshot', NULL, NULL, 0, 0, 0, 4),
	(10001, NULL, NULL, NULL, NULL, 'u00B0C', NULL, 'Weather station temperature', 'c23/c22', '336.098,314.553,294.524,275.897,258.563,242.427,227.398,213.394,200.339,188.163,176.803,166.198,156.294,147.042,138.393,130.306,122.741,115.661,109.032,102.824,97.006,91.553,86.439,81.641,77.138,72.911,68.940,65.209,61.703,58.405,55.304,52.385,49.638,47.050,44.613,42.317,40.151,38.110,36.184,34.366,32.651,31.031,29.500,28.054,26.687,25.395,24.172,23.016,21.921,20.885,19.903,18.973,18.092,17.257,16.465,15.714,15.001,14.324,13.682,13.073,12.493,11.943,11.420,10.923,10.450,10.000,9.572,9.165,8.777,8.408,8.056,7.721,7.402,7.097,6.807,6.530,6.266,6.014,5.774,5.544,5.325,5.116,4.916,4.724,4.542,4.367,4.200,4.040,3.887,3.741,3.601', 0, 0, 0, 0),
	(10002, NULL, NULL, NULL, NULL, NULL, NULL, 'Dome/feedwater level and superheat temperature camera image composite', 'c160[0 0 500 500 1000 0 720]&c180&c140', '', 0, 0, 0, 0);
/*!40000 ALTER TABLE `t_channel` ENABLE KEYS */;

-- Dumpar struktur för tabell test.t_device
DROP TABLE IF EXISTS `t_device`;
CREATE TABLE IF NOT EXISTS `t_device` (
  `DEVICE_UNIQUE_INDEX` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `DEVICE_TEXT_ID` varchar(50) DEFAULT NULL,
  `DEVICE_HARDWARE_ID` varchar(50) NOT NULL,
  `DEVICE_DESCRIPTION` varchar(200) DEFAULT NULL,
  `HOST_INDEX` smallint(5) unsigned DEFAULT NULL,
  PRIMARY KEY (`DEVICE_HARDWARE_ID`),
  UNIQUE KEY `t_devices_UN` (`DEVICE_UNIQUE_INDEX`),
  KEY `t_devices_t_hosts_FK` (`HOST_INDEX`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- Dumpar data för tabell test.t_device: ~10 rows (ungefär)
/*!40000 ALTER TABLE `t_device` DISABLE KEYS */;
INSERT INTO `t_device` (`DEVICE_UNIQUE_INDEX`, `DEVICE_TEXT_ID`, `DEVICE_HARDWARE_ID`, `DEVICE_DESCRIPTION`, `HOST_INDEX`) VALUES
	(0, NULL, '0', 'No specified device', 0),
	(1, NULL, '1', 'NI cDAQ-9188 main chassis (upper floor)', 3),
	(2, NULL, '2', 'NI cDAQ-9188 aux chassis (control room)', 3),
	(3, NULL, '3', 'Raspicam on rpi_heta_01', 2),
	(4, NULL, '4', 'Raspicam on rpi_heta_02', 5),
	(5, NULL, '5', 'USB camera on LAN gateway host', 4),
	(6, NULL, '6', 'Arduino on rpi_heta_02', 5),
	(7, NULL, '7', 'USB camera on storage/uplink host', 1),
	(8, NULL, '8', 'USB camera on rpi_heta_02', 5),
	(9, NULL, '9', 'PureThermal USB thermal camera on storage/uplink host', 1);
/*!40000 ALTER TABLE `t_device` ENABLE KEYS */;

-- Dumpar struktur för tabell test.t_device_channels
DROP TABLE IF EXISTS `t_device_channels`;
CREATE TABLE IF NOT EXISTS `t_device_channels` (
  `CHANNEL_UNIQUE_INDEX` smallint(5) unsigned NOT NULL,
  `CHANNEL_SAMPLE_RATE` float unsigned DEFAULT NULL,
  `CHANNEL_MIN_VALUE` float unsigned DEFAULT NULL,
  `CHANNEL_MAX_VALUE` float unsigned DEFAULT NULL,
  `CHANNEL_TEXT_ID` varchar(50) DEFAULT NULL,
  `CHANNEL_DESCRIPTION` varchar(1000) DEFAULT NULL,
  `CHANNEL_FUNCTION` varchar(200) DEFAULT NULL,
  `CHANNEL_LOOKUP` varchar(2000) DEFAULT NULL,
  `CHANNEL_OFFSET` smallint(5) unsigned NOT NULL,
  `DEVICE_INDEX` smallint(5) unsigned NOT NULL,
  PRIMARY KEY (`DEVICE_INDEX`,`CHANNEL_OFFSET`),
  UNIQUE KEY `t_device_channels_UN` (`CHANNEL_UNIQUE_INDEX`),
  CONSTRAINT `t_device_channels_t_devices_FK` FOREIGN KEY (`DEVICE_INDEX`) REFERENCES `t_device` (`DEVICE_UNIQUE_INDEX`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumpar data för tabell test.t_device_channels: ~0 rows (ungefär)
/*!40000 ALTER TABLE `t_device_channels` DISABLE KEYS */;
INSERT INTO `t_device_channels` (`CHANNEL_UNIQUE_INDEX`, `CHANNEL_SAMPLE_RATE`, `CHANNEL_MIN_VALUE`, `CHANNEL_MAX_VALUE`, `CHANNEL_TEXT_ID`, `CHANNEL_DESCRIPTION`, `CHANNEL_FUNCTION`, `CHANNEL_LOOKUP`, `CHANNEL_OFFSET`, `DEVICE_INDEX`) VALUES
	(140, NULL, NULL, NULL, NULL, 'RPi HETA 01 Raspicam', NULL, NULL, 0, 3),
	(160, NULL, NULL, NULL, NULL, 'RPi HETA 02 Raspicam', NULL, NULL, 0, 4);
/*!40000 ALTER TABLE `t_device_channels` ENABLE KEYS */;

-- Dumpar struktur för tabell test.t_host
DROP TABLE IF EXISTS `t_host`;
CREATE TABLE IF NOT EXISTS `t_host` (
  `HOST_UNIQUE_INDEX` smallint(5) unsigned NOT NULL,
  `HOST_TEXT_ID` varchar(50) DEFAULT NULL,
  `HOST_HARDWARE_ID` varchar(50) NOT NULL,
  `HOST_IP_ADDRESS` varchar(50) DEFAULT NULL,
  `HOST_PERSISTENT_DATA_PATH` varchar(200) DEFAULT NULL,
  `HOST_DATABASE_CONNECTION_STRING` varchar(200) DEFAULT NULL,
  `HOST_DESCRIPTION` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`HOST_HARDWARE_ID`),
  UNIQUE KEY `t_hosts_UN` (`HOST_UNIQUE_INDEX`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- Dumpar data för tabell test.t_host: ~6 rows (ungefär)
/*!40000 ALTER TABLE `t_host` DISABLE KEYS */;
INSERT INTO `t_host` (`HOST_UNIQUE_INDEX`, `HOST_TEXT_ID`, `HOST_HARDWARE_ID`, `HOST_IP_ADDRESS`, `HOST_PERSISTENT_DATA_PATH`, `HOST_DATABASE_CONNECTION_STRING`, `HOST_DESCRIPTION`) VALUES
	(0, '', '0', '', '', '', 'No specified host'),
	(1, 'dogger', '1', '192.168.1.194', '/home/heta/Z/data/files', 'server=dogger;port=3306;database=test;uid=root;password=admin', 'LAN storage host'),
	(2, 'rpi_heta_01', '2', '192.168.1.226', '/home/pi/LS220D5EC/data/files/', NULL, 'RPi HETA 01'),
	(3, 'nidaq-daqc', '3', '192.168.1.193', 'Z:/data/files/', NULL, 'NI CompactDAQ acquisition host'),
	(5, 'rpi_heta_02', '5', '192.168.1.42', '/home/pi/LS220D5EC/data/files/', NULL, 'RPi HETA 02'),
	(4, 'PC20843795', '64-31-50-20-40-25', '192.168.1.103', NULL, '', 'LAN server host (control room)');
/*!40000 ALTER TABLE `t_host` ENABLE KEYS */;

-- Dumpar struktur för tabell test.t_module
DROP TABLE IF EXISTS `t_module`;
CREATE TABLE IF NOT EXISTS `t_module` (
  `MODULE_UNIQUE_INDEX` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `MODULE_TEXT_ID` varchar(50) DEFAULT NULL,
  `MODULE_DESCRIPTION` varchar(200) DEFAULT NULL,
  `SLOT_INDEX` smallint(5) unsigned NOT NULL,
  `DEVICE_INDEX` smallint(5) unsigned NOT NULL,
  PRIMARY KEY (`SLOT_INDEX`,`DEVICE_INDEX`),
  UNIQUE KEY `t_modules_UN` (`MODULE_UNIQUE_INDEX`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- Dumpar data för tabell test.t_module: ~8 rows (ungefär)
/*!40000 ALTER TABLE `t_module` DISABLE KEYS */;
INSERT INTO `t_module` (`MODULE_UNIQUE_INDEX`, `MODULE_TEXT_ID`, `MODULE_DESCRIPTION`, `SLOT_INDEX`, `DEVICE_INDEX`) VALUES
	(0, NULL, 'No module specified', 0, 0),
	(1, NULL, NULL, 1, 1),
	(5, NULL, NULL, 1, 2),
	(2, NULL, NULL, 2, 1),
	(6, NULL, NULL, 2, 2),
	(3, NULL, NULL, 3, 1),
	(7, NULL, NULL, 3, 2),
	(4, NULL, NULL, 4, 1);
/*!40000 ALTER TABLE `t_module` ENABLE KEYS */;

-- Dumpar struktur för tabell test.t_ports
DROP TABLE IF EXISTS `t_ports`;
CREATE TABLE IF NOT EXISTS `t_ports` (
  `PORT_UNIQUE_INDEX` smallint(5) unsigned NOT NULL,
  `PORT_TEXT_ID` varchar(50) DEFAULT NULL,
  `PORT_DESCRIPTION` varchar(200) DEFAULT NULL,
  `HOST_INDEX` smallint(5) unsigned DEFAULT NULL,
  `DEVICE_INDEX` smallint(5) unsigned DEFAULT NULL,
  PRIMARY KEY (`PORT_UNIQUE_INDEX`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- Dumpar data för tabell test.t_ports: ~4 rows (ungefär)
/*!40000 ALTER TABLE `t_ports` DISABLE KEYS */;
INSERT INTO `t_ports` (`PORT_UNIQUE_INDEX`, `PORT_TEXT_ID`, `PORT_DESCRIPTION`, `HOST_INDEX`, `DEVICE_INDEX`) VALUES
	(1, '169.254.254.254', 'cDAQ-9188 main chassis address', 3, 1),
	(2, '169.254.254.253', 'cDAQ-9188 aux chassis addres', 3, 2),
	(3, 'video0', 'Raspicam on heta_rpi_01', 2, 3),
	(5, '0000.001a.0007.004.000.000.000.000.000', 'USB camera on WAN gateway host', 1, 10);
/*!40000 ALTER TABLE `t_ports` ENABLE KEYS */;

-- Dumpar struktur för tabell test.t_servers
DROP TABLE IF EXISTS `t_servers`;
CREATE TABLE IF NOT EXISTS `t_servers` (
  `SERVER_UNIQUE_INDEX` smallint(5) unsigned NOT NULL,
  `SERVER_TEXT_ID` varchar(50) DEFAULT NULL,
  `SERVER_DESCRIPTION` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`SERVER_UNIQUE_INDEX`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- Dumpar data för tabell test.t_servers: ~2 rows (ungefär)
/*!40000 ALTER TABLE `t_servers` DISABLE KEYS */;
INSERT INTO `t_servers` (`SERVER_UNIQUE_INDEX`, `SERVER_TEXT_ID`, `SERVER_DESCRIPTION`) VALUES
	(0, NULL, 'No specified server'),
	(1, '109.74.8.84', 'Default WAN gateway'),
	(2, '192.168.1.103', 'PC20843795 Energilabbet LAN gateway');
/*!40000 ALTER TABLE `t_servers` ENABLE KEYS */;

-- Dumpar struktur för tabell test.t_service
DROP TABLE IF EXISTS `t_service`;
CREATE TABLE IF NOT EXISTS `t_service` (
  `SERVICE_UNIQUE_INDEX` smallint(5) unsigned NOT NULL,
  `SERVICE_TEXT_ID` varchar(50) DEFAULT NULL,
  `SERVICE_DESCRIPTION` varchar(200) DEFAULT NULL,
  `SERVICE_REBOOT_NEXT` tinyint(4) DEFAULT NULL,
  `HOST_INDEX` smallint(5) unsigned DEFAULT NULL,
  UNIQUE KEY `t_hosts_UN` (`SERVICE_UNIQUE_INDEX`) USING BTREE,
  KEY `t_service_t_hosts_FK` (`HOST_INDEX`),
  CONSTRAINT `t_service_t_hosts_FK` FOREIGN KEY (`HOST_INDEX`) REFERENCES `t_host` (`HOST_UNIQUE_INDEX`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumpar data för tabell test.t_service: ~0 rows (ungefär)
/*!40000 ALTER TABLE `t_service` DISABLE KEYS */;
INSERT INTO `t_service` (`SERVICE_UNIQUE_INDEX`, `SERVICE_TEXT_ID`, `SERVICE_DESCRIPTION`, `SERVICE_REBOOT_NEXT`, `HOST_INDEX`) VALUES
	(0, NULL, NULL, 0, 5);
/*!40000 ALTER TABLE `t_service` ENABLE KEYS */;

-- Dumpar struktur för tabell test.t_slots
DROP TABLE IF EXISTS `t_slots`;
CREATE TABLE IF NOT EXISTS `t_slots` (
  `SLOT_UNIQUE_INDEX` smallint(5) unsigned NOT NULL,
  `SLOT_DEVICE_INDEX` smallint(5) unsigned DEFAULT NULL,
  `SLOT_TEXT_ID` varchar(50) DEFAULT NULL,
  `SLOT_DESCRIPTION` varchar(200) DEFAULT NULL,
  `MODULE_INDEX` smallint(5) unsigned DEFAULT NULL,
  `DEVICE_INDEX` smallint(5) unsigned DEFAULT NULL,
  PRIMARY KEY (`SLOT_UNIQUE_INDEX`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='Behövs denna verkligen? Räcker det inte med att ange SLOT_INDEX per modul?';

-- Dumpar data för tabell test.t_slots: ~16 rows (ungefär)
/*!40000 ALTER TABLE `t_slots` DISABLE KEYS */;
INSERT INTO `t_slots` (`SLOT_UNIQUE_INDEX`, `SLOT_DEVICE_INDEX`, `SLOT_TEXT_ID`, `SLOT_DESCRIPTION`, `MODULE_INDEX`, `DEVICE_INDEX`) VALUES
	(1, 1, 'Slot 01', NULL, 1, 1),
	(2, 2, 'Slot 02', NULL, 2, 1),
	(3, 3, 'Slot 03', NULL, 3, 1),
	(4, 4, 'Slot 04', NULL, 4, 1),
	(5, 5, 'Slot 05', NULL, 0, 1),
	(6, 6, 'Slot 06', NULL, 0, 1),
	(7, 7, 'Slot 07', NULL, 0, 1),
	(8, 8, 'Slot 08', NULL, 0, 1),
	(9, 1, 'Slot 01', NULL, 5, 2),
	(10, 2, 'Slot 02', NULL, 6, 2),
	(11, 3, 'Slot 03', NULL, 7, 2),
	(12, 4, 'Slot 04', NULL, 0, 2),
	(13, 5, 'Slot 05', NULL, 0, 2),
	(14, 6, 'Slot 06', NULL, 0, 2),
	(15, 7, 'Slot 07', NULL, 0, 2),
	(16, 8, 'Slot 08', NULL, 0, 2);
/*!40000 ALTER TABLE `t_slots` ENABLE KEYS */;

-- Dumpar struktur för tabell test.t_task
DROP TABLE IF EXISTS `t_task`;
CREATE TABLE IF NOT EXISTS `t_task` (
  `TASK_UNIQUE_INDEX` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `TASK_RATE` float unsigned DEFAULT NULL,
  `TASK_STATE` tinyint(4) DEFAULT NULL,
  `TASK_TEXT_ID` varchar(50) DEFAULT NULL,
  `TASK_DESCRIPTION` varchar(1000) DEFAULT NULL,
  `SERVER_INDEX` smallint(5) unsigned NOT NULL,
  `HOST_INDEX` smallint(5) unsigned NOT NULL,
  PRIMARY KEY (`SERVER_INDEX`,`HOST_INDEX`),
  UNIQUE KEY `t_uplinks_UN` (`TASK_UNIQUE_INDEX`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- Dumpar data för tabell test.t_task: ~4 rows (ungefär)
/*!40000 ALTER TABLE `t_task` DISABLE KEYS */;
INSERT INTO `t_task` (`TASK_UNIQUE_INDEX`, `TASK_RATE`, `TASK_STATE`, `TASK_TEXT_ID`, `TASK_DESCRIPTION`, `SERVER_INDEX`, `HOST_INDEX`) VALUES
	(4, NULL, NULL, NULL, 'store', 0, 1),
	(2, NULL, NULL, NULL, 'upload', 1, 5),
	(1, NULL, NULL, NULL, 'transform', 2, 0),
	(3, NULL, NULL, NULL, 'upload', 2, 5);
/*!40000 ALTER TABLE `t_task` ENABLE KEYS */;

-- Dumpar struktur för tabell test.t_task_channel
DROP TABLE IF EXISTS `t_task_channel`;
CREATE TABLE IF NOT EXISTS `t_task_channel` (
  `TASK_CHANNEL_UNIQUE_INDEX` smallint(5) unsigned NOT NULL,
  `TASK_CHANNEL_TEXT_ID` varchar(50) DEFAULT NULL,
  `TASK_CHANNEL_DESCRIPTION` varchar(200) DEFAULT NULL,
  `CHANNEL_INDEX` smallint(5) unsigned DEFAULT NULL,
  `TASK_INDEX` smallint(5) unsigned DEFAULT NULL,
  PRIMARY KEY (`TASK_CHANNEL_UNIQUE_INDEX`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- Dumpar data för tabell test.t_task_channel: ~12 rows (ungefär)
/*!40000 ALTER TABLE `t_task_channel` DISABLE KEYS */;
INSERT INTO `t_task_channel` (`TASK_CHANNEL_UNIQUE_INDEX`, `TASK_CHANNEL_TEXT_ID`, `TASK_CHANNEL_DESCRIPTION`, `CHANNEL_INDEX`, `TASK_INDEX`) VALUES
	(1, NULL, NULL, 20, 4),
	(2, NULL, NULL, 21, 4),
	(3, NULL, NULL, 22, 4),
	(4, NULL, NULL, 23, 4),
	(5, NULL, NULL, 24, 4),
	(6, NULL, NULL, 161, 4),
	(7, NULL, NULL, 162, 4),
	(8, NULL, NULL, 163, 4),
	(9, NULL, NULL, 164, 4),
	(10, NULL, NULL, 160, 2),
	(11, NULL, NULL, 160, 3),
	(12, NULL, NULL, 10002, 1);
/*!40000 ALTER TABLE `t_task_channel` ENABLE KEYS */;

-- Dumpar struktur för tabell test.t_uplink_process
DROP TABLE IF EXISTS `t_uplink_process`;
CREATE TABLE IF NOT EXISTS `t_uplink_process` (
  `UPLINK_PROCESS_UNIQUE_INDEX` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `UPLINK_PROCESS_TEXT_ID` varchar(50) DEFAULT NULL,
  `UPLINK_PROCESS_DESCRIPTION` varchar(1000) DEFAULT NULL,
  `CHANNEL_INDEX` smallint(5) unsigned NOT NULL,
  `CLIENT_SERVER_INDEX` smallint(5) unsigned NOT NULL,
  `HOST_INDEX` smallint(5) unsigned NOT NULL,
  PRIMARY KEY (`CHANNEL_INDEX`,`CLIENT_SERVER_INDEX`,`HOST_INDEX`),
  UNIQUE KEY `t_uplinks_UN` (`UPLINK_PROCESS_UNIQUE_INDEX`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- Dumpar data för tabell test.t_uplink_process: ~2 rows (ungefär)
/*!40000 ALTER TABLE `t_uplink_process` DISABLE KEYS */;
INSERT INTO `t_uplink_process` (`UPLINK_PROCESS_UNIQUE_INDEX`, `UPLINK_PROCESS_TEXT_ID`, `UPLINK_PROCESS_DESCRIPTION`, `CHANNEL_INDEX`, `CLIENT_SERVER_INDEX`, `HOST_INDEX`) VALUES
	(3, NULL, NULL, 160, 2, 1),
	(1, NULL, NULL, 10002, 2, 0);
/*!40000 ALTER TABLE `t_uplink_process` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;