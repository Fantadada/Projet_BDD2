/* 
Auteur : Damien CAPPELLINI
Projet BDD 2 - 2025/2026
*/

-- 1. Le nom et le pays des auteurs collaborateurs (externes) du chercheur "Jean Azi" de 2016 à 2020
SELECT DISTINCT
    ae.nomAuteurExt AS "Auteur Externe",
    le.paysLabo AS "Pays"
FROM PERSONNEL p
JOIN AUTEUR_INTERNE_PUBLICATION aip ON p.id_Personnel = aip.id_Personnel_fk
JOIN PUBLICATION pub ON aip.id_Publication_fk = pub.id_Publication
JOIN AUTEUR_EXTERNE_PUBLICATION aep ON pub.id_Publication = aep.id_Publication_fk
JOIN AUTEUR_EXTERNE ae ON aep.id_AuteurExt_fk = ae.id_AuteurExt
JOIN LABORATOIRE_EXTERNE le ON ae.id_Labo_fk = le.id_Labo
WHERE p.nomPerso = 'Azi' 
  AND p.prenomPerso = 'Jean'
  AND pub.anneePub BETWEEN 2016 AND 2020;


-- 2. Le nombre de pays avec lesquels le LAAS a collaboré dans le cadre de publications de rang A

SELECT COUNT(DISTINCT le.paysLabo) AS "nb_pays_classe_A"
FROM PUBLICATION p
JOIN CONFERENCE c ON p.nomConf_fk = c.nomConf
JOIN AUTEUR_EXTERNE_PUBLICATION aep ON p.id_Publication = aep.id_Publication_fk
JOIN AUTEUR_EXTERNE ae ON aep.id_AuteurExt_fk = ae.id_AuteurExt
JOIN LABORATOIRE_EXTERNE le ON ae.id_Labo_fk = le.id_Labo
WHERE c.classe_Conf = 'A';


-- 3. Le nom et le prénom des chercheurs qui n’ont jamais publié NI encadré
SELECT p.nomPerso AS "nom", 
       p.prenomPerso AS "prenom"
FROM CHERCHEUR c
JOIN PERSONNEL p ON c.id_Personnel_fk = p.id_Personnel
WHERE c.id_Personnel_fk NOT IN (SELECT id_Personnel_fk FROM AUTEUR_INTERNE_PUBLICATION)
  AND c.id_Personnel_fk NOT IN (SELECT id_Scientifique_fk FROM ENCADREMENT);


-- 4. Identifiant, nom et prénom des doctorants qui ont un seul encadrant
SELECT d.id_Personnel_fk AS "Identifiant", 
       p.nomPerso AS "Nom", 
       p.prenomPerso AS "Prenom"
FROM DOCTORANT d
JOIN PERSONNEL p ON d.id_Personnel_fk = p.id_Personnel
JOIN ENCADREMENT e ON d.id_Personnel_fk = e.id_Doctorant_fk
GROUP BY d.id_Personnel_fk, p.nomPerso, p.prenomPerso
HAVING COUNT(e.id_Scientifique_fk) = 1;


-- 5. L'identifiant des chercheurs qui n'ont publié QUE dans des conférences de classe A
SELECT DISTINCT aip.id_Personnel_fk AS "Identifiant de(s) chercheur(s)"
FROM AUTEUR_INTERNE_PUBLICATION aip
JOIN PUBLICATION p ON aip.id_Publication_fk = p.id_Publication
JOIN CONFERENCE c ON p.nomConf_fk = c.nomConf
WHERE c.classe_Conf = 'A'
AND aip.id_Personnel_fk NOT IN (
    SELECT aip2.id_Personnel_fk
    FROM AUTEUR_INTERNE_PUBLICATION aip2
    JOIN PUBLICATION p2 ON aip2.id_Publication_fk = p2.id_Publication
    JOIN CONFERENCE c2 ON p2.nomConf_fk = c2.nomConf
    WHERE c2.classe_Conf <> 'A' -- Tout ce qui n'est pas A (B, C, A*...)
);


-- 6. Nom, prénom et identifiant des chercheurs qui auraient été encadrants de TOUS les doctorants
SELECT p.nomPerso AS "Nom", 
       p.prenomPerso AS "Prenom", 
       s.id_Personnel_fk AS "Identifiant"
FROM SCIENTIFIQUE s
JOIN PERSONNEL p ON s.id_Personnel_fk = p.id_Personnel
WHERE NOT EXISTS (--Cas orphelin
    SELECT d.id_Personnel_fk
    FROM DOCTORANT d
    WHERE NOT EXISTS (
        SELECT 1
        FROM ENCADREMENT e
        WHERE e.id_Scientifique_fk = s.id_Personnel_fk
        AND e.id_Doctorant_fk = d.id_Personnel_fk
    )
);


-- 7. Le pays avec lequel le laboratoire a plus de publications
SELECT le.paysLabo AS "Labo pays"
FROM PUBLICATION p
JOIN AUTEUR_EXTERNE_PUBLICATION aep ON p.id_Publication = aep.id_Publication_fk
JOIN AUTEUR_EXTERNE ae ON aep.id_AuteurExt_fk = ae.id_AuteurExt
JOIN LABORATOIRE_EXTERNE le ON ae.id_Labo_fk = le.id_Labo
GROUP BY le.paysLabo
ORDER BY COUNT(p.id_Publication) DESC
LIMIT 1;