-- phpMyAdmin SQL Dump
-- version 3.5.1
-- http://www.phpmyadmin.net
--
-- Servidor: localhost
-- Tiempo de generación: 15-06-2016 a las 15:28:04
-- Versión del servidor: 5.5.24-log
-- Versión de PHP: 5.4.3

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Base de datos: `sale`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `app_config`
--

CREATE TABLE IF NOT EXISTS `app_config` (
  `key` varchar(300) COLLATE utf8_unicode_ci NOT NULL,
  `value` varchar(300) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`key`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Volcado de datos para la tabla `app_config`
--

INSERT INTO `app_config` (`key`, `value`) VALUES
('address', 'Dirección: Calle 36 # 3 B 81 sur'),
('company', 'Sistema de Ventas Pintuedward NIT:830.227.885-3'),
('currency_symbol', '$ '),
('default_tax_1_name', 'IVA'),
('default_tax_1_rate', '16'),
('default_tax_2_name', 'Impuesto de Ventas 2'),
('default_tax_2_rate', ''),
('default_tax_rate', '8'),
('email', 'pintuedward@gmail.com'),
('fax', ''),
('phone', 'Teléfono: 4520618'),
('print_after_sale', 'print_after_sale'),
('return_policy', 'Test'),
('timezone', 'America/Bogota'),
('website', '');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `customers`
--

CREATE TABLE IF NOT EXISTS `customers` (
  `person_id` int(11) NOT NULL,
  `taxable` int(1) NOT NULL DEFAULT '1',
  `deleted` int(1) NOT NULL DEFAULT '0',
  KEY `person_id` (`person_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Volcado de datos para la tabla `customers`
--

INSERT INTO `customers` (`person_id`, `taxable`, `deleted`) VALUES
(2, 1, 0),
(3, 1, 0),
(7, 1, 0),
(9, 1, 0),
(10, 1, 0),
(13, 1, 0),
(15, 1, 0),
(17, 1, 0),
(22, 1, 0),
(23, 1, 1),
(25, 1, 0),
(26, 1, 0),
(27, 1, 0),
(33, 1, 0),
(34, 1, 0),
(35, 1, 0),
(36, 1, 0),
(37, 1, 1),
(38, 1, 0),
(40, 1, 1),
(41, 1, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `employees`
--

CREATE TABLE IF NOT EXISTS `employees` (
  `username` varchar(300) COLLATE utf8_unicode_ci NOT NULL,
  `password` varchar(300) COLLATE utf8_unicode_ci NOT NULL,
  `person_id` int(11) NOT NULL,
  `deleted` int(1) NOT NULL DEFAULT '0',
  UNIQUE KEY `username` (`username`),
  KEY `person_id` (`person_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Volcado de datos para la tabla `employees`
--

INSERT INTO `employees` (`username`, `password`, `person_id`, `deleted`) VALUES
('admin', '987123456', 1, 0),
('caravill', '123456789', 14, 0),
('lmesi', 'c4fbb197bc512be66a6d1de2e04c79cd', 5, 0),
('almacen', '123456789', 6, 0),
('vendedor', '123456987', 24, 0),
('tomasVend', '123456789', 42, 0),
('admin1', '987123456', 43, 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `inventory`
--

CREATE TABLE IF NOT EXISTS `inventory` (
  `trans_id` int(11) NOT NULL AUTO_INCREMENT,
  `trans_items` int(11) NOT NULL DEFAULT '0',
  `trans_user` int(11) NOT NULL DEFAULT '0',
  `trans_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `trans_comment` text COLLATE utf8_unicode_ci NOT NULL,
  `trans_inventory` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`trans_id`),
  KEY `inventory_ibfk_1` (`trans_items`),
  KEY `inventory_ibfk_2` (`trans_user`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=50 ;

--
-- Volcado de datos para la tabla `inventory`
--

INSERT INTO `inventory` (`trans_id`, `trans_items`, `trans_user`, `trans_date`, `trans_comment`, `trans_inventory`) VALUES
(1, 5, 1, '2016-02-18 05:17:12', 'RECV 1', 1),
(2, 5, 1, '2016-02-18 05:46:59', 'RECV 2', 10),
(3, 4, 1, '2016-02-24 00:50:14', 'FRA. 3', -3),
(4, 3, 1, '2016-02-24 00:50:15', 'FRA. 3', -2),
(5, 4, 1, '2016-04-06 23:20:15', 'FRA. 4', -1),
(6, 3, 1, '2016-04-06 23:20:16', 'FRA. 4', -5),
(7, 5, 1, '2016-05-06 14:13:41', 'FRA. 5', -5),
(8, 3, 1, '2016-05-06 14:15:14', 'FRA. 6', -3),
(9, 5, 1, '2016-05-06 14:15:14', 'FRA. 6', -1),
(10, 5, 1, '2016-05-06 14:53:11', 'FRA. 7', -2),
(11, 2, 1, '2016-05-10 15:22:05', 'FRA. 8', -3),
(12, 1, 1, '2016-05-10 15:23:27', 'FRA. 9', -3),
(13, 1, 24, '2016-05-10 15:37:51', 'FRA. 10', -3),
(14, 3, 1, '2016-05-11 12:48:08', 'FRA. 11', -3),
(15, 2, 1, '2016-05-11 12:48:08', 'FRA. 11', -5),
(16, 3, 1, '2016-05-11 12:58:09', 'FRA. 12', -5),
(17, 1, 1, '2016-05-11 12:58:48', 'RECV 3', 10),
(18, 2, 1, '2016-05-11 12:59:28', 'RECV 4', 30),
(19, 2, 1, '2016-05-11 13:37:44', 'FRA. 13', -2),
(20, 3, 1, '2016-05-12 13:02:56', '', 500),
(21, 3, 1, '2016-05-12 13:03:11', '', 1000),
(22, 3, 1, '2016-05-12 14:48:37', 'FRA. 14', -1),
(23, 3, 1, '2016-05-17 14:40:37', 'FRA. 15', -3),
(24, 1, 1, '2016-05-17 14:44:19', 'FRA. 16', -1),
(25, 1, 1, '2016-05-17 15:37:32', 'FRA. 17', 1),
(26, 2, 1, '2016-05-17 15:42:02', 'FRA. 18', -1),
(27, 2, 1, '2016-05-17 15:42:53', 'FRA. 19', 1),
(28, 4, 1, '2016-05-17 15:49:21', 'Edición Manual de Cantidad', 100),
(29, 4, 1, '2016-05-17 15:51:46', 'FRA. 20', -1),
(30, 4, 1, '2016-05-20 11:47:13', 'FRA. 21', -3),
(31, 2, 1, '2016-05-20 12:00:22', 'FRA. 22', -1),
(32, 3, 1, '2016-05-20 12:03:48', 'FRA. 23', -1),
(33, 2, 1, '2016-05-20 12:03:48', 'FRA. 23', -1),
(34, 2, 1, '2016-05-20 12:21:55', 'FRA. 24', -4),
(35, 3, 1, '2016-05-20 12:23:46', 'FRA. 25', -2),
(36, 3, 1, '2016-05-20 14:26:59', 'FRA. 26', -2),
(37, 2, 1, '2016-05-20 14:28:01', 'FRA. 27', -3),
(38, 4, 1, '2016-05-31 15:11:27', '', 5),
(39, 5, 1, '2016-05-31 16:41:48', 'Edición Manual de Cantidad', 1),
(40, 3, 1, '2016-05-31 16:43:48', 'FRA. 28', -4),
(41, 5, 1, '2016-06-01 01:04:04', 'RECV 5', 50),
(42, 2, 1, '2016-06-01 01:10:19', 'FRA. 29', -1),
(43, 5, 1, '2016-06-01 01:48:09', 'FRA. 30', -2),
(44, 3, 1, '2016-06-01 01:50:48', 'FRA. 31', -1),
(45, 4, 1, '2016-06-08 04:33:08', 'FRA. 32', -3),
(46, 3, 1, '2016-06-08 05:05:47', 'RECV 6', 2),
(47, 5, 1, '2016-06-10 15:52:45', 'FRA. 33', -3),
(48, 3, 1, '2016-06-13 13:12:42', 'FRA. 34', -3),
(49, 2, 1, '2016-06-13 13:12:42', 'FRA. 34', -2);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `items`
--

CREATE TABLE IF NOT EXISTS `items` (
  `name` varchar(300) COLLATE utf8_unicode_ci NOT NULL,
  `category` varchar(300) COLLATE utf8_unicode_ci NOT NULL,
  `supplier_id` int(11) DEFAULT NULL,
  `item_number` varchar(300) COLLATE utf8_unicode_ci DEFAULT NULL,
  `description` varchar(300) COLLATE utf8_unicode_ci NOT NULL,
  `cost_price` double(15,2) NOT NULL,
  `unit_price` double(15,2) NOT NULL,
  `quantity` double(15,2) NOT NULL DEFAULT '0.00',
  `item_id` int(11) NOT NULL AUTO_INCREMENT,
  `deleted` int(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`item_id`),
  UNIQUE KEY `item_number` (`item_number`),
  KEY `items_ibfk_1` (`supplier_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=6 ;

--
-- Volcado de datos para la tabla `items`
--

INSERT INTO `items` (`name`, `category`, `supplier_id`, `item_number`, `description`, `cost_price`, `unit_price`, `quantity`, `item_id`, `deleted`) VALUES
('Pintura Blanca', 'Vinilos', 4, '0182456641', 'caneca de pintura por 5 galones', 103230.00, 135000.00, 28.00, 1, 0),
('laca negra', 'Lacas', 4, '0183875796', '', 31000.00, 35000.00, 17.00, 2, 0),
('Esmalte blanco ', 'Esmaltes', 11, '01248751363', 'Esmalte superlavable 5 galones', 150000.00, 180000.00, 1530.00, 3, 0),
('Esmalte Negro', 'Esmaltes', 4, '0124522222', 'Pintura Lavable negra', 145000.00, 178000.00, 98.00, 4, 0),
('laca caoba', 'Lacas', 18, '1255545622', '', 35000.00, 41000.00, 46.00, 5, 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `items_taxes`
--

CREATE TABLE IF NOT EXISTS `items_taxes` (
  `item_id` int(11) NOT NULL,
  `name` varchar(300) COLLATE utf8_unicode_ci NOT NULL,
  `percent` double(15,2) NOT NULL,
  PRIMARY KEY (`item_id`,`name`,`percent`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Volcado de datos para la tabla `items_taxes`
--

INSERT INTO `items_taxes` (`item_id`, `name`, `percent`) VALUES
(1, 'IVA', 16.00),
(2, 'IVA', 16.00),
(3, 'IVA', 16.00),
(4, 'IVA', 16.00),
(5, 'IVA', 16.00);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `modules`
--

CREATE TABLE IF NOT EXISTS `modules` (
  `name_lang_key` varchar(300) COLLATE utf8_unicode_ci NOT NULL,
  `desc_lang_key` varchar(300) COLLATE utf8_unicode_ci NOT NULL,
  `sort` int(11) NOT NULL,
  `module_id` varchar(300) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`module_id`),
  UNIQUE KEY `desc_lang_key` (`desc_lang_key`),
  UNIQUE KEY `name_lang_key` (`name_lang_key`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Volcado de datos para la tabla `modules`
--

INSERT INTO `modules` (`name_lang_key`, `desc_lang_key`, `sort`, `module_id`) VALUES
('module_config', 'module_config_desc', 100, 'config'),
('module_customers', 'module_customers_desc', 10, 'customers'),
('module_employees', 'module_employees_desc', 80, 'employees'),
('module_items', 'module_items_desc', 20, 'items'),
('module_receivings', 'module_receivings_desc', 60, 'receivings'),
('module_reports', 'module_reports_desc', 50, 'reports'),
('module_sales', 'module_sales_desc', 70, 'sales'),
('module_suppliers', 'module_suppliers_desc', 40, 'suppliers');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `people`
--

CREATE TABLE IF NOT EXISTS `people` (
  `first_name` varchar(300) COLLATE utf8_unicode_ci NOT NULL,
  `last_name` varchar(300) COLLATE utf8_unicode_ci NOT NULL,
  `documento` bigint(11) NOT NULL,
  `phone_number` varchar(300) COLLATE utf8_unicode_ci NOT NULL,
  `email` varchar(300) COLLATE utf8_unicode_ci NOT NULL,
  `address_1` varchar(300) COLLATE utf8_unicode_ci NOT NULL,
  `city` varchar(300) COLLATE utf8_unicode_ci NOT NULL,
  `state` varchar(300) COLLATE utf8_unicode_ci NOT NULL,
  `country` varchar(300) COLLATE utf8_unicode_ci NOT NULL,
  `comments` text COLLATE utf8_unicode_ci NOT NULL,
  `person_id` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`person_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=44 ;

--
-- Volcado de datos para la tabla `people`
--

INSERT INTO `people` (`first_name`, `last_name`, `documento`, `phone_number`, `email`, `address_1`, `city`, `state`, `country`, `comments`, `person_id`) VALUES
('Yaneth', 'Castro', 52626358, '4596823', 'Yane.cast@gmail.com', 'Calles 147', '', '', '', '', 1),
('Francisco', 'Memdez', 19568245, '', 'francisco.mendez@gmail.com', '', '', '', '', '', 2),
('Nadin', 'Heredia', 52364221, '304825409', 'nadine@gmail.com', '', '', '', '', '', 3),
('Luis ', 'Diaz', 8005302563, '', '', '', '', '', '', '', 4),
('Leonel', 'Mezi', 25987452, '', 'lenoel.mezi@gmail.com', '', '', '', '', '', 5),
('Mayerly', 'Rojas', 1030258975, '3212425242', '', '', '', '', '', '', 6),
('Damaris', 'Lopez', 52457898, '3202587488', '', '', '', '', '', '', 7),
('Marcos Andres', 'Contrera Bedoya', 79668351, '3182548364', 'contbedoymar@gmail.com', 'Cra 8 # 52-12 s', 'Bogota', 'null', 'Colombia', '', 8),
('raul', 'diaz', 79584575, '', 'rauldiaz@gmail.com', '', '', '', '', '', 9),
('Marcos', 'Ramirez', 1030258963, '', 'marcramir@gmail.com', '', '', '', '', '', 10),
('Maria', 'Reyes', 830120580, '', 'pintuco@pintuco.com.co', '', '', '', '', '', 11),
('Elsa', 'Rojas', 9308502154, '3102987584', 'Pintduitama@hotmail.com', '', 'duitama', 'boyaca', '', '', 12),
('Jaime ', 'Rueda', 80536985, '3112254854', 'jaimer@gmail.com', '', '', '', '', '', 13),
('Carlos', 'Arias', 1030258459, '3215421512', 'caravill@gmail.com', '', '', '', 'Colombia', '', 14),
('Luz Marina', 'Carvajal', 1030569882, '4258792', '', '', '', '', '', '', 15),
('Fabian', 'Ramirez', 80584575, '', '', '', '', '', '', '', 17),
('Javier ', 'Fernandez', 8305302563, '', '', '', '', '', '', '', 18),
('martin a', 'carrillo', 1030258458, '', '', '', '', '', '', '', 22),
('frhrdjh', 'srfhdrj', 1030258450, '', '', '', '', '', '', '', 23),
('Melisa', 'Valencia', 1025424212, '', 'melval@gmail.com', '', '', '', '', '', 24),
('dddd', 'ddddd', 122, '', '', '', '', '', '', '', 25),
('dqario', 'dddd', 1235, '', '', '', '', '', '', '', 26),
('fvsfdfgvsdg', 'fsfsgf', 122, '', '', '', '', '', '', '', 27),
('gdgedgdg', 'gdgdg', 12545, '', '', '', '', '', '', '', 28),
('rdthrdtjtgj', 'rsjtdktjtdj', 68235, '', '', '', '', '', '', '', 29),
('sabgsdb', 'dbhhedbhdb', 68235, '', '', '', '', '', '', '', 30),
('grdhttjh', 'ethrjtdrjhtdj', 8005302563, '', '', '', '', '', '', '', 31),
('wgegeg', 'gesrtgrh', 545222, '', '', '', '', '', '', '', 32),
('wgehgerhr', 'ehgrejthrtdhr', 5245652, '', '', '', '', '', '', '', 33),
('sgvdsgdsrh', 'esrhdfthdth', 2452, '', '', '', '', '', '', '', 34),
('bdhbdbdb', 'sgdhdrh', 11222, '', '', '', '', '', '', '', 35),
('wsrfgeasgr', 'rgerrgseg', 0, '', '', '', '', '', '', '', 36),
('fsfsf', 'santos', 1233, '', '', '', '', '', '', '', 37),
('sgdgdg', 'dzgsdrh', 1452585, '', '', '', '', '', '', '', 38),
('sagdeg', 'gdehdrhrdhrdhh', 12345666, '', '', '', '', '', '', '', 39),
('getetgg', 'gdegegd', 12354582211111, '', '', '', '', '', '', '', 40),
('mao', 'dorrrt', 123456655, '', '', '', '', '', '', '', 41),
('Tobias', 'Castillo', 79820246, '', '', '', '', '', '', '', 42),
('Javier', 'Sanchez', 80265987, '3104578424', 'javisan@gmail.com', 'cra 74 # 85-10', 'Bogotá', 'Bogotá', 'Colombia', 'Admin1', 43);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `permissions`
--

CREATE TABLE IF NOT EXISTS `permissions` (
  `module_id` varchar(300) COLLATE utf8_unicode_ci NOT NULL,
  `person_id` int(11) NOT NULL,
  PRIMARY KEY (`module_id`,`person_id`),
  KEY `person_id` (`person_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Volcado de datos para la tabla `permissions`
--

INSERT INTO `permissions` (`module_id`, `person_id`) VALUES
('config', 1),
('customers', 1),
('customers', 24),
('customers', 42),
('customers', 43),
('employees', 1),
('employees', 43),
('items', 1),
('items', 5),
('items', 6),
('items', 14),
('items', 24),
('items', 42),
('items', 43),
('receivings', 1),
('receivings', 6),
('receivings', 43),
('reports', 1),
('reports', 43),
('sales', 1),
('sales', 5),
('sales', 24),
('sales', 42),
('sales', 43),
('suppliers', 1),
('suppliers', 6),
('suppliers', 24),
('suppliers', 43);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `receivings`
--

CREATE TABLE IF NOT EXISTS `receivings` (
  `receiving_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `supplier_id` int(11) DEFAULT NULL,
  `employee_id` int(11) NOT NULL DEFAULT '0',
  `comment` text COLLATE utf8_unicode_ci NOT NULL,
  `receiving_id` int(11) NOT NULL AUTO_INCREMENT,
  `payment_type` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`receiving_id`),
  KEY `supplier_id` (`supplier_id`),
  KEY `employee_id` (`employee_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=7 ;

--
-- Volcado de datos para la tabla `receivings`
--

INSERT INTO `receivings` (`receiving_time`, `supplier_id`, `employee_id`, `comment`, `receiving_id`, `payment_type`) VALUES
('2016-02-18 05:17:12', 11, 1, '', 1, 'Efectivo'),
('2016-02-18 05:46:59', 11, 1, '', 2, 'Efectivo'),
('2016-05-11 12:58:48', 12, 1, '', 3, 'Efectivo'),
('2016-05-11 12:59:28', NULL, 1, '', 4, 'Efectivo'),
('2016-06-01 01:04:04', 4, 1, '', 5, 'Efectivo'),
('2016-06-08 05:05:47', 30, 1, '', 6, 'Efectivo');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `receivings_items`
--

CREATE TABLE IF NOT EXISTS `receivings_items` (
  `receiving_id` int(11) NOT NULL DEFAULT '0',
  `item_id` int(11) NOT NULL DEFAULT '0',
  `description` varchar(30) COLLATE utf8_unicode_ci DEFAULT NULL,
  `line` int(3) NOT NULL,
  `quantity_purchased` int(11) NOT NULL DEFAULT '0',
  `item_cost_price` decimal(15,2) NOT NULL,
  `item_unit_price` double(15,2) NOT NULL,
  `discount_percent` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`receiving_id`,`item_id`,`line`),
  KEY `item_id` (`item_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Volcado de datos para la tabla `receivings_items`
--

INSERT INTO `receivings_items` (`receiving_id`, `item_id`, `description`, `line`, `quantity_purchased`, `item_cost_price`, `item_unit_price`, `discount_percent`) VALUES
(1, 5, 'Esmalte superlavable 5 galones', 1, 1, '150000.00', 150000.00, 0),
(2, 5, 'Esmalte superlavable 5 galones', 1, 10, '150000.00', 150000.00, 0),
(3, 1, 'caneca de pintura por 5 galone', 1, 10, '103230.00', 103230.00, 0),
(4, 2, '', 1, 30, '31000.00', 31000.00, 0),
(5, 5, '', 1, 50, '35000.00', 35000.00, 0),
(6, 3, 'Esmalte superlavable 5 galones', 1, 2, '150000.00', 150000.00, 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `sales`
--

CREATE TABLE IF NOT EXISTS `sales` (
  `sale_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `customer_id` int(11) DEFAULT NULL,
  `employee_id` int(11) NOT NULL DEFAULT '0',
  `comment` text COLLATE utf8_unicode_ci,
  `sale_id` int(11) NOT NULL AUTO_INCREMENT,
  `payment_type` varchar(512) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`sale_id`),
  KEY `customer_id` (`customer_id`),
  KEY `employee_id` (`employee_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=35 ;

--
-- Volcado de datos para la tabla `sales`
--

INSERT INTO `sales` (`sale_time`, `customer_id`, `employee_id`, `comment`, `sale_id`, `payment_type`) VALUES
('2016-02-17 02:48:58', 7, 1, '0', 1, 'Efectivo: $ 156600.00<br />'),
('2016-02-18 04:31:44', 9, 1, '0', 2, 'Cheque: $ 243600.00<br />'),
('2016-02-24 00:50:14', 9, 1, '0', 3, 'Tarjeta de DÃ©bito: $ 435000.00<br />'),
('2016-04-06 23:20:15', 3, 1, '0', 4, 'Tarjeta de DÃ©bito: $ 823600.00<br />'),
('2016-05-06 14:13:41', 7, 1, '0', 5, 'Efectivo: $ 1044000.00<br />'),
('2016-05-06 14:15:14', 13, 1, '0', 6, 'Tarjeta de DÃ©bito: $ 678600.00<br />'),
('2016-05-06 14:53:11', 15, 1, '0', 7, 'Efectivo: $ 417600.00<br />'),
('2016-05-10 15:22:05', 15, 1, '0', 8, 'Efectivo: $ 119364.00<br />'),
('2016-05-10 15:23:27', 22, 1, '0', 9, 'Efectivo: $ 469800.00<br />'),
('2016-05-10 15:37:51', 13, 24, '0', 10, 'Efectivo: $ 469800.00<br />'),
('2016-05-11 12:48:07', 9, 1, '0', 11, 'Tarjeta de Débito: $ 829400.00<br />'),
('2016-05-11 12:58:09', 7, 1, '0', 12, 'Efectivo: $ 1044000.00<br />'),
('2016-05-11 13:37:44', NULL, 1, '0', 13, 'Efectivo: $ 81200.00<br />'),
('2016-05-12 14:48:37', 13, 1, '0', 14, 'Efectivo: $ 208800.00<br />'),
('2016-05-17 14:40:37', NULL, 1, '0', 15, 'Efectivo: $ 626400.00<br />'),
('2016-05-17 14:44:19', 15, 1, '0', 16, 'Efectivo: $ 156600.00<br />'),
('2016-05-17 15:37:32', 15, 1, 'se anula FRA. 22', 17, 'Efectivo: -$ 156600.00<br />'),
('2016-05-17 15:42:02', 9, 1, '0', 18, 'Efectivo: $ 40600.00<br />'),
('2016-05-17 15:42:53', 9, 1, '0', 19, 'Efectivo: -$ 40600.00<br />'),
('2016-05-17 15:51:46', 9, 1, '0', 20, 'Efectivo: $ 100000.00<br />Tarjeta de Débito: $ 106480.00<br />'),
('2016-05-20 11:47:13', 9, 1, '0', 21, 'Efectivo: $ 619440.00<br />'),
('2016-05-20 12:00:22', 9, 1, '0', 22, 'Efectivo: $ 40600.00<br />'),
('2016-05-20 12:03:48', 13, 1, '0', 23, 'Efectivo: $ 249400.00<br />'),
('2016-05-20 12:21:55', 22, 1, '0', 24, 'Tarjeta de Débito: $ 100000.00<br />Efectivo: $ 62400.00<br />'),
('2016-05-20 12:23:46', 9, 1, '0', 25, 'Efectivo: $ 417600.00<br />'),
('2016-05-20 14:26:59', NULL, 1, '0', 26, 'Efectivo: $ 417600.00<br />'),
('2016-05-20 14:28:01', 15, 1, '0', 27, 'Efectivo: $ 121800.00<br />'),
('2016-05-31 16:43:48', 15, 1, '0', 28, 'Efectivo: $ 835200.00<br />'),
('2016-06-01 01:10:19', 9, 1, '0', 29, 'Efectivo: $ 40600.00<br />'),
('2016-06-01 01:48:09', 15, 1, '0', 30, 'Efectivo: $ 100000.00<br />'),
('2016-06-01 01:50:48', 22, 1, '0', 31, 'Efectivo: $ 208800.00<br />'),
('2016-06-08 04:33:08', 15, 1, NULL, 32, 'Efectivo: $ 619440.00<br />'),
('2016-06-10 15:52:45', 15, 1, NULL, 33, 'Efectivo: $ 142680.00<br />'),
('2016-06-13 13:12:42', 15, 1, NULL, 34, 'Tarjeta de Débito: $ 707600.00<br />');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `sales_items`
--

CREATE TABLE IF NOT EXISTS `sales_items` (
  `sale_id` int(11) NOT NULL DEFAULT '0',
  `item_id` int(11) NOT NULL DEFAULT '0',
  `description` varchar(30) COLLATE utf8_unicode_ci DEFAULT NULL,
  `line` int(3) NOT NULL DEFAULT '0',
  `quantity_purchased` double(15,2) NOT NULL DEFAULT '0.00',
  `item_cost_price` decimal(15,2) NOT NULL,
  `item_unit_price` double(15,2) NOT NULL,
  `discount_percent` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`sale_id`,`item_id`,`line`),
  KEY `item_id` (`item_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Volcado de datos para la tabla `sales_items`
--

INSERT INTO `sales_items` (`sale_id`, `item_id`, `description`, `line`, `quantity_purchased`, `item_cost_price`, `item_unit_price`, `discount_percent`) VALUES
(1, 3, 'caneca de pintura por 5 galone', 1, 1.00, '103230.00', 135000.00, 0),
(2, 4, '', 1, 6.00, '31000.00', 35000.00, 0),
(3, 3, 'caneca de pintura por 5 galone', 2, 2.00, '103230.00', 135000.00, 0),
(3, 4, '', 1, 3.00, '31000.00', 35000.00, 0),
(4, 4, '', 1, 1.00, '31000.00', 35000.00, 0),
(4, 3, 'caneca de pintura por 5 galone', 2, 5.00, '103230.00', 135000.00, 0),
(5, 5, 'Esmalte superlavable 5 galones', 1, 5.00, '150000.00', 180000.00, 0),
(6, 3, 'caneca de pintura por 5 galone', 1, 3.00, '103230.00', 135000.00, 0),
(6, 5, 'Esmalte superlavable 5 galones', 2, 1.00, '150000.00', 180000.00, 0),
(7, 5, 'Esmalte superlavable 5 galones', 1, 2.00, '150000.00', 180000.00, 0),
(8, 2, '', 1, 3.00, '31000.00', 35000.00, 2),
(9, 1, 'caneca de pintura por 5 galone', 1, 3.00, '103230.00', 135000.00, 0),
(10, 1, 'caneca de pintura por 5 galone', 1, 3.00, '103230.00', 135000.00, 0),
(11, 3, 'Esmalte superlavable 5 galones', 1, 3.00, '150000.00', 180000.00, 0),
(11, 2, '', 2, 5.00, '31000.00', 35000.00, 0),
(12, 3, 'Esmalte superlavable 5 galones', 1, 5.00, '150000.00', 180000.00, 0),
(13, 2, '', 1, 2.00, '31000.00', 35000.00, 0),
(14, 3, 'Esmalte superlavable 5 galones', 1, 1.00, '150000.00', 180000.00, 0),
(15, 3, 'Esmalte superlavable 5 galones', 1, 3.00, '150000.00', 180000.00, 0),
(16, 1, 'caneca de pintura por 5 galone', 1, 1.00, '103230.00', 135000.00, 0),
(17, 1, 'caneca de pintura por 5 galone', 1, -1.00, '103230.00', 135000.00, 0),
(18, 2, '', 1, 1.00, '31000.00', 35000.00, 0),
(19, 2, '', 1, -1.00, '31000.00', 35000.00, 0),
(20, 4, 'Pintura Lavable negra', 1, 1.00, '145000.00', 178000.00, 0),
(21, 4, 'Pintura Lavable negra', 1, 3.00, '145000.00', 178000.00, 0),
(22, 2, '', 1, 1.00, '31000.00', 35000.00, 0),
(23, 3, 'Esmalte superlavable 5 galones', 1, 1.00, '150000.00', 180000.00, 0),
(23, 2, '', 2, 1.00, '31000.00', 35000.00, 0),
(24, 2, '', 1, 4.00, '31000.00', 35000.00, 0),
(25, 3, 'Esmalte superlavable 5 galones', 1, 2.00, '150000.00', 180000.00, 0),
(26, 3, 'Esmalte superlavable 5 galones', 1, 2.00, '150000.00', 180000.00, 0),
(27, 2, '', 1, 3.00, '31000.00', 35000.00, 0),
(28, 3, 'Esmalte superlavable 5 galones', 1, 4.00, '150000.00', 180000.00, 0),
(29, 2, '', 1, 1.00, '31000.00', 35000.00, 0),
(30, 5, '', 1, 2.00, '35000.00', 41000.00, 0),
(31, 3, 'Esmalte superlavable 5 galones', 1, 1.00, '150000.00', 180000.00, 0),
(32, 4, 'Pintura Lavable negra', 1, 3.00, '145000.00', 178000.00, 0),
(33, 5, '', 1, 3.00, '35000.00', 41000.00, 0),
(34, 3, 'Esmalte superlavable 5 galones', 1, 3.00, '150000.00', 180000.00, 0),
(34, 2, '', 2, 2.00, '31000.00', 35000.00, 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `sales_items_taxes`
--

CREATE TABLE IF NOT EXISTS `sales_items_taxes` (
  `sale_id` int(11) NOT NULL,
  `item_id` int(11) NOT NULL,
  `line` int(3) NOT NULL DEFAULT '0',
  `name` varchar(300) COLLATE utf8_unicode_ci NOT NULL,
  `percent` double(15,2) NOT NULL,
  PRIMARY KEY (`sale_id`,`item_id`,`line`,`name`,`percent`),
  KEY `item_id` (`item_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Volcado de datos para la tabla `sales_items_taxes`
--

INSERT INTO `sales_items_taxes` (`sale_id`, `item_id`, `line`, `name`, `percent`) VALUES
(1, 3, 1, 'IVA', 16.00),
(2, 4, 1, 'IVA', 16.00),
(3, 3, 2, 'IVA', 16.00),
(3, 4, 1, 'IVA', 16.00),
(4, 3, 2, 'IVA', 16.00),
(4, 4, 1, 'IVA', 16.00),
(5, 5, 1, 'IVA', 16.00),
(6, 3, 1, 'IVA', 16.00),
(6, 5, 2, 'IVA', 16.00),
(7, 5, 1, 'IVA', 16.00),
(8, 2, 1, 'IVA', 16.00),
(9, 1, 1, 'IVA', 16.00),
(10, 1, 1, 'IVA', 16.00),
(11, 2, 2, 'IVA', 16.00),
(11, 3, 1, 'IVA', 16.00),
(12, 3, 1, 'IVA', 16.00),
(13, 2, 1, 'IVA', 16.00),
(14, 3, 1, 'IVA', 16.00),
(15, 3, 1, 'IVA', 16.00),
(16, 1, 1, 'IVA', 16.00),
(17, 1, 1, 'IVA', 16.00),
(18, 2, 1, 'IVA', 16.00),
(19, 2, 1, 'IVA', 16.00),
(20, 4, 1, 'IVA', 16.00),
(21, 4, 1, 'IVA', 16.00),
(22, 2, 1, 'IVA', 16.00),
(23, 2, 2, 'IVA', 16.00),
(23, 3, 1, 'IVA', 16.00),
(24, 2, 1, 'IVA', 16.00),
(25, 3, 1, 'IVA', 16.00),
(26, 3, 1, 'IVA', 16.00),
(27, 2, 1, 'IVA', 16.00),
(28, 3, 1, 'IVA', 16.00),
(29, 2, 1, 'IVA', 16.00),
(30, 5, 1, 'IVA', 16.00),
(31, 3, 1, 'IVA', 16.00),
(32, 4, 1, 'IVA', 16.00),
(33, 5, 1, 'IVA', 16.00),
(34, 2, 2, 'IVA', 16.00),
(34, 3, 1, 'IVA', 16.00);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `sales_payments`
--

CREATE TABLE IF NOT EXISTS `sales_payments` (
  `sale_id` int(11) NOT NULL,
  `payment_type` varchar(40) COLLATE utf8_unicode_ci NOT NULL,
  `payment_amount` decimal(15,2) NOT NULL,
  PRIMARY KEY (`sale_id`,`payment_type`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Volcado de datos para la tabla `sales_payments`
--

INSERT INTO `sales_payments` (`sale_id`, `payment_type`, `payment_amount`) VALUES
(1, 'Efectivo', '156600.00'),
(2, 'Cheque', '243600.00'),
(3, 'Tarjeta de DÃ©bito', '435000.00'),
(4, 'Tarjeta de DÃ©bito', '823600.00'),
(5, 'Efectivo', '1044000.00'),
(6, 'Tarjeta de DÃ©bito', '678600.00'),
(7, 'Efectivo', '417600.00'),
(8, 'Efectivo', '119364.00'),
(9, 'Efectivo', '469800.00'),
(10, 'Efectivo', '469800.00'),
(11, 'Tarjeta de Débito', '829400.00'),
(12, 'Efectivo', '1044000.00'),
(13, 'Efectivo', '81200.00'),
(14, 'Efectivo', '208800.00'),
(15, 'Efectivo', '626400.00'),
(16, 'Efectivo', '156600.00'),
(17, 'Efectivo', '-156600.00'),
(18, 'Efectivo', '40600.00'),
(19, 'Efectivo', '-40600.00'),
(20, 'Efectivo', '100000.00'),
(20, 'Tarjeta de Débito', '106480.00'),
(21, 'Efectivo', '619440.00'),
(22, 'Efectivo', '40600.00'),
(23, 'Efectivo', '249400.00'),
(24, 'Tarjeta de Débito', '100000.00'),
(24, 'Efectivo', '62400.00'),
(25, 'Efectivo', '417600.00'),
(26, 'Efectivo', '417600.00'),
(27, 'Efectivo', '121800.00'),
(28, 'Efectivo', '835200.00'),
(29, 'Efectivo', '40600.00'),
(30, 'Efectivo', '100000.00'),
(31, 'Efectivo', '208800.00'),
(32, 'Efectivo', '619440.00'),
(33, 'Efectivo', '142680.00'),
(34, 'Tarjeta de Débito', '707600.00');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `sessions`
--

CREATE TABLE IF NOT EXISTS `sessions` (
  `id` varchar(40) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  `ip_address` varchar(16) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  `timestamp` int(11) unsigned NOT NULL DEFAULT '0',
  `data` blob,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Volcado de datos para la tabla `sessions`
--

INSERT INTO `sessions` (`id`, `ip_address`, `timestamp`, `data`) VALUES
('f1b09390fca405725455c6c6d9ccfbca7598206d', '127.0.0.1', 1465358851, 0x5f5f63695f6c6173745f726567656e65726174657c693a313436353335383835313b),
('cf114aac5a3e7d828a128a3467f42544b61cfa81', '127.0.0.1', 1465359219, 0x5f5f63695f6c6173745f726567656e65726174657c693a313436353335393231393b),
('649110499872094c3742dfc3fe8422650fde8b83', '127.0.0.1', 1465360388, 0x5f5f63695f6c6173745f726567656e65726174657c693a313436353336303132363b706572736f6e5f69647c733a313a2231223b),
('7c995b105ba27b271a288220f58eb30ab989d3f4', '127.0.0.1', 1465361859, 0x5f5f63695f6c6173745f726567656e65726174657c693a313436353336313835393b706572736f6e5f69647c733a313a2231223b),
('1cc13f824382868663f298acb09166d049f4eebb', '127.0.0.1', 1465360722, 0x5f5f63695f6c6173745f726567656e65726174657c693a313436353336303534353b706572736f6e5f69647c733a313a2231223b),
('07ed2b0374602dcc270f8a42c1e460571546d5d7', '127.0.0.1', 1465361070, 0x5f5f63695f6c6173745f726567656e65726174657c693a313436353336303930373b706572736f6e5f69647c733a313a2231223b),
('91bab06039aa8aa12f18e8720c9336d3761f4bd4', '127.0.0.1', 1465361834, 0x5f5f63695f6c6173745f726567656e65726174657c693a313436353336313534343b706572736f6e5f69647c733a313a2231223b),
('04e434ecb32b00dc36e173c49e4925f16d7719f8', '127.0.0.1', 1465362439, 0x5f5f63695f6c6173745f726567656e65726174657c693a313436353336323239333b706572736f6e5f69647c733a313a2231223b726563765f6d6f64657c733a373a2272656365697665223b),
('1361dd2a0ba4ef1975c22f361d71e5d5e6e928d2', '::1', 1465486320, 0x5f5f63695f6c6173745f726567656e65726174657c693a313436353438363331393b),
('a92d96059ed5fc6a035473809006bc682d84c7f6', '::1', 1465486705, 0x5f5f63695f6c6173745f726567656e65726174657c693a313436353438363730353b),
('ab7381976de5d5268d95a6b49c83a5fc99798553', '::1', 1465487194, 0x5f5f63695f6c6173745f726567656e65726174657c693a313436353438373038313b706572736f6e5f69647c733a313a2231223b),
('45d3f5156efb4cfa69d910500a9d7b3285d3f81e', '::1', 1465487450, 0x5f5f63695f6c6173745f726567656e65726174657c693a313436353438373434373b706572736f6e5f69647c733a313a2231223b63617274526563767c613a303a7b7d726563765f6d6f64657c733a373a2272656365697665223b737570706c6965727c693a2d313b636172747c613a303a7b7d73616c655f6d6f64657c733a343a2273616c65223b637573746f6d65727c693a2d313b7061796d656e74737c613a303a7b7d),
('e22372c649eefc1ff466e4593779d2b2a50840aa', '::1', 1465558292, 0x5f5f63695f6c6173745f726567656e65726174657c693a313436353535383237363b706572736f6e5f69647c733a313a2231223b),
('70ba5f92a1c30b77d40450625cf6866a3874fc39', '::1', 1465563864, 0x5f5f63695f6c6173745f726567656e65726174657c693a313436353536333734363b706572736f6e5f69647c733a313a2231223b),
('1febdbc880c75154c13ce636a3c9391093be1f22', '::1', 1465564524, 0x5f5f63695f6c6173745f726567656e65726174657c693a313436353536343532323b706572736f6e5f69647c733a313a2231223b636172747c613a303a7b7d73616c655f6d6f64657c733a343a2273616c65223b637573746f6d65727c693a2d313b7061796d656e74737c613a303a7b7d),
('eec9e77df1e6e0d8d303d519b4ceef542feb18ec', '::1', 1465568871, 0x5f5f63695f6c6173745f726567656e65726174657c693a313436353536383837313b),
('31a6427b76089bcc5c4415e8a6edcb47d64c03a0', '::1', 1465570221, 0x5f5f63695f6c6173745f726567656e65726174657c693a313436353537303230363b),
('5c17ad771727b702ae417ac16f7dfc05d160839a', '::1', 1465571162, 0x5f5f63695f6c6173745f726567656e65726174657c693a313436353537313136323b),
('29c03eb8f93c6029c2c50ce724ab70775b92a214', '::1', 1465571744, 0x5f5f63695f6c6173745f726567656e65726174657c693a313436353537313436363b),
('416907fa3e73fc7e44bf1db35d55c7739f598333', '::1', 1465571978, 0x5f5f63695f6c6173745f726567656e65726174657c693a313436353537313737393b),
('63918b0d2fe8c6176c19425682cbcfe4b698a608', '::1', 1465572659, 0x5f5f63695f6c6173745f726567656e65726174657c693a313436353537323635393b),
('bc8e3436446e300672fecf1fa2b0b1431567019a', '::1', 1465573031, 0x5f5f63695f6c6173745f726567656e65726174657c693a313436353537323739343b),
('f5cc69340cf09dc6a2cc1c9ac42b4497f4d7f8eb', '::1', 1465573809, 0x5f5f63695f6c6173745f726567656e65726174657c693a313436353537333537383b706572736f6e5f69647c733a313a2231223b63617274526563767c613a303a7b7d726563765f6d6f64657c733a373a2272656365697665223b737570706c6965727c693a2d313b636172747c613a303a7b7d73616c655f6d6f64657c733a343a2273616c65223b637573746f6d65727c693a2d313b7061796d656e74737c613a303a7b7d),
('3efdb7a304604f6b6ec5d67d31ef9fd58c15b906', '::1', 1465573980, 0x5f5f63695f6c6173745f726567656e65726174657c693a313436353537333933313b706572736f6e5f69647c733a313a2231223b63617274526563767c613a303a7b7d726563765f6d6f64657c733a373a2272656365697665223b737570706c6965727c693a2d313b),
('734d8b72cf3381cbcc20fcc3c827ac6f568d84e7', '::1', 1465822852, 0x5f5f63695f6c6173745f726567656e65726174657c693a313436353832323630343b706572736f6e5f69647c733a313a2231223b),
('09d361a829d4b1f757386cad6b4aed34f57c1d07', '::1', 1465823689, 0x5f5f63695f6c6173745f726567656e65726174657c693a313436353832333431313b706572736f6e5f69647c733a313a2231223b),
('62b0b511a2d629f69a02e18d41549b78191500a4', '::1', 1465574801, 0x5f5f63695f6c6173745f726567656e65726174657c693a313436353537343735343b706572736f6e5f69647c733a313a2231223b63617274526563767c613a303a7b7d726563765f6d6f64657c733a373a2272656365697665223b737570706c6965727c693a2d313b),
('84e7226854f357285a7b376707c9ed157cf77a3b', '::1', 1465829699, 0x5f5f63695f6c6173745f726567656e65726174657c693a313436353832393639393b706572736f6e5f69647c733a323a223433223b),
('130d6e6361004262d7a3a79d4e6f8c9505b19477', '::1', 1465823964, 0x5f5f63695f6c6173745f726567656e65726174657c693a313436353832333934363b706572736f6e5f69647c733a313a2231223b63617274526563767c613a303a7b7d726563765f6d6f64657c733a373a2272656365697665223b737570706c6965727c693a2d313b636172747c613a303a7b7d73616c655f6d6f64657c733a343a2273616c65223b637573746f6d65727c693a2d313b7061796d656e74737c613a303a7b7d),
('0017b2dc1c96547aa6abd0ae7611a045e80a0dba', '::1', 1465824402, 0x5f5f63695f6c6173745f726567656e65726174657c693a313436353832343335313b706572736f6e5f69647c733a313a2231223b63617274526563767c613a303a7b7d726563765f6d6f64657c733a373a2272656365697665223b737570706c6965727c693a2d313b636172747c613a303a7b7d73616c655f6d6f64657c733a343a2273616c65223b637573746f6d65727c693a2d313b7061796d656e74737c613a303a7b7d),
('690157704168988455091e967fdf1207968476c5', '::1', 1465828660, 0x5f5f63695f6c6173745f726567656e65726174657c693a313436353832383630393b706572736f6e5f69647c733a323a223433223b),
('e3e34e637ea8bfbffff48f44583be41651af4ffc', '::1', 1466003876, 0x5f5f63695f6c6173745f726567656e65726174657c693a313436363030333837363b),
('ecf7ac5ff86ff81028204872bc9a918dcc13cf73', '::1', 1466004453, 0x5f5f63695f6c6173745f726567656e65726174657c693a313436363030343435323b706572736f6e5f69647c733a323a223433223b);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `suppliers`
--

CREATE TABLE IF NOT EXISTS `suppliers` (
  `person_id` int(11) NOT NULL,
  `company_name` varchar(300) COLLATE utf8_unicode_ci NOT NULL,
  `account_number` varchar(300) COLLATE utf8_unicode_ci DEFAULT NULL,
  `deleted` int(1) NOT NULL DEFAULT '0',
  UNIQUE KEY `account_number` (`account_number`),
  KEY `person_id` (`person_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Volcado de datos para la tabla `suppliers`
--

INSERT INTO `suppliers` (`person_id`, `company_name`, `account_number`, `deleted`) VALUES
(4, 'Exportaciones e Importaciones S.A.C', '3987456123', 0),
(11, 'Pintuco S.A.', NULL, 0),
(12, 'Pinturas Duitama', NULL, 0),
(18, 'Pinturas Fernandez', NULL, 0),
(28, 'zgsdg', NULL, 0),
(29, 'dcghfrdjh', NULL, 0),
(30, 'dsavdszb', NULL, 0),
(31, 'sgrhrdhrh', NULL, 0),
(32, 'awfdsafwg', NULL, 0),
(39, 'gvszgzsg', NULL, 0);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
