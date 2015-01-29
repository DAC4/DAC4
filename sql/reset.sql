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

-- Config table
CREATE TABLE `config` (
  `id`   VARCHAR(50) NOT NULL UNIQUE,
  `value` VARCHAR(250),

  PRIMARY KEY (`id`)
)
  ENGINE = InnoDB
  DEFAULT CHARSET = UTF8;

-- User table
CREATE TABLE `users`
(
  `id`       INT(11)      NOT NULL AUTO_INCREMENT,
  `login`    VARCHAR(30)  NOT NULL UNIQUE,
  `password` VARCHAR(300) NOT NULL,
  `name`     VARCHAR(120) NOT NULL,
  `email`    VARCHAR(55)  NOT NULL,
  `credits`  INT(11)      NOT NULL,
  `approved` BOOLEAN      NOT NULL,

  PRIMARY KEY (`id`)
)
  ENGINE = InnoDB
  DEFAULT CHARSET = UTF8
  AUTO_INCREMENT = 1;

-- Item table
CREATE TABLE `items` (
  `id`              INT(11)       NOT NULL AUTO_INCREMENT,
  `name`            VARCHAR(50)   NOT NULL,
  `imagePath`       VARCHAR(1000)          DEFAULT NULL,
  `description`     VARCHAR(1000) NOT NULL,
  `ownerId`         INT(11)       NOT NULL,
  `availability`    BOOLEAN       NOT NULL,
  `lockerNum`       INT(11)       NOT NULL,
  `maxLoanDuration` INT(11)       NOT NULL,
  `approved`        BOOLEAN       NOT NULL,
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
  `startDate` DATE    NOT NULL,
  `endDate`   DATE             DEFAULT NULL,
  PRIMARY KEY (`id`),
  FOREIGN KEY (`userId`) REFERENCES users (`id`),
  FOREIGN KEY (`itemId`) REFERENCES items (`id`)
)
  ENGINE = InnoDB
  DEFAULT CHARSET = UTF8
  AUTO_INCREMENT = 1;

--
-- Inserts
--

-- Config
INSERT INTO `config` VALUES ('lockerAmount', '27');

-- Users
INSERT INTO `users` VALUES (DEFAULT, 'admin', 'admin', 'Mr Admin', 'admin@admin.admin', 0, TRUE);
INSERT INTO `users` VALUES (DEFAULT, 'user1', 'user1', 'User 1', 'user1@test.test', 5, TRUE);
INSERT INTO `users` VALUES (DEFAULT, 'user2', 'user2', 'User 2', 'user2@test.test', 5, TRUE);
INSERT INTO `users` VALUES (DEFAULT, 'test', 'test', 'Test', 'test@test.test', 5, FALSE);

-- Items
INSERT INTO `items` VALUES (DEFAULT, 'Item1', NULL, 'Description of item 1', 2, FALSE, 14, 8, TRUE);
INSERT INTO `items` VALUES (DEFAULT, 'Item2', NULL, 'Description of item 2', 2, TRUE, 2, 19, TRUE);
INSERT INTO `items` VALUES (DEFAULT, 'Item3', NULL, 'Description of item 3', 3, TRUE, 6, 11, TRUE);
INSERT INTO `items` VALUES (DEFAULT, 'Item4', NULL, 'Description of item 4', 3, TRUE, 12, 11, FALSE);

-- Past loans
INSERT INTO `loans` VALUES (DEFAULT, 2, 2, '2015-01-12', '2015-01-24');
INSERT INTO `loans` VALUES (DEFAULT, 2, 3, '2015-01-09', '2015-01-19');

-- Items currently borrowed
INSERT INTO `loans` VALUES (DEFAULT, 3, 1, '2015-01-20', NULL);

-- Commit
COMMIT;
