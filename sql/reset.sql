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
INSERT INTO `users` VALUES (DEFAULT, 'admin', 'Mr Admin', 'admin', 'admin@admin.admin');
INSERT INTO `users` VALUES (DEFAULT, 'Ribesg', 'Gael Ribes', 'mdp', 'ribesg@yahoo.fr');
INSERT INTO `users` VALUES (DEFAULT, 'Phalexei', 'Tom André-Poyaud', 'mdp', 'tandrepoyaud@gmail.com');
INSERT INTO `users` VALUES (DEFAULT, 'pacaletx', 'Xavier Pacalet', 'mdp', 'x.pacalet@gmail.com');
INSERT INTO `users` VALUES (DEFAULT, 'momo', 'Mohammed Taha El Ahmar', 'mdp', 'med.taha.elahmar@gmail.com');
INSERT INTO `users` VALUES (DEFAULT, 'laforesy', 'Yann Laforest', 'mdp', 'laforest.yann@gmail.com');
INSERT INTO `users` VALUES (DEFAULT, 'levillar', 'Remi Levillain', 'mdp', 'levillain.remi@gmail.com');
INSERT INTO `users` VALUES (DEFAULT, 'bienners', 'Solenne Bienner', 'mdp', 'solenne.bienner@gmail.com');

-- Commit
COMMIT;
