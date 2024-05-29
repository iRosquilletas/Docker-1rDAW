USE videoclub;
SELECT P1.CodiPeli AS 'ID Película', P1.Titol AS 'Película', P2.CodiPeli AS 'ID Segunda Parte', P2.Titol AS 'Segunda Parte'
FROM PELICULA P1
LEFT JOIN PELICULA P2 ON P1.SegonaPart = P2.CodiPeli;
