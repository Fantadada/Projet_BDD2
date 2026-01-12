/* 
Auteur : Damien CAPPELLINI
Projet BDD 2 - 2025/2026
*/

-- 0. NETTOYAGE 
TRUNCATE TABLE 
    ETABLISSEMENT, PARTENAIRE_PARTICIPANT, LABORATOIRE_EXTERNE, CONFERENCE, EVENEMENT, 
    PERSONNEL, SCIENTIFIQUE, DOCTORANT, AUTEUR_EXTERNE, PUBLICATION, 
    CONGRES, PORTES_OUVERTES, CHERCHEUR, CHERCHEUR_ENSEIGNANT, PROJET_DE_RECHERCHE, 
    ENCADREMENT, PARTICIPE_PROJET, PROJET_PARTENAIRE, AUTEUR_INTERNE_PUBLICATION, 
    AUTEUR_EXTERNE_PUBLICATION, PRESIDE_CONGRES, PARTICIPE_JPO
CASCADE;

-- ============================================================
-- 1. Les tables "mère"
-- ============================================================

INSERT INTO ETABLISSEMENT (acronyme, nom, adEtablissement) VALUES 
('UPS', 'Université Paul Sabatier', '118 Route de Narbonne, 31062 Toulouse'),
('INSA', 'Institut National des Sciences Appliquées', '135 Avenue de Rangueil, 31400 Toulouse');

INSERT INTO PARTENAIRE_PARTICIPANT (id_Partenaire, nom, pays) VALUES 
(1, 'Airbus', 'France'), 
(2, 'Thales', 'France'), 
(3, 'DLR', 'Allemagne'), 
(4, 'NASA', 'USA');


INSERT INTO LABORATOIRE_EXTERNE (id_Labo, nomLabo, paysLabo) VALUES 
(1, 'MIT CSAIL', 'USA'),
(2, 'ETH Zurich', 'Suisse'),
(3, 'LIRMM', 'France'),
(4, 'Politecnico di Milano', 'Italie'),   -- Cible Jean Azi
(5, 'USC', 'Espagne'),                   -- Pays Classe A
(6, 'University of Tokyo', 'Japon'),     -- Pays Classe A
(7, 'Imperial College', 'Royaume-Uni'),  -- Cible Jean Azi
(8, 'Mila', 'Canada'),
(9, 'Tsinghua', 'Chine'),
(10, 'Stanford', 'USA'),                 -- Doublon USA pour gagner Req 7
(11, 'Berkeley', 'USA');                 -- Triplé USA pour gagner Req 7

INSERT INTO CONFERENCE (nomConf, classe_Conf) VALUES 
('ICRA', 'A*'), 
('IROS', 'A'), 
('Automatica', 'B'), 
('CVPR', 'A'), 
('NeurIPS', 'A*'), 
('ECCV', 'A'), 
('SmallTalk', 'C');

INSERT INTO EVENEMENT (id_Event, dateDeb, dateFin) VALUES 
(1, '2023-05-15', '2023-05-19'), 
(2, '2023-10-14', '2023-10-14');

-- ============================================================
-- 2. PERSONNEL
-- ============================================================

INSERT INTO PERSONNEL (id_Personnel, nomPerso, prenomPerso, birthday, adrPerso, recrutement) VALUES 
-- > scientifiques 
('s01', 'Dupont', 'Marie', '1980-04-12', 'Toulouse', '2005-09-01'),
('s02', 'Martin', 'Pierre', '1975-11-23', 'Toulouse', '2002-01-15'),
('s03', 'Azi', 'Jean', '1982-05-10', 'Toulouse', '2010-01-01'), -- Cible Req 1
('s04', 'Tesla', 'Nikola', '1856-07-10', 'USA', '2020-01-01'),
('s05', 'Hawk', 'Stephen', '1942-01-08', 'UK', '2015-09-01'),   -- Cible Req 3 (Inactif)
('s10', 'Fantome', 'Casper', '1990-01-01', 'Toulouse', '2023-01-01'), -- Cible Req 3 (Inactif)
('s11', 'Elite', 'Anna', '1985-05-05', 'Ramonville', '2015-06-01'),   -- Cible Req 5 (Que du A)
('s12', 'Bosseur', 'Tom', '1988-08-08', 'Toulouse', '2012-09-01'),

('s99', 'Universel', 'Dieu', '1900-01-01', 'Ciel', '1900-01-01'), -- Encadre TOUT LE MONDE

-- > Doctorants
('d001', 'Turing', 'Alan', '1995-06-23', 'Toulouse', '2023-01-01'),
('d02', 'Bernard', 'Sophie', '1998-06-30', 'Toulouse', '2022-10-01'),
('d03', 'Leroy', 'Lucas', '1999-02-14', 'Toulouse', '2023-10-01'),
('d04', 'Lovelace', 'Ada', '1990-12-10', 'London', '2019-09-01'),
('d10', 'Solo', 'Han', '1999-12-12', 'Crous', '2023-09-01'), -- Cible Req 4 (1 seul encadrant)
('d11', 'Duo', 'Marie', '2000-01-01', 'Toulouse', '2023-10-01'),
-- > Administratif
('adm01', 'Petit', 'Julie', '1985-08-09', 'Toulouse', '2010-03-01');

-- ============================================================
-- 3. HÉRITAGE & RÔLES
-- ============================================================

INSERT INTO SCIENTIFIQUE (id_Personnel_fk, grade) VALUES 
('s01', 'cr1'), 
('s02', 'mcf hors classe'), 
('s03', 'cr1'), 
('s04', 'dr1'), 
('s05', 'dr2'), 
('s10', 'cr2'), 
('s11', 'dr1'), 
('s12', 'mcf'),
('s99', 'dr classe ex'); -- Le superviseur universel (Dieu)

INSERT INTO DOCTORANT (id_Personnel_fk, debutThese, soutenance) VALUES 
('d001', '2023-01-01', NULL),
('d02', '2022-10-01', NULL),
('d03', '2023-10-01', '2026-10-01'),
('d04', '2019-09-01', '2022-06-15'),
('d10', '2023-09-01', NULL),
('d11', '2023-10-01', NULL);

INSERT INTO CHERCHEUR (id_Personnel_fk) VALUES 
('s01'), 
('s03'), 
('s04'), 
('s05'), 
('s10'), 
('s11'), 
('s99');

INSERT INTO CHERCHEUR_ENSEIGNANT (id_Personnel_fk, echelon, acronyme_etablissement_fk) VALUES 
('s02', '3eme', 'UPS'), 
('s12', '2eme', 'INSA');

-- ============================================================
-- 4. ENCADREMENT 
-- ============================================================

INSERT INTO ENCADREMENT (id_Doctorant_fk, id_Scientifique_fk) VALUES 
-- 1. Le Superviseur Universel (Dieu) encadre TOUT LE MONDE
('d001', 's99'), 
('d02', 's99'), 
('d03', 's99'), 
('d04', 's99'), 
('d10', 's99'), 
('d11', 's99'),

-- 2. Les autres encadrants (Ce qui crée des doctorants à multiples superviseurs)
('d001', 's01'), -- Turing a s99 + s01
('d02', 's02'),  -- Sophie a s99 + s02
('d03', 's03'),  -- Lucas a s99 + s03
('d04', 's04'),  -- Ada a s99 + s04
('d11', 's11');  -- Marie a s99 + s11

-- ============================================================
-- 5. PUBLICATIONS & AUTEURS 
-- ============================================================

INSERT INTO AUTEUR_EXTERNE (id_AuteurExt, nomAuteurExt, prenomAuteurExt, mailAuteurExt, id_Labo_fk) VALUES 
(1, 'Smith', 'John', 'mit.edu', 1),   -- USA
(2, 'Muller', 'Hans', 'ethz.ch', 2),  -- Suisse
(3, 'Rossi', 'Mario', 'polimi.it', 4),-- Italie (Cible Azi)
(4, 'Prieto', 'Manuel', 'usc.es', 5), -- Espagne
(5, 'Tanaka', 'Ken', 'tokyo.jp', 6),  -- Japon
(6, 'Bond', 'James', 'uk.uk', 7),     -- UK (Cible Azi)
(7, 'Bengio', 'Yoshua', 'mila.ca', 8),-- Canada
(8, 'Lee', 'Kai', 'cn.cn', 9), --Chine
(9, 'Doe', 'Jane', 'stanford.edu', 10), -- USA
(10,'Musk', 'Elon', 'spacex.com', 11);  -- USA

INSERT INTO PUBLICATION (id_Publication, titre, anneePub, nbPages, nomConf_fk) VALUES 
-- Publis de Jean Azi (s03) pour Req 1 (Cible: 2016-2020)
(1, 'Azi Collab Italie', 2018, 10, 'Automatica'),
(2, 'Azi Collab UK', 2019, 12, 'ICRA'),
(3, 'Azi Collab Hors Date', 2022, 5, 'IROS'),
(10, 'Elite Paper 1', 2023, 10, 'CVPR'), -- A
(11, 'Elite Paper 2', 2022, 8, 'ECCV'),  -- A
(20, 'Normal Paper A', 2023, 6, 'IROS'), -- A
(21, 'Normal Paper B', 2023, 6, 'Automatica'), -- B
(30, 'USA Paper 1', 2022, 10, 'ICRA'), -- A*
(31, 'USA Paper 2', 2021, 10, 'CVPR'), -- A
(32, 'USA Paper 3', 2020, 10, 'NeurIPS'); -- A*

-- LIAISONS AUTEURS INTERNES
INSERT INTO AUTEUR_INTERNE_PUBLICATION (id_Personnel_fk, id_Publication_fk) VALUES 
('s03', 1), 
('s03', 2), 
('s03', 3), 
('s11', 10), 
('s11', 11),           
('s02', 20), 
('s02', 21),           
('s04', 30), 
('s04', 31), 
('s04', 32);

-- LIAISONS AUTEURS EXTERNES (Collaborations)
INSERT INTO AUTEUR_EXTERNE_PUBLICATION (id_AuteurExt_fk, id_Publication_fk) VALUES 
(3, 1), -- Rossi (Italie) avec Azi (2018) -> OK Req 1
(6, 2), -- Bond (UK) avec Azi (2019) -> OK Req 1
(1, 30), -- USA 1
(9, 31), -- USA 2
(10, 32), -- USA 3 -> USA a 3 collaborations, les autres moins. USA gagne Req 7.
(5, 20); -- Japon sur IROS (A) -> Compte pour Req 2


INSERT INTO PROJET_DE_RECHERCHE (id_Projet, titre, anneeDebut, duree, coutGlobal, budget, id_porteur_fk) VALUES 
(1, 'Mars', 2022, 36, 100000, 50000, 's01'),
(2, 'AI', 2023, 24, 200000, 10000, 's02');

INSERT INTO PARTICIPE_PROJET (id_Scientifique_fk, id_Projet_fk) VALUES
('s01', 1), 
('s02', 2);
INSERT INTO PROJET_PARTENAIRE (id_Projet_fk, id_Partenaire_fk) VALUES 
(1, 4);

INSERT INTO CONGRES (id_Event_fk, nbInscription, classe_Congres) VALUES 
(1, 150, 'A');
INSERT INTO PORTES_OUVERTES (id_Event_fk) VALUES 
(2);
INSERT INTO PRESIDE_CONGRES (id_Scientifique_fk, id_Congres_fk) VALUES 
('s02', 1); 
INSERT INTO PARTICIPE_JPO (id_Personnel_fk, id_PortesOuvertes_fk) VALUES 
('adm01', 2);