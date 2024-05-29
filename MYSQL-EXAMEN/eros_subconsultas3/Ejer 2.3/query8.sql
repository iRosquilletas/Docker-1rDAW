SELECT Name , Composer
FROM Track
WHERE GenreId = (
    SELECT GenreId
    FROM (
        SELECT GenreId, COUNT(*) AS NumTracks
        FROM Track
        GROUP BY GenreId
        ORDER BY NumTracks DESC
        LIMIT 1
    ) as Tabla
);