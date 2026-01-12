SELECT DISTINCT
    ae.nomAuteurExt AS "Nom Auteur Externe",
    le.paysLabo AS "Pays"
FROM 
    PERSONNEL p
-- On lie le personnel à ses publications
JOIN 
    AUTEUR_INTERNE_PUBLICATION aip ON p.id_Personnel = aip.id_Personnel_fk
JOIN 
    PUBLICATION pub ON aip.id_Publication_fk = pub.id_Publication
-- On cherche les auteurs externes sur ces MÊMES publications
JOIN 
    AUTEUR_EXTERNE_PUBLICATION aep ON pub.id_Publication = aep.id_Publication_fk
JOIN 
    AUTEUR_EXTERNE ae ON aep.id_AuteurExt_fk = ae.id_AuteurExt
-- On remonte au laboratoire pour avoir le pays
JOIN 
    LABORATOIRE_EXTERNE le ON ae.id_Labo_fk = le.id_Labo
WHERE 
    p.nomPerso = 'Azi' 
    AND p.prenomPerso = 'Jean'
    AND pub.anneePub BETWEEN 2016 AND 2020;