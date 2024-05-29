USE videoclub;
SELECT P.Titol, A.Nom AS 'Actor Principal'
FROM PELICULA P
JOIN ACTOR A ON P.CodiActor = A.CodiActor;
