SELECT 
    d.id_Personnel_fk AS "Identifiant Doctorant", 
    COUNT(aip.id_Publication_fk) AS "Nombre de Publications"
FROM 
    DOCTORANT d
LEFT JOIN 
    AUTEUR_INTERNE_PUBLICATION aip ON d.id_Personnel_fk = aip.id_Personnel_fk
GROUP BY 
    d.id_Personnel_fk
ORDER BY 
    "Nombre de Publications" DESC;