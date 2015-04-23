-- phpMyAdmin SQL Dump
-- version 3.5.3
-- http://www.phpmyadmin.net
--
-- Servidor: localhost
-- Temps de generació: 18-03-2015 a les 12:52:47
-- Versió del servidor: 5.1.63-log
-- Versió de PHP: 5.3.17

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Base de dades: `mps`
--

-- --------------------------------------------------------

--
-- Estructura de la taula `mps_books`
--

CREATE TABLE IF NOT EXISTS `mps_books` (
  `id` bigint(10) NOT NULL AUTO_INCREMENT,
  `isbn` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `level` varchar(255) NOT NULL,
  `format` varchar(255) NOT NULL,
  `path` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=8 ;

--
-- Bolcant dades de la taula `mps_books`
--

INSERT INTO `mps_books` (`id`, `isbn`, `name`, `level`, `format`, `path`) VALUES
(1, '1111111111', 'Llibre scorm remot sense unitat', '1ESO', 'scorm', '1111111111/imsmanifest.xml'),
(2, '2222222222', 'Llibre contingut remot sense unitat', '1ESO', 'webcontent', '2222222222/index.php'),
(3, '3333333333', 'Llibre scorm remot amb dues unitats', '1ESO', 'scorm', '3333333333/imsmanifest.xml'),
(4, '4444444444', 'Llibre contingut remot amb dues unitats', '1ESO', 'webcontent', '4444444444/index.php'),
(5, '5555555555', 'Llibre scorm remot amb dues activitats', '2ESO', 'scorm', '5555555555/imsmanifest.xml'),
(6, '6666666666', 'Llibre contingut remot amb dues activitats', '2ESO', 'webcontent', '6666666666/index.php'),
(7, '7777777777', 'Llibre contingut remot jeràrquic', '1ESO', 'webcontent', '7777777777/index.php');

-- --------------------------------------------------------

--
-- Estructura de la taula `mps_books_activities`
--

CREATE TABLE IF NOT EXISTS `mps_books_activities` (
  `id` bigint(10) NOT NULL AUTO_INCREMENT,
  `bookid` bigint(10) NOT NULL,
  `unitid` bigint(10) NOT NULL,
  `code` varchar(100) NOT NULL,
  `name` varchar(255) NOT NULL,
  `sortorder` bigint(10) NOT NULL,
  `path` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=14 ;

--
-- Bolcant dades de la taula `mps_books_activities`
--

INSERT INTO `mps_books_activities` (`id`, `bookid`, `unitid`, `code`, `name`, `sortorder`, `path`) VALUES
(1, 5, 5, '1', 'Activitat 1', 1, '5555555555/55555/111/imsmanifest.xml'),
(2, 5, 5, '2', 'Activitat 2', 2, '5555555555/55555/222/imsmanifest.xml'),
(3, 5, 6, '1', 'Activitat 1', 1, '5555555555/66666/333/imsmanifest.xml'),
(4, 5, 6, '2', 'Activitat 2', 2, '5555555555/66666/444/imsmanifest.xml'),
(5, 6, 7, '1', 'Activitat 1', 1, '6666666666/77777/555/index.php'),
(6, 6, 7, '2', 'Activitat 2', 2, '6666666666/77777/666/index.php'),
(7, 6, 8, '1', 'Activitat 1', 1, '6666666666/88888/777/index.php'),
(8, 6, 8, '2', 'Activitat 2', 2, '6666666666/88888/888/index.php'),
(9, 7, 9, '1', 'Activitat 1', 1, '7777777777/Unit1/Act1/index.php'),
(10, 7, 9, '2', 'Activitat 2', 2, '7777777777/Unit1/Act2/index.php'),
(11, 7, 9, '3', 'Activitat 3', 3, '7777777777/Unit1/Act3/index.php'),
(12, 7, 10, '1', 'Activitat 1', 1, '7777777777/Unit2/Act1/index.php'),
(13, 7, 10, '2', 'Activitat 2', 2, '7777777777/Unit2/Act2/index.php');

-- --------------------------------------------------------

--
-- Estructura de la taula `mps_books_credentials`
--

CREATE TABLE IF NOT EXISTS `mps_books_credentials` (
  `id` bigint(10) NOT NULL AUTO_INCREMENT,
  `isbn` varchar(255) NOT NULL,
  `credentials` varchar(255) DEFAULT NULL,
  `success` bigint(1) NOT NULL,
  `code` varchar(100) NOT NULL,
  `description` text NOT NULL,
  `url` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=36 ;

--
-- Bolcant dades de la taula `mps_books_credentials`
--

INSERT INTO `mps_books_credentials` (`id`, `isbn`, `credentials`, `success`, `code`, `description`, `url`) VALUES
(1, '1111111111', '1', 1, '1', 'URL generada correctament', 'http://www.xtec.cat/llibre.html'),
(2, '1111111111', '0', 0, '0', 'Error inesperat', 'http://www.xtec.cat/error.html'),
(3, '1111111111', '-1', 0, '-1', 'Error al realitzar la URL dinàmica', 'http://www.xtec.cat/error.html'),
(4, '1111111111', '-2', 0, '-2', 'El codi de llicencia no es vàlid', 'http://www.xtec.cat/error.html'),
(5, '1111111111', '-4', 0, '-4', 'La llicencia ha expirat', 'http://www.xtec.cat/error.html'),
(6, '2222222222', '1', 1, '1', 'URL generada correctament', 'http://www.xtec.cat/llibre.html'),
(7, '2222222222', '0', 0, '0', 'Error inesperat', 'http://www.xtec.cat/error.html'),
(8, '2222222222', '-1', 0, '-1', 'Error al realitzar la URL dinàmica', 'http://www.xtec.cat/error.html'),
(9, '2222222222', '-2', 0, '-2', 'El codi de llicencia no es vàlid', 'http://www.xtec.cat/error.html'),
(10, '2222222222', '-4', 0, '-4', 'La llicencia ha expirat', 'http://www.xtec.cat/error.html'),
(11, '3333333333', '1', 1, '1', 'URL generada correctament', 'http://www.xtec.cat/llibre.html'),
(12, '3333333333', '0', 0, '0', 'Error inesperat', 'http://www.xtec.cat/error.html'),
(13, '3333333333', '-1', 0, '-1', 'Error al realitzar la URL dinàmica', 'http://www.xtec.cat/error.html'),
(14, '3333333333', '-2', 0, '-2', 'El codi de llicencia no es vàlid', 'http://www.xtec.cat/error.html'),
(15, '3333333333', '-4', 0, '-4', 'La llicencia ha expirat', 'http://www.xtec.cat/error.html'),
(16, '4444444444', '1', 1, '1', 'URL generada correctament', 'http://www.xtec.cat/llibre.html'),
(17, '4444444444', '0', 0, '0', 'Error inesperat', 'http://www.xtec.cat/error.html'),
(18, '4444444444', '-1', 0, '-1', 'Error al realitzar la URL dinàmica', 'http://www.xtec.cat/error.html'),
(19, '4444444444', '-2', 0, '-2', 'El codi de llicencia no es vàlid', 'http://www.xtec.cat/error.html'),
(20, '4444444444', '-4', 0, '-4', 'La llicencia ha expirat', 'http://www.xtec.cat/error.html'),
(21, '5555555555', '1', 1, '1', 'URL generada correctament', 'http://www.xtec.cat/llibre.html'),
(22, '5555555555', '0', 0, '0', 'Error inesperat', 'http://www.xtec.cat/error.html'),
(23, '5555555555', '-1', 0, '-1', 'Error al realitzar la URL dinàmica', 'http://www.xtec.cat/error.html'),
(24, '5555555555', '-2', 0, '-2', 'El codi de llicencia no es vàlid', 'http://www.xtec.cat/error.html'),
(25, '5555555555', '-4', 0, '-4', 'La llicencia ha expirat', 'http://www.xtec.cat/error.html'),
(26, '6666666666', '1', 1, '1', 'URL generada correctament', 'http://www.xtec.cat/llibre.html'),
(27, '6666666666', '0', 0, '0', 'Error inesperat', 'http://www.xtec.cat/error.html'),
(28, '6666666666', '-1', 0, '-1', 'Error al realitzar la URL dinàmica', 'http://www.xtec.cat/error.html'),
(29, '6666666666', '-2', 0, '-2', 'El codi de llicencia no es vàlid', 'http://www.xtec.cat/error.html'),
(30, '6666666666', '-4', 0, '-4', 'La llicencia ha expirat', 'http://www.xtec.cat/error.html'),
(31, '7777777777', '1', 1, '1', 'URL generada correctament', 'http://www.xtec.cat/llibre.html'),
(32, '7777777777', '0', 0, '0', 'Error inesperat', 'http://www.xtec.cat/error.html'),
(33, '7777777777', '-1', 0, '-1', 'Error al realitzar la URL dinàmica', 'http://www.xtec.cat/error.html'),
(34, '7777777777', '-2', 0, '-2', 'El codi de llicencia no es vàlid', 'http://www.xtec.cat/error.html'),
(35, '7777777777', '-4', 0, '-4', 'La llicencia ha expirat', 'http://www.xtec.cat/error.html');

-- --------------------------------------------------------

--
-- Estructura de la taula `mps_books_units`
--

CREATE TABLE IF NOT EXISTS `mps_books_units` (
  `id` bigint(10) NOT NULL AUTO_INCREMENT,
  `bookid` bigint(10) NOT NULL,
  `code` varchar(100) NOT NULL,
  `name` varchar(255) NOT NULL,
  `sortorder` bigint(10) NOT NULL,
  `path` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=11 ;

--
-- Bolcant dades de la taula `mps_books_units`
--

INSERT INTO `mps_books_units` (`id`, `bookid`, `code`, `name`, `sortorder`, `path`) VALUES
(1, 3, '1', 'Unitat 1', 1, '3333333333/11111/imsmanifest.xml'),
(2, 3, '2', 'Unitat 2', 2, '3333333333/22222/imsmanifest.xml'),
(3, 4, '1', 'Unitat 1', 1, '4444444444/33333/index.php'),
(4, 4, '2', 'Unitat 2', 2, '4444444444/44444/index.php'),
(5, 5, '1', 'Unitat 1', 1, '5555555555/55555/imsmanifest.xml'),
(6, 5, '2', 'Unitat 2', 2, '5555555555/66666/imsmanifest.xml'),
(7, 6, '1', 'Unitat 1', 1, '6666666666/77777/index.php'),
(8, 6, '2', 'Unitat 2', 2, '6666666666/88888/index.php'),
(9, 7, '1', 'Unitat 1 (Autoavaluada)', 1, '7777777777/Unit1/index.php'),
(10, 7, '2', 'Unitat 2 (Avaluada per professor)', 2, '7777777777/Unit2/index.php');

-- --------------------------------------------------------

--
-- Estructura de la taula `mps_categories`
--

CREATE TABLE IF NOT EXISTS `mps_categories` (
  `id` bigint(10) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=4 ;

--
-- Bolcant dades de la taula `mps_categories`
--

INSERT INTO `mps_categories` (`id`, `name`) VALUES
(1, 'authentication'),
(2, 'bookstructure'),
(3, 'tracking');

-- --------------------------------------------------------

--
-- Estructura de la taula `mps_center`
--

CREATE TABLE IF NOT EXISTS `mps_center` (
  `id` bigint(10) NOT NULL AUTO_INCREMENT,
  `code` varchar(100) NOT NULL,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2 ;

--
-- Bolcant dades de la taula `mps_center`
--

INSERT INTO `mps_center` (`id`, `code`, `name`) VALUES
(1, '001', 'Marsupial School Simulator');

-- --------------------------------------------------------

--
-- Estructura de la taula `mps_center_books`
--

CREATE TABLE IF NOT EXISTS `mps_center_books` (
  `id` bigint(10) NOT NULL AUTO_INCREMENT,
  `bookid` bigint(10) NOT NULL,
  `centerid` bigint(10) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=3 ;

--
-- Bolcant dades de la taula `mps_center_books`
--

INSERT INTO `mps_center_books` (`id`, `bookid`, `centerid`) VALUES
(1, 3, 1),
(2, 6, 1);

-- --------------------------------------------------------

--
-- Estructura de la taula `mps_config`
--

CREATE TABLE IF NOT EXISTS `mps_config` (
  `id` bigint(10) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `value` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=15 ;

--
-- Bolcant dades de la taula `mps_config`
--

INSERT INTO `mps_config` (`id`, `name`, `value`) VALUES
(1, 'theme', 'mpstheme'),
(2, 'style', 'default'),
(3, 'template', 'default'),
(4, 'timezone', '99'),
(5, 'country', 'ES'),
(6, 'lang', 'ca_utf8'),
(7, 'langlist', 'ca'),
(8, 'sitename', 'MPS - Marsupial Simulador d''Editorial'),
(9, 'session_error_counter', '8'),
(10, 'debugmode', '0'),
(11, 'limitviewentries', '100'),
(12, 'sessiontimeout', '7200'),
(13, 'sessioncookie', 'mps'),
(14, 'sessioncookiepath', '/');

-- --------------------------------------------------------

--
-- Estructura de la taula `mps_lms_ws_credentials`
--

CREATE TABLE IF NOT EXISTS `mps_lms_ws_credentials` (
  `id` bigint(10) NOT NULL AUTO_INCREMENT,
  `username` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `success` bigint(1) NOT NULL,
  `code` varchar(100) NOT NULL,
  `description` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=3 ;

--
-- Bolcant dades de la taula `mps_lms_ws_credentials`
--

INSERT INTO `mps_lms_ws_credentials` (`id`, `username`, `password`, `success`, `code`, `description`) VALUES
(1, 'S1mul4d0r', 'ed1t0r14l', 1, '1', 'Usuari/contrasenya amb drets'),
(2, 'USP', 'PUSP', 0, '-102', 'Usuari/contrasenya sense permisos suficients');

-- --------------------------------------------------------

--
-- Estructura de la taula `mps_log`
--

CREATE TABLE IF NOT EXISTS `mps_log` (
  `id` bigint(10) NOT NULL AUTO_INCREMENT,
  `time` bigint(10) NOT NULL,
  `ip` varchar(15) NOT NULL,
  `categoryid` text NOT NULL,
  `actionid` varchar(255) NOT NULL,
  `info` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=246 ;

--
-- Bolcant dades de la taula `mps_log`
--

INSERT INTO `mps_log` (`id`, `time`, `ip`, `categoryid`, `actionid`, `info`) VALUES
(1, 1356023786, '127.0.0.1', '2', '1', ''),
(2, 1356023786, '127.0.0.1', '2', '12', 'O:8:"stdClass":1:{s:8:"idcentro";s:8:"08000003";}'),
(3, 1356023786, '127.0.0.1', '2', '11', 'O:8:"stdClass":2:{s:4:"user";s:9:"S1mul4d0r";s:3:"pwd";s:9:"ed1t0r14l";}'),
(4, 1356023786, '127.0.0.1', '2', '21', 'O:8:"stdClass":2:{s:6:"Codigo";s:1:"1";s:11:"Descripcion";s:28:"Usuari/contrasenya amb drets";}'),
(5, 1356023786, '127.0.0.1', '2', '22', 'O:8:"stdClass":3:{s:6:"Codigo";s:1:"1";s:11:"Descripcion";s:16:"procés correcte";s:8:"Catalogo";O:8:"Catalogo":1:{s:6:"libros";a:7:{i:0;O:5:"libro":5:{s:4:"ISBN";s:10:"1111111111";s:6:"titulo";s:31:"Llibre scorm remot sense unitat";s:5:"nivel";s:4:"1ESO";s:7:"formato";s:5:"scorm";s:8:"unidades";N;}i:1;O:5:"libro":5:{s:4:"ISBN";s:10:"2222222222";s:6:"titulo";s:35:"Llibre contingut remot sense unitat";s:5:"nivel";s:4:"1ESO";s:7:"formato";s:10:"webcontent";s:8:"unidades";N;}i:2;O:5:"libro":5:{s:4:"ISBN";s:10:"3333333333";s:6:"titulo";s:35:"Llibre scorm remot amb dues unitats";s:5:"nivel";s:4:"1ESO";s:7:"formato";s:5:"scorm";s:8:"unidades";N;}i:3;O:5:"libro":5:{s:4:"ISBN";s:10:"4444444444";s:6:"titulo";s:39:"Llibre contingut remot amb dues unitats";s:5:"nivel";s:4:"1ESO";s:7:"formato";s:10:"webcontent";s:8:"unidades";N;}i:4;O:5:"libro":5:{s:4:"ISBN";s:10:"5555555555";s:6:"titulo";s:38:"Llibre scorm remot amb dues activitats";s:5:"nivel";s:4:"2ESO";s:7:"formato";s:5:"scorm";s:8:"unidades";N;}i:5;O:5:"libro":5:{s:4:"ISBN";s:10:"6666666666";s:6:"titulo";s:42:"Llibre contingut remot amb dues activitats";s:5:"nivel";s:4:"2ESO";s:7:"formato";s:10:"webcontent";s:8:"unidades";N;}i:6;O:5:"libro":5:{s:4:"ISBN";s:10:"7777777777";s:6:"titulo";s:33:"Llibre contingut remot jeràrquic";s:5:"nivel";s:4:"1ESO";s:7:"formato";s:10:"webcontent";s:8:"unidades";N;}}}}'),
(6, 1356023786, '127.0.0.1', '2', '100', ''),
(7, 1356023786, '127.0.0.1', '2', '1', ''),
(8, 1356023786, '127.0.0.1', '2', '10', 'O:8:"stdClass":1:{s:4:"ISBN";s:10:"1111111111";}'),
(9, 1356023786, '127.0.0.1', '2', '11', 'O:8:"stdClass":2:{s:4:"user";s:9:"S1mul4d0r";s:3:"pwd";s:9:"ed1t0r14l";}'),
(10, 1356023786, '127.0.0.1', '2', '21', 'O:8:"stdClass":2:{s:6:"Codigo";s:1:"1";s:11:"Descripcion";s:28:"Usuari/contrasenya amb drets";}'),
(11, 1356023786, '127.0.0.1', '2', '20', 'O:8:"stdClass":3:{s:6:"Codigo";s:1:"1";s:11:"Descripcion";s:16:"procés correcte";s:6:"Libros";O:8:"stdClass":1:{s:5:"libro";O:5:"libro":5:{s:4:"ISBN";s:10:"1111111111";s:6:"titulo";s:31:"Llibre scorm remot sense unitat";s:5:"nivel";s:4:"1ESO";s:7:"formato";s:5:"scorm";s:8:"unidades";N;}}}'),
(12, 1356023786, '127.0.0.1', '2', '100', ''),
(13, 1356023786, '127.0.0.1', '2', '1', ''),
(14, 1356023786, '127.0.0.1', '2', '10', 'O:8:"stdClass":1:{s:4:"ISBN";s:10:"2222222222";}'),
(15, 1356023786, '127.0.0.1', '2', '11', 'O:8:"stdClass":2:{s:4:"user";s:9:"S1mul4d0r";s:3:"pwd";s:9:"ed1t0r14l";}'),
(16, 1356023786, '127.0.0.1', '2', '21', 'O:8:"stdClass":2:{s:6:"Codigo";s:1:"1";s:11:"Descripcion";s:28:"Usuari/contrasenya amb drets";}'),
(17, 1356023786, '127.0.0.1', '2', '20', 'O:8:"stdClass":3:{s:6:"Codigo";s:1:"1";s:11:"Descripcion";s:16:"procés correcte";s:6:"Libros";O:8:"stdClass":1:{s:5:"libro";O:5:"libro":5:{s:4:"ISBN";s:10:"2222222222";s:6:"titulo";s:35:"Llibre contingut remot sense unitat";s:5:"nivel";s:4:"1ESO";s:7:"formato";s:10:"webcontent";s:8:"unidades";N;}}}'),
(18, 1356023786, '127.0.0.1', '2', '100', ''),
(19, 1356023787, '127.0.0.1', '2', '1', ''),
(20, 1356023787, '127.0.0.1', '2', '10', 'O:8:"stdClass":1:{s:4:"ISBN";s:10:"3333333333";}'),
(21, 1356023787, '127.0.0.1', '2', '11', 'O:8:"stdClass":2:{s:4:"user";s:9:"S1mul4d0r";s:3:"pwd";s:9:"ed1t0r14l";}'),
(22, 1356023787, '127.0.0.1', '2', '21', 'O:8:"stdClass":2:{s:6:"Codigo";s:1:"1";s:11:"Descripcion";s:28:"Usuari/contrasenya amb drets";}'),
(23, 1356023787, '127.0.0.1', '2', '20', 'O:8:"stdClass":3:{s:6:"Codigo";s:1:"1";s:11:"Descripcion";s:16:"procés correcte";s:6:"Libros";O:8:"stdClass":1:{s:5:"libro";O:5:"libro":5:{s:4:"ISBN";s:10:"3333333333";s:6:"titulo";s:35:"Llibre scorm remot amb dues unitats";s:5:"nivel";s:4:"1ESO";s:7:"formato";s:5:"scorm";s:8:"unidades";a:2:{i:0;O:6:"unidad":4:{s:2:"id";s:1:"1";s:6:"titulo";s:8:"Unitat 1";s:5:"orden";s:1:"1";s:11:"actividades";N;}i:1;O:6:"unidad":4:{s:2:"id";s:1:"2";s:6:"titulo";s:8:"Unitat 2";s:5:"orden";s:1:"2";s:11:"actividades";N;}}}}}'),
(24, 1356023787, '127.0.0.1', '2', '100', ''),
(25, 1356023787, '127.0.0.1', '2', '1', ''),
(26, 1356023787, '127.0.0.1', '2', '10', 'O:8:"stdClass":1:{s:4:"ISBN";s:10:"4444444444";}'),
(27, 1356023787, '127.0.0.1', '2', '11', 'O:8:"stdClass":2:{s:4:"user";s:9:"S1mul4d0r";s:3:"pwd";s:9:"ed1t0r14l";}'),
(28, 1356023787, '127.0.0.1', '2', '21', 'O:8:"stdClass":2:{s:6:"Codigo";s:1:"1";s:11:"Descripcion";s:28:"Usuari/contrasenya amb drets";}'),
(29, 1356023787, '127.0.0.1', '2', '20', 'O:8:"stdClass":3:{s:6:"Codigo";s:1:"1";s:11:"Descripcion";s:16:"procés correcte";s:6:"Libros";O:8:"stdClass":1:{s:5:"libro";O:5:"libro":5:{s:4:"ISBN";s:10:"4444444444";s:6:"titulo";s:39:"Llibre contingut remot amb dues unitats";s:5:"nivel";s:4:"1ESO";s:7:"formato";s:10:"webcontent";s:8:"unidades";a:2:{i:0;O:6:"unidad":4:{s:2:"id";s:1:"1";s:6:"titulo";s:8:"Unitat 1";s:5:"orden";s:1:"1";s:11:"actividades";N;}i:1;O:6:"unidad":4:{s:2:"id";s:1:"2";s:6:"titulo";s:8:"Unitat 2";s:5:"orden";s:1:"2";s:11:"actividades";N;}}}}}'),
(30, 1356023787, '127.0.0.1', '2', '100', ''),
(31, 1356023787, '127.0.0.1', '2', '1', ''),
(32, 1356023787, '127.0.0.1', '2', '10', 'O:8:"stdClass":1:{s:4:"ISBN";s:10:"5555555555";}'),
(33, 1356023787, '127.0.0.1', '2', '11', 'O:8:"stdClass":2:{s:4:"user";s:9:"S1mul4d0r";s:3:"pwd";s:9:"ed1t0r14l";}'),
(34, 1356023787, '127.0.0.1', '2', '21', 'O:8:"stdClass":2:{s:6:"Codigo";s:1:"1";s:11:"Descripcion";s:28:"Usuari/contrasenya amb drets";}'),
(35, 1356023787, '127.0.0.1', '2', '20', 'O:8:"stdClass":3:{s:6:"Codigo";s:1:"1";s:11:"Descripcion";s:16:"procés correcte";s:6:"Libros";O:8:"stdClass":1:{s:5:"libro";O:5:"libro":5:{s:4:"ISBN";s:10:"5555555555";s:6:"titulo";s:38:"Llibre scorm remot amb dues activitats";s:5:"nivel";s:4:"2ESO";s:7:"formato";s:5:"scorm";s:8:"unidades";a:2:{i:0;O:6:"unidad":4:{s:2:"id";s:1:"1";s:6:"titulo";s:8:"Unitat 1";s:5:"orden";s:1:"1";s:11:"actividades";a:2:{i:0;O:9:"actividad":3:{s:2:"id";s:1:"1";s:6:"titulo";s:11:"Activitat 1";s:5:"orden";s:1:"1";}i:1;O:9:"actividad":3:{s:2:"id";s:1:"2";s:6:"titulo";s:11:"Activitat 2";s:5:"orden";s:1:"2";}}}i:1;O:6:"unidad":4:{s:2:"id";s:1:"2";s:6:"titulo";s:8:"Unitat 2";s:5:"orden";s:1:"2";s:11:"actividades";a:2:{i:0;O:9:"actividad":3:{s:2:"id";s:1:"1";s:6:"titulo";s:11:"Activitat 1";s:5:"orden";s:1:"1";}i:1;O:9:"actividad":3:{s:2:"id";s:1:"2";s:6:"titulo";s:11:"Activitat 2";s:5:"orden";s:1:"2";}}}}}}}'),
(36, 1356023787, '127.0.0.1', '2', '100', ''),
(37, 1356023787, '127.0.0.1', '2', '1', ''),
(38, 1356023787, '127.0.0.1', '2', '10', 'O:8:"stdClass":1:{s:4:"ISBN";s:10:"6666666666";}'),
(39, 1356023787, '127.0.0.1', '2', '11', 'O:8:"stdClass":2:{s:4:"user";s:9:"S1mul4d0r";s:3:"pwd";s:9:"ed1t0r14l";}'),
(40, 1356023787, '127.0.0.1', '2', '21', 'O:8:"stdClass":2:{s:6:"Codigo";s:1:"1";s:11:"Descripcion";s:28:"Usuari/contrasenya amb drets";}'),
(41, 1356023787, '127.0.0.1', '2', '20', 'O:8:"stdClass":3:{s:6:"Codigo";s:1:"1";s:11:"Descripcion";s:16:"procés correcte";s:6:"Libros";O:8:"stdClass":1:{s:5:"libro";O:5:"libro":5:{s:4:"ISBN";s:10:"6666666666";s:6:"titulo";s:42:"Llibre contingut remot amb dues activitats";s:5:"nivel";s:4:"2ESO";s:7:"formato";s:10:"webcontent";s:8:"unidades";a:2:{i:0;O:6:"unidad":4:{s:2:"id";s:1:"1";s:6:"titulo";s:8:"Unitat 1";s:5:"orden";s:1:"1";s:11:"actividades";a:2:{i:0;O:9:"actividad":3:{s:2:"id";s:1:"1";s:6:"titulo";s:11:"Activitat 1";s:5:"orden";s:1:"1";}i:1;O:9:"actividad":3:{s:2:"id";s:1:"2";s:6:"titulo";s:11:"Activitat 2";s:5:"orden";s:1:"2";}}}i:1;O:6:"unidad":4:{s:2:"id";s:1:"2";s:6:"titulo";s:8:"Unitat 2";s:5:"orden";s:1:"2";s:11:"actividades";a:2:{i:0;O:9:"actividad":3:{s:2:"id";s:1:"1";s:6:"titulo";s:11:"Activitat 1";s:5:"orden";s:1:"1";}i:1;O:9:"actividad":3:{s:2:"id";s:1:"2";s:6:"titulo";s:11:"Activitat 2";s:5:"orden";s:1:"2";}}}}}}}'),
(42, 1356023787, '127.0.0.1', '2', '100', ''),
(43, 1356023788, '127.0.0.1', '2', '1', ''),
(44, 1356023788, '127.0.0.1', '2', '10', 'O:8:"stdClass":1:{s:4:"ISBN";s:10:"7777777777";}'),
(45, 1356023788, '127.0.0.1', '2', '11', 'O:8:"stdClass":2:{s:4:"user";s:9:"S1mul4d0r";s:3:"pwd";s:9:"ed1t0r14l";}'),
(46, 1356023788, '127.0.0.1', '2', '21', 'O:8:"stdClass":2:{s:6:"Codigo";s:1:"1";s:11:"Descripcion";s:28:"Usuari/contrasenya amb drets";}'),
(47, 1356023788, '127.0.0.1', '2', '20', 'O:8:"stdClass":3:{s:6:"Codigo";s:1:"1";s:11:"Descripcion";s:16:"procés correcte";s:6:"Libros";O:8:"stdClass":1:{s:5:"libro";O:5:"libro":5:{s:4:"ISBN";s:10:"7777777777";s:6:"titulo";s:33:"Llibre contingut remot jeràrquic";s:5:"nivel";s:4:"1ESO";s:7:"formato";s:10:"webcontent";s:8:"unidades";a:2:{i:0;O:6:"unidad":4:{s:2:"id";s:1:"1";s:6:"titulo";s:23:"Unitat 1 (Autoavaluada)";s:5:"orden";s:1:"1";s:11:"actividades";a:3:{i:0;O:9:"actividad":3:{s:2:"id";s:1:"1";s:6:"titulo";s:11:"Activitat 1";s:5:"orden";s:1:"1";}i:1;O:9:"actividad":3:{s:2:"id";s:1:"2";s:6:"titulo";s:11:"Activitat 2";s:5:"orden";s:1:"2";}i:2;O:9:"actividad":3:{s:2:"id";s:1:"3";s:6:"titulo";s:11:"Activitat 3";s:5:"orden";s:1:"3";}}}i:1;O:6:"unidad":4:{s:2:"id";s:1:"2";s:6:"titulo";s:33:"Unitat 2 (Avaluada per professor)";s:5:"orden";s:1:"2";s:11:"actividades";a:2:{i:0;O:9:"actividad":3:{s:2:"id";s:1:"1";s:6:"titulo";s:11:"Activitat 1";s:5:"orden";s:1:"1";}i:1;O:9:"actividad":3:{s:2:"id";s:1:"2";s:6:"titulo";s:11:"Activitat 2";s:5:"orden";s:1:"2";}}}}}}}'),
(48, 1356023788, '127.0.0.1', '2', '100', ''),
(49, 1356024062, '127.0.0.1', '1', '1', ''),
(50, 1356024062, '127.0.0.1', '1', '10', 'O:8:"stdClass":9:{s:10:"Credencial";s:1:"1";s:4:"ISBN";s:10:"4444444444";s:9:"IdUsuario";s:1:"2";s:7:"IdCurso";s:2:"21";s:8:"IdCentro";s:8:"08000003";s:12:"URLResultado";s:109:"http://agora-virtual.educat1x1.cat/agora/usu3/moodle/mod/rcontent/WebServices/WsSeguimiento/wsSeguimiento.php";s:14:"IdContenidoLMS";s:1:"1";s:8:"IdUnidad";s:1:"1";s:11:"IdActividad";s:0:"";}'),
(51, 1356024062, '127.0.0.1', '1', '11', 'O:8:"stdClass":2:{s:4:"user";s:9:"S1mul4d0r";s:3:"pwd";s:9:"ed1t0r14l";}'),
(52, 1356024062, '127.0.0.1', '1', '21', 'O:8:"stdClass":2:{s:6:"Codigo";s:1:"1";s:11:"Descripcion";s:28:"Usuari/contrasenya amb drets";}'),
(53, 1356024062, '127.0.0.1', '1', '20', 'O:8:"stdClass":3:{s:6:"Codigo";s:1:"1";s:11:"Descripcion";s:25:"URL generada correctament";s:3:"URL";s:83:"http://agora/mps/data/books/4444444444/33333/index.php?token=50d348feaac68990366189";}'),
(54, 1356024062, '127.0.0.1', '1', '100', ''),
(55, 1356024063, '127.0.0.1', '1', '1', ''),
(56, 1356024063, '127.0.0.1', '1', '10', 'O:8:"stdClass":9:{s:10:"Credencial";s:1:"1";s:4:"ISBN";s:10:"4444444444";s:9:"IdUsuario";s:1:"2";s:7:"IdCurso";s:2:"21";s:8:"IdCentro";s:8:"08000003";s:12:"URLResultado";s:109:"http://agora-virtual.educat1x1.cat/agora/usu3/moodle/mod/rcontent/WebServices/WsSeguimiento/wsSeguimiento.php";s:14:"IdContenidoLMS";s:1:"1";s:8:"IdUnidad";s:1:"1";s:11:"IdActividad";s:0:"";}'),
(57, 1356024063, '127.0.0.1', '1', '11', 'O:8:"stdClass":2:{s:4:"user";s:9:"S1mul4d0r";s:3:"pwd";s:9:"ed1t0r14l";}'),
(58, 1356024063, '127.0.0.1', '1', '21', 'O:8:"stdClass":2:{s:6:"Codigo";s:1:"1";s:11:"Descripcion";s:28:"Usuari/contrasenya amb drets";}'),
(59, 1356024063, '127.0.0.1', '1', '20', 'O:8:"stdClass":3:{s:6:"Codigo";s:1:"1";s:11:"Descripcion";s:25:"URL generada correctament";s:3:"URL";s:83:"http://agora/mps/data/books/4444444444/33333/index.php?token=50d348ff16493859980114";}'),
(60, 1356024063, '127.0.0.1', '1', '100', ''),
(61, 1356024079, '192.168.56.1', '3', '1', ''),
(62, 1356024079, '192.168.56.1', '3', '10', 'O:8:"stdClass":10:{s:5:"token";s:22:"50d348feaac68990366189";s:7:"grade_1";i:100;s:7:"grade_2";i:100;s:7:"grade_3";i:100;s:7:"grade_4";i:0;s:7:"key0b20";i:1;s:7:"key1b20";i:1;s:7:"key2b20";i:1;s:7:"key3b20";i:0;s:10:"totalgrade";i:75;}'),
(63, 1356024079, '192.168.56.1', '3', '11', 'O:8:"stdClass":6:{s:2:"id";s:1:"1";s:8:"username";s:9:"S1mul4d0r";s:8:"password";s:9:"ed1t0r14l";s:7:"success";s:1:"1";s:4:"code";s:1:"1";s:11:"description";s:28:"Usuari/contrasenya amb drets";}'),
(64, 1356024079, '192.168.56.1', '3', '12', 'O:8:"stdClass":16:{s:11:"idActividad";s:0:"";s:14:"ActividadOrden";s:0:"";s:15:"ActividadTitulo";s:0:"";s:8:"idUnidad";s:1:"1";s:11:"UnidadOrden";s:0:"";s:12:"UnidadTitulo";s:0:"";s:8:"idCentro";s:7:"8000003";s:14:"idContenidoLMS";s:1:"1";s:9:"idUsuario";s:1:"2";s:9:"SumaPesos";s:1:"4";s:8:"Duracion";s:2:"17";s:15:"FechaHoraInicio";s:10:"1356024062";s:11:"MaxDuracion";s:5:"86400";s:13:"Observaciones";s:0:"";s:12:"Calificacion";s:2:"75";s:16:"URLVerResultados";s:103:"http://agora/mps/data/books/4444444444/33333/index.php?token=50d348feaac68990366189&q0=1&q1=1&q2=1&q3=0";}'),
(65, 1356024079, '192.168.56.1', '3', '13', 'i:4;'),
(66, 1356024172, '127.0.0.1', '1', '1', ''),
(67, 1356024172, '127.0.0.1', '1', '10', 'O:8:"stdClass":9:{s:10:"Credencial";s:1:"1";s:4:"ISBN";s:10:"4444444444";s:9:"IdUsuario";s:1:"2";s:7:"IdCurso";s:2:"21";s:8:"IdCentro";s:8:"08000003";s:12:"URLResultado";s:109:"http://agora-virtual.educat1x1.cat/agora/usu3/moodle/mod/rcontent/WebServices/WsSeguimiento/wsSeguimiento.php";s:14:"IdContenidoLMS";s:1:"1";s:8:"IdUnidad";s:1:"1";s:11:"IdActividad";s:0:"";}'),
(68, 1356024172, '127.0.0.1', '1', '11', 'O:8:"stdClass":2:{s:4:"user";s:9:"S1mul4d0r";s:3:"pwd";s:9:"ed1t0r14l";}'),
(69, 1356024172, '127.0.0.1', '1', '21', 'O:8:"stdClass":2:{s:6:"Codigo";s:1:"1";s:11:"Descripcion";s:28:"Usuari/contrasenya amb drets";}'),
(70, 1356024172, '127.0.0.1', '1', '20', 'O:8:"stdClass":3:{s:6:"Codigo";s:1:"1";s:11:"Descripcion";s:25:"URL generada correctament";s:3:"URL";s:83:"http://agora/mps/data/books/4444444444/33333/index.php?token=50d3496c9af80642084357";}'),
(71, 1356024172, '127.0.0.1', '1', '100', ''),
(72, 1356024172, '127.0.0.1', '1', '1', ''),
(73, 1356024172, '127.0.0.1', '1', '10', 'O:8:"stdClass":9:{s:10:"Credencial";s:1:"1";s:4:"ISBN";s:10:"4444444444";s:9:"IdUsuario";s:1:"2";s:7:"IdCurso";s:2:"21";s:8:"IdCentro";s:8:"08000003";s:12:"URLResultado";s:109:"http://agora-virtual.educat1x1.cat/agora/usu3/moodle/mod/rcontent/WebServices/WsSeguimiento/wsSeguimiento.php";s:14:"IdContenidoLMS";s:1:"1";s:8:"IdUnidad";s:1:"1";s:11:"IdActividad";s:0:"";}'),
(74, 1356024172, '127.0.0.1', '1', '11', 'O:8:"stdClass":2:{s:4:"user";s:9:"S1mul4d0r";s:3:"pwd";s:9:"ed1t0r14l";}'),
(75, 1356024172, '127.0.0.1', '1', '21', 'O:8:"stdClass":2:{s:6:"Codigo";s:1:"1";s:11:"Descripcion";s:28:"Usuari/contrasenya amb drets";}'),
(76, 1356024172, '127.0.0.1', '1', '20', 'O:8:"stdClass":3:{s:6:"Codigo";s:1:"1";s:11:"Descripcion";s:25:"URL generada correctament";s:3:"URL";s:83:"http://agora/mps/data/books/4444444444/33333/index.php?token=50d3496cf20ce917953415";}'),
(77, 1356024172, '127.0.0.1', '1', '100', ''),
(78, 1356024181, '192.168.56.1', '3', '1', ''),
(79, 1356024181, '192.168.56.1', '3', '10', 'O:8:"stdClass":10:{s:5:"token";s:22:"50d3496c9af80642084357";s:7:"grade_1";i:100;s:7:"grade_2";i:100;s:7:"grade_3";i:100;s:7:"grade_4";i:0;s:7:"key0b20";i:1;s:7:"key1b20";i:1;s:7:"key2b20";i:1;s:7:"key3b20";i:0;s:10:"totalgrade";i:75;}'),
(80, 1356024181, '192.168.56.1', '3', '11', 'O:8:"stdClass":6:{s:2:"id";s:1:"1";s:8:"username";s:9:"S1mul4d0r";s:8:"password";s:9:"ed1t0r14l";s:7:"success";s:1:"1";s:4:"code";s:1:"1";s:11:"description";s:28:"Usuari/contrasenya amb drets";}'),
(81, 1356024181, '192.168.56.1', '3', '12', 'O:8:"stdClass":16:{s:11:"idActividad";s:0:"";s:14:"ActividadOrden";s:0:"";s:15:"ActividadTitulo";s:0:"";s:8:"idUnidad";s:1:"1";s:11:"UnidadOrden";s:0:"";s:12:"UnidadTitulo";s:0:"";s:8:"idCentro";s:7:"8000003";s:14:"idContenidoLMS";s:1:"1";s:9:"idUsuario";s:1:"2";s:9:"SumaPesos";s:1:"4";s:8:"Duracion";s:1:"9";s:15:"FechaHoraInicio";s:10:"1356024172";s:11:"MaxDuracion";s:5:"86400";s:13:"Observaciones";s:0:"";s:12:"Calificacion";s:2:"75";s:16:"URLVerResultados";s:103:"http://agora/mps/data/books/4444444444/33333/index.php?token=50d3496c9af80642084357&q0=1&q1=1&q2=1&q3=0";}'),
(82, 1356024181, '192.168.56.1', '3', '13', 'i:4;'),
(83, 1356024181, '192.168.56.1', '3', '14', ''),
(84, 1360076740, '127.0.0.1', '2', '1', ''),
(85, 1360076740, '127.0.0.1', '2', '12', 'O:8:"stdClass":1:{s:8:"idcentro";s:8:"08000003";}'),
(86, 1360076740, '127.0.0.1', '2', '11', 'O:8:"stdClass":2:{s:4:"user";s:9:"S1mul4d0r";s:3:"pwd";s:9:"ed1t0r14l";}'),
(87, 1360076740, '127.0.0.1', '2', '21', 'O:8:"stdClass":2:{s:6:"Codigo";s:1:"1";s:11:"Descripcion";s:28:"Usuari/contrasenya amb drets";}'),
(88, 1360076740, '127.0.0.1', '2', '22', 'O:8:"stdClass":3:{s:6:"Codigo";s:1:"1";s:11:"Descripcion";s:16:"procés correcte";s:8:"Catalogo";O:8:"Catalogo":1:{s:6:"libros";a:7:{i:0;O:5:"libro":5:{s:4:"ISBN";s:10:"1111111111";s:6:"titulo";s:31:"Llibre scorm remot sense unitat";s:5:"nivel";s:4:"1ESO";s:7:"formato";s:5:"scorm";s:8:"unidades";N;}i:1;O:5:"libro":5:{s:4:"ISBN";s:10:"2222222222";s:6:"titulo";s:35:"Llibre contingut remot sense unitat";s:5:"nivel";s:4:"1ESO";s:7:"formato";s:10:"webcontent";s:8:"unidades";N;}i:2;O:5:"libro":5:{s:4:"ISBN";s:10:"3333333333";s:6:"titulo";s:35:"Llibre scorm remot amb dues unitats";s:5:"nivel";s:4:"1ESO";s:7:"formato";s:5:"scorm";s:8:"unidades";N;}i:3;O:5:"libro":5:{s:4:"ISBN";s:10:"4444444444";s:6:"titulo";s:39:"Llibre contingut remot amb dues unitats";s:5:"nivel";s:4:"1ESO";s:7:"formato";s:10:"webcontent";s:8:"unidades";N;}i:4;O:5:"libro":5:{s:4:"ISBN";s:10:"5555555555";s:6:"titulo";s:38:"Llibre scorm remot amb dues activitats";s:5:"nivel";s:4:"2ESO";s:7:"formato";s:5:"scorm";s:8:"unidades";N;}i:5;O:5:"libro":5:{s:4:"ISBN";s:10:"6666666666";s:6:"titulo";s:42:"Llibre contingut remot amb dues activitats";s:5:"nivel";s:4:"2ESO";s:7:"formato";s:10:"webcontent";s:8:"unidades";N;}i:6;O:5:"libro":5:{s:4:"ISBN";s:10:"7777777777";s:6:"titulo";s:33:"Llibre contingut remot jeràrquic";s:5:"nivel";s:4:"1ESO";s:7:"formato";s:10:"webcontent";s:8:"unidades";N;}}}}'),
(89, 1360076741, '127.0.0.1', '2', '100', ''),
(90, 1360151726, '127.0.0.1', '2', '1', ''),
(91, 1360151727, '127.0.0.1', '2', '12', 'O:8:"stdClass":1:{s:8:"idcentro";s:0:"";}'),
(92, 1360151727, '127.0.0.1', '2', '11', 'O:8:"stdClass":2:{s:4:"user";s:9:"S1mul4d0r";s:3:"pwd";s:9:"ed1t0r14l";}'),
(93, 1360151727, '127.0.0.1', '2', '21', 'O:8:"stdClass":2:{s:6:"Codigo";s:1:"1";s:11:"Descripcion";s:28:"Usuari/contrasenya amb drets";}'),
(94, 1360151727, '127.0.0.1', '2', '22', 'O:8:"stdClass":3:{s:6:"Codigo";s:1:"1";s:11:"Descripcion";s:16:"procés correcte";s:8:"Catalogo";O:8:"Catalogo":1:{s:6:"libros";a:7:{i:0;O:5:"libro":5:{s:4:"ISBN";s:10:"1111111111";s:6:"titulo";s:31:"Llibre scorm remot sense unitat";s:5:"nivel";s:4:"1ESO";s:7:"formato";s:5:"scorm";s:8:"unidades";N;}i:1;O:5:"libro":5:{s:4:"ISBN";s:10:"2222222222";s:6:"titulo";s:35:"Llibre contingut remot sense unitat";s:5:"nivel";s:4:"1ESO";s:7:"formato";s:10:"webcontent";s:8:"unidades";N;}i:2;O:5:"libro":5:{s:4:"ISBN";s:10:"3333333333";s:6:"titulo";s:35:"Llibre scorm remot amb dues unitats";s:5:"nivel";s:4:"1ESO";s:7:"formato";s:5:"scorm";s:8:"unidades";N;}i:3;O:5:"libro":5:{s:4:"ISBN";s:10:"4444444444";s:6:"titulo";s:39:"Llibre contingut remot amb dues unitats";s:5:"nivel";s:4:"1ESO";s:7:"formato";s:10:"webcontent";s:8:"unidades";N;}i:4;O:5:"libro":5:{s:4:"ISBN";s:10:"5555555555";s:6:"titulo";s:38:"Llibre scorm remot amb dues activitats";s:5:"nivel";s:4:"2ESO";s:7:"formato";s:5:"scorm";s:8:"unidades";N;}i:5;O:5:"libro":5:{s:4:"ISBN";s:10:"6666666666";s:6:"titulo";s:42:"Llibre contingut remot amb dues activitats";s:5:"nivel";s:4:"2ESO";s:7:"formato";s:10:"webcontent";s:8:"unidades";N;}i:6;O:5:"libro":5:{s:4:"ISBN";s:10:"7777777777";s:6:"titulo";s:33:"Llibre contingut remot jeràrquic";s:5:"nivel";s:4:"1ESO";s:7:"formato";s:10:"webcontent";s:8:"unidades";N;}}}}'),
(95, 1360151727, '127.0.0.1', '2', '100', ''),
(96, 1360152055, '127.0.0.1', '2', '1', ''),
(97, 1360152055, '127.0.0.1', '2', '12', 'O:8:"stdClass":1:{s:8:"idcentro";s:1:"0";}'),
(98, 1360152055, '127.0.0.1', '2', '11', 'O:8:"stdClass":2:{s:4:"user";s:9:"S1mul4d0r";s:3:"pwd";s:9:"ed1t0r14l";}'),
(99, 1360152055, '127.0.0.1', '2', '21', 'O:8:"stdClass":2:{s:6:"Codigo";s:1:"1";s:11:"Descripcion";s:28:"Usuari/contrasenya amb drets";}'),
(100, 1360152055, '127.0.0.1', '2', '22', 'O:8:"stdClass":3:{s:6:"Codigo";s:1:"1";s:11:"Descripcion";s:16:"procés correcte";s:8:"Catalogo";O:8:"Catalogo":1:{s:6:"libros";a:7:{i:0;O:5:"libro":5:{s:4:"ISBN";s:10:"1111111111";s:6:"titulo";s:31:"Llibre scorm remot sense unitat";s:5:"nivel";s:4:"1ESO";s:7:"formato";s:5:"scorm";s:8:"unidades";N;}i:1;O:5:"libro":5:{s:4:"ISBN";s:10:"2222222222";s:6:"titulo";s:35:"Llibre contingut remot sense unitat";s:5:"nivel";s:4:"1ESO";s:7:"formato";s:10:"webcontent";s:8:"unidades";N;}i:2;O:5:"libro":5:{s:4:"ISBN";s:10:"3333333333";s:6:"titulo";s:35:"Llibre scorm remot amb dues unitats";s:5:"nivel";s:4:"1ESO";s:7:"formato";s:5:"scorm";s:8:"unidades";N;}i:3;O:5:"libro":5:{s:4:"ISBN";s:10:"4444444444";s:6:"titulo";s:39:"Llibre contingut remot amb dues unitats";s:5:"nivel";s:4:"1ESO";s:7:"formato";s:10:"webcontent";s:8:"unidades";N;}i:4;O:5:"libro":5:{s:4:"ISBN";s:10:"5555555555";s:6:"titulo";s:38:"Llibre scorm remot amb dues activitats";s:5:"nivel";s:4:"2ESO";s:7:"formato";s:5:"scorm";s:8:"unidades";N;}i:5;O:5:"libro":5:{s:4:"ISBN";s:10:"6666666666";s:6:"titulo";s:42:"Llibre contingut remot amb dues activitats";s:5:"nivel";s:4:"2ESO";s:7:"formato";s:10:"webcontent";s:8:"unidades";N;}i:6;O:5:"libro":5:{s:4:"ISBN";s:10:"7777777777";s:6:"titulo";s:33:"Llibre contingut remot jeràrquic";s:5:"nivel";s:4:"1ESO";s:7:"formato";s:10:"webcontent";s:8:"unidades";N;}}}}'),
(101, 1360152055, '127.0.0.1', '2', '100', ''),
(102, 1360152055, '127.0.0.1', '2', '1', ''),
(103, 1360152056, '127.0.0.1', '2', '10', 'O:8:"stdClass":1:{s:4:"ISBN";s:10:"1111111111";}'),
(104, 1360152056, '127.0.0.1', '2', '11', 'O:8:"stdClass":2:{s:4:"user";s:9:"S1mul4d0r";s:3:"pwd";s:9:"ed1t0r14l";}'),
(105, 1360152056, '127.0.0.1', '2', '21', 'O:8:"stdClass":2:{s:6:"Codigo";s:1:"1";s:11:"Descripcion";s:28:"Usuari/contrasenya amb drets";}'),
(106, 1360152056, '127.0.0.1', '2', '20', 'O:8:"stdClass":3:{s:6:"Codigo";s:1:"1";s:11:"Descripcion";s:16:"procés correcte";s:6:"Libros";O:8:"stdClass":1:{s:5:"libro";O:5:"libro":5:{s:4:"ISBN";s:10:"1111111111";s:6:"titulo";s:31:"Llibre scorm remot sense unitat";s:5:"nivel";s:4:"1ESO";s:7:"formato";s:5:"scorm";s:8:"unidades";N;}}}'),
(107, 1360152056, '127.0.0.1', '2', '100', ''),
(108, 1360152057, '127.0.0.1', '2', '1', ''),
(109, 1360152057, '127.0.0.1', '2', '10', 'O:8:"stdClass":1:{s:4:"ISBN";s:10:"2222222222";}'),
(110, 1360152057, '127.0.0.1', '2', '11', 'O:8:"stdClass":2:{s:4:"user";s:9:"S1mul4d0r";s:3:"pwd";s:9:"ed1t0r14l";}'),
(111, 1360152057, '127.0.0.1', '2', '21', 'O:8:"stdClass":2:{s:6:"Codigo";s:1:"1";s:11:"Descripcion";s:28:"Usuari/contrasenya amb drets";}'),
(112, 1360152057, '127.0.0.1', '2', '20', 'O:8:"stdClass":3:{s:6:"Codigo";s:1:"1";s:11:"Descripcion";s:16:"procés correcte";s:6:"Libros";O:8:"stdClass":1:{s:5:"libro";O:5:"libro":5:{s:4:"ISBN";s:10:"2222222222";s:6:"titulo";s:35:"Llibre contingut remot sense unitat";s:5:"nivel";s:4:"1ESO";s:7:"formato";s:10:"webcontent";s:8:"unidades";N;}}}'),
(113, 1360152057, '127.0.0.1', '2', '100', ''),
(114, 1360152057, '127.0.0.1', '2', '1', ''),
(115, 1360152057, '127.0.0.1', '2', '10', 'O:8:"stdClass":1:{s:4:"ISBN";s:10:"3333333333";}'),
(116, 1360152057, '127.0.0.1', '2', '11', 'O:8:"stdClass":2:{s:4:"user";s:9:"S1mul4d0r";s:3:"pwd";s:9:"ed1t0r14l";}'),
(117, 1360152057, '127.0.0.1', '2', '21', 'O:8:"stdClass":2:{s:6:"Codigo";s:1:"1";s:11:"Descripcion";s:28:"Usuari/contrasenya amb drets";}'),
(118, 1360152057, '127.0.0.1', '2', '20', 'O:8:"stdClass":3:{s:6:"Codigo";s:1:"1";s:11:"Descripcion";s:16:"procés correcte";s:6:"Libros";O:8:"stdClass":1:{s:5:"libro";O:5:"libro":5:{s:4:"ISBN";s:10:"3333333333";s:6:"titulo";s:35:"Llibre scorm remot amb dues unitats";s:5:"nivel";s:4:"1ESO";s:7:"formato";s:5:"scorm";s:8:"unidades";a:2:{i:0;O:6:"unidad":4:{s:2:"id";s:1:"1";s:6:"titulo";s:8:"Unitat 1";s:5:"orden";s:1:"1";s:11:"actividades";N;}i:1;O:6:"unidad":4:{s:2:"id";s:1:"2";s:6:"titulo";s:8:"Unitat 2";s:5:"orden";s:1:"2";s:11:"actividades";N;}}}}}'),
(119, 1360152057, '127.0.0.1', '2', '100', ''),
(120, 1360152058, '127.0.0.1', '2', '1', ''),
(121, 1360152058, '127.0.0.1', '2', '10', 'O:8:"stdClass":1:{s:4:"ISBN";s:10:"4444444444";}'),
(122, 1360152058, '127.0.0.1', '2', '11', 'O:8:"stdClass":2:{s:4:"user";s:9:"S1mul4d0r";s:3:"pwd";s:9:"ed1t0r14l";}'),
(123, 1360152058, '127.0.0.1', '2', '21', 'O:8:"stdClass":2:{s:6:"Codigo";s:1:"1";s:11:"Descripcion";s:28:"Usuari/contrasenya amb drets";}'),
(124, 1360152058, '127.0.0.1', '2', '20', 'O:8:"stdClass":3:{s:6:"Codigo";s:1:"1";s:11:"Descripcion";s:16:"procés correcte";s:6:"Libros";O:8:"stdClass":1:{s:5:"libro";O:5:"libro":5:{s:4:"ISBN";s:10:"4444444444";s:6:"titulo";s:39:"Llibre contingut remot amb dues unitats";s:5:"nivel";s:4:"1ESO";s:7:"formato";s:10:"webcontent";s:8:"unidades";a:2:{i:0;O:6:"unidad":4:{s:2:"id";s:1:"1";s:6:"titulo";s:8:"Unitat 1";s:5:"orden";s:1:"1";s:11:"actividades";N;}i:1;O:6:"unidad":4:{s:2:"id";s:1:"2";s:6:"titulo";s:8:"Unitat 2";s:5:"orden";s:1:"2";s:11:"actividades";N;}}}}}'),
(125, 1360152058, '127.0.0.1', '2', '100', ''),
(126, 1360152059, '127.0.0.1', '2', '1', ''),
(127, 1360152059, '127.0.0.1', '2', '10', 'O:8:"stdClass":1:{s:4:"ISBN";s:10:"5555555555";}'),
(128, 1360152059, '127.0.0.1', '2', '11', 'O:8:"stdClass":2:{s:4:"user";s:9:"S1mul4d0r";s:3:"pwd";s:9:"ed1t0r14l";}'),
(129, 1360152059, '127.0.0.1', '2', '21', 'O:8:"stdClass":2:{s:6:"Codigo";s:1:"1";s:11:"Descripcion";s:28:"Usuari/contrasenya amb drets";}'),
(130, 1360152059, '127.0.0.1', '2', '20', 'O:8:"stdClass":3:{s:6:"Codigo";s:1:"1";s:11:"Descripcion";s:16:"procés correcte";s:6:"Libros";O:8:"stdClass":1:{s:5:"libro";O:5:"libro":5:{s:4:"ISBN";s:10:"5555555555";s:6:"titulo";s:38:"Llibre scorm remot amb dues activitats";s:5:"nivel";s:4:"2ESO";s:7:"formato";s:5:"scorm";s:8:"unidades";a:2:{i:0;O:6:"unidad":4:{s:2:"id";s:1:"1";s:6:"titulo";s:8:"Unitat 1";s:5:"orden";s:1:"1";s:11:"actividades";a:2:{i:0;O:9:"actividad":3:{s:2:"id";s:1:"1";s:6:"titulo";s:11:"Activitat 1";s:5:"orden";s:1:"1";}i:1;O:9:"actividad":3:{s:2:"id";s:1:"2";s:6:"titulo";s:11:"Activitat 2";s:5:"orden";s:1:"2";}}}i:1;O:6:"unidad":4:{s:2:"id";s:1:"2";s:6:"titulo";s:8:"Unitat 2";s:5:"orden";s:1:"2";s:11:"actividades";a:2:{i:0;O:9:"actividad":3:{s:2:"id";s:1:"1";s:6:"titulo";s:11:"Activitat 1";s:5:"orden";s:1:"1";}i:1;O:9:"actividad":3:{s:2:"id";s:1:"2";s:6:"titulo";s:11:"Activitat 2";s:5:"orden";s:1:"2";}}}}}}}'),
(131, 1360152059, '127.0.0.1', '2', '100', ''),
(132, 1360152059, '127.0.0.1', '2', '1', ''),
(133, 1360152059, '127.0.0.1', '2', '10', 'O:8:"stdClass":1:{s:4:"ISBN";s:10:"6666666666";}'),
(134, 1360152059, '127.0.0.1', '2', '11', 'O:8:"stdClass":2:{s:4:"user";s:9:"S1mul4d0r";s:3:"pwd";s:9:"ed1t0r14l";}'),
(135, 1360152059, '127.0.0.1', '2', '21', 'O:8:"stdClass":2:{s:6:"Codigo";s:1:"1";s:11:"Descripcion";s:28:"Usuari/contrasenya amb drets";}'),
(136, 1360152060, '127.0.0.1', '2', '20', 'O:8:"stdClass":3:{s:6:"Codigo";s:1:"1";s:11:"Descripcion";s:16:"procés correcte";s:6:"Libros";O:8:"stdClass":1:{s:5:"libro";O:5:"libro":5:{s:4:"ISBN";s:10:"6666666666";s:6:"titulo";s:42:"Llibre contingut remot amb dues activitats";s:5:"nivel";s:4:"2ESO";s:7:"formato";s:10:"webcontent";s:8:"unidades";a:2:{i:0;O:6:"unidad":4:{s:2:"id";s:1:"1";s:6:"titulo";s:8:"Unitat 1";s:5:"orden";s:1:"1";s:11:"actividades";a:2:{i:0;O:9:"actividad":3:{s:2:"id";s:1:"1";s:6:"titulo";s:11:"Activitat 1";s:5:"orden";s:1:"1";}i:1;O:9:"actividad":3:{s:2:"id";s:1:"2";s:6:"titulo";s:11:"Activitat 2";s:5:"orden";s:1:"2";}}}i:1;O:6:"unidad":4:{s:2:"id";s:1:"2";s:6:"titulo";s:8:"Unitat 2";s:5:"orden";s:1:"2";s:11:"actividades";a:2:{i:0;O:9:"actividad":3:{s:2:"id";s:1:"1";s:6:"titulo";s:11:"Activitat 1";s:5:"orden";s:1:"1";}i:1;O:9:"actividad":3:{s:2:"id";s:1:"2";s:6:"titulo";s:11:"Activitat 2";s:5:"orden";s:1:"2";}}}}}}}'),
(137, 1360152060, '127.0.0.1', '2', '100', ''),
(138, 1360152060, '127.0.0.1', '2', '1', ''),
(139, 1360152060, '127.0.0.1', '2', '10', 'O:8:"stdClass":1:{s:4:"ISBN";s:10:"7777777777";}'),
(140, 1360152060, '127.0.0.1', '2', '11', 'O:8:"stdClass":2:{s:4:"user";s:9:"S1mul4d0r";s:3:"pwd";s:9:"ed1t0r14l";}'),
(141, 1360152060, '127.0.0.1', '2', '21', 'O:8:"stdClass":2:{s:6:"Codigo";s:1:"1";s:11:"Descripcion";s:28:"Usuari/contrasenya amb drets";}'),
(142, 1360152060, '127.0.0.1', '2', '20', 'O:8:"stdClass":3:{s:6:"Codigo";s:1:"1";s:11:"Descripcion";s:16:"procés correcte";s:6:"Libros";O:8:"stdClass":1:{s:5:"libro";O:5:"libro":5:{s:4:"ISBN";s:10:"7777777777";s:6:"titulo";s:33:"Llibre contingut remot jeràrquic";s:5:"nivel";s:4:"1ESO";s:7:"formato";s:10:"webcontent";s:8:"unidades";a:2:{i:0;O:6:"unidad":4:{s:2:"id";s:1:"1";s:6:"titulo";s:23:"Unitat 1 (Autoavaluada)";s:5:"orden";s:1:"1";s:11:"actividades";a:3:{i:0;O:9:"actividad":3:{s:2:"id";s:1:"1";s:6:"titulo";s:11:"Activitat 1";s:5:"orden";s:1:"1";}i:1;O:9:"actividad":3:{s:2:"id";s:1:"2";s:6:"titulo";s:11:"Activitat 2";s:5:"orden";s:1:"2";}i:2;O:9:"actividad":3:{s:2:"id";s:1:"3";s:6:"titulo";s:11:"Activitat 3";s:5:"orden";s:1:"3";}}}i:1;O:6:"unidad":4:{s:2:"id";s:1:"2";s:6:"titulo";s:33:"Unitat 2 (Avaluada per professor)";s:5:"orden";s:1:"2";s:11:"actividades";a:2:{i:0;O:9:"actividad":3:{s:2:"id";s:1:"1";s:6:"titulo";s:11:"Activitat 1";s:5:"orden";s:1:"1";}i:1;O:9:"actividad":3:{s:2:"id";s:1:"2";s:6:"titulo";s:11:"Activitat 2";s:5:"orden";s:1:"2";}}}}}}}'),
(143, 1360152060, '127.0.0.1', '2', '100', ''),
(144, 1360152682, '127.0.0.1', '2', '1', ''),
(145, 1360152682, '127.0.0.1', '2', '12', 'O:8:"stdClass":1:{s:8:"idcentro";s:1:"0";}'),
(146, 1360152682, '127.0.0.1', '2', '11', 'O:8:"stdClass":2:{s:4:"user";s:9:"S1mul4d0r";s:3:"pwd";s:9:"ed1t0r14l";}'),
(147, 1360152682, '127.0.0.1', '2', '21', 'O:8:"stdClass":2:{s:6:"Codigo";s:1:"1";s:11:"Descripcion";s:28:"Usuari/contrasenya amb drets";}'),
(148, 1360152682, '127.0.0.1', '2', '22', 'O:8:"stdClass":3:{s:6:"Codigo";s:1:"1";s:11:"Descripcion";s:16:"procés correcte";s:8:"Catalogo";O:8:"Catalogo":1:{s:6:"libros";a:7:{i:0;O:5:"libro":5:{s:4:"ISBN";s:10:"1111111111";s:6:"titulo";s:31:"Llibre scorm remot sense unitat";s:5:"nivel";s:4:"1ESO";s:7:"formato";s:5:"scorm";s:8:"unidades";N;}i:1;O:5:"libro":5:{s:4:"ISBN";s:10:"2222222222";s:6:"titulo";s:35:"Llibre contingut remot sense unitat";s:5:"nivel";s:4:"1ESO";s:7:"formato";s:10:"webcontent";s:8:"unidades";N;}i:2;O:5:"libro":5:{s:4:"ISBN";s:10:"3333333333";s:6:"titulo";s:35:"Llibre scorm remot amb dues unitats";s:5:"nivel";s:4:"1ESO";s:7:"formato";s:5:"scorm";s:8:"unidades";N;}i:3;O:5:"libro":5:{s:4:"ISBN";s:10:"4444444444";s:6:"titulo";s:39:"Llibre contingut remot amb dues unitats";s:5:"nivel";s:4:"1ESO";s:7:"formato";s:10:"webcontent";s:8:"unidades";N;}i:4;O:5:"libro":5:{s:4:"ISBN";s:10:"5555555555";s:6:"titulo";s:38:"Llibre scorm remot amb dues activitats";s:5:"nivel";s:4:"2ESO";s:7:"formato";s:5:"scorm";s:8:"unidades";N;}i:5;O:5:"libro":5:{s:4:"ISBN";s:10:"6666666666";s:6:"titulo";s:42:"Llibre contingut remot amb dues activitats";s:5:"nivel";s:4:"2ESO";s:7:"formato";s:10:"webcontent";s:8:"unidades";N;}i:6;O:5:"libro":5:{s:4:"ISBN";s:10:"7777777777";s:6:"titulo";s:33:"Llibre contingut remot jeràrquic";s:5:"nivel";s:4:"1ESO";s:7:"formato";s:10:"webcontent";s:8:"unidades";N;}}}}'),
(149, 1360152682, '127.0.0.1', '2', '100', ''),
(150, 1360152682, '127.0.0.1', '2', '1', ''),
(151, 1360152682, '127.0.0.1', '2', '10', 'O:8:"stdClass":1:{s:4:"ISBN";s:10:"1111111111";}'),
(152, 1360152682, '127.0.0.1', '2', '11', 'O:8:"stdClass":2:{s:4:"user";s:9:"S1mul4d0r";s:3:"pwd";s:9:"ed1t0r14l";}'),
(153, 1360152682, '127.0.0.1', '2', '21', 'O:8:"stdClass":2:{s:6:"Codigo";s:1:"1";s:11:"Descripcion";s:28:"Usuari/contrasenya amb drets";}'),
(154, 1360152682, '127.0.0.1', '2', '20', 'O:8:"stdClass":3:{s:6:"Codigo";s:1:"1";s:11:"Descripcion";s:16:"procés correcte";s:6:"Libros";O:8:"stdClass":1:{s:5:"libro";O:5:"libro":5:{s:4:"ISBN";s:10:"1111111111";s:6:"titulo";s:31:"Llibre scorm remot sense unitat";s:5:"nivel";s:4:"1ESO";s:7:"formato";s:5:"scorm";s:8:"unidades";N;}}}'),
(155, 1360152682, '127.0.0.1', '2', '100', ''),
(156, 1360152682, '127.0.0.1', '2', '1', ''),
(157, 1360152682, '127.0.0.1', '2', '10', 'O:8:"stdClass":1:{s:4:"ISBN";s:10:"2222222222";}'),
(158, 1360152682, '127.0.0.1', '2', '11', 'O:8:"stdClass":2:{s:4:"user";s:9:"S1mul4d0r";s:3:"pwd";s:9:"ed1t0r14l";}'),
(159, 1360152682, '127.0.0.1', '2', '21', 'O:8:"stdClass":2:{s:6:"Codigo";s:1:"1";s:11:"Descripcion";s:28:"Usuari/contrasenya amb drets";}'),
(160, 1360152682, '127.0.0.1', '2', '20', 'O:8:"stdClass":3:{s:6:"Codigo";s:1:"1";s:11:"Descripcion";s:16:"procés correcte";s:6:"Libros";O:8:"stdClass":1:{s:5:"libro";O:5:"libro":5:{s:4:"ISBN";s:10:"2222222222";s:6:"titulo";s:35:"Llibre contingut remot sense unitat";s:5:"nivel";s:4:"1ESO";s:7:"formato";s:10:"webcontent";s:8:"unidades";N;}}}'),
(161, 1360152682, '127.0.0.1', '2', '100', ''),
(162, 1360152682, '127.0.0.1', '2', '1', ''),
(163, 1360152682, '127.0.0.1', '2', '10', 'O:8:"stdClass":1:{s:4:"ISBN";s:10:"3333333333";}'),
(164, 1360152682, '127.0.0.1', '2', '11', 'O:8:"stdClass":2:{s:4:"user";s:9:"S1mul4d0r";s:3:"pwd";s:9:"ed1t0r14l";}'),
(165, 1360152682, '127.0.0.1', '2', '21', 'O:8:"stdClass":2:{s:6:"Codigo";s:1:"1";s:11:"Descripcion";s:28:"Usuari/contrasenya amb drets";}'),
(166, 1360152682, '127.0.0.1', '2', '20', 'O:8:"stdClass":3:{s:6:"Codigo";s:1:"1";s:11:"Descripcion";s:16:"procés correcte";s:6:"Libros";O:8:"stdClass":1:{s:5:"libro";O:5:"libro":5:{s:4:"ISBN";s:10:"3333333333";s:6:"titulo";s:35:"Llibre scorm remot amb dues unitats";s:5:"nivel";s:4:"1ESO";s:7:"formato";s:5:"scorm";s:8:"unidades";a:2:{i:0;O:6:"unidad":4:{s:2:"id";s:1:"1";s:6:"titulo";s:8:"Unitat 1";s:5:"orden";s:1:"1";s:11:"actividades";N;}i:1;O:6:"unidad":4:{s:2:"id";s:1:"2";s:6:"titulo";s:8:"Unitat 2";s:5:"orden";s:1:"2";s:11:"actividades";N;}}}}}'),
(167, 1360152682, '127.0.0.1', '2', '100', ''),
(168, 1360152682, '127.0.0.1', '2', '1', ''),
(169, 1360152682, '127.0.0.1', '2', '10', 'O:8:"stdClass":1:{s:4:"ISBN";s:10:"4444444444";}'),
(170, 1360152682, '127.0.0.1', '2', '11', 'O:8:"stdClass":2:{s:4:"user";s:9:"S1mul4d0r";s:3:"pwd";s:9:"ed1t0r14l";}'),
(171, 1360152682, '127.0.0.1', '2', '21', 'O:8:"stdClass":2:{s:6:"Codigo";s:1:"1";s:11:"Descripcion";s:28:"Usuari/contrasenya amb drets";}'),
(172, 1360152682, '127.0.0.1', '2', '20', 'O:8:"stdClass":3:{s:6:"Codigo";s:1:"1";s:11:"Descripcion";s:16:"procés correcte";s:6:"Libros";O:8:"stdClass":1:{s:5:"libro";O:5:"libro":5:{s:4:"ISBN";s:10:"4444444444";s:6:"titulo";s:39:"Llibre contingut remot amb dues unitats";s:5:"nivel";s:4:"1ESO";s:7:"formato";s:10:"webcontent";s:8:"unidades";a:2:{i:0;O:6:"unidad":4:{s:2:"id";s:1:"1";s:6:"titulo";s:8:"Unitat 1";s:5:"orden";s:1:"1";s:11:"actividades";N;}i:1;O:6:"unidad":4:{s:2:"id";s:1:"2";s:6:"titulo";s:8:"Unitat 2";s:5:"orden";s:1:"2";s:11:"actividades";N;}}}}}'),
(173, 1360152682, '127.0.0.1', '2', '100', ''),
(174, 1360152682, '127.0.0.1', '2', '1', ''),
(175, 1360152682, '127.0.0.1', '2', '10', 'O:8:"stdClass":1:{s:4:"ISBN";s:10:"5555555555";}'),
(176, 1360152682, '127.0.0.1', '2', '11', 'O:8:"stdClass":2:{s:4:"user";s:9:"S1mul4d0r";s:3:"pwd";s:9:"ed1t0r14l";}'),
(177, 1360152682, '127.0.0.1', '2', '21', 'O:8:"stdClass":2:{s:6:"Codigo";s:1:"1";s:11:"Descripcion";s:28:"Usuari/contrasenya amb drets";}'),
(178, 1360152682, '127.0.0.1', '2', '20', 'O:8:"stdClass":3:{s:6:"Codigo";s:1:"1";s:11:"Descripcion";s:16:"procés correcte";s:6:"Libros";O:8:"stdClass":1:{s:5:"libro";O:5:"libro":5:{s:4:"ISBN";s:10:"5555555555";s:6:"titulo";s:38:"Llibre scorm remot amb dues activitats";s:5:"nivel";s:4:"2ESO";s:7:"formato";s:5:"scorm";s:8:"unidades";a:2:{i:0;O:6:"unidad":4:{s:2:"id";s:1:"1";s:6:"titulo";s:8:"Unitat 1";s:5:"orden";s:1:"1";s:11:"actividades";a:2:{i:0;O:9:"actividad":3:{s:2:"id";s:1:"1";s:6:"titulo";s:11:"Activitat 1";s:5:"orden";s:1:"1";}i:1;O:9:"actividad":3:{s:2:"id";s:1:"2";s:6:"titulo";s:11:"Activitat 2";s:5:"orden";s:1:"2";}}}i:1;O:6:"unidad":4:{s:2:"id";s:1:"2";s:6:"titulo";s:8:"Unitat 2";s:5:"orden";s:1:"2";s:11:"actividades";a:2:{i:0;O:9:"actividad":3:{s:2:"id";s:1:"1";s:6:"titulo";s:11:"Activitat 1";s:5:"orden";s:1:"1";}i:1;O:9:"actividad":3:{s:2:"id";s:1:"2";s:6:"titulo";s:11:"Activitat 2";s:5:"orden";s:1:"2";}}}}}}}'),
(179, 1360152682, '127.0.0.1', '2', '100', ''),
(180, 1360152682, '127.0.0.1', '2', '1', ''),
(181, 1360152682, '127.0.0.1', '2', '10', 'O:8:"stdClass":1:{s:4:"ISBN";s:10:"6666666666";}'),
(182, 1360152682, '127.0.0.1', '2', '11', 'O:8:"stdClass":2:{s:4:"user";s:9:"S1mul4d0r";s:3:"pwd";s:9:"ed1t0r14l";}'),
(183, 1360152682, '127.0.0.1', '2', '21', 'O:8:"stdClass":2:{s:6:"Codigo";s:1:"1";s:11:"Descripcion";s:28:"Usuari/contrasenya amb drets";}'),
(184, 1360152682, '127.0.0.1', '2', '20', 'O:8:"stdClass":3:{s:6:"Codigo";s:1:"1";s:11:"Descripcion";s:16:"procés correcte";s:6:"Libros";O:8:"stdClass":1:{s:5:"libro";O:5:"libro":5:{s:4:"ISBN";s:10:"6666666666";s:6:"titulo";s:42:"Llibre contingut remot amb dues activitats";s:5:"nivel";s:4:"2ESO";s:7:"formato";s:10:"webcontent";s:8:"unidades";a:2:{i:0;O:6:"unidad":4:{s:2:"id";s:1:"1";s:6:"titulo";s:8:"Unitat 1";s:5:"orden";s:1:"1";s:11:"actividades";a:2:{i:0;O:9:"actividad":3:{s:2:"id";s:1:"1";s:6:"titulo";s:11:"Activitat 1";s:5:"orden";s:1:"1";}i:1;O:9:"actividad":3:{s:2:"id";s:1:"2";s:6:"titulo";s:11:"Activitat 2";s:5:"orden";s:1:"2";}}}i:1;O:6:"unidad":4:{s:2:"id";s:1:"2";s:6:"titulo";s:8:"Unitat 2";s:5:"orden";s:1:"2";s:11:"actividades";a:2:{i:0;O:9:"actividad":3:{s:2:"id";s:1:"1";s:6:"titulo";s:11:"Activitat 1";s:5:"orden";s:1:"1";}i:1;O:9:"actividad":3:{s:2:"id";s:1:"2";s:6:"titulo";s:11:"Activitat 2";s:5:"orden";s:1:"2";}}}}}}}'),
(185, 1360152682, '127.0.0.1', '2', '100', ''),
(186, 1360152682, '127.0.0.1', '2', '1', ''),
(187, 1360152682, '127.0.0.1', '2', '10', 'O:8:"stdClass":1:{s:4:"ISBN";s:10:"7777777777";}'),
(188, 1360152682, '127.0.0.1', '2', '11', 'O:8:"stdClass":2:{s:4:"user";s:9:"S1mul4d0r";s:3:"pwd";s:9:"ed1t0r14l";}'),
(189, 1360152682, '127.0.0.1', '2', '21', 'O:8:"stdClass":2:{s:6:"Codigo";s:1:"1";s:11:"Descripcion";s:28:"Usuari/contrasenya amb drets";}'),
(190, 1360152682, '127.0.0.1', '2', '20', 'O:8:"stdClass":3:{s:6:"Codigo";s:1:"1";s:11:"Descripcion";s:16:"procés correcte";s:6:"Libros";O:8:"stdClass":1:{s:5:"libro";O:5:"libro":5:{s:4:"ISBN";s:10:"7777777777";s:6:"titulo";s:33:"Llibre contingut remot jeràrquic";s:5:"nivel";s:4:"1ESO";s:7:"formato";s:10:"webcontent";s:8:"unidades";a:2:{i:0;O:6:"unidad":4:{s:2:"id";s:1:"1";s:6:"titulo";s:23:"Unitat 1 (Autoavaluada)";s:5:"orden";s:1:"1";s:11:"actividades";a:3:{i:0;O:9:"actividad":3:{s:2:"id";s:1:"1";s:6:"titulo";s:11:"Activitat 1";s:5:"orden";s:1:"1";}i:1;O:9:"actividad":3:{s:2:"id";s:1:"2";s:6:"titulo";s:11:"Activitat 2";s:5:"orden";s:1:"2";}i:2;O:9:"actividad":3:{s:2:"id";s:1:"3";s:6:"titulo";s:11:"Activitat 3";s:5:"orden";s:1:"3";}}}i:1;O:6:"unidad":4:{s:2:"id";s:1:"2";s:6:"titulo";s:33:"Unitat 2 (Avaluada per professor)";s:5:"orden";s:1:"2";s:11:"actividades";a:2:{i:0;O:9:"actividad":3:{s:2:"id";s:1:"1";s:6:"titulo";s:11:"Activitat 1";s:5:"orden";s:1:"1";}i:1;O:9:"actividad":3:{s:2:"id";s:1:"2";s:6:"titulo";s:11:"Activitat 2";s:5:"orden";s:1:"2";}}}}}}}'),
(191, 1360152682, '127.0.0.1', '2', '100', ''),
(192, 1390233796, '127.0.0.1', '2', '1', ''),
(193, 1390233796, '127.0.0.1', '2', '12', 'O:8:"stdClass":1:{s:8:"idcentro";s:8:"08000003";}'),
(194, 1390233796, '127.0.0.1', '2', '11', 'O:8:"stdClass":2:{s:4:"user";s:9:"S1mul4d0r";s:3:"pwd";s:9:"ed1t0r14l";}'),
(195, 1390233796, '127.0.0.1', '2', '21', 'O:8:"stdClass":2:{s:6:"Codigo";s:1:"1";s:11:"Descripcion";s:28:"Usuari/contrasenya amb drets";}'),
(196, 1390233796, '127.0.0.1', '2', '22', 'O:8:"stdClass":3:{s:6:"Codigo";s:1:"1";s:11:"Descripcion";s:16:"procés correcte";s:8:"Catalogo";O:8:"Catalogo":1:{s:6:"libros";a:7:{i:0;O:5:"libro":5:{s:4:"ISBN";s:10:"1111111111";s:6:"titulo";s:31:"Llibre scorm remot sense unitat";s:5:"nivel";s:4:"1ESO";s:7:"formato";s:5:"scorm";s:8:"unidades";N;}i:1;O:5:"libro":5:{s:4:"ISBN";s:10:"2222222222";s:6:"titulo";s:35:"Llibre contingut remot sense unitat";s:5:"nivel";s:4:"1ESO";s:7:"formato";s:10:"webcontent";s:8:"unidades";N;}i:2;O:5:"libro":5:{s:4:"ISBN";s:10:"3333333333";s:6:"titulo";s:35:"Llibre scorm remot amb dues unitats";s:5:"nivel";s:4:"1ESO";s:7:"formato";s:5:"scorm";s:8:"unidades";N;}i:3;O:5:"libro":5:{s:4:"ISBN";s:10:"4444444444";s:6:"titulo";s:39:"Llibre contingut remot amb dues unitats";s:5:"nivel";s:4:"1ESO";s:7:"formato";s:10:"webcontent";s:8:"unidades";N;}i:4;O:5:"libro":5:{s:4:"ISBN";s:10:"5555555555";s:6:"titulo";s:38:"Llibre scorm remot amb dues activitats";s:5:"nivel";s:4:"2ESO";s:7:"formato";s:5:"scorm";s:8:"unidades";N;}i:5;O:5:"libro":5:{s:4:"ISBN";s:10:"6666666666";s:6:"titulo";s:42:"Llibre contingut remot amb dues activitats";s:5:"nivel";s:4:"2ESO";s:7:"formato";s:10:"webcontent";s:8:"unidades";N;}i:6;O:5:"libro":5:{s:4:"ISBN";s:10:"7777777777";s:6:"titulo";s:33:"Llibre contingut remot jeràrquic";s:5:"nivel";s:4:"1ESO";s:7:"formato";s:10:"webcontent";s:8:"unidades";N;}}}}'),
(197, 1390233796, '127.0.0.1', '2', '100', ''),
(198, 1390233796, '127.0.0.1', '2', '1', ''),
(199, 1390233796, '127.0.0.1', '2', '10', 'O:8:"stdClass":1:{s:4:"ISBN";s:10:"1111111111";}'),
(200, 1390233796, '127.0.0.1', '2', '11', 'O:8:"stdClass":2:{s:4:"user";s:9:"S1mul4d0r";s:3:"pwd";s:9:"ed1t0r14l";}'),
(201, 1390233796, '127.0.0.1', '2', '21', 'O:8:"stdClass":2:{s:6:"Codigo";s:1:"1";s:11:"Descripcion";s:28:"Usuari/contrasenya amb drets";}'),
(202, 1390233796, '127.0.0.1', '2', '20', 'O:8:"stdClass":3:{s:6:"Codigo";s:1:"1";s:11:"Descripcion";s:16:"procés correcte";s:6:"Libros";O:8:"stdClass":1:{s:5:"libro";O:5:"libro":5:{s:4:"ISBN";s:10:"1111111111";s:6:"titulo";s:31:"Llibre scorm remot sense unitat";s:5:"nivel";s:4:"1ESO";s:7:"formato";s:5:"scorm";s:8:"unidades";N;}}}'),
(203, 1390233796, '127.0.0.1', '2', '100', ''),
(204, 1390233797, '127.0.0.1', '2', '1', ''),
(205, 1390233797, '127.0.0.1', '2', '10', 'O:8:"stdClass":1:{s:4:"ISBN";s:10:"2222222222";}'),
(206, 1390233797, '127.0.0.1', '2', '11', 'O:8:"stdClass":2:{s:4:"user";s:9:"S1mul4d0r";s:3:"pwd";s:9:"ed1t0r14l";}'),
(207, 1390233797, '127.0.0.1', '2', '21', 'O:8:"stdClass":2:{s:6:"Codigo";s:1:"1";s:11:"Descripcion";s:28:"Usuari/contrasenya amb drets";}'),
(208, 1390233797, '127.0.0.1', '2', '20', 'O:8:"stdClass":3:{s:6:"Codigo";s:1:"1";s:11:"Descripcion";s:16:"procés correcte";s:6:"Libros";O:8:"stdClass":1:{s:5:"libro";O:5:"libro":5:{s:4:"ISBN";s:10:"2222222222";s:6:"titulo";s:35:"Llibre contingut remot sense unitat";s:5:"nivel";s:4:"1ESO";s:7:"formato";s:10:"webcontent";s:8:"unidades";N;}}}'),
(209, 1390233797, '127.0.0.1', '2', '100', ''),
(210, 1390233797, '127.0.0.1', '2', '1', ''),
(211, 1390233797, '127.0.0.1', '2', '10', 'O:8:"stdClass":1:{s:4:"ISBN";s:10:"3333333333";}'),
(212, 1390233797, '127.0.0.1', '2', '11', 'O:8:"stdClass":2:{s:4:"user";s:9:"S1mul4d0r";s:3:"pwd";s:9:"ed1t0r14l";}'),
(213, 1390233797, '127.0.0.1', '2', '21', 'O:8:"stdClass":2:{s:6:"Codigo";s:1:"1";s:11:"Descripcion";s:28:"Usuari/contrasenya amb drets";}'),
(214, 1390233797, '127.0.0.1', '2', '20', 'O:8:"stdClass":3:{s:6:"Codigo";s:1:"1";s:11:"Descripcion";s:16:"procés correcte";s:6:"Libros";O:8:"stdClass":1:{s:5:"libro";O:5:"libro":5:{s:4:"ISBN";s:10:"3333333333";s:6:"titulo";s:35:"Llibre scorm remot amb dues unitats";s:5:"nivel";s:4:"1ESO";s:7:"formato";s:5:"scorm";s:8:"unidades";a:2:{i:0;O:6:"unidad":4:{s:2:"id";s:1:"1";s:6:"titulo";s:8:"Unitat 1";s:5:"orden";s:1:"1";s:11:"actividades";N;}i:1;O:6:"unidad":4:{s:2:"id";s:1:"2";s:6:"titulo";s:8:"Unitat 2";s:5:"orden";s:1:"2";s:11:"actividades";N;}}}}}'),
(215, 1390233797, '127.0.0.1', '2', '100', ''),
(216, 1390233798, '127.0.0.1', '2', '1', ''),
(217, 1390233798, '127.0.0.1', '2', '10', 'O:8:"stdClass":1:{s:4:"ISBN";s:10:"4444444444";}'),
(218, 1390233798, '127.0.0.1', '2', '11', 'O:8:"stdClass":2:{s:4:"user";s:9:"S1mul4d0r";s:3:"pwd";s:9:"ed1t0r14l";}'),
(219, 1390233798, '127.0.0.1', '2', '21', 'O:8:"stdClass":2:{s:6:"Codigo";s:1:"1";s:11:"Descripcion";s:28:"Usuari/contrasenya amb drets";}'),
(220, 1390233798, '127.0.0.1', '2', '20', 'O:8:"stdClass":3:{s:6:"Codigo";s:1:"1";s:11:"Descripcion";s:16:"procés correcte";s:6:"Libros";O:8:"stdClass":1:{s:5:"libro";O:5:"libro":5:{s:4:"ISBN";s:10:"4444444444";s:6:"titulo";s:39:"Llibre contingut remot amb dues unitats";s:5:"nivel";s:4:"1ESO";s:7:"formato";s:10:"webcontent";s:8:"unidades";a:2:{i:0;O:6:"unidad":4:{s:2:"id";s:1:"1";s:6:"titulo";s:8:"Unitat 1";s:5:"orden";s:1:"1";s:11:"actividades";N;}i:1;O:6:"unidad":4:{s:2:"id";s:1:"2";s:6:"titulo";s:8:"Unitat 2";s:5:"orden";s:1:"2";s:11:"actividades";N;}}}}}'),
(221, 1390233798, '127.0.0.1', '2', '100', ''),
(222, 1390233798, '127.0.0.1', '2', '1', ''),
(223, 1390233798, '127.0.0.1', '2', '10', 'O:8:"stdClass":1:{s:4:"ISBN";s:10:"5555555555";}'),
(224, 1390233798, '127.0.0.1', '2', '11', 'O:8:"stdClass":2:{s:4:"user";s:9:"S1mul4d0r";s:3:"pwd";s:9:"ed1t0r14l";}'),
(225, 1390233798, '127.0.0.1', '2', '21', 'O:8:"stdClass":2:{s:6:"Codigo";s:1:"1";s:11:"Descripcion";s:28:"Usuari/contrasenya amb drets";}'),
(226, 1390233798, '127.0.0.1', '2', '20', 'O:8:"stdClass":3:{s:6:"Codigo";s:1:"1";s:11:"Descripcion";s:16:"procés correcte";s:6:"Libros";O:8:"stdClass":1:{s:5:"libro";O:5:"libro":5:{s:4:"ISBN";s:10:"5555555555";s:6:"titulo";s:38:"Llibre scorm remot amb dues activitats";s:5:"nivel";s:4:"2ESO";s:7:"formato";s:5:"scorm";s:8:"unidades";a:2:{i:0;O:6:"unidad":4:{s:2:"id";s:1:"1";s:6:"titulo";s:8:"Unitat 1";s:5:"orden";s:1:"1";s:11:"actividades";a:2:{i:0;O:9:"actividad":3:{s:2:"id";s:1:"1";s:6:"titulo";s:11:"Activitat 1";s:5:"orden";s:1:"1";}i:1;O:9:"actividad":3:{s:2:"id";s:1:"2";s:6:"titulo";s:11:"Activitat 2";s:5:"orden";s:1:"2";}}}i:1;O:6:"unidad":4:{s:2:"id";s:1:"2";s:6:"titulo";s:8:"Unitat 2";s:5:"orden";s:1:"2";s:11:"actividades";a:2:{i:0;O:9:"actividad":3:{s:2:"id";s:1:"1";s:6:"titulo";s:11:"Activitat 1";s:5:"orden";s:1:"1";}i:1;O:9:"actividad":3:{s:2:"id";s:1:"2";s:6:"titulo";s:11:"Activitat 2";s:5:"orden";s:1:"2";}}}}}}}'),
(227, 1390233798, '127.0.0.1', '2', '100', ''),
(228, 1390233799, '127.0.0.1', '2', '1', ''),
(229, 1390233799, '127.0.0.1', '2', '10', 'O:8:"stdClass":1:{s:4:"ISBN";s:10:"6666666666";}'),
(230, 1390233799, '127.0.0.1', '2', '11', 'O:8:"stdClass":2:{s:4:"user";s:9:"S1mul4d0r";s:3:"pwd";s:9:"ed1t0r14l";}'),
(231, 1390233799, '127.0.0.1', '2', '21', 'O:8:"stdClass":2:{s:6:"Codigo";s:1:"1";s:11:"Descripcion";s:28:"Usuari/contrasenya amb drets";}'),
(232, 1390233799, '127.0.0.1', '2', '20', 'O:8:"stdClass":3:{s:6:"Codigo";s:1:"1";s:11:"Descripcion";s:16:"procés correcte";s:6:"Libros";O:8:"stdClass":1:{s:5:"libro";O:5:"libro":5:{s:4:"ISBN";s:10:"6666666666";s:6:"titulo";s:42:"Llibre contingut remot amb dues activitats";s:5:"nivel";s:4:"2ESO";s:7:"formato";s:10:"webcontent";s:8:"unidades";a:2:{i:0;O:6:"unidad":4:{s:2:"id";s:1:"1";s:6:"titulo";s:8:"Unitat 1";s:5:"orden";s:1:"1";s:11:"actividades";a:2:{i:0;O:9:"actividad":3:{s:2:"id";s:1:"1";s:6:"titulo";s:11:"Activitat 1";s:5:"orden";s:1:"1";}i:1;O:9:"actividad":3:{s:2:"id";s:1:"2";s:6:"titulo";s:11:"Activitat 2";s:5:"orden";s:1:"2";}}}i:1;O:6:"unidad":4:{s:2:"id";s:1:"2";s:6:"titulo";s:8:"Unitat 2";s:5:"orden";s:1:"2";s:11:"actividades";a:2:{i:0;O:9:"actividad":3:{s:2:"id";s:1:"1";s:6:"titulo";s:11:"Activitat 1";s:5:"orden";s:1:"1";}i:1;O:9:"actividad":3:{s:2:"id";s:1:"2";s:6:"titulo";s:11:"Activitat 2";s:5:"orden";s:1:"2";}}}}}}}'),
(233, 1390233799, '127.0.0.1', '2', '100', ''),
(234, 1390233799, '127.0.0.1', '2', '1', ''),
(235, 1390233799, '127.0.0.1', '2', '10', 'O:8:"stdClass":1:{s:4:"ISBN";s:10:"7777777777";}'),
(236, 1390233799, '127.0.0.1', '2', '11', 'O:8:"stdClass":2:{s:4:"user";s:9:"S1mul4d0r";s:3:"pwd";s:9:"ed1t0r14l";}'),
(237, 1390233799, '127.0.0.1', '2', '21', 'O:8:"stdClass":2:{s:6:"Codigo";s:1:"1";s:11:"Descripcion";s:28:"Usuari/contrasenya amb drets";}'),
(238, 1390233799, '127.0.0.1', '2', '20', 'O:8:"stdClass":3:{s:6:"Codigo";s:1:"1";s:11:"Descripcion";s:16:"procés correcte";s:6:"Libros";O:8:"stdClass":1:{s:5:"libro";O:5:"libro":5:{s:4:"ISBN";s:10:"7777777777";s:6:"titulo";s:33:"Llibre contingut remot jeràrquic";s:5:"nivel";s:4:"1ESO";s:7:"formato";s:10:"webcontent";s:8:"unidades";a:2:{i:0;O:6:"unidad":4:{s:2:"id";s:1:"1";s:6:"titulo";s:23:"Unitat 1 (Autoavaluada)";s:5:"orden";s:1:"1";s:11:"actividades";a:3:{i:0;O:9:"actividad":3:{s:2:"id";s:1:"1";s:6:"titulo";s:11:"Activitat 1";s:5:"orden";s:1:"1";}i:1;O:9:"actividad":3:{s:2:"id";s:1:"2";s:6:"titulo";s:11:"Activitat 2";s:5:"orden";s:1:"2";}i:2;O:9:"actividad":3:{s:2:"id";s:1:"3";s:6:"titulo";s:11:"Activitat 3";s:5:"orden";s:1:"3";}}}i:1;O:6:"unidad":4:{s:2:"id";s:1:"2";s:6:"titulo";s:33:"Unitat 2 (Avaluada per professor)";s:5:"orden";s:1:"2";s:11:"actividades";a:2:{i:0;O:9:"actividad":3:{s:2:"id";s:1:"1";s:6:"titulo";s:11:"Activitat 1";s:5:"orden";s:1:"1";}i:1;O:9:"actividad":3:{s:2:"id";s:1:"2";s:6:"titulo";s:11:"Activitat 2";s:5:"orden";s:1:"2";}}}}}}}'),
(239, 1390233799, '127.0.0.1', '2', '100', ''),
(240, 1390233898, '127.0.0.1', '2', '1', ''),
(241, 1390233898, '127.0.0.1', '2', '12', 'O:8:"stdClass":1:{s:8:"idcentro";s:8:"08000003";}'),
(242, 1390233898, '127.0.0.1', '2', '11', 'O:8:"stdClass":2:{s:4:"user";s:9:"S1mul4d0r";s:3:"pwd";s:9:"ed1t0r14l";}'),
(243, 1390233898, '127.0.0.1', '2', '21', 'O:8:"stdClass":2:{s:6:"Codigo";s:1:"1";s:11:"Descripcion";s:28:"Usuari/contrasenya amb drets";}');
INSERT INTO `mps_log` (`id`, `time`, `ip`, `categoryid`, `actionid`, `info`) VALUES
(244, 1390233898, '127.0.0.1', '2', '22', 'O:8:"stdClass":3:{s:6:"Codigo";s:1:"1";s:11:"Descripcion";s:16:"procés correcte";s:8:"Catalogo";O:8:"Catalogo":1:{s:6:"libros";a:7:{i:0;O:5:"libro":5:{s:4:"ISBN";s:10:"1111111111";s:6:"titulo";s:31:"Llibre scorm remot sense unitat";s:5:"nivel";s:4:"1ESO";s:7:"formato";s:5:"scorm";s:8:"unidades";N;}i:1;O:5:"libro":5:{s:4:"ISBN";s:10:"2222222222";s:6:"titulo";s:35:"Llibre contingut remot sense unitat";s:5:"nivel";s:4:"1ESO";s:7:"formato";s:10:"webcontent";s:8:"unidades";N;}i:2;O:5:"libro":5:{s:4:"ISBN";s:10:"3333333333";s:6:"titulo";s:35:"Llibre scorm remot amb dues unitats";s:5:"nivel";s:4:"1ESO";s:7:"formato";s:5:"scorm";s:8:"unidades";N;}i:3;O:5:"libro":5:{s:4:"ISBN";s:10:"4444444444";s:6:"titulo";s:39:"Llibre contingut remot amb dues unitats";s:5:"nivel";s:4:"1ESO";s:7:"formato";s:10:"webcontent";s:8:"unidades";N;}i:4;O:5:"libro":5:{s:4:"ISBN";s:10:"5555555555";s:6:"titulo";s:38:"Llibre scorm remot amb dues activitats";s:5:"nivel";s:4:"2ESO";s:7:"formato";s:5:"scorm";s:8:"unidades";N;}i:5;O:5:"libro":5:{s:4:"ISBN";s:10:"6666666666";s:6:"titulo";s:42:"Llibre contingut remot amb dues activitats";s:5:"nivel";s:4:"2ESO";s:7:"formato";s:10:"webcontent";s:8:"unidades";N;}i:6;O:5:"libro":5:{s:4:"ISBN";s:10:"7777777777";s:6:"titulo";s:33:"Llibre contingut remot jeràrquic";s:5:"nivel";s:4:"1ESO";s:7:"formato";s:10:"webcontent";s:8:"unidades";N;}}}}'),
(245, 1390233898, '127.0.0.1', '2', '100', '');

-- --------------------------------------------------------

--
-- Estructura de la taula `mps_log_errors`
--

CREATE TABLE IF NOT EXISTS `mps_log_errors` (
  `id` bigint(10) NOT NULL AUTO_INCREMENT,
  `time` bigint(10) NOT NULL,
  `ip` varchar(15) NOT NULL,
  `actionid` varchar(255) NOT NULL,
  `info` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estructura de la taula `mps_publishers_credentials`
--

CREATE TABLE IF NOT EXISTS `mps_publishers_credentials` (
  `id` bigint(10) NOT NULL AUTO_INCREMENT,
  `username` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `success` bigint(1) NOT NULL,
  `code` varchar(100) NOT NULL,
  `description` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estructura de la taula `mps_sessions`
--

CREATE TABLE IF NOT EXISTS `mps_sessions` (
  `id` bigint(10) NOT NULL AUTO_INCREMENT,
  `token` varchar(255) NOT NULL,
  `isbn` varchar(255) NOT NULL,
  `userid` bigint(10) NOT NULL,
  `nameape` varchar(255) NOT NULL,
  `groupid` bigint(10) NOT NULL,
  `courseid` bigint(10) NOT NULL,
  `centerid` bigint(10) NOT NULL,
  `wsurltracking` varchar(255) NOT NULL,
  `lmscontentid` bigint(10) NOT NULL,
  `unitid` varchar(100) NOT NULL,
  `activityid` varchar(100) NOT NULL,
  `addtime` bigint(10) NOT NULL,
  `expiretime` bigint(10) NOT NULL,
  `urlcontent` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=5 ;

--
-- Bolcant dades de la taula `mps_sessions`
--

INSERT INTO `mps_sessions` (`id`, `token`, `isbn`, `userid`, `nameape`, `groupid`, `courseid`, `centerid`, `wsurltracking`, `lmscontentid`, `unitid`, `activityid`, `addtime`, `expiretime`, `urlcontent`) VALUES
(1, '50d348feaac68990366189', '4444444444', 2, '', 0, 21, 8000003, 'http://agora-virtual.educat1x1.cat/agora/usu3/moodle/mod/rcontent/WebServices/WsSeguimiento/wsSeguimiento.php', 1, '1', '', 1356024062, 1356110462, 'http://agora/mps/data/books/4444444444/33333/index.php?token=50d348feaac68990366189'),
(2, '50d348ff16493859980114', '4444444444', 2, '', 0, 21, 8000003, 'http://agora-virtual.educat1x1.cat/agora/usu3/moodle/mod/rcontent/WebServices/WsSeguimiento/wsSeguimiento.php', 1, '1', '', 1356024063, 1356110463, 'http://agora/mps/data/books/4444444444/33333/index.php?token=50d348ff16493859980114'),
(3, '50d3496c9af80642084357', '4444444444', 2, '', 0, 21, 8000003, 'http://agora-virtual.educat1x1.cat/agora/usu3/moodle/mod/rcontent/WebServices/WsSeguimiento/wsSeguimiento.php', 1, '1', '', 1356024172, 1356110572, 'http://agora/mps/data/books/4444444444/33333/index.php?token=50d3496c9af80642084357'),
(4, '50d3496cf20ce917953415', '4444444444', 2, '', 0, 21, 8000003, 'http://agora-virtual.educat1x1.cat/agora/usu3/moodle/mod/rcontent/WebServices/WsSeguimiento/wsSeguimiento.php', 1, '1', '', 1356024172, 1356110572, 'http://agora/mps/data/books/4444444444/33333/index.php?token=50d3496cf20ce917953415');

-- --------------------------------------------------------

--
-- Estructura de la taula `mps_user`
--

CREATE TABLE IF NOT EXISTS `mps_user` (
  `id` bigint(10) NOT NULL AUTO_INCREMENT,
  `auth` varchar(255) NOT NULL,
  `username` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `firstname` varchar(255) NOT NULL,
  `lastname` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2 ;

--
-- Bolcant dades de la taula `mps_user`
--

INSERT INTO `mps_user` (`id`, `auth`, `username`, `password`, `firstname`, `lastname`) VALUES
(1, 'manual', 'admin', '6142bfd56a583d891f0b1dcdbb2a9ef8', 'Administrador/a', 'MPS');

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
