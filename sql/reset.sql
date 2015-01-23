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
  imagePath         VARCHAR(1000)          DEFAULT NULL,
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
-- Insert example values
--

INSERT INTO `users` VALUES (DEFAULT, 'admin', 'admin', 'Mr Admin', 'admin@admin.admin', 0, TRUE);
INSERT INTO `users` VALUES (DEFAULT, 'Ribesg', 'mdp', 'Gael Ribes', 'ribesg@yahoo.fr', 11, TRUE);
INSERT INTO `users` VALUES (DEFAULT, 'Phalexei', 'mdp', 'Tom André-Poyaud', 'tandrepoyaud@gmail.com', 5, TRUE);
INSERT INTO `users` VALUES (DEFAULT, 'pacaletx', 'mdp', 'Xavier Pacalet', 'x.pacalet@gmail.com', 5, TRUE);
INSERT INTO `users` VALUES (DEFAULT, 'momo', 'mdp', 'Mohammed Taha El Ahmar', 'med.taha.elahmar@gmail.com', 2, TRUE);
INSERT INTO `users` VALUES (DEFAULT, 'laforesy', 'mdp', 'Yann Laforest', 'laforest.yann@gmail.com', 2, TRUE);
INSERT INTO `users` VALUES (DEFAULT, 'levillar', 'mdp', 'Remi Levillain', 'levillain.remi@gmail.com', 10, TRUE);
INSERT INTO `users` VALUES (DEFAULT, 'bienners', 'mdp', 'Solenne Bienner', 'solenne.bienner@gmail.com', 0, TRUE);
INSERT INTO `users` VALUES (DEFAULT, 'test', 'test', 'Test', 'test@test.test', 5, FALSE);

INSERT INTO `items` VALUES (DEFAULT, 'Item1', NULL, 'Description of item 1', 7, FALSE, 1, 8, TRUE);
INSERT INTO `items` VALUES (DEFAULT, 'Item2', NULL, 'Description of item 2', 2, TRUE, 2, 19, TRUE);
INSERT INTO `items` VALUES (DEFAULT, 'Item3', NULL, 'Description of item 3', 5, TRUE, 3, 11, FALSE);
INSERT INTO `items` VALUES (DEFAULT, 'Item4', NULL, 'Description of item 4', 2, FALSE, 4, 14, TRUE);
INSERT INTO `items` VALUES (DEFAULT, 'Item5', NULL, 'Description of item 5', 7, TRUE, 5, 7, FALSE);
INSERT INTO `items` VALUES (DEFAULT, 'Item6', NULL, 'Description of item 6', 4, TRUE, 6, 8, FALSE);
INSERT INTO `items` VALUES (DEFAULT, 'Item7', NULL, 'Description of item 7', 3, FALSE, 7, 5, TRUE);
INSERT INTO `items` VALUES (DEFAULT, 'Item8', NULL, 'Description of item 8', 6, TRUE, 8, 13, FALSE);
INSERT INTO `items` VALUES (DEFAULT, 'Item9', NULL, 'Description of item 9', 4, TRUE, 9, 6, FALSE);
INSERT INTO `items` VALUES (DEFAULT, 'Item10', NULL, 'Description of item 10', 4, TRUE, 10, 14, FALSE);
INSERT INTO `items` VALUES (DEFAULT, 'Item11', NULL, 'Description of item 11', 2, TRUE, 11, 18, TRUE);
INSERT INTO `items` VALUES (DEFAULT, 'Item12', NULL, 'Description of item 12', 4, TRUE, 12, 17, FALSE);
INSERT INTO `items` VALUES (DEFAULT, 'Item13', NULL, 'Description of item 13', 7, TRUE, 13, 13, TRUE);
INSERT INTO `items` VALUES (DEFAULT, 'Item14', NULL, 'Description of item 14', 2, TRUE, 14, 5, FALSE);
INSERT INTO `items` VALUES (DEFAULT, 'Item15', NULL, 'Description of item 15', 5, FALSE, 15, 19, TRUE);
INSERT INTO `items` VALUES (DEFAULT, 'Item16', NULL, 'Description of item 16', 3, TRUE, 16, 6, FALSE);
INSERT INTO `items` VALUES (DEFAULT, 'Item17', NULL, 'Description of item 17', 7, TRUE, 17, 8, FALSE);
INSERT INTO `items` VALUES (DEFAULT, 'Item18', NULL, 'Description of item 18', 7, TRUE, 18, 10, FALSE);
INSERT INTO `items` VALUES (DEFAULT, 'Item19', NULL, 'Description of item 19', 3, FALSE, 19, 10, TRUE);
INSERT INTO `items` VALUES (DEFAULT, 'Item20', NULL, 'Description of item 20', 4, FALSE, 20, 12, TRUE);
INSERT INTO `items` VALUES (DEFAULT, 'Item21', NULL, 'Description of item 21', 2, TRUE, 21, 8, FALSE);
INSERT INTO `items` VALUES (DEFAULT, 'Item22', NULL, 'Description of item 22', 3, TRUE, 22, 10, FALSE);
INSERT INTO `items` VALUES (DEFAULT, 'Item23', NULL, 'Description of item 23', 6, FALSE, 23, 19, TRUE);
INSERT INTO `items` VALUES (DEFAULT, 'Item24', NULL, 'Description of item 24', 3, TRUE, 24, 18, FALSE);
INSERT INTO `items` VALUES (DEFAULT, 'Item25', NULL, 'Description of item 25', 3, TRUE, 25, 18, FALSE);
INSERT INTO `items` VALUES (DEFAULT, 'Item26', NULL, 'Description of item 26', 7, TRUE, 26, 12, FALSE);
INSERT INTO `items` VALUES (DEFAULT, 'Item27', NULL, 'Description of item 27', 7, FALSE, 27, 18, TRUE);
INSERT INTO `items` VALUES (DEFAULT, 'Item28', NULL, 'Description of item 28', 7, TRUE, 28, 9, TRUE);
INSERT INTO `items` VALUES (DEFAULT, 'Item29', NULL, 'Description of item 29', 5, TRUE, 29, 5, TRUE);
INSERT INTO `items` VALUES (DEFAULT, 'Item30', NULL, 'Description of item 30', 2, FALSE, 30, 12, TRUE);
INSERT INTO `items` VALUES (DEFAULT, 'Item31', NULL, 'Description of item 31', 4, FALSE, 31, 17, TRUE);
INSERT INTO `items` VALUES (DEFAULT, 'Item32', NULL, 'Description of item 32', 7, TRUE, 32, 15, FALSE);
INSERT INTO `items` VALUES (DEFAULT, 'Item33', NULL, 'Description of item 33', 7, TRUE, 33, 16, TRUE);
INSERT INTO `items` VALUES (DEFAULT, 'Item34', NULL, 'Description of item 34', 7, TRUE, 34, 6, TRUE);
INSERT INTO `items` VALUES (DEFAULT, 'Item35', NULL, 'Description of item 35', 3, TRUE, 35, 8, FALSE);
INSERT INTO `items` VALUES (DEFAULT, 'Item36', NULL, 'Description of item 36', 5, TRUE, 36, 16, FALSE);
INSERT INTO `items` VALUES (DEFAULT, 'Item37', NULL, 'Description of item 37', 2, FALSE, 37, 17, TRUE);
INSERT INTO `items` VALUES (DEFAULT, 'Item38', NULL, 'Description of item 38', 7, FALSE, 38, 13, TRUE);
INSERT INTO `items` VALUES (DEFAULT, 'Item39', NULL, 'Description of item 39', 5, TRUE, 39, 19, TRUE);
INSERT INTO `items` VALUES (DEFAULT, 'Item40', NULL, 'Description of item 40', 2, TRUE, 40, 8, FALSE);
INSERT INTO `items` VALUES (DEFAULT, 'Item41', NULL, 'Description of item 41', 2, TRUE, 41, 10, FALSE);
INSERT INTO `items` VALUES (DEFAULT, 'Item42', NULL, 'Description of item 42', 6, TRUE, 42, 7, TRUE);
INSERT INTO `items` VALUES (DEFAULT, 'Item43', NULL, 'Description of item 43', 3, FALSE, 43, 12, TRUE);
INSERT INTO `items` VALUES (DEFAULT, 'Item44', NULL, 'Description of item 44', 2, TRUE, 44, 12, FALSE);
INSERT INTO `items` VALUES (DEFAULT, 'Item45', NULL, 'Description of item 45', 2, TRUE, 45, 14, TRUE);
INSERT INTO `items` VALUES (DEFAULT, 'Item46', NULL, 'Description of item 46', 2, TRUE, 46, 19, FALSE);
INSERT INTO `items` VALUES (DEFAULT, 'Item47', NULL, 'Description of item 47', 6, FALSE, 47, 12, TRUE);
INSERT INTO `items` VALUES (DEFAULT, 'Item48', NULL, 'Description of item 48', 6, TRUE, 48, 13, FALSE);
INSERT INTO `items` VALUES (DEFAULT, 'Item49', NULL, 'Description of item 49', 7, TRUE, 49, 11, FALSE);
INSERT INTO `items` VALUES (DEFAULT, 'Item50', NULL, 'Description of item 50', 6, FALSE, 50, 18, TRUE);

-- Past loans
INSERT INTO `loans` VALUES (DEFAULT, 5, 27, '2015-01-01', '2015-01-20');
INSERT INTO `loans` VALUES (DEFAULT, 6, 15, '2015-01-01', '2015-01-20');
INSERT INTO `loans` VALUES (DEFAULT, 3, 13, '2015-01-01', '2015-01-20');
INSERT INTO `loans` VALUES (DEFAULT, 2, 2, '2015-01-01', '2015-01-20');
INSERT INTO `loans` VALUES (DEFAULT, 4, 11, '2015-01-01', '2015-01-20');
INSERT INTO `loans` VALUES (DEFAULT, 3, 42, '2015-01-01', '2015-01-20');
INSERT INTO `loans` VALUES (DEFAULT, 4, 28, '2015-01-01', '2015-01-20');
INSERT INTO `loans` VALUES (DEFAULT, 4, 7, '2015-01-01', '2015-01-20');
INSERT INTO `loans` VALUES (DEFAULT, 5, 4, '2015-01-01', '2015-01-20');
INSERT INTO `loans` VALUES (DEFAULT, 3, 38, '2015-01-01', '2015-01-20');
INSERT INTO `loans` VALUES (DEFAULT, 5, 1, '2015-01-01', '2015-01-20');
INSERT INTO `loans` VALUES (DEFAULT, 4, 37, '2015-01-01', '2015-01-20');
INSERT INTO `loans` VALUES (DEFAULT, 5, 29, '2015-01-01', '2015-01-20');
INSERT INTO `loans` VALUES (DEFAULT, 3, 31, '2015-01-01', '2015-01-20');
INSERT INTO `loans` VALUES (DEFAULT, 4, 50, '2015-01-01', '2015-01-20');

-- Items currently borrowed
INSERT INTO `loans` VALUES (DEFAULT, 5, 1, '2015-01-12', NULL);
INSERT INTO `loans` VALUES (DEFAULT, 5, 7, '2015-01-15', NULL);
INSERT INTO `loans` VALUES (DEFAULT, 5, 4, '2015-01-17', NULL);
INSERT INTO `loans` VALUES (DEFAULT, 3, 15, '2015-01-14', NULL);
INSERT INTO `loans` VALUES (DEFAULT, 4, 23, '2015-01-15', NULL);
INSERT INTO `loans` VALUES (DEFAULT, 6, 43, '2015-01-07', NULL);
INSERT INTO `loans` VALUES (DEFAULT, 2, 47, '2015-01-11', NULL);
INSERT INTO `loans` VALUES (DEFAULT, 3, 50, '2015-01-10', NULL);
INSERT INTO `loans` VALUES (DEFAULT, 3, 30, '2015-01-01', NULL);
INSERT INTO `loans` VALUES (DEFAULT, 6, 31, '2015-01-10', NULL);
INSERT INTO `loans` VALUES (DEFAULT, 2, 27, '2015-01-07', NULL);
INSERT INTO `loans` VALUES (DEFAULT, 6, 37, '2015-01-10', NULL);
INSERT INTO `loans` VALUES (DEFAULT, 7, 19, '2015-01-10', NULL);
INSERT INTO `loans` VALUES (DEFAULT, 7, 20, '2015-01-05', NULL);
INSERT INTO `loans` VALUES (DEFAULT, 2, 38, '2015-01-11', NULL);

-- Commit
COMMIT;
