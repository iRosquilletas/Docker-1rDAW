USE chinook;
SELECT
    Album.Title,
    (
        SELECT COUNT(*)
        FROM Track
        WHERE Track.AlbumId = Album.AlbumId
    ) AS canciones
FROM Album;