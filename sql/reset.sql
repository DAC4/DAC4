-- Destroy database if it exists
DROP DATABASE IF EXISTS troc_box;

-- Database creation and selection
CREATE DATABASE troc_box;
USE troc_box;

-- Create tables in the database
CREATE TABLE users
(
  id       VARCHAR(30)  NOT NULL,
  name     VARCHAR(120) NULL,
  password VARCHAR(45)  NULL,
  email    VARCHAR(55)  NULL,

  PRIMARY KEY (id)
);

CREATE TABLE groups
(
  id      VARCHAR(30) NOT NULL,
  user_id VARCHAR(30) NULL,

  PRIMARY KEY (id),
  INDEX USRGPFK00_idx (user_id ASC),

  CONSTRAINT USRGPFK00 FOREIGN KEY (user_id) REFERENCES users (id)
);

CREATE TABLE Guest (
  id   BIGINT      NOT NULL,
  name VARCHAR(30) NULL,

  PRIMARY KEY (id)
);

-- Insert base values
INSERT INTO users VALUES ('admin', 'Mr Admin', 'admin', 'admin@admin.admin');
INSERT INTO groups VALUES ('all', 'admin');

INSERT INTO Guest VALUES (1, 'Toto');
INSERT INTO Guest VALUES (2, 'Yann');
INSERT INTO Guest VALUES (3, 'Yann aussi');
INSERT INTO Guest VALUES (4, 'Yann encore');
INSERT INTO Guest VALUES (5, 'Yannou');
INSERT INTO Guest VALUES (6, 'Yhahn');

-- Commit
COMMIT;
