SELECT COUNT(*) AS nombre_collaborateurs_total
FROM (
    -- 1. Récupérer les co-auteurs INTERNES (collègues du labo)
    SELECT id_Personnel_fk::VARCHAR AS identifiant -- Cast en texte pour l'UNION
    FROM AUTEUR_INTERNE_PUBLICATION
    WHERE id_Publication_fk IN (
        -- Toutes les publications écrites par S001
        SELECT id_Publication_fk 
        FROM AUTEUR_INTERNE_PUBLICATION 
        WHERE id_Personnel_fk = 'S001'
    )
    AND id_Personnel_fk <> 'S001' -- On exclut S001 lui-même

    UNION -- UNION supprime automatiquement les doublons (si on collabore plusieurs fois avec la même personne)

    -- 2. Récupérer les co-auteurs EXTERNES
    SELECT id_AuteurExt_fk::VARCHAR AS identifiant
    FROM AUTEUR_EXTERNE_PUBLICATION
    WHERE id_Publication_fk IN (
        -- Toutes les publications écrites par S001
        SELECT id_Publication_fk 
        FROM AUTEUR_INTERNE_PUBLICATION 
        WHERE id_Personnel_fk = 's04'
    )
) AS subquery;