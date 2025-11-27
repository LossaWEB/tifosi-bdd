-- ==========================================
-- 03_requetes_tifosi.sql
-- Requêtes de test sur la base Tifosi
-- ==========================================

USE tifosi;

-- ------------------------------------------------
-- Requête 1
-- But : Afficher la liste des noms des focaccias
--       par ordre alphabétique croissant.
-- Résultat attendu (8 lignes) :
--   Américaine
--   Emmentalaccia
--   Gorgonzollaccia
--   Hawaienne
--   Mozaccia
--   Paysanne
--   Raclaccia
--   Tradizione
-- ------------------------------------------------
SELECT nom
FROM focaccia
ORDER BY nom ASC;

-- ------------------------------------------------
-- Requête 2
-- But : Afficher le nombre total d'ingrédients.
-- Résultat attendu : 25
-- ------------------------------------------------
SELECT COUNT(*) AS nb_ingredients
FROM ingredient;

-- ------------------------------------------------
-- Requête 3
-- But : Afficher le prix moyen des focaccias.
-- Résultat attendu : 10.375 (≈ 10.38)
-- ------------------------------------------------
SELECT AVG(prix) AS prix_moyen
FROM focaccia;

-- ------------------------------------------------
-- Requête 4
-- But : Afficher la liste des boissons avec leur
--       marque, triée par nom de boisson.
-- ------------------------------------------------
SELECT b.nom AS nom_boisson,
       m.nom AS marque
FROM boisson b
JOIN marque m ON b.id_marque = m.id_marque
ORDER BY b.nom;

-- ------------------------------------------------
-- Requête 5
-- But : Afficher la liste des ingrédients pour
--       une "Raclaccia".
-- ------------------------------------------------
SELECT i.nom AS ingredient
FROM focaccia f
JOIN focaccia_ingredient fi ON f.id_focaccia = fi.id_focaccia
JOIN ingredient i           ON fi.id_ingredient = i.id_ingredient
WHERE f.nom = 'Raclaccia'
ORDER BY i.nom;

-- ------------------------------------------------
-- Requête 6
-- But : Afficher le nom et le nombre d'ingrédients
--       pour chaque focaccia.
-- ------------------------------------------------
SELECT f.nom,
       COUNT(DISTINCT fi.id_ingredient) AS nb_ingredients
FROM focaccia f
LEFT JOIN focaccia_ingredient fi
       ON f.id_focaccia = fi.id_focaccia
GROUP BY f.id_focaccia, f.nom
ORDER BY f.nom;

-- ------------------------------------------------
-- Requête 7
-- But : Afficher le nom de la focaccia qui a le
--       plus d'ingrédients.
-- ------------------------------------------------
SELECT f.nom,
       COUNT(DISTINCT fi.id_ingredient) AS nb_ingredients
FROM focaccia f
JOIN focaccia_ingredient fi
     ON f.id_focaccia = fi.id_focaccia
GROUP BY f.id_focaccia, f.nom
ORDER BY nb_ingredients DESC
LIMIT 1;

-- ------------------------------------------------
-- Requête 8
-- But : Afficher la liste des focaccias qui
--       contiennent de l'ail.
-- ------------------------------------------------
SELECT DISTINCT f.nom
FROM focaccia f
JOIN focaccia_ingredient fi ON f.id_focaccia = fi.id_focaccia
JOIN ingredient i           ON fi.id_ingredient = i.id_ingredient
WHERE i.nom = 'Ail'
ORDER BY f.nom;

-- ------------------------------------------------
-- Requête 9
-- But : Afficher la liste des ingrédients
--       inutilisés (jamais utilisés).
-- ------------------------------------------------
SELECT i.nom
FROM ingredient i
LEFT JOIN focaccia_ingredient fi
       ON i.id_ingredient = fi.id_ingredient
WHERE fi.id_ingredient IS NULL
ORDER BY i.nom;

-- ------------------------------------------------
-- Requête 10
-- But : Afficher la liste des focaccias qui
--       n'ont pas de champignons.
-- ------------------------------------------------
SELECT DISTINCT f.nom
FROM focaccia f
WHERE f.id_focaccia NOT IN (
    SELECT fi.id_focaccia
    FROM focaccia_ingredient fi
    JOIN ingredient i ON fi.id_ingredient = i.id_ingredient
    WHERE i.nom = 'Champignon'
)
ORDER BY f.nom;
