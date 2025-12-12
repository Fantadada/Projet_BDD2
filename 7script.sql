SELECT 
    p.nomPerso, 
    p.prenomPerso
FROM 
    SCIENTIFIQUE s
JOIN 
    PERSONNEL p ON s.id_Personnel_fk = p.id_Personnel
WHERE 
    s.id_Personnel_fk NOT IN (
        SELECT DISTINCT id_Scientifique_fk 
        FROM ENCADREMENT
    );