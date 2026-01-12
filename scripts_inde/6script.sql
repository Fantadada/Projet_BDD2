SELECT 
    COUNT(*) AS "Nombre de doctorants ayant soutenu"
FROM 
    DOCTORANT
WHERE 
    soutenance IS NOT NULL;