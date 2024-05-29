USE Chinook;

-- ID Y N canciones de cada álbym
SELECT AlbumId, COUNT(*) AS N_Canciones
FROM Track
GROUP BY AlbumId;

-- Media de canciones en todos los álbumes
SELECT AVG(N_Canciones) FROM
(
	SELECT AlbumId, COUNT(*) AS N_Canciones
	FROM Track
	GROUP BY AlbumId
) AS Album_NCanciones;

-- AlbumId, junto al número de canciones
SELECT AlbumId, COUNT(*) AS N_Canciones
FROM Track
GROUP BY AlbumId
HAVING N_Canciones > (SELECT AVG(N_Canciones) FROM
(
	SELECT AlbumId, COUNT(*) AS N_Canciones
	FROM Track
	GROUP BY AlbumId
) AS Album_NCanciones

);

-- info de los albumes con más canciones
SELECT * FROM Album
WHERE Albumid in 
(
select Albumid
from Track
group by AlbumId
having count(*)> (
select avg(N_canciones) FROM ( select AlbumId, count(*) as N_canciones
from Track
group by AlbumId
) as album_canciones
)
);