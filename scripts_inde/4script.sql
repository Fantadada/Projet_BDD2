SELECT 
    COUNT(DISTINCT le.paysLabo) AS nb_pays_classe_A
FROM 
    PUBLICATION p
JOIN 
    CONFERENCE c ON p.nomConf_fk = c.nomConf
JOIN 
    AUTEUR_EXTERNE_PUBLICATION aep ON p.id_Publication = aep.id_Publication_fk
JOIN 
    AUTEUR_EXTERNE ae ON aep.id_AuteurExt_fk = ae.id_AuteurExt
JOIN 
    LABORATOIRE_EXTERNE le ON ae.id_Labo_fk = le.id_Labo
WHERE 
    c.classe_Conf = 'A'; -- Filtre strict sur la classe A (exclut A*, B, etc.)