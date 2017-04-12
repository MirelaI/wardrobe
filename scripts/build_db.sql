CREATE DATABASE wardrobe
  DEFAULT CHARACTER SET utf8
  DEFAULT COLLATE utf8_general_ci;

USE wardrobe;

CREATE TABLE clothes (
  id INT NOT NULL auto_increment,
  name VARCHAR(255) NOT NULL,
  category VARCHAR(255),
    PRIMARY KEY (id)
) ENGINE=InnoDB CHARACTER SET utf8 COLLATE utf8_general_ci;

CREATE TABLE outfits (
  id INT NOT NULL auto_increment,
  tag VARCHAR(255),
  description text DEFAULT NULL,
  PRIMARY KEY (id)
) ENGINE=InnoDB CHARACTER SET utf8 COLLATE utf8_general_ci;

CREATE TABLE clothes_tags (
  cloth_id INT NOT NULL,
  tag_id INT NOT NULL,
  FOREIGN KEY (cloth_id) 
      REFERENCES clothes(id)
      ON DELETE CASCADE,
  FOREIGN KEY (tag_id) 
      REFERENCES outfits(id)
      ON DELETE CASCADE
)  ENGINE=InnoDB;

