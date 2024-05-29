USE videoclub;
SELECT P.Titol, A.Nom AS 'Actores'
FROM PELICULA P
JOIN INTERPRETADA I ON P.CodiPeli = I.CodiPeli
JOIN ACTOR A ON I.CodiActor = A.CodiActor;
