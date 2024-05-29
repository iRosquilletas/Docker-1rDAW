USE chinook;
SELECT Artist.Name AS Nombre,
    (SELECT Title
        FROM Album
        WHERE Album.ArtistId = Artist.ArtistId
        ORDER BY Album.AlbumId DESC
        LIMIT 1
    ) AS ultimoAlbum
FROM Artist;