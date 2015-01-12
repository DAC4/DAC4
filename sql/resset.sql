-- phpMyAdmin SQL Dump
-- version 3.5.2.2
-- http://www.phpmyadmin.net
--
-- Client: 127.0.0.1
-- Généré le: Mer 31 Décembre 2014 à 13:38
-- Version du serveur: 5.5.27
-- Version de PHP: 5.4.7

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Base de données: `troc_box`
--

-- --------------------------------------------------------

--
-- Structure de la table `emprunt`
--

CREATE TABLE IF NOT EXISTS `emprunt` (
  `emp-id` int(11) NOT NULL AUTO_INCREMENT,
  `emp-date` date NOT NULL,
  `emp-retDate` date NOT NULL,
  `user-id` int(11) NOT NULL,
  `object-id` int(11) NOT NULL,
  `emp-returned` tinyint(1) NOT NULL,
  `emp-datedep` tinyint(1) NOT NULL,
  PRIMARY KEY (`emp-id`),
  KEY `user-id` (`user-id`),
  KEY `object-id` (`object-id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Structure de la table `objects`
--

CREATE TABLE IF NOT EXISTS `objects` (
  `object-id` int(11) NOT NULL AUTO_INCREMENT,
  `object-name` varchar(50) DEFAULT NULL,
  `object-imageID` varchar(100) NOT NULL,
  `object-availability` varchar(20) DEFAULT NULL,
  `object-depDate` date NOT NULL,
  `object-disp` tinyint(1) NOT NULL,
  `obj-numCasier` int(11) NOT NULL,
  `object-desc` varchar(200) NOT NULL,
  `object-dureemax` varchar(30) NOT NULL,
  `Object-accepted` tinyint(1) NOT NULL,
  PRIMARY KEY (`object-id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=2 ;

--
-- Contenu de la table `objects`
--

INSERT INTO `objects` (`object-id`, `object-name`, `object-imageID`, `object-availability`, `object-depDate`, `object-disp`, `obj-numCasier`, `object-desc`, `object-dureemax`, `Object-accepted`) VALUES
(1, 'dd', 'dd', NULL, '2014-12-14', 0, 0, '', '', 0);

-- --------------------------------------------------------

--
-- Structure de la table `user`
--

CREATE TABLE IF NOT EXISTS `user` (
  `user-id` int(11) NOT NULL AUTO_INCREMENT,
  `user-name` varchar(30) NOT NULL,
  `user-fname` varchar(30) NOT NULL,
  `user-email` varchar(50) NOT NULL,
  `user-login` varchar(30) NOT NULL,
  `user-password` varchar(30) NOT NULL,
  `user-credits` int(11) NOT NULL,
  `user-inscValidee` tinyint(1) NOT NULL,
  PRIMARY KEY (`user-id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Cette table contient les informations sur les utilisateurs' AUTO_INCREMENT=1 ;

--
-- Contraintes pour les tables exportées
--

--
-- Contraintes pour la table `emprunt`
--
ALTER TABLE `emprunt`
  ADD CONSTRAINT `emprunt_ibfk_1` FOREIGN KEY (`user-id`) REFERENCES `user` (`user-id`),
  ADD CONSTRAINT `emprunt_ibfk_2` FOREIGN KEY (`object-id`) REFERENCES `objects` (`object-id`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
