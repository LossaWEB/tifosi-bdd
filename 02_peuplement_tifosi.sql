-- ==========================================
-- 02_peuplement_tifosi.sql
-- Insertion des données de test
-- ==========================================

USE tifosi;

-- =========================
-- 1. MARQUES  (marque.xlsx)
-- =========================
INSERT INTO marque (id_marque, nom) VALUES
  (1, 'Coca-cola'),
  (2, 'Cristalline'),
  (3, 'Monster'),
  (4, 'Pepsico');

-- =========================
-- 2. INGREDIENTS (ingredient.xlsx)
-- =========================
INSERT INTO ingredient (id_ingredient, nom) VALUES
  (1, 'Ail'),
  (2, 'Ananas'),
  (3, 'Artichaut'),
  (4, 'Bacon'),
  (5, 'Base Tomate'),
  (6, 'Base crème'),
  (7, 'Champignon'),
  (8, 'Chevre'),
  (9, 'Cresson'),
  (10, 'Emmental'),
  (11, 'Gorgonzola'),
  (12, 'Jambon cuit'),
  (13, 'Jambon fumé'),
  (14, 'Oeuf'),
  (15, 'Oignon'),
  (16, 'Olive noire'),
  (17, 'Olive verte'),
  (18, 'Parmesan'),
  (19, 'Piment'),
  (20, 'Poivre'),
  (21, 'Pomme de terre'),
  (22, 'Raclette'),
  (23, 'Salami'),
  (24, 'Tomate cerise'),
  (25, 'Mozarella');

-- =========================
-- 3. FOCACCIAS (focaccia.xlsx)
-- =========================
INSERT INTO focaccia (id_focaccia, nom, prix) VALUES
  (1, 'Mozaccia',        9.8),
  (2, 'Gorgonzollaccia', 10.8),
  (3, 'Raclaccia',       8.9),
  (4, 'Emmentalaccia',   9.8),
  (5, 'Tradizione',      8.9),
  (6, 'Hawaienne',       11.2),
  (7, 'Américaine',      10.8),
  (8, 'Paysanne',        12.8);

-- =========================
-- 4. BOISSONS (boisson.xlsx)
-- =========================
INSERT INTO boisson (id_boisson, nom, id_marque) VALUES
  (1,  'Coca-cola zéro',           1),
  (2,  'Coca-cola original',       1),
  (3,  'Fanta citron',             1),
  (4,  'Fanta orange',             1),
  (5,  'Capri-sun',                1),
  (6,  'Pepsi',                    4),
  (7,  'Pepsi Max Zéro',           4),
  (8,  'Lipton zéro citron',       4),
  (9,  'Lipton Peach',             4),
  (10, 'Monster energy ultra gold',3),
  (11, 'Monster energy ultra blue',3),
  (12, 'Eau de source',            2);

-- =========================
-- 5. COMPOSITION FOCACCIA / INGREDIENT
--    (relation "comprend" -> focaccia_ingredient)
--    Quantité mise à 1 (non utilisée dans les requêtes)
-- =========================

-- Mozaccia (id_focaccia = 1)
INSERT INTO focaccia_ingredient (id_focaccia, id_ingredient, quantite)
SELECT 1, id_ingredient, 1
FROM ingredient
WHERE nom IN (
  'Base Tomate', 'Mozarella', 'Cresson', 'Jambon fumé',
  'Ail', 'Artichaut', 'Champignon', 'Parmesan',
  'Poivre', 'Olive noire'
);

-- Gorgonzollaccia (id_focaccia = 2)
INSERT INTO focaccia_ingredient (id_focaccia, id_ingredient, quantite)
SELECT 2, id_ingredient, 1
FROM ingredient
WHERE nom IN (
  'Base Tomate', 'Gorgonzola', 'Cresson', 'Ail',
  'Champignon', 'Parmesan', 'Poivre', 'Olive noire'
);

-- Raclaccia (id_focaccia = 3)
INSERT INTO focaccia_ingredient (id_focaccia, id_ingredient, quantite)
SELECT 3, id_ingredient, 1
FROM ingredient
WHERE nom IN (
  'Base Tomate', 'Raclette', 'Cresson', 'Ail',
  'Champignon', 'Parmesan', 'Poivre'
);

-- Emmentalaccia (id_focaccia = 4)
INSERT INTO focaccia_ingredient (id_focaccia, id_ingredient, quantite)
SELECT 4, id_ingredient, 1
FROM ingredient
WHERE nom IN (
  'Base crème', 'Emmental', 'Cresson',
  'Champignon', 'Parmesan', 'Poivre', 'Oignon'
);

-- Tradizione (id_focaccia = 5)
INSERT INTO focaccia_ingredient (id_focaccia, id_ingredient, quantite)
SELECT 5, id_ingredient, 1
FROM ingredient
WHERE nom IN (
  'Base Tomate', 'Mozarella', 'Cresson', 'Jambon cuit',
  'Champignon', 'Parmesan', 'Poivre',
  'Olive noire', 'Olive verte'
);

-- Hawaienne (id_focaccia = 6)
INSERT INTO focaccia_ingredient (id_focaccia, id_ingredient, quantite)
SELECT 6, id_ingredient, 1
FROM ingredient
WHERE nom IN (
  'Base Tomate', 'Mozarella', 'Cresson',
  'Bacon', 'Ananas', 'Piment',
  'Parmesan', 'Poivre', 'Olive noire'
);

-- Américaine (id_focaccia = 7)
INSERT INTO focaccia_ingredient (id_focaccia, id_ingredient, quantite)
SELECT 7, id_ingredient, 1
FROM ingredient
WHERE nom IN (
  'Base Tomate', 'Mozarella', 'Cresson',
  'Bacon', 'Pomme de terre',
  'Parmesan', 'Poivre', 'Olive noire'
);

-- Paysanne (id_focaccia = 8)
INSERT INTO focaccia_ingredient (id_focaccia, id_ingredient, quantite)
SELECT 8, id_ingredient, 1
FROM ingredient
WHERE nom IN (
  'Base crème', 'Chevre', 'Cresson', 'Pomme de terre',
  'Jambon fumé', 'Ail', 'Artichaut', 'Champignon',
  'Parmesan', 'Poivre', 'Olive noire', 'Oeuf'
);
