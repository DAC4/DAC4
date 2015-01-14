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
  `id`              INT(11)       NOT NULL AUTO_INCREMENT,
  `name`            VARCHAR(50)   NOT NULL,
  `imageId`         VARCHAR(1000) NOT NULL,
  `description`     VARCHAR(1000) NOT NULL,
  `ownerId`         INT(11)       NOT NULL,
  `availability`    BOOLEAN       NOT NULL,
  `lockerNum`       INT(11)       NOT NULL,
  `maxLoanDuration` INT(11)       NOT NULL,
  `accepted`        BOOLEAN       NOT NULL,
  PRIMARY KEY (`id`),
  FOREIGN KEY (`ownerId`) REFERENCES users (`id`)
)
  ENGINE = InnoDB
  DEFAULT CHARSET = UTF8
  AUTO_INCREMENT = 1;

-- Loan table
CREATE TABLE `loans` (
  `id`        INT(11) NOT NULL AUTO_INCREMENT,
  `userId`    INT(11) NOT NULL,
  `itemId`    INT(11) NOT NULL,
  `returned`  BOOLEAN NOT NULL,
  `startDate` DATE    NOT NULL,
  `endDate`   DATE    NOT NULL,
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
INSERT INTO `users` VALUES (DEFAULT, 'test', 'test', 'Test', 'test@test.test', 50, FALSE);

INSERT INTO `items` VALUES (DEFAULT, 'Example Item', '42', 'This is an example item', 1, FALSE, 12, 10, TRUE);
INSERT INTO `items` VALUES (DEFAULT, 'Example Item 2', '1337', 'This is another example item', 2, TRUE, 11, 2, FALSE);

INSERT INTO `loans` VALUES (DEFAULT, 1, 1, FALSE, '2015-01-01', '2015-01-01');

-- Commit
COMMIT;
