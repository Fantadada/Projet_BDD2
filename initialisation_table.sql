-- Suppression des tables si elles existent déjà
DROP TABLE IF EXISTS ETABLISSEMENT CASCADE;
DROP TABLE IF EXISTS PARTENAIRE_PARTICIPANT CASCADE;
DROP TABLE IF EXISTS LABORATOIRE_EXTERNE CASCADE;
DROP TABLE IF EXISTS CONFERENCE CASCADE;
DROP TABLE IF EXISTS EVENEMENT CASCADE;
DROP TABLE IF EXISTS PERSONNEL CASCADE;
DROP TABLE IF EXISTS SCIENTIFIQUE CASCADE;
DROP TABLE IF EXISTS DOCTORANT CASCADE;
DROP TABLE IF EXISTS AUTEUR_EXTERNE CASCADE;
DROP TABLE IF EXISTS PUBLICATION CASCADE;
DROP TABLE IF EXISTS CONGRES CASCADE;
DROP TABLE IF EXISTS PORTES_OUVERTES CASCADE;
DROP TABLE IF EXISTS CHERCHEUR CASCADE;
DROP TABLE IF EXISTS CHERCHEUR_ENSEIGNANT CASCADE;
DROP TABLE IF EXISTS PROJET_DE_RECHERCHE CASCADE;
DROP TABLE IF EXISTS ENCADREMENT CASCADE;
DROP TABLE IF EXISTS PARTICIPE_PROJET CASCADE;
DROP TABLE IF EXISTS PROJET_PARTENAIRE CASCADE;
DROP TABLE IF EXISTS AUTEUR_INTERNE_PUBLICATION CASCADE;
DROP TABLE IF EXISTS AUTEUR_EXTERNE_PUBLICATION CASCADE;
DROP TABLE IF EXISTS PRESIDE_CONGRES CASCADE;
DROP TABLE IF EXISTS PARTICIPE_JPO CASCADE;

/* ==================================================================
   ÉTAPE 1 : CRÉATION DES TABLES "PARENTS"
   ================================================================== */

CREATE TABLE ETABLISSEMENT (
    acronyme VARCHAR(50) PRIMARY KEY,
    nom VARCHAR(255) NOT NULL,
    adEtablissement TEXT
);

CREATE TABLE PARTENAIRE_PARTICIPANT (
    id_Partenaire INT PRIMARY KEY,
    nom VARCHAR(255) NOT NULL,
    pays VARCHAR(100)
);

CREATE TABLE LABORATOIRE_EXTERNE (
    id_Labo INT PRIMARY KEY,
    nomLabo VARCHAR(255) NOT NULL,
    paysLabo VARCHAR(100)
);

CREATE TABLE CONFERENCE (
    nomConf VARCHAR(255) PRIMARY KEY,
    classe_Conf VARCHAR(10)
);

CREATE TABLE EVENEMENT (
    id_Event INT PRIMARY KEY,
    dateDeb DATE NOT NULL,
    dateFin DATE
);

CREATE TABLE PERSONNEL (
    id_Personnel VARCHAR(50) PRIMARY KEY, 
    nomPerso VARCHAR(100) NOT NULL,
    prenomPerso VARCHAR(100) NOT NULL,
    birthday DATE,
    adrPerso TEXT,
    recrutement DATE NOT NULL
);

/* ==================================================================
   ÉTAPE 2 : CRÉATION DES TABLES "FILLES" & RELATIONS SIMPLES
   ================================================================== */

-- Héritage de Personnel 
CREATE TABLE SCIENTIFIQUE (
    id_Personnel_fk VARCHAR(50) PRIMARY KEY,
    grade VARCHAR(50) NOT NULL,
    FOREIGN KEY (id_Personnel_fk) REFERENCES PERSONNEL(id_Personnel)
);

-- Héritage de Personnel 
CREATE TABLE DOCTORANT (
    id_Personnel_fk VARCHAR(50) PRIMARY KEY,
    soutenance DATE,
    debutThese DATE NOT NULL,
    FOREIGN KEY (id_Personnel_fk) REFERENCES PERSONNEL(id_Personnel)
);

CREATE TABLE AUTEUR_EXTERNE (
    id_AuteurExt INT PRIMARY KEY,
    nomAuteurExt VARCHAR(100) NOT NULL,
    prenomAuteurExt VARCHAR(100) NOT NULL,
    mailAuteurExt VARCHAR(255),
    id_Labo_fk INT,
    FOREIGN KEY (id_Labo_fk) REFERENCES LABORATOIRE_EXTERNE(id_Labo)
);

CREATE TABLE PUBLICATION (
    id_Publication INT PRIMARY KEY,
    titre VARCHAR(255) NOT NULL,
    anneePub INT NOT NULL,
    nbPages INT,
    nomConf_fk VARCHAR(255),
    FOREIGN KEY (nomConf_fk) REFERENCES CONFERENCE(nomConf)
);

CREATE TABLE CONGRES (
    id_Event_fk INT PRIMARY KEY,
    nbInscription INT,
    classe_Congres VARCHAR(10),
    FOREIGN KEY (id_Event_fk) REFERENCES EVENEMENT(id_Event)
);

CREATE TABLE PORTES_OUVERTES (
    id_Event_fk INT PRIMARY KEY,
    FOREIGN KEY (id_Event_fk) REFERENCES EVENEMENT(id_Event)
);

/* ==================================================================
   ÉTAPE 3 : CRÉATION DES TABLES SPÉCIFIQUES & PROJETS
   ================================================================== */

-- Héritage de Scientifique 
CREATE TABLE CHERCHEUR (
    id_Personnel_fk VARCHAR(50) PRIMARY KEY,
    FOREIGN KEY (id_Personnel_fk) REFERENCES SCIENTIFIQUE(id_Personnel_fk)
);

-- Héritage de Scientifique 
CREATE TABLE CHERCHEUR_ENSEIGNANT (
    id_Personnel_fk VARCHAR(50) PRIMARY KEY,
    echelon VARCHAR(50),
    acronyme_etablissement_fk VARCHAR(50),
    FOREIGN KEY (id_Personnel_fk) REFERENCES SCIENTIFIQUE(id_Personnel_fk),
    FOREIGN KEY (acronyme_etablissement_fk) REFERENCES ETABLISSEMENT(acronyme)
);

CREATE TABLE PROJET_DE_RECHERCHE (
    id_Projet INT PRIMARY KEY,
    titre VARCHAR(255) NOT NULL,
    acronyme VARCHAR(50),
    anneeDebut INT NOT NULL,
    duree INT,
    coutGlobal DECIMAL(15, 2),
    budget DECIMAL(15, 2),
    id_porteur_fk VARCHAR(50) NOT NULL,
    FOREIGN KEY (id_porteur_fk) REFERENCES SCIENTIFIQUE(id_Personnel_fk)
);

/* ==================================================================
   ÉTAPE 4 : CRÉATION DES TABLES DE JONCTION (RELATIONS N-N)
   ================================================================== */


CREATE TABLE ENCADREMENT (
    id_Doctorant_fk VARCHAR(50),
    id_Scientifique_fk VARCHAR(50),
    PRIMARY KEY (id_Doctorant_fk, id_Scientifique_fk),
    FOREIGN KEY (id_Doctorant_fk) REFERENCES DOCTORANT(id_Personnel_fk),
    FOREIGN KEY (id_Scientifique_fk) REFERENCES SCIENTIFIQUE(id_Personnel_fk)
);


CREATE TABLE PARTICIPE_PROJET (
    id_Scientifique_fk VARCHAR(50),
    id_Projet_fk INT,
    PRIMARY KEY (id_Scientifique_fk, id_Projet_fk),
    FOREIGN KEY (id_Scientifique_fk) REFERENCES SCIENTIFIQUE(id_Personnel_fk),
    FOREIGN KEY (id_Projet_fk) REFERENCES PROJET_DE_RECHERCHE(id_Projet)
);

CREATE TABLE PROJET_PARTENAIRE (
    id_Projet_fk INT,
    id_Partenaire_fk INT,
    PRIMARY KEY (id_Projet_fk, id_Partenaire_fk),
    FOREIGN KEY (id_Projet_fk) REFERENCES PROJET_DE_RECHERCHE(id_Projet),
    FOREIGN KEY (id_Partenaire_fk) REFERENCES PARTENAIRE_PARTICIPANT(id_Partenaire)
);

CREATE TABLE AUTEUR_INTERNE_PUBLICATION (
    id_Personnel_fk VARCHAR(50),
    id_Publication_fk INT,
    PRIMARY KEY (id_Personnel_fk, id_Publication_fk),
    FOREIGN KEY (id_Personnel_fk) REFERENCES PERSONNEL(id_Personnel),
    FOREIGN KEY (id_Publication_fk) REFERENCES PUBLICATION(id_Publication)
);

CREATE TABLE AUTEUR_EXTERNE_PUBLICATION (
    id_AuteurExt_fk INT,
    id_Publication_fk INT,
    PRIMARY KEY (id_AuteurExt_fk, id_Publication_fk),
    FOREIGN KEY (id_AuteurExt_fk) REFERENCES AUTEUR_EXTERNE(id_AuteurExt),
    FOREIGN KEY (id_Publication_fk) REFERENCES PUBLICATION(id_Publication)
);

CREATE TABLE PRESIDE_CONGRES (
    id_Scientifique_fk VARCHAR(50),
    id_Congres_fk INT,
    PRIMARY KEY (id_Scientifique_fk, id_Congres_fk),
    FOREIGN KEY (id_Scientifique_fk) REFERENCES SCIENTIFIQUE(id_Personnel_fk),
    FOREIGN KEY (id_Congres_fk) REFERENCES CONGRES(id_Event_fk)
);

CREATE TABLE PARTICIPE_JPO (
    id_Personnel_fk VARCHAR(50),
    id_PortesOuvertes_fk INT,
    PRIMARY KEY (id_Personnel_fk, id_PortesOuvertes_fk),
    FOREIGN KEY (id_Personnel_fk) REFERENCES PERSONNEL(id_Personnel),
    FOREIGN KEY (id_PortesOuvertes_fk) REFERENCES PORTES_OUVERTES(id_Event_fk)
);