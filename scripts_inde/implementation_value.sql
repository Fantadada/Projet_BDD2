/* 
Auteur : Damien CAPPELLINI
Projet BDD 2 - 2025/2026
*/

-- Etablissements d'enseignement 
INSERT INTO ETABLISSEMENT (acronyme, nom, adEtablissement) VALUES 
('UPS', 'Université Paul Sabatier', '118 Route de Narbonne, 31062 Toulouse'),
('INSA', 'Institut National des Sciences Appliquées', '135 Avenue de Rangueil, 31400 Toulouse');

-- Partenaires pour les projets 
INSERT INTO PARTENAIRE_PARTICIPANT (id_Partenaire, nom, pays) VALUES 
(1, 'Airbus Defence and Space', 'France'),
(2, 'Thales Alenia Space', 'France'),
(3, 'DLR (Agence aérospatiale)', 'Allemagne');

-- Laboratoires externes pour les auteurs externes
INSERT INTO LABORATOIRE_EXTERNE (id_Labo, nomLabo, paysLabo) VALUES 
(1, 'MIT CSAIL', 'USA'),
(2, 'ETH Zurich', 'Suisse'),
(3, 'LIRMM', 'France'),
(4, 'Politecnico di Milano', 'Italie'),
(5, 'USC Saint-Jacques-de-Compostelle', 'Espagne'),
(6, 'University of Tokyo', 'Japon'),
(7, 'Imperial College London', 'Royaume-Uni'),
(8, 'Mila - Quebec AI Institute', 'Canada'),
(9, 'Tsinghua University', 'Chine');

-- Conférences (Normalisation 3NF) 
INSERT INTO CONFERENCE (nomConf, classe_Conf) VALUES 
('ICRA', 'A*'),
('IROS', 'A'),
('Automatica', 'B'),
('CVPR', 'A*'),
('NeurIPS', 'A*'),
('ECCV', 'A');

-- Evènements (Congrès et JPO) 
INSERT INTO EVENEMENT (id_Event, dateDeb, dateFin) VALUES 
(1, '2023-05-15', '2023-05-19'), -- Futur Congrès
(2, '2023-10-14', '2023-10-14'); -- Future JPO


-- Convention : 's' = scientifique, 'd' = doctorant, 'adm' = administratif
INSERT INTO PERSONNEL (id_Personnel, nomPerso, prenomPerso, birthday, adrPerso, recrutement) VALUES 
('s01', 'Dupont', 'Marie', '1980-04-12', '10 rue des Lilas, Toulouse', '2005-09-01'),
('s02', 'Martin', 'Pierre', '1975-11-23', '5 avenue Jean Jaurès, Toulouse', '2002-01-15'),
('d001', 'Turing', 'Alan', '1995-06-23', '24 Rue des Lois, Toulouse', '2023-01-01'), -- LE DOCTORANT CIBLE
('d02', 'Bernard', 'Sophie', '1998-06-30', 'Résidence Crous, Rangueil', '2022-10-01'),
('d03', 'Leroy', 'Lucas', '1999-02-14', '2 rue du Taur, Toulouse', '2023-10-01'),
('adm01', 'Petit', 'Julie', '1985-08-09', 'Place du Capitole, Toulouse', '2010-03-01'),
('s03', 'Azi', 'Jean', '1982-05-10', '15 rue de la Pomme, Toulouse', '2010-01-01'),
('s04', 'Tesla', 'Nikola', '1856-07-10', '7 Wardenclyffe Tower', '2020-01-01'),--
('d04', 'Lovelace', 'Ada', '1990-12-10', 'London', '2019-09-01'),
('s05', 'Hawk', 'Stephen', '1942-01-08', 'Cambridge', '2015-09-01'),
('s10', 'Fantome', 'Casper', '1990-01-01', 'Toulouse', '2023-01-01'), 
('s11', 'Elite', 'Anna', '1985-05-05', 'Ramonville', '2015-06-01'),   
('s12', 'Bosseur', 'Tom', '1988-08-08', 'Toulouse', '2012-09-01'),    
('d10', 'Solo', 'Han', '1999-12-12', 'Crous', '2023-09-01'),          
('d11', 'Duo', 'Marie', '2000-01-01', 'Toulouse', '2023-10-01');

-- Scientifiques
INSERT INTO SCIENTIFIQUE (id_Personnel_fk, grade) VALUES 
('s01', 'cr1'),           
('s02', 'mcf hors classe'), 
('s03', 'cr1'), 
('s04', 'dr1'), 
('s05', 'dr2'),
('s10', 'cr2'),
('s11', 'dr1'),
('s12', 'mcf');
-- Doctorants
INSERT INTO DOCTORANT (id_Personnel_fk, debutThese, soutenance) VALUES 
('d001', '2023-01-01', NULL),        -- Alan Turing (Cible requête)
('d02', '2022-10-01', NULL),          -- Sophie Bernard
('d03', '2023-10-01', '2026-10-01'),  -- Lucas Leroy
('d04', '2019-09-01', '2022-06-15'),
('d10', '2023-09-01', NULL),
('d11', '2023-10-01', NULL);
-- Auteurs Externes
INSERT INTO AUTEUR_EXTERNE (id_AuteurExt, nomAuteurExt, prenomAuteurExt, mailAuteurExt, id_Labo_fk) VALUES 
(1, 'Smith', 'John', 'j.smith@mit.edu', 1),
(2, 'Muller', 'Hans', 'h.muller@ethz.ch', 2),
(3, 'Rossi', 'Mario', 'm.rossi@polimi.it', 4),
(4, 'Prieto Perera', 'Manuel', 'manuel.prietoperera@usc.es', 5),  
(5, 'Tanaka', 'Ken', 'k.tanaka@u-tokyo.jp', 6),
(6, 'Bond', 'James', '007@imperial.uk', 7),   -- UK
(7, 'Bengio', 'Yoshua', 'y.b@mila.ca', 8),    -- Canada
(8, 'Lee', 'Kai', 'k.lee@tsinghua.cn', 9);
-- Publications 
INSERT INTO PUBLICATION (id_Publication, titre, anneePub, nbPages, nomConf_fk) VALUES 
(1, 'Advanced Robotics in Space', 2022, 8, 'ICRA'),
(2, 'Neural Networks for Control', 2023, 6, 'IROS'),
(3, 'Collaborative Systems in Europe', 2018, 10, 'Automatica'),
(4, 'Wireless Energy Transfer', 2021, 12, 'ICRA'),
(5, 'Soft Robotics for Humanity', 2023, 8, 'IROS'),
(10, 'Algorithm Design for Beginners', 2023, 15, 'ICRA'),
(11, 'Encryption Methods', 2024, 10, 'Automatica'),
(12, 'Future of AI', 2024, 5, 'IROS'),
(20, 'Deep Learning Frontiers', 2023, 10, 'CVPR'),
(21, 'Computer Vision Basics', 2022, 8, 'ECCV'),
(22, 'Legacy Systems in IoT', 2019, 12, 'Automatica');
-- Spécialisation Evènements
INSERT INTO CONGRES (id_Event_fk, nbInscription, classe_Congres) VALUES 
(1, 150, 'A');

INSERT INTO PORTES_OUVERTES (id_Event_fk) VALUES 
(2);

-- Chercheurs seulement 
INSERT INTO CHERCHEUR (id_Personnel_fk) VALUES 
('s01'),
('s04'),--Tesla
('s03'),--Azi
('s05'),
('s10'), 
('s11');
-- Chercheurs-Enseignants 
INSERT INTO CHERCHEUR_ENSEIGNANT (id_Personnel_fk, echelon, acronyme_etablissement_fk) VALUES 
('s02', '3eme echelon', 'UPS'),
('s12', '2eme', 'INSA');

-- Projets de Recherche 
INSERT INTO PROJET_DE_RECHERCHE (id_Projet, titre, acronyme, anneeDebut, duree, coutGlobal, budget, id_porteur_fk) VALUES 
(1, 'Robots Autonomes pour Mars', 'ROBOMARS', 2022, 36, 1500000.00, 500000.00, 's01'),
(2, 'Intelligence Artificielle Verte', 'GREEN-AI', 2023, 24, 800000.00, 200000.00, 's02');

-- ============================================================
-- 4. INSERTION DANS LES TABLES DE JONCTION (Relations N-N)
-- ============================================================

-- Encadrement des thèses
INSERT INTO ENCADREMENT (id_Doctorant_fk, id_Scientifique_fk) VALUES 
('d001', 's01'), -- d001 (Turing) est encadré par s01 (Dupont - Grade CR1)
('d001', 's02'), -- d001 (Turing) est encadré par s02 (Martin - Grade MCF)
('d02', 's01'),  -- Sophie encadrée par Marie
('d02', 's02'),  -- Sophie co-encadrée par Pierre
('d03', 's01'),  -- Lucas encadré par Marie
('d10', 's12'),  -- Han Solo n'a que Tom Bosseur (Valide Req 4)
('d11', 's11'),  -- Marie Duo a Anna...
('d11', 's12');  

-- Participation aux projets 
INSERT INTO PARTICIPE_PROJET (id_Scientifique_fk, id_Projet_fk) VALUES 
('s01', 1), 
('s02', 1), 
('s02', 2); 

-- Partenaires des projets 
INSERT INTO PROJET_PARTENAIRE (id_Projet_fk, id_Partenaire_fk) VALUES 
(1, 1), 
(1, 2), 
(2, 3); 

-- Auteurs Internes des publications 
INSERT INTO AUTEUR_INTERNE_PUBLICATION (id_Personnel_fk, id_Publication_fk) VALUES 
('s01', 1), 
('d02', 1), 
('s02', 2), 
('s03', 3),
('s02', 4),
('d001', 10),
('d001', 11),
('s04', 4),
('d03', 12),
('s11', 20),
('s12', 21),
('s03', 22);
-- Auteurs Externes des publications 
INSERT INTO AUTEUR_EXTERNE_PUBLICATION (id_AuteurExt_fk, id_Publication_fk) VALUES 
(1, 1),
(2, 4),
(4, 2),
(5, 5),
(3, 3),
(7, 20), 
(8, 21), 
(6, 22);

-- Présidence de congrès 
INSERT INTO PRESIDE_CONGRES (id_Scientifique_fk, id_Congres_fk) VALUES 
('s02', 1); 

-- Participation aux JPO 
INSERT INTO PARTICIPE_JPO (id_Personnel_fk, id_PortesOuvertes_fk) VALUES 
('d02', 2), 
('adm01', 2);