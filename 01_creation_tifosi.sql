-- ==========================================
-- 01_creation_tifosi.sql
-- Création de la base de données Tifosi
-- ==========================================

-- On supprime l'ancienne base si elle existe
DROP DATABASE IF EXISTS tifosi;

-- Création de la base
CREATE DATABASE tifosi
  CHARACTER SET utf8mb4
  COLLATE utf8mb4_unicode_ci;

-- Utilisation de la base
USE tifosi;

-- ==========================================
-- Création de l'utilisateur "tifosi"
-- (à exécuter avec un compte ayant les droits admin)
-- ==========================================
CREATE USER IF NOT EXISTS 'tifosi'@'localhost'
  IDENTIFIED BY 'motdepasse';

GRANT ALL PRIVILEGES ON tifosi.* TO 'tifosi'@'localhost';
FLUSH PRIVILEGES;

-- ==========================================
-- Création des tables
-- ==========================================

-- Table CLIENT
CREATE TABLE client (
  id_client   INT AUTO_INCREMENT PRIMARY KEY,
  nom         VARCHAR(50)  NOT NULL,
  email       VARCHAR(150) NOT NULL UNIQUE,
  code_postal INT          NOT NULL
) ENGINE=InnoDB;

-- Table MARQUE
CREATE TABLE marque (
  id_marque INT PRIMARY KEY,
  nom       VARCHAR(50) NOT NULL UNIQUE
) ENGINE=InnoDB;

-- Table INGREDIENT
CREATE TABLE ingredient (
  id_ingredient INT PRIMARY KEY,
  nom           VARCHAR(50) NOT NULL UNIQUE
) ENGINE=InnoDB;

-- Table FOCACCIA
CREATE TABLE focaccia (
  id_focaccia INT PRIMARY KEY,
  nom         VARCHAR(50)  NOT NULL,
  prix        DECIMAL(5,2) NOT NULL
) ENGINE=InnoDB;

-- Table BOISSON
CREATE TABLE boisson (
  id_boisson INT PRIMARY KEY,
  nom        VARCHAR(50) NOT NULL,
  id_marque  INT         NOT NULL,
  CONSTRAINT fk_boisson_marque
    FOREIGN KEY (id_marque) REFERENCES marque(id_marque)
      ON UPDATE CASCADE ON DELETE RESTRICT
) ENGINE=InnoDB;

-- Table MENU (chaque menu contient UNE focaccia)
CREATE TABLE menu (
  id_menu     INT PRIMARY KEY,
  nom         VARCHAR(50)  NOT NULL,
  prix        DECIMAL(5,2) NOT NULL,
  id_focaccia INT          NOT NULL,
  CONSTRAINT fk_menu_focaccia
    FOREIGN KEY (id_focaccia) REFERENCES focaccia(id_focaccia)
      ON UPDATE CASCADE ON DELETE RESTRICT
) ENGINE=InnoDB;

-- Table d'association MENU_BOISSON (relation "contient")
CREATE TABLE menu_boisson (
  id_menu    INT NOT NULL,
  id_boisson INT NOT NULL,
  PRIMARY KEY (id_menu, id_boisson),
  CONSTRAINT fk_mb_menu
    FOREIGN KEY (id_menu) REFERENCES menu(id_menu)
      ON UPDATE CASCADE ON DELETE CASCADE,
  CONSTRAINT fk_mb_boisson
    FOREIGN KEY (id_boisson) REFERENCES boisson(id_boisson)
      ON UPDATE CASCADE ON DELETE RESTRICT
) ENGINE=InnoDB;

-- Table d'association FOCACCIA_INGREDIENT (relation "comprend")
CREATE TABLE focaccia_ingredient (
  id_focaccia   INT NOT NULL,
  id_ingredient INT NOT NULL,
  quantite      INT NOT NULL DEFAULT 1,
  PRIMARY KEY (id_focaccia, id_ingredient),
  CONSTRAINT fk_fi_focaccia
    FOREIGN KEY (id_focaccia) REFERENCES focaccia(id_focaccia)
      ON UPDATE CASCADE ON DELETE CASCADE,
  CONSTRAINT fk_fi_ingredient
    FOREIGN KEY (id_ingredient) REFERENCES ingredient(id_ingredient)
      ON UPDATE CASCADE ON DELETE RESTRICT
) ENGINE=InnoDB;

-- Table ACHAT (relation "achète" entre client et menu)
CREATE TABLE achat (
  id_client  INT  NOT NULL,
  id_menu    INT  NOT NULL,
  date_achat DATE NOT NULL,
  PRIMARY KEY (id_client, id_menu, date_achat),
  CONSTRAINT fk_achat_client
    FOREIGN KEY (id_client) REFERENCES client(id_client)
      ON UPDATE CASCADE ON DELETE CASCADE,
  CONSTRAINT fk_achat_menu
    FOREIGN KEY (id_menu) REFERENCES menu(id_menu)
      ON UPDATE CASCADE ON DELETE RESTRICT
) ENGINE=InnoDB;
