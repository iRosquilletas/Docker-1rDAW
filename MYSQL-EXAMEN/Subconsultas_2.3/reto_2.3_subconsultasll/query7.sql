USE chinook;
SELECT  AlbumId, SUM(Milliseconds) AS duracion
FROM Track
GROUP BY AlbumId
HAVING duracion > (SELECT AVG(duracion)
        FROM (SELECT AlbumId, SUM(Milliseconds) AS duracion
            FROM Track
            GROUP BY AlbumId) AS duracionDelAlbum
    );