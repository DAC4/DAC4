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
INSERT INTO `users` VALUES (DEFAULT, 'admin', 'admin', 'Mr Admin', 'admin@admin.admin');
INSERT INTO `users` VALUES (DEFAULT, 'Ribesg', 'mdp', 'Gael Ribes', 'ribesg@yahoo.fr');
INSERT INTO `users` VALUES (DEFAULT, 'Phalexei', 'mdp', 'Tom André-Poyaud', 'tandrepoyaud@gmail.com');
INSERT INTO `users` VALUES (DEFAULT, 'pacaletx', 'mdp', 'Xavier Pacalet', 'x.pacalet@gmail.com');
INSERT INTO `users` VALUES (DEFAULT, 'momo', 'mdp', 'Mohammed Taha El Ahmar', 'med.taha.elahmar@gmail.com');
INSERT INTO `users` VALUES (DEFAULT, 'laforesy', 'mdp', 'Yann Laforest', 'laforest.yann@gmail.com');
INSERT INTO `users` VALUES (DEFAULT, 'levillar', 'mdp', 'Remi Levillain', 'levillain.remi@gmail.com');
INSERT INTO `users` VALUES (DEFAULT, 'bienners', 'mdp', 'Solenne Bienner', 'solenne.bienner@gmail.com');

-- Commit
COMMIT;
