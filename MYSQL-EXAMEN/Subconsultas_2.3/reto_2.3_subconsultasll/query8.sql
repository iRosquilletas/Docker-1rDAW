USE chinook;
SELECT Track.Name, Genre.Name
FROM Track
INNER JOIN Genre ON Track.GenreId = Genre.GenreId
WHERE Genre.GenreId = (SELECT GenreId
        FROM(SELECT GenreId, COUNT(*) AS numeroCanciones
                FROM Track
                GROUP BY GenreId
                ORDER BY COUNT(*) DESC
                LIMIT 1
            ) AS generoComun
    );