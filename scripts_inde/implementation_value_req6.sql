INSERT INTO ETABLISSEMENT (acronyme, nom, adEtablissement) VALUES 
('UPS', 'Université Paul Sabatier', 'Toulouse'),
('INSA', 'Institut National des Sciences Appliquées', 'Toulouse');

INSERT INTO PARTENAIRE_PARTICIPANT (id_Partenaire, nom, pays) VALUES 
(1, 'Airbus', 'France'), 
(2, 'NASA', 'USA');

INSERT INTO LABORATOIRE_EXTERNE (id_Labo, nomLabo, paysLabo) VALUES 
(1, 'MIT', 'USA'), 
(2, 'CERN', 'Suisse'), 
(3, 'Tokyo Lab', 'Japon');

INSERT INTO CONFERENCE (nomConf, classe_Conf) VALUES 
('ICRA', 'A*'), 
('IROS', 'A'), 
('SmallConf', 'B');

INSERT INTO EVENEMENT (id_Event, dateDeb, dateFin) VALUES 
(1, '2023-06-01', '2023-06-05'), 
(2, '2023-09-01', '2023-09-01');

-- 2. PERSONNEL (Les acteurs du scénario)

-- LES CHERCHEURS
INSERT INTO PERSONNEL (id_Personnel, nomPerso, prenomPerso, birthday, adrPerso, recrutement) VALUES 
('s01', 'Curie', 'Marie', '1980-01-01', 'Toulouse', '2010-01-01'), -- CELLE QUI DOIT RESSORTIR (Req 6)
('s02', 'Presque', 'Pierre', '1982-02-02', 'Toulouse', '2012-01-01'),    -- Il lui manquera 1 doctorant
('s03', 'Fantome', 'Casper', '1990-03-03', 'Toulouse', '2020-01-01'),    -- Ne fait rien (Req 3)
('s04', 'Montana', 'Anna', '1985-04-04', 'Toulouse', '2015-01-01');        -- Publie que du A (Req 5)

-- LES DOCTORANTS (Le groupe témoin pour la Req 6)
INSERT INTO PERSONNEL (id_Personnel, nomPerso, prenomPerso, birthday, adrPerso, recrutement) VALUES 
('d01', 'Avogadro', 'Alice', '1998-01-01', 'Toulouse', '2022-01-01'),
('d02', 'Pie', 'Bob', '1999-02-02', 'Toulouse', '2022-02-01'),
('d03', 'Theta', 'Charlie', '2000-03-03', 'Toulouse', '2023-01-01'),
('d04', 'Beta', 'David', '2001-04-04', 'Toulouse', '2023-03-01');

-- 3. TABLES FILLES

INSERT INTO SCIENTIFIQUE (id_Personnel_fk, grade) VALUES 
('s01', 'dr1'), 
('s02', 'cr1'), 
('s03', 'cr2'), 
('s04', 'dr2');

INSERT INTO CHERCHEUR (id_Personnel_fk) VALUES 
('s01'), 
('s03'), 
('s04');
INSERT INTO CHERCHEUR_ENSEIGNANT (id_Personnel_fk, echelon, acronyme_etablissement_fk) VALUES 
('s02', '2eme', 'UPS');

-- Création des doctorants
INSERT INTO DOCTORANT (id_Personnel_fk, debutThese, soutenance) VALUES 
('d01', '2022-01-01', NULL),
('d02', '2022-02-01', NULL),
('d03', '2023-01-01', NULL),
('d04', '2023-03-01', NULL);

-- Auteurs Externes & Publications
INSERT INTO AUTEUR_EXTERNE (id_AuteurExt, nomAuteurExt, prenomAuteurExt, mailAuteurExt, id_Labo_fk) VALUES 
(1, 'Smith', 'John', 'mit.edu', 1);

INSERT INTO PUBLICATION (id_Publication, titre, anneePub, nbPages, nomConf_fk) VALUES 
(1, 'Journeys', 2022, 10, 'ICRA'), -- A*
(2, 'Science', 2023, 8, 'IROS'),   -- A
(3, 'Physical_teq', 2021, 12, 'SmallConf'); -- B

INSERT INTO CONGRES (id_Event_fk, nbInscription, classe_Congres) VALUES 
(1, 200, 'A');
INSERT INTO PORTES_OUVERTES (id_Event_fk) VALUES 
(2);

-- 4. JONCTIONS 

INSERT INTO ENCADREMENT (id_Doctorant_fk, id_Scientifique_fk) VALUES 
-- s01 (Mme Universelle) encadre TOUS les doctorants (4/4)
('d01', 's01'),
('d02', 's01'),
('d03', 's01'),
('d04', 's01'), -- <--- C'est cette ligne qui fait la différence !

-- s02 (M. Presque) encadre 3 doctorants sur 4 (Il manque d04)
('d01', 's02'),
('d02', 's02'),
('d03', 's02');
-- Il ne ressortira PAS dans la requête 6.

-- NOTE pour Req 4 (Doctorants à 1 seul encadrant) :
-- d04 n'est encadré QUE par s01. Il validera donc la requête 4.
-- d01, d02, d03 sont encadrés par s01 ET s02. Ils ne valideront pas la req 4.

-- Projets
INSERT INTO PROJET_DE_RECHERCHE (id_Projet, titre, anneeDebut, duree, coutGlobal, budget, id_porteur_fk) VALUES 
(1, 'Mars Mission', 2022, 48, 1000000, 500000, 's01');

INSERT INTO PARTICIPE_PROJET (id_Scientifique_fk, id_Projet_fk) VALUES 
('s01', 1), 
('s02', 1);
INSERT INTO PROJET_PARTENAIRE (id_Projet_fk, id_Partenaire_fk) VALUES 
(1, 1);

-- Publications (Pour Req 5 : "Que du classe A")
INSERT INTO AUTEUR_INTERNE_PUBLICATION (id_Personnel_fk, id_Publication_fk) VALUES 
('s04', 1), -- s04 publie dans ICRA (A*) -> OK
('s04', 2), -- s04 publie dans IROS (A)  -> OK
-- s04 ne publie PAS dans 'Physical_teq' (B). Elle validera la Req 5.

('s01', 1), -- s01 publie en A*
('s01', 3); -- s01 publie aussi en B (Ne valide pas Req 5)

-- Collaborations Externes
INSERT INTO AUTEUR_EXTERNE_PUBLICATION (id_AuteurExt_fk, id_Publication_fk) VALUES 
(1, 1); -- USA sur publi 1