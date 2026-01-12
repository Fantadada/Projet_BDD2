-- ============================================================
-- 1. TABLES DE RÉFÉRENCE (PARENTS)
-- ============================================================
SELECT * FROM ETABLISSEMENT;
SELECT * FROM PARTENAIRE_PARTICIPANT;
SELECT * FROM LABORATOIRE_EXTERNE;
SELECT * FROM CONFERENCE;
SELECT * FROM EVENEMENT;
SELECT * FROM PERSONNEL;

-- ============================================================
-- 2. TABLES SPÉCIALISÉES (ENFANTS)
-- ============================================================
-- Note : Vérifiez bien que les clés étrangères (id_Personnel_fk) correspondent
SELECT * FROM SCIENTIFIQUE;
SELECT * FROM DOCTORANT;
SELECT * FROM CHERCHEUR;
SELECT * FROM CHERCHEUR_ENSEIGNANT;

SELECT * FROM AUTEUR_EXTERNE;
SELECT * FROM PUBLICATION;

-- Spécialisation des événements
SELECT * FROM CONGRES;
SELECT * FROM PORTES_OUVERTES;

-- Les projets
SELECT * FROM PROJET_DE_RECHERCHE;

-- ============================================================
-- 3. TABLES DE JONCTION (RELATIONS N-N)
-- ============================================================
-- Ces tables ne contiennent souvent que des ID, c'est normal.
SELECT * FROM ENCADREMENT;
SELECT * FROM PARTICIPE_PROJET;
SELECT * FROM PROJET_PARTENAIRE;
SELECT * FROM AUTEUR_INTERNE_PUBLICATION;
SELECT * FROM AUTEUR_EXTERNE_PUBLICATION;
SELECT * FROM PRESIDE_CONGRES;
SELECT * FROM PARTICIPE_JPO;