-- Database creation and selection
CREATE DATABASE troc_box;
USE troc_box;

-- Create tables in the database
CREATE TABLE users
(
  USID VARCHAR(30)  NOT NULL,
  USNM VARCHAR(120) NULL,
  PASS VARCHAR(45)  NULL,
  EMAL VARCHAR(55)  NULL,

  PRIMARY KEY (USID)
);

CREATE TABLE groups
(
  USGP VARCHAR(30) NOT NULL,
  USID VARCHAR(30) NULL,

  PRIMARY KEY (USGP),
  INDEX USRGPFK00_idx (USID ASC),

  CONSTRAINT USRGPFK00 FOREIGN KEY (USID) REFERENCES users (USID)
);

-- Insert base values
INSERT INTO users VALUES ('admin', 'Mr Admin', 'admin', 'admin@admin.admin');
INSERT INTO groups VALUES ('all', 'admin');

-- Commit
COMMIT;
