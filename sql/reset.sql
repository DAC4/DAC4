-- Destroy database if it exists
DROP DATABASE IF EXISTS `troc_box`;

-- Database creation and selection
CREATE DATABASE `troc_box`;
USE `troc_box`;

-- Create tables in the database
CREATE TABLE `users`
(
  `id`       BIGINT       NOT NULL AUTO_INCREMENT,
  `login`    VARCHAR(30)  NOT NULL UNIQUE,
  `password` VARCHAR(45)  NOT NULL,
  `name`     VARCHAR(120) NOT NULL,
  `email`    VARCHAR(55)  NOT NULL,

  PRIMARY KEY (`id`)
);

-- Insert base values
INSERT INTO `users` VALUES (0, 'admin', 'Mr Admin', 'admin', 'admin@admin.admin');
INSERT INTO `users` VALUES (1, 'Ribesg', 'Gael Ribes', 'mdp', 'ribesg@yahoo.fr');
INSERT INTO `users` VALUES (2, 'Phalexei', 'Tom André-Poyaud', 'mdp', 'tandrepoyaud@gmail.com');
INSERT INTO `users` VALUES (3, 'pacaletx', 'Xavier Pacalet', 'mdp', 'x.pacalet@gmail.com');
INSERT INTO `users` VALUES (4, 'momo', 'Mohammed Taha El Ahmar', 'mdp', 'med.taha.elahmar@gmail.com');
INSERT INTO `users` VALUES (5, 'laforesy', 'Yann Laforest', 'mdp', 'laforest.yann@gmail.com');
INSERT INTO `users` VALUES (6, 'levillar', 'Remi Levillain', 'mdp', 'levillain.remi@gmail.com');
INSERT INTO `users` VALUES (7, 'bienners', 'Solenne Bienner', 'mdp', 'solenne.bienner@gmail.com');

-- Commit
COMMIT;
