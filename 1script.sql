SELECT 
    p.nomPerso, 
    s.grade
FROM 
    ENCADREMENT e
JOIN 
    SCIENTIFIQUE s ON e.id_Scientifique_fk = s.id_Personnel_fk
JOIN 
    PERSONNEL p ON s.id_Personnel_fk = p.id_Personnel
WHERE 
    e.id_Doctorant_fk = 'd001';