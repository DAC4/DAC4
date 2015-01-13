SET NAMES UTF8;

--
-- Reset the database
--

-- Destroy database if it exists
DROP DATABASE IF EXISTS `troc_box`;

-- Database creation and selection
CREATE DATABASE `troc_box`;
USE `troc_box`;

--
-- Create tables in the database
--

-- User table
CREATE TABLE `users`
(
  `id`                   INT(11)      NOT NULL AUTO_INCREMENT,
  `login`                VARCHAR(30)  NOT NULL UNIQUE,
  `password`             VARCHAR(300) NOT NULL,
  `name`                 VARCHAR(120) NOT NULL,
  `email`                VARCHAR(55)  NOT NULL,
  `credits`              INT(11)      NOT NULL,
  `registrationComplete` BOOLEAN      NOT NULL,

  PRIMARY KEY (`id`)
)
  ENGINE = InnoDB
  DEFAULT CHARSET = UTF8
  AUTO_INCREMENT = 1;

-- Item table
CREATE TABLE `items` (
  `id`                   INT(11)       NOT NULL AUTO_INCREMENT,
  `name`                 VARCHAR(50)            DEFAULT NULL,
  `imageId`              VARCHAR(100)  NOT NULL, -- TODO Varchar?
  `description`          VARCHAR(1000) NOT NULL,
  `?object-availability` VARCHAR(20)            DEFAULT NULL, -- TODO Wtf is this
  `?object-depDate`      DATE          NOT NULL, -- TODO Wtf is this
  `?object-disp`         BOOLEAN       NOT NULL, -- TODO Wtf is this
  `lockerNum`            INT(11)       NOT NULL,
  `?object-dureemax`     VARCHAR(30)   NOT NULL, -- TODO Wtf is this
  `?Object-accepted`     BOOLEAN       NOT NULL, -- TODO Wtf is this
  PRIMARY KEY (`id`)
)
  ENGINE = InnoDB
  DEFAULT CHARSET = UTF8
  AUTO_INCREMENT = 1;

-- Loan table
CREATE TABLE `loans` (
  `id`          INT(11) NOT NULL AUTO_INCREMENT,
  `date`        DATE    NOT NULL,
  `emp-retDate` DATE    NOT NULL, -- TODO Wtf is this
  `userId`      INT(11) NOT NULL,
  `itemId`      INT(11) NOT NULL,
  `returned`    BOOLEAN NOT NULL,
  `emp-datedep` BOOLEAN NOT NULL, -- TODO Wtf is this
  PRIMARY KEY (`id`),
  FOREIGN KEY (`userId`) REFERENCES users (`id`),
  FOREIGN KEY (`itemId`) REFERENCES items (`id`)
)
  ENGINE = InnoDB
  DEFAULT CHARSET = UTF8
  AUTO_INCREMENT = 1;

--
-- Insert example values
--

INSERT INTO `users` VALUES (DEFAULT, 'admin', 'admin', 'Mr Admin', 'admin@admin.admin', 0, TRUE);
INSERT INTO `users` VALUES (DEFAULT, 'Ribesg', 'mdp', 'Gael Ribes', 'ribesg@yahoo.fr', 50, TRUE);
INSERT INTO `users` VALUES (DEFAULT, 'Phalexei', 'mdp', 'Tom André-Poyaud', 'tandrepoyaud@gmail.com', 50, TRUE);
INSERT INTO `users` VALUES (DEFAULT, 'pacaletx', 'mdp', 'Xavier Pacalet', 'x.pacalet@gmail.com', 50, TRUE);
INSERT INTO `users` VALUES (DEFAULT, 'momo', 'mdp', 'Mohammed Taha El Ahmar', 'med.taha.elahmar@gmail.com', 50, TRUE);
INSERT INTO `users` VALUES (DEFAULT, 'laforesy', 'mdp', 'Yann Laforest', 'laforest.yann@gmail.com', 50, TRUE);
INSERT INTO `users` VALUES (DEFAULT, 'levillar', 'mdp', 'Remi Levillain', 'levillain.remi@gmail.com', 50, TRUE);
INSERT INTO `users` VALUES (DEFAULT, 'bienners', 'mdp', 'Solenne Bienner', 'solenne.bienner@gmail.com', 50, TRUE);

INSERT INTO `items` VALUES (DEFAULT, 'Example Item', '42', 'This is an example item', '?', '2015-01-01', FALSE, 12, '?', TRUE);

INSERT INTO `loans` VALUES (DEFAULT, '2015-01-01', '2015-01-01', 1, 1, FALSE, TRUE);

-- Commit
COMMIT;
